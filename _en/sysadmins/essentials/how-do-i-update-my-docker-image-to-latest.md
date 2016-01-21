---
title: How do I update my Docker image to latest?
---

We update our Docker image for security releases and other library updates. These updates are **not** picked up in `admin/upgrade`

To update

SSH into your web server using putty or your favorite SSH client. 

```text
cd /var/discourse
git pull
./launcher rebuild app
```

If you are running low on disk space (check with `df`) try clearing up old images using:

```
./launcher cleanup
```

If you cannot upgrade the container because Docker itself is out of date, upgrade Docker first. To upgrade Docker itself on Ubuntu:

    apt-get update
    apt-get dist-upgrade
    apt-get upgrade lxc-docker

<small class="documentation-source">Source: [https://meta.discourse.org/t/how-do-i-update-my-docker-image-to-latest/23325](https://meta.discourse.org/t/how-do-i-update-my-docker-image-to-latest/23325)</small>
