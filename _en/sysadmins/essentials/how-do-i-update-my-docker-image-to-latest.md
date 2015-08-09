---
title: How do I update my Docker image to latest?
---

<small class="doc-source">Source: https://meta.discourse.org/t/how-do-i-update-my-docker-image-to-latest/23325</small>

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
