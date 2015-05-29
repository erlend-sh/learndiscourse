---
title: How do I update my Docker image to latest?
translations:
tags:
  - install
---

We update our Docker image for security releases and other library updates. These updates are **not** picked up in `admin/upgrade`

To update run: 

```text
cd /var/discourse
git pull
./launcher rebuild app
```

If you are running low on disk space (check with `df`) try clearing up old images using:

```
./launcher cleanup
```