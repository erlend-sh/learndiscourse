---
title: Configure a firewall for Discourse
name: configure-a-firewall-for-discourse
---

It's unclear [if Linux distributions really "need" a firewall](https://meta.discourse.org/t/does-discourse-docker-automatically-configure-firewall-too/16750/11) -- but we have found that the following [Uncomplicated Firewall](https://wiki.ubuntu.com/UncomplicatedFirewall) rules work fine with a standard Docker based Discourse install:

    ufw allow http
    ufw allow https
    ufw allow ssh
    ufw enable


That is, allow HTTP (port 80), HTTPS (port 443), and SSH (port 22), and nothing else.

A firewall should not matter if you are using a default Docker install of Discourse, for the same reason almost no Linux distribution ships with a firewall enabled by default.

But if you have somehow installed extra services that talk to the outside world, adding a firewall gives you "belt and suspenders" security, if that is of interest to you.