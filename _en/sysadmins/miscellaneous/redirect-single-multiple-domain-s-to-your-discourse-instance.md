---
title: Redirect single/multiple domain(s) to your Discourse instance
---

So you want to redirect domain(s) to your Discourse instance? Great, let's get started!

In this tutorial we'll show how to redirect `www.example.com` and `example.com` to `talk.example.com`.

## Update DNS Record

Update the A record for the domain(s) you want to redirect to original domain.

## Edit Configuration FIle

Open configuration file `app.yml`. From console, run these commands:

```
cd /var/discourse
git pull
nano containers/app.yml
```

Configuration file will open in *nano* editor. Search for *hooks* (with <kbd>Ctrl</kbd>+<kbd>W</kbd>) in the file:

```
hooks:
  after_code:
    - exec:
        cd: $home/plugins
        cmd:
          - mkdir -p plugins
          - git clone https://github.com/discourse/docker_manager.git
```

Add `after_web_config` block to the `hooks` (proper indentation is important):

```
hooks:
  after_code:
    - exec:
        cd: $home/plugins
        cmd:
          - mkdir -p plugins
          - git clone https://github.com/discourse/docker_manager.git
  after_web_config:
    - replace:
        filename: /etc/nginx/nginx.conf
        from: /sendfile.+on;/
        to: |
          server_names_hash_bucket_size 64;
          sendfile on;
    - file:
        path: /etc/nginx/conf.d/discourse_redirect_1.conf
        contents: |
          server {
            listen 80;
            server_name example.com;
            return 301 $scheme://talk.example.com$request_uri;
          }
    - file:
        path: /etc/nginx/conf.d/discourse_redirect_2.conf
        contents: |
          server {
            listen 80;
            server_name www.example.com;
            return 301 $scheme://talk.example.com$request_uri;
          }
```

You can add as many `file` blocks as you want, depending on number of domain(s) you want to redirect:

```
    - file:
        path: /etc/nginx/conf.d/discourse_redirect_3.conf
        contents: |
          server {
            listen 80;
            server_name discourse.example.com;
            return 301 $scheme://talk.example.com$request_uri;
          }
```

Modify the file name `discourse_redirect_3` and domain name to which you want to redirect `discourse.example.com` as per your need.

*Note that original domain name `talk.example.com` will remain same in all `file` blocks.*

After completing your edits, press <kbd>Ctrl</kbd>+<kbd>O</kbd> then Enter to save and <kbd>Ctrl</kbd>+<kbd>X</kbd> to exit.

## Rebuild Container

Run this command:

```
./launcher rebuild app
```

Congratulations, that's it! Try visiting `example.com` and `www.example.com`, they both will redirect to `talk.example.com`!

<small class="documentation-source">Source: [https://meta.discourse.org/t/redirect-single-multiple-domain-s-to-your-discourse-instance/18492](https://meta.discourse.org/t/redirect-single-multiple-domain-s-to-your-discourse-instance/18492)</small>
