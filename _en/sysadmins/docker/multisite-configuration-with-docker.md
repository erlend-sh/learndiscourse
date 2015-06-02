---
title: Multisite configuration with Docker
name: multisite-configuration-with-docker
---

You may wish to host multiple domains on a singled Docker setup. To do so follow these instructions:

### We strongly recommend you run separate web and data containers

The standalone container is extremely easy to configure, however has a couple of drawbacks

1. You will need to stop your site when bootstrapping a new image
2. You run through the db bootstrap only when needed 

Multisite is a fairly advanced topic, learn about hooks before attempting this. 

###Understand hooks

Discourse templates use [pups][1], its rules are simple and powerful. 

Each rule you run may define a hook: 

```
run:
  exec:
    cd: some/path
    hook: my_hook
    cmd:
      - echo 1
```

Later on in your container you can *insert* rules before or after a hook:

```
hooks:
  before_my_hook:
    - exec: echo "I ran before"
  after_my_hook:
     - exec: echo "I ran after"
```

So in the example above you will see output like the following:

> I ran before
> 1
> I ran after

You can read through the templates in `/var/discourse/templates` to see what hooks you have available.

### Amend your standalone container to provision the site and talk to it

Replace the **entire** hooks section with:

```text
hooks:
  after_postgres:
     - exec: sudo -u postgres createdb b_discourse || exit 0
     - exec:
          stdin: |
            grant all privileges on database b_discourse to discourse;
          cmd: sudo -u postgres psql b_discourse
          raise_on_fail: false

     - exec: /bin/bash -c 'sudo -u postgres psql b_discourse <<< "alter schema public owner to discourse;"'
     - exec: /bin/bash -c 'sudo -u postgres psql b_discourse <<< "create extension if not exists hstore;"'
     - exec: /bin/bash -c 'sudo -u postgres psql b_discourse <<< "create extension if not exists pg_trgm;"'

  after_code:
    - exec:
        cd: $home/plugins
        cmd:
          - mkdir -p plugins
          - git clone https://github.com/discourse/docker_manager.git
  before_bundle_exec:
    - file:
        path: $home/config/multisite.yml
        contents: |
         secondsite:
           adapter: postgresql
           database: b_discourse
           pool: 25
           timeout: 5000
           db_id: 2
           host_names:
             - b.discourse.example.com

  after_bundle_exec:
    - exec: cd /var/www/discourse && sudo -E -u discourse bundle exec rake multisite:migrate
```

There are 3 hooks in play:

1. after_postgres, ensures that after postgres is installed an additional db called `b_discourse` is created with the appropriate permissions. 

2. before_bundle_exec, ensures `docker_manager` is in place and that the `multisite.yml` file is in place (which defines where to find the databases)

3. after_bundle_exec, runs the custom db migration tast `rake multisite:migrate` this ensures all the dbs are up to date.


The above sample can be split into data container  / app container if needed (just run the after_postgres hook in the data container and the rest in web container) 

The above sample can be extended to provision evne more DBs, to do so, provision more dbs by duplicating the create db etc calls, and make sure you have additional sites in multisite.yml

Make **sure** you amend the `host_names` node in multisite.yml to match the actual host name you wish to host. 

  [1]: https://github.com/samsaffron/pups