---
title: Advanced Setup and Administration
---

Here are some of the more advanced Discourse setup and administration questions we see:



## How can I enable Cross-origin Resource Sharing with Docker?



Modify these settings in `app.yml` file:



    DISCOURSE_ENABLE_CORS: true

    DISCOURSE_CORS_ORIGIN: '*'



Now rebuild the container:



    cd /var/discourse

    ./launcher rebuild app



This will enable Cross-origin Resource Sharing on your Discourse instance.



## How can I use Nginx alongside the Discourse Instance?



Change the port the docker container binds to in `app.yml` to something other than 80; and then in your nginx install set up http forwarding to direct to this alternate port. Follow the steps for installing normally until you reach `./launcher bootstrap app`



 - Edit `app.yml` to bind to a port other than port 80 externally. Pick something that is not in use (maybe 4578?)



```yml

 - "4578:80"   # fwd host port 4578   to container port 80 (http)

```

 - Continue with the steps above (bootstraping, starting), and verify that you can see discourse on the alternate port. Use your server IP as above, and add in the port you chose. For example: `http://8.8.8.8:4578` if your server IP was 8.8.8.8.



- Configure your current nginx install to `proxy_pass` to the docker container. [Here][nginx_gist] is an example of something you can include in `sites-enabled`.



- Remember to restart your external nginx. 





## How can I change Upload Maximum value?



Add this text to your `app.yml` after `- exec: echo "Beginning of custom commands"`:

```

  - replace:

      filename: "/etc/nginx/conf.d/discourse.conf"

      from: /client_max_body_size.+$/

      to: client_max_body_size XXm;

```



Change `XX` to any amount of megabytes you want. Then rebuild your container with 



    ./launcher rebuild app



## How can I completely wipe my Discourse Instance?



If you want to destroy your entire Discourse instance data, and want to start fresh:



    rm -rf /var/discourse/shared*





## I can't upgrade my Docker based Discourse instance. Any workaround?



Try doing this:



    cd /var/discourse

    git pull

    ./launcher rebuild app





## How can I upgrade Docker on my Ubuntu server?



Run these commands:



    apt-get update

    apt-get dist-upgrade

    apt-get upgrade lxc-docker





## How can I set-up automatic security updates in Ubuntu?



Run this command:



    dpkg-reconfigure -plow unattended-upgrades





## How can I set-up email notification of other Ubuntu updates?



    apt-get install sendmail

    apt-get install apticron

    nano /etc/apticron/apticron.conf



(change `EMAIL` to `youremail@address.com`)



## My Docker container is low on Disk Space. How can I clean up old Docker containers?



A quick way to recover space



```

docker images --no-trunc| grep none | awk '{print $3}' | xargs -r docker rmi

```



  [nginx_gist]: https://gist.github.com/trident523/ee1be110212b4a7a1291

  [back_rest]: http://learndiscourse.org/move-your-discourse-instance-to-a-different-server

  [poll]: https://github.com/discourse/discourse/blob/master/plugins/poll/README.md

  [love_discourse]: https://meta.discourse.org/t/i-so-love-this-soft-thank-you/15439/2

  [docker_multisite]: http://learndiscourse.org/multisite-configuration-with-docker

  [troubleshoot]: https://meta.discourse.org/t/advanced-troubleshooting-with-docker/15927/6

<small class="documentation-source">Source: [https://meta.discourse.org/t/advanced-setup-and-administration/15929](https://meta.discourse.org/t/advanced-setup-and-administration/15929)</small>
