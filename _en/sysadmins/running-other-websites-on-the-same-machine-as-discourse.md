---
title: Running other websites on the same machine as Discourse
name: running-other-websites-on-the-same-machine-as-discourse
subsection: docker
---

If you want to run other websites on the same machine as Discourse, you need to set up an extra NGINX proxy in front of the Docker container.

If you have not already, please read the [Advanced Troubleshooting with Docker](https://meta.discourse.org/t/advanced-troubleshooting-with-docker/15927/) guide, as it covers the basics on the separation between host and container.

This guide **assumes you already have Discourse working** - if you don't, it may be hard to tell whether or not the configuration is working.

## Install nginx outside the container
First, make sure the container is not running:

    cd /var/discourse
    ./launcher stop app

Then install nginx from the package manager:

    sudo apt-get install nginx

## Change the container definition

This is where we change how Discourse actually gets set up. We don't want the container listening on ports - instead, we'll tell it to listen on a special file.

Change your app.yml to look like this:

```yml
# this is the base templates used, you can cut it down to include less functionality per container
templates:
  - "templates/cron.template.yml"
  - "templates/postgres.template.yml"
  - "templates/redis.template.yml"
  - "templates/sshd.template.yml"
  - "templates/web.template.yml"
  # - "templates/web.ssl.template.yml" # if HTTPS
  - "templates/web.ratelimited.template.yml"
  - "templates/web.socketed.template.yml" # <-- Added
# which ports to expose?
expose:
  - "2222:22" # If you don't need to use ./launcher ssh app, you can remove this too

```

## Firewall the port

Because we need to pass through the real IP of visitors, and this is done through HTTP headers, we don't want people to connect on 4001, as this would allow IP spoofing.

**Note: If your system already has `iptables` rules, check your other rules for conflicts with this.**

Sorry, but I don't have a command ready for you to paste for this. Try to get it working with the firewall you are using.
<!--
TODO this doesn't seem to work `    iptables -A INPUT ! -s localhost -p tcp --dport 4001 -j DROP`
-->

## Create a NGINX 'site' for the outer nginx

Put this in `/etc/nginx/sites-available/discourse`, making sure to change the `server_name`:

```
server {
	listen 80;
	# change this
	server_name forum.riking.org;

	location / {
        proxy_pass http://unix:/var/discourse/shared/standalone/nginx.http.sock:;
		proxy_set_header Host $http_host;
		proxy_http_version 1.1;
		proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
	}
}
```

For a HTTPS site, base the file off of this instead: <a class="attachment" href="/uploads/default/39778/ba7906f602aa6c37.txt">discourse.conf.txt</a> (1.3 KB)

Then, in a shell:

```bash
cd /etc/nginx/sites-enabled
sudo ln -s ../sites-available/discourse discourse

# test configuration
sudo nginx -t
# Important: If nginx -t comes back with an error, correct the config before reloading!
sudo service nginx reload
```

## Create your other sites

You're done with the Discourse section!

Make other NGINX "sites", then link and enable them, as in the last step above.
