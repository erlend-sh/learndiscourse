---
title: How to use a self-signed cert with Discourse for emails
---

<small class="documentation-source">Source: [https://meta.discourse.org/t/how-to-use-a-self-signed-cert-with-discourse-for-emails/32042](https://meta.discourse.org/t/how-to-use-a-self-signed-cert-with-discourse-for-emails/32042)</small>

Using a self-signed certificate with your SMTP and POP mail in Discourse is easy once you know how - here's how!

*There is a condition, and that is that your hostname (main domain for server - usually the domain used for your name servers) allows your other domains to check email through it (usually via mail.domain.com). Most hosting panels allow this.*

## Steps

- First create your self-signed certificate - just make sure your 'web server hostname' does not have http or www (so something like yourdomain.com)

- Then upload the certificate (not the key!) to somewhere on your server, such as yourmainsite.com/certs/8777373333.crt 

- Then add the following code to your app.yml:

```
run:
 - file:
     path: /tmp/add-cert
     chmod: +x
     contents: |
       #!/bin/bash -e
       #Download cert
       wget http://yourmainsite.com/certs/8777373333.crt  -O - > /usr/local/share/ca-certificates/your-email-cert.crt
       update-ca-certificates

 - exec: "/tmp/add-cert"
```

(Change `http://yourmainsite.com/certs/8777373333.crt` to match your details)

- Then `./launcher rebuild app` to rebuild your app.

- Then in your admin control panel, make sure the `pop3 polling host` setting is just the hostname (so not mail.domain.com, just domain.com).

That's it!!

If you need to trouble shoot:

`./launcher enter app`

Then `cd /etc/ssl/certs` and make sure your crt is there.

*Thanks to @riking for all his help in this :)*
