---
title: Running other websites on the same machine as Discourse
---

If you want to run other websites on the same machine as Discourse, you need to set up an extra NGINX proxy in front of the Docker container.

If you have not already, please read the [Advanced Troubleshooting with Docker](https://meta.discourse.org/t/advanced-troubleshooting-with-docker/15927/) guide, as it covers the basics on the separation between host and container.

This guide **assumes you already have Discourse working** - if you don't, it may be hard to tell whether or not the configuration is working.

## Install nginx outside the container
First, make sure the container is not running:

    cd /var/discourse
    ./launcher stop app

Then [install nginx from its PPA](https://www.nginx.com/resources/wiki/start/topics/tutorials/install/#ubuntu-ppa) (Ubuntu ships by default a very old version, 1.4.0):

    sudo add-apt-repository ppa:nginx/stable -y
    sudo apt-get update && sudo apt-get install nginx

## Change the container definition

This is where we change how Discourse actually gets set up. We don't want the container listening on ports - instead, we'll tell it to listen on a special file.

Change your `/var/discourse/containers/app.yml` to look like this:

```yml
# base templates used; can cut down to include less functionality per container templates:
  - "templates/cron.template.yml"
  - "templates/postgres.template.yml"
  - "templates/redis.template.yml"
  - "templates/sshd.template.yml"
  - "templates/web.template.yml"
  # - "templates/web.ssl.template.yml" # uncomment if using HTTPS
  - "templates/web.ratelimited.template.yml"
  - "templates/web.socketed.template.yml"  # <-- Added
# which ports to expose?
expose:
  - "2222:22" # If you don't need to use ./launcher ssh app, you can remove this too

```


## Create an NGINX 'site' for the outer nginx

For an HTTP site, put this in `/etc/nginx/conf.d/discourse.conf`, making sure to change the `server_name`:

```nginx
server {
	listen 80; listen [::]:80;
	server_name forum.example.com;  # <-- change this

	location / {
		proxy_pass http://unix:/var/discourse/shared/standalone/nginx.http.sock:;
		proxy_set_header Host $http_host;
		proxy_http_version 1.1;
		proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
	}
}
```

For an [HTTPS site](/t/allowing-ssl-for-your-discourse-docker-setup/13847), make `/etc/nginx/conf.d/discourse.conf` look like this:

```nginx
server {
    listen 80; listen [::]:80;
    server_name forum.example.com;  # <-- change this

    return 301 https://$host$request_uri;
}

server {
    listen 443 ssl spdy;  listen [::]:443 ssl spdy;
    server_name forum.example.com;  # <-- change this

    ssl on;
    ssl_certificate      /var/discourse/shared/standalone/ssl/ssl.crt;
    ssl_certificate_key  /var/discourse/shared/standalone/ssl/ssl.key;
    ssl_dhparam          /var/discourse/shared/standalone/ssl/dhparams.pem;
    ssl_session_tickets off;
    ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-DSS-AES128-GCM-SHA256:kEDH+AESGCM:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA:ECDHE-ECDSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-DSS-AES128-SHA256:DHE-RSA-AES256-SHA256:DHE-DSS-AES256-SHA:DHE-RSA-AES256-SHA:ECDHE-RSA-DES-CBC3-SHA:ECDHE-ECDSA-DES-CBC3-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:AES128-SHA:AES256-SHA:AES:CAMELLIA:DES-CBC3-SHA:!aNULL:!eNULL:!EXPORT:!DES:!RC4:!MD5:!PSK:!aECDH:!EDH-DSS-DES-CBC3-SHA:!EDH-RSA-DES-CBC3-SHA:!KRB5-DES-CBC3-SHA;

    # enable SPDY header compression
    spdy_headers_comp 6;
    spdy_keepalive_timeout 300; # up from 180 secs default

    location / {
        proxy_pass https://unix:/var/discourse/shared/standalone/nginx.https.sock:;
        proxy_set_header Host $http_host;
        proxy_http_version 1.1;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
```

Make sure that the default site is either disabled or has the correct `server_name` set.

Then, in a shell:

```bash
# Make sure that Discourse isn't running
/var/discourse/launcher stop app || true

# test configuration
sudo nginx -t
# Important: If nginx -t comes back with an error, correct the config before reloading!
sudo service nginx reload

# Rebuild the container to apply changes
/var/discourse/launcher rebuild app
```

## Create your other sites

You're done with the Discourse section!

Make other NGINX "sites", then link and enable them, as in the last step above.

<small class="documentation-source">Source: [https://meta.discourse.org/t/running-other-websites-on-the-same-machine-as-discourse/17247](https://meta.discourse.org/t/running-other-websites-on-the-same-machine-as-discourse/17247)</small>
