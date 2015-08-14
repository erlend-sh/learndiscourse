---
title: How to configure Discourse Docker on higher end servers
---

<small class="documentation-source">Source: [https://meta.discourse.org/t/how-to-configure-discourse-docker-on-higher-end-servers/18569](https://meta.discourse.org/t/how-to-configure-discourse-docker-on-higher-end-servers/18569)</small>

When you install Discourse on an instance with 4GB or more you should consider the following:

### Monitor your setup

If you elect to use a higher end setup we strongly recommend you set up monitoring using [Newrelic][1] or some other monitoring service. You will need to analyze the results of configuration changes to reach an optimal setup.

### Out of the box Discourse Docker ships with 3 web workers

Web workers are served via [unicorn][2], this process is capable of serving one request at a time, you should at least have one worker per CPU. You can increase this number in your template like so

```
env: 
   # to raise to 6 workers 
   UNICORN_WORKERS: 6
```

### Database configuration is optimised for 2GB of RAM 

As guideline you want to dedicate 1/3 of the memory available to postgres to "shared_buffers" to raise this:

```
params:
  db_shared_buffers: "1GB"
```

### Be sure to install latest Discourse Docker

We update our base templates with various optimisations, be sure to update regularly to ensure you take advantage of it.

  [1]: https://meta.discourse.org/t/newrelic-plugin/12986
  [2]: http://unicorn.bogomips.org/
