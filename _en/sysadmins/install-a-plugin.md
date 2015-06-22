---
title: Install a Plugin
name: install-a-plugin
subsection: essentions
---

So you want to install a plugin on your Discourse instance? Great, let's get started!

In this tutorial, we'll install [Discourse Spoiler Alert](https://github.com/discourse/discourse-spoiler-alert) plugin.

* Get the plugin's [GitHub](https://github.com/) or [Bitbucket](https://bitbucket.org/) `git clone` url.

* Add the plugin's repository url to your container's `app.yml` file:

```yml
hooks:
  after_code:
    - exec:
        cd: $home/plugins
        cmd:
          - mkdir -p plugins
          - git clone https://github.com/discourse/docker_manager.git
          - git clone https://github.com/discourse/discourse-spoiler-alert.git
```

(Add the plugin's `git clone` url just below `git clone https://github.com/discourse/docker_manager.git`)

* Rebuild the container:

```
cd /var/discourse
./launcher rebuild app
```

That's it, you've successfully installed the [Discourse Spoiler Alert](https://github.com/discourse/discourse-spoiler-alert) plugin on your Discourse instance!
