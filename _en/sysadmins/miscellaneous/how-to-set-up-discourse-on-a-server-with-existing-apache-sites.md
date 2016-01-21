---
title: How to set up Discourse on a server with existing Apache sites
---

**It's not as daunting as it sounds!**

As you probably know, the only supported installs of Discourse are the Docker installs. While this may sound a bit intimidating at first, it's really not all that bad. You basically need to do two things:

1. Install HAProxy (or an alternative) which will take over port 80 and then divert your Discourse traffic to your docker container, and all your other sites to your usual Apache set-up.

2. Let Apache know which port to listen for.

While this is only a rough guide, it should do a good job of pointing you in the right direction. Let's get started!

## Upgrade your kernel

I personally recommend you upgrade your kernel as docker works better with the latest kernels. Just Google how to upgrade your kernel for your distro. 

**Edit**: This may not be such a good idea after all as Docker will only support certain kernels with certain distros. So if you can, upgrade your OS instead.

## Install Docker

I used the CentOS guide here: https://docs.docker.com/installation/centos (you only need to go as far as installing docker - you don't need to pull any images)

Then start it, and set it to start on boot.

**Edit**: Discourse works best with the latest Docker version, for CentOS upgrade as per instructions here: http://linoxide.com/linux-how-to/docker-1-6-features-upgrade-fedora-centos/

## Install Discourse

Follow the install instructions (start from here: https://github.com/discourse/discourse/blob/master/docs/INSTALL-cloud.md#install-discourse). When you come to edit app.yml, under "## which TCP/IP ports should this container expose?" you want:

`"8888:80"   # fwd host port 8888   to container port 80 (http)`

*Once it's all installed you can continue setting up your Discourse forum after the rest of the steps below.*

## Install HAProxy

On CentOS it's  ```yum install haproxy```.

Then edit your config, to something like this:

[code]
global
    # to have these messages end up in /var/log/haproxy.log you will
    # need to:
    #
    # 1) configure syslog to accept network log events.  This is done
    #    by adding the '-r' option to the SYSLOGD_OPTIONS in
    #    /etc/sysconfig/syslog
    #
    # 2) configure local2 events to go to the /var/log/haproxy.log
    #   file. A line like the following can be added to
    #   /etc/sysconfig/syslog
    #
    #    local2.*                       /var/log/haproxy.log
    #
    log         127.0.0.1 local2
 
    # chroot      /var/lib/haproxy
    pidfile     /var/run/haproxy.pid
    maxconn     4000
    user        haproxy
    group       haproxy
    daemon
 
    # turn on stats unix socket
    stats socket /var/lib/haproxy/stats
 
defaults
    mode                    http
    log                     global
    option                  httplog
    option                  dontlognull
    option http-server-close
    option forwardfor       except 127.0.0.0/8
    option                  redispatch
    retries                 3
    timeout http-request    10s
    timeout queue           1m
    timeout connect         10s
    timeout client          1m
    timeout server          1m
    timeout http-keep-alive 10s
    timeout check           10s
    maxconn                 3000
 
 
frontend http-in
        bind *:80
        default_backend main_apache_sites
 
        # Define hosts
        acl host_discourse hdr(host) -i my_discourse_site.com
 
        # figure out which one to use
        use_backend discourse_docker if host_discourse
 
backend main_apache_sites
    server server1 127.0.0.1:8080 cookie A check
 
backend discourse_docker
    server server2 127.0.0.1:8888 cookie A check
[/code]


## Edit Apache config

Edit the Apache config to listen on port 8080: `Listen *:8080`
Edit all of the existing virtual host files for each domain to reflect this change (first line should read) `<VirtualHost *:8080>`


## Install mod_extract_forwarded

You'll want to install this or everyone's IP will be of your servers. For CentOS see the guide here http://albertech.net/2014/03/preserve-remote-ip-address-with-haproxy-centos

For Centos 7, use: http://httpd.apache.org/docs/trunk/mod/mod_remoteip.html


## Start HAProxy, restart apache and proceed to set up your discourse install

Set HAProxy to start to start on boot, start it, and then restart Apache to pick up your changes and you should be all sorted. All you've got left to do is set up your Discourse install.

*Thanks to @macsmith71 for his help with HAProxy :)*
*If I've missed anything out please let me know, it's way past my bed time* :stuck_out_tongue:

<small class="documentation-source">Source: [https://meta.discourse.org/t/how-to-set-up-discourse-on-a-server-with-existing-apache-sites/30013](https://meta.discourse.org/t/how-to-set-up-discourse-on-a-server-with-existing-apache-sites/30013)</small>
