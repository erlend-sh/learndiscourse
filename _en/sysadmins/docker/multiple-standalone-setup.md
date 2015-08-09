---
title: Multiple Standalone Setup
---

<small class="doc-source">Source: https://meta.discourse.org/t/multiple-standalone-setup/30142</small>

So multisite confuses you, and you got the memory to dish out? 

This guide is a how-to for people who can't quite wrap their heads around multisite, but need to have... multiple sites! Easy peasy.

## Assumptions ##
 - you've got multiple subdomains pointed to your server IP
 - you've got at least 1 gig for each site in combined memory and swap
 - you have root access to install new apps
 - you're already familiar with docker and basic standalone setup
 - currently on ubuntu 14.04 64bit


Okay, with that out of the way, lets move forward. 

You'll need to setup nginx as a reverse proxy so that you can have the multiple web apps running through the same http port externally (80 or 443), assuming this is http, this is how it'll work out..

Install nginx

    apt-get install nginx

zoom to the correct directory and download this snippet into it, rename appropriately

    cd /etc/nginx/sites-enabled
    wget https://gist.githubusercontent.com/trident523/ee1be110212b4a7a1291/raw/9415a7f2e9bfd84a1c8857e17686bd526d4e652f/discourse.conf
    mv discourse.conf anyname.conf
    cp anyname.conf anyother.conf
    nano anyname.conf anyother.conf

so you should see a file like this:

https://gist.githubusercontent.com/trident523/ee1be110212b4a7a1291/raw/9415a7f2e9bfd84a1c8857e17686bd526d4e652f/discourse.conf

  upstream **discourse** {
   #fail_timeout is optional; I throw it in to see errors quickly
    server 127.0.0.1:**4578** fail_timeout=5;
     }
 
   # configure the virtual host
     server {
     # replace with your domain name
     server_name **discourse.example.com**;
 
  location / {
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header Host $http_host;
    proxy_redirect off;
    # pass to the upstream discourse server mentioned above
   proxy_pass http:// **discourse**;
      }
    }

You need to change the bold. Starting at the top, the two copies need to be differentiated. You can use discourse1, and discourse2, or whatever else. 

The port can be ascending, so 4578, and 4579 will work. 

The servername is the same name as you will configure in the app.yml files. These are the same as you will create the a-record with the hosting company. we'll use discourse1.example.com and discourse2.example.com.

So then the end result would be this:

  upstream discourse1 {
   #fail_timeout is optional; I throw it in to see errors quickly
    server 127.0.0.1:4578 fail_timeout=5;
     }
 
   # configure the virtual host
     server {
     # replace with your domain name
     server_name discourse1.example.com;
 
  location / {
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header Host $http_host;
    proxy_redirect off;
    # pass to the upstream discourse server mentioned above
   proxy_pass http://discourse1;
      }
    }

  upstream discourse2 {
   #fail_timeout is optional; I throw it in to see errors quickly
    server 127.0.0.1:4579 fail_timeout=5;
     }
 
   # configure the virtual host
     server {
     # replace with your domain name
     server_name discourse2.example.com;
 
  location / {
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header Host $http_host;
    proxy_redirect off;
    # pass to the upstream discourse server mentioned above
   proxy_pass http://discourse2;
      }
    }

Now nginx is setup, awesome. 

Do you already have an app.yml? If so, you just need to copy a second one and differentiate some things in the file, if not:

    cd /var/discourse
    cp /samples/standalone.yml /containers/discourse1.yml
    cd containers
    cp discourse1.yml discourse2.yml
    nano discourse1.yml discourse2.yml

now we need to change some settings inside the containers

look for this part:

https://i.imgur.com/Ksv4xOX.png

You see those ports? Change the outgoing http port to 4578 on the first container, and 2222 for ssh. The next container after you close this file make it one up, 4579, and 2223

If you recall there is section to fill in the basics, including hostname. This is where you match what you choose for the subdomains with your a-records, and the nginx config files earlier. We are using discourse1.example.com, and discourse2.example.com here. 

The only other differentiation is the volumes section below the standard configs. Check it here:

https://i.imgur.com/KNF534z.png

you see where I added an additional folder layer after shared? That's all there is to it. You can make this the hostnames, or ports, I suggest hostnames. 

After you have edited both yaml files, you can do the regular

    cd ..
    ./launcher bootstrap discourse1 && ./launcher start discourse1
    ./launcher bootstrap discourse2 && ./launcher start discourse2

The last step would be to start the nginx service

    service nginx restart 

if fail, check 

    nginx -t 

and solve issue. 

Now, that wasn't so painful, was it?
