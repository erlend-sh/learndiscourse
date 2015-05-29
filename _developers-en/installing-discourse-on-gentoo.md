---
title: Installing Discourse on Gentoo
translations:
tags:
  - System Administration
---

Hello everybody, I tried to install Discourse on my Gentoo box and managed to start the development. I hope this can help other Gentoo users.

Installing necessary packages
=======
     sudo emerge dev-lang/ruby dev-db/postgresql-base www-servers/nginx dev-db/redis

Creating user for discourse
=======
Add user in `/etc/passwds`:

    sudo useradd -d /var/www/discourse/ discourse

Create user in postgresql:

    sudo -u postgres createuser discourse -s -P

Clone discourse repo
======
Clone repo:

    sudo git clone https://github.com/baus/discourse.git /var/www/discourse

Change ownership:
    
    sudo chown -R discourse:discourse /var/www/discourse

Installing RVM and other gems
======
First we need to switch to discourse, we also need to `unset RUBYOPT` to avoid potential problems. 

    su - discourse
    unset RUBYOPT

Install `rvm`:
    
    \curl -L https://get.rvm.io | bash -s stable
    . ~/.bash_profile
    rvm install 2.0.0
    rvm use 2.0.0 --default

Install `bundler`:

    gem install bundler

Install `thin` as server for development:

    gem install thin

(Optional) If you want to use `rails server`, you also need to install `railties`:

    gem install railties

Install all other gems

    bundle install

Configuring discourse
========

Copy example configuration files:

    cp ~/config/database.yml.sample ~/config/database.yml
    cp ~/config/redis.yml.sample ~/config/redis.yml

Remember to add username and passwords of the database user to `~/config/database.yml`

    vim ~/config/database.yml

Test run
========

    thin start

