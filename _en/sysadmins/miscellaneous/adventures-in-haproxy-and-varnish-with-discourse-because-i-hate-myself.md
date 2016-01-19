---
title: Adventures in haproxy and varnish with discourse because i hate myself
---

Had some downtime this afternoon and without even really planning to ended up setting up haproxy in front of my web server, which hosts a bunch of stuff including Discourse. The configuration, surprisingly, wound up working without much hassle at all; I give up SPDY support because haproxy doesn't support it, but I don't think that's going to have a whole lot of material effect.

I wound up dragging a second unused server into the mix to work as the haproxy host, but I don't think there'd be any issue in running everything on one box. My stack, when done, is haproxy -> varnish -> nginx, with the main nginx instance serving up my sites (including discourse, which seems perfectly happy being sandwiched behind haproxy and varnish and an nginx).

Why the hell am I doing this? Two reasons: I wanted to go all HTTPS so I could be HSTS compliant, and I also wanted to keep leveraging Varnish as my cache, since at least IMO it's still way better at serving static objects really fast than nginx, even with nginx mainline's caching (which I've since mostly turned off in favor of just letting varnish do its thing).

My haproxy config is pretty straightforward:
```
global
    log /dev/log    local0
    log /dev/log    local1 notice
    chroot /var/lib/haproxy
    stats socket /run/haproxy/admin.sock mode 660 level admin
    stats timeout 30s
    user haproxy
    group haproxy
    daemon

    # Default SSL material locations
    ca-base /etc/ssl/certs
    crt-base /etc/ssl/private

    ssl-default-bind-ciphers EECDH+ECDSA+AESGCM:EECDH+aRSA+AESGCM:EECDH+ECDSA+SHA384:EECDH+ECDSA+SHA256:EECDH+aRSA+SHA384:EECDH+aRSA+SHA256:EECDH+aRSA+RC4:EECDH:EDH+aRSA:!aNULL:!eNULL:!LOW:!3DES:!MD5:!EXP:!PSK:!SRP:!DSS:!RC4
    ssl-default-bind-options no-sslv3 no-tlsv10
    tune.ssl.default-dh-param 4096

defaults
    log    global
    mode    http
    option    httplog
    option    dontlognull
    option    forwardfor
    option    http-server-close
        timeout connect 5000
        timeout client  50000
        timeout server  50000
    errorfile 400 /etc/haproxy/errors/400.http
    errorfile 403 /etc/haproxy/errors/403.http
    errorfile 408 /etc/haproxy/errors/408.http
    errorfile 500 /etc/haproxy/errors/500.http
    errorfile 502 /etc/haproxy/errors/502.http
    errorfile 503 /etc/haproxy/errors/503.http
    errorfile 504 /etc/haproxy/errors/504.http

frontend haproxyserver
    bind *:80
    bind *:443 ssl crt first-wildcard-cert.pem crt second-wildcard-cert.pem crt third-wildcard-cert.pem
    acl secure dst_port eq 443
    redirect prefix https://newsitename 301 if { hdr(host) -i oldsitename }
    redirect scheme https if !{ ssl_fc }
    rspadd Strict-Transport-Security:\ max-age=31536000;\ includeSubDomains;\ preload
    rsprep ^Set-Cookie:\ (.*) Set-Cookie:\ \1;\ Secure if secure
    default_backend webserver

    backend webserver
    http-request set-header X-Forwarded-Port %[dst_port]
    http-request add-header X-Forwarded-Proto https if { ssl_fc }
    server webserver 10.10.10.4:80

listen stats *:8778
    stats enable
    stats uri /
```

Not a lot changed from default, but I did make sure to force no SSLv3 and no TLS 1.0 protocols, and sub in the cipherlist I've had the most success with with the SSL Labs tester. Also bumped up the dhparam to 4096.

I have three main domains I serve and I use wildcard certs from StartSSL, and haproxy is really good about accepting all 3 certs and figuring out which one to used based on the requested hostname—zero problems there, so the [Chronicles of George](http://www.chroniclesofgeorge.com) and [my Discourse instance](http://discourse.bigdinosaur.org) both get SSL/TLS properly terminated.

My varnish config I left unchanged for Discourse:

```
sub vcl_recv {

...
    # Cache only the static assets and pass everything else
    if (req.http.host ~"discourse.bigdinosaur.org") {
        if (!(req.url ~ "^/uploads/"||"^/assets/"||"^/user_avatar/" )) {                              
            return (pass);
        }
    }

...
sub vcl_pass {

...
    set bereq.http.connection = "close";
    # Fix broken behavior showing tons of requests from 127.0.0.1 with Discourse
    if (req.http.X-Forwarded-For) {
        set bereq.http.X-Forwarded-For = req.http.X-Forwarded-For;
    } else {
        set bereq.http.X-Forwarded-For = regsub(client.ip, ":.*", "");
    }
}
...
```

And my Nginx config without SSL/TLS in it has gotten a lot simpler, too:
```
server {
    server_name discourse.bigdinosaur.org;
    listen 8881;

    sendfile on;

    location / {
        access_log off;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header Host $http_host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_redirect off;
        proxy_pass http://localhost:8089;
    }
}
```

Then whatever magic @sam has in the Discourse docker image takes care of the rest.

edited to add - Updated the post with my current prod config, which is a teeny bit cleaner. I'm also doing a 301 redirect for one of my sites at the haproxy level rather than with nginx, because doing a redirect at the nginx level means waiting for an ssl handshake by haproxy, then getting the redirect from nginx, then doing a second ssl handshake with haproxy for the new site. Doing the redirect by hostname with haproxy saves quite a bit of time. This seems obvious in hindsight and I should have done it that way in the first place.

<small class="documentation-source">Source: [https://meta.discourse.org/t/adventures-in-haproxy-and-varnish-with-discourse-because-i-hate-myself/27782](https://meta.discourse.org/t/adventures-in-haproxy-and-varnish-with-discourse-because-i-hate-myself/27782)</small>
