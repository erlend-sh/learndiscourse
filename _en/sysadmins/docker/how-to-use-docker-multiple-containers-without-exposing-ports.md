---
title: How to use Docker multiple containers without exposing ports
---

<small class="doc-source">Source: https://meta.discourse.org/t/how-to-use-docker-multiple-containers-without-exposing-ports/22283</small>

Hello everyone!

If you don't want to mess with the firewall rules and security of your server, you can configure your Docker multiple container setup with just links and **no** exposed ports!

This way you can share your data container (postgres/redis) with other containers without exposing it to the internet.

----------

**How to:**

 1. Edit your `data.yml` file commenting all the `expose` section:
    >\#expose:
    >\#   - "5432:5432"
    >\#   - "6379:6379"
    >\#   - "2221:22"

 1. Edit your `web_only.yml` file uncommenting the `links` section:
    >links:
    >- link:
    >name: data
    >alias: data
    
    *(remeber to use the name of your data container here)*

 1. The trick! Also on `web_only.yml` file, use your data container's name to connect to the database:
    > DISCOURSE_DB_HOST: data
    > DISCOURSE_REDIS_HOST: data

----------

####The Docker's Magic:
As explained on [Docker Container Linking][1] documentation, when you `--link` containers:
> Docker adds a host entry for the source container to the /etc/hosts file

So now the containers can communicate locally! Also:
> If you restart the source container, the linked containers /etc/hosts files will be automatically updated with the source container's new IP address, allowing linked communication to continue.




  [1]: https://docs.docker.com/userguide/dockerlinks/#docker-container-linking
