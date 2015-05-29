---
title: Allowing SSL for your Discourse Docker setup
translations:
tags:
  - System Administration
---

So you'd like to enable SSL for your Docker-based Discourse setup? Let's do it! 

This guide assumes you used all the standard install defaults -- a container configuration file at`/var/discourse/containers/app.yml` and Discourse docker is installed at: `/var/discourse`

### Buy a SSL Certificate

Go to [namecheap][1] or some other SSL cert provider and purchase a SSL cert for your domain. Follow all the step documented by them to generate private key and CSR and finally get your cert. I used the apache defaults, they will work fine. 

Keep your private key and cert somewhere safe. 

### Place the Certificate and Key

Get a signed cert and key and place them in the `/var/discourse/shared/standalone/ssl/` folder 

Private key is:

 `/var/discourse/shared/standalone/ssl/ssl.key`

Cert is 

 `/var/discourse/shared/standalone/ssl/ssl.crt`

**File names are critical** do not stray from them or your nginx template will not know where to find the cert. 

Have a look at your `app.yml` configuration file to see where the shared folder is mounted. 

    volumes:
      - volume:
          host: /var/discourse/shared/standalone
          guest: /shared

In essence the files must be located at `/shared/ssl/ssl.key` `/shared/ssl/ssl.crt` inside the container.  

For all clients to find a path from your cert to a trusted root cert (i.e., not give your users any warnings), you may need to concatenate the cert files from your provider like so:

    cat "Your PositiveSSL Certificate" "Intermediate CA Certificate" "Intermediate CA Certificate" >> ssl.crt

### Configure NGINX

Add a reference to the nginx ssl template from your `app.yml` configuration file:

    templates:
      - "templates/postgres.template.yml"
      - "templates/redis.template.yml"
      - "templates/sshd.template.yml"
      - "templates/web.template.yml"
      - "templates/web.ssl.template.yml"

### Configure your Docker Container

Tell your container to listen on SSL

    expose:
      - "80:80"
      - "2222:22"
      - "443:443"

### Bootstrap your Docker Container

Rebuild your app

```
./launcher rebuild app
```

Profit, you are done!


### Troubleshooting

Be sure to read through the logs using 

```
./launcher logs app
```

If anything goes wrong. 

### How this works

The template used is vaguely based on @igrigorik's [recommended template][2] with two missing bits:

- I skipped [OSCP stapling][4] cause it involves a slightly more complex setup 
- I had to skip session tickets setting which is not available until we use mainline

The image has rewrite rules that will redirect any requests on either port 80 or 443 to https://DISCOURSE_HOST_NAME , meaning that if you have a cert that covers multiple domains they can all go to a single one. 

Customising this setup is very easy, see: 

https://github.com/discourse/discourse_docker/blob/master/templates/web.ssl.template.yml

You can make a copy of that file and amend the template as needed. 

The advantage of using templates and replace here is that we get to keep all the rest of the Discourse recommended NGINX setup, it changes over time. 

### Testing your config

See https://www.ssllabs.com/ssltest/ to make sure all is working correctly. It is possible for some browsers and OS combinations to be happy with partially configured https, so check it here first.

  [1]: https://www.namecheap.com
  [2]: https://meta.discourse.org/t/nginx-nginx-and-docker/13299/10?u=sam
  [4]: http://chimera.labs.oreilly.com/books/1230000000545/ch04.html#_ocsp_stapling