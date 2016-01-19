---
title: Replace rubygems.org with taobao mirror to resolve network error in China
---

rubygems.org hosts its resource in Amazon S3 which is disturbed by GFW. So `gem` and `bundle` complain from time to time.

This guide assumes you used docker installation. This guide also has a version in Chinese. [中文指南](https://meta.discoursecn.org/t/discourse/28)

### Add a template

Open your congiruation file, say,  `app.yml`.

Add a reference to the china template:

    templates:
      - "templates/postgres.template.yml"
      - "templates/redis.template.yml"
      - "templates/sshd.template.yml"
      - "templates/web.template.yml"
      - "templates/web.china.yml"

### Bootstrap docker container

Rebuild your app

    ./launcher rebuild app

Or bootstrap:

    ./launcher bootstrap app

You are done! Everything should work then.

<small class="documentation-source">Source: [https://meta.discourse.org/t/replace-rubygems-org-with-taobao-mirror-to-resolve-network-error-in-china/21988](https://meta.discourse.org/t/replace-rubygems-org-with-taobao-mirror-to-resolve-network-error-in-china/21988)</small>
