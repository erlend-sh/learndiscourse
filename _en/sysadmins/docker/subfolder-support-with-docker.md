---
title: Subfolder support with Docker
---

<small class="documentation-source">Source: [https://meta.discourse.org/t/subfolder-support-with-docker/30507](https://meta.discourse.org/t/subfolder-support-with-docker/30507)</small>

To serve Discourse from a subfolder (a.k.a. with a path prefix) on your domain, like http://www.example.com/forum, here's how to do it!

### Docker config

In the `env` section of your docker container yml file, add the `DISCOURSE_RELATIVE_URL_ROOT` setting with the subfolder you want to use.

```
env:
  ...
  DISCOURSE_RELATIVE_URL_ROOT: /forum
```

The `run` section needs some changes to send all Discourse routes to the right place. Here is a complete run section with subfolder support:

```
run:
    - exec:
        cd: $home
        cmd:
          - mkdir -p public/forum
          - cd public/forum && ln -s ../uploads && ln -s ../backups
          - rm public/uploads
          - rm public/backups
    - replace:
       global: true
       filename: /etc/nginx/conf.d/discourse.conf
       from: proxy_pass http://discourse;
       to: |
          rewrite ^/(.*)$ /forum/$1 break;
          proxy_pass http://discourse;
    - replace:
       filename: /etc/nginx/conf.d/discourse.conf
       from: etag off;
       to: |
          etag off;
          location /forum {
             rewrite ^/forum/?(.*)$ /$1;
          }
    - replace:
         filename: /etc/nginx/conf.d/discourse.conf
         from: $proxy_add_x_forwarded_for
         to: $http_fastly_client_ip
         global: true
```

After making these changes, bootstrap your Docker container as usual, or rebuild if you're changing an existing container.

```
./launcher bootstrap app
```

or

```
./launcher rebuild app
```

Attached is a complete example yml file of a standalone container.

<a class="attachment" href="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/5/c/5c3b3c1f3c120f9a909eb719d3d8bd7b6a8976e0.yml">subfolder-sample.yml</a> (3.1 KB)
