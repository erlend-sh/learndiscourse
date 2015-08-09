---
title: Beginners Guide to Install Discourse on Ubuntu for Development
---

<small class="doc-source">Source: https://meta.discourse.org/t/beginners-guide-to-install-discourse-on-ubuntu-for-development/14727</small>

So you want to set up Discourse on Ubuntu to hack on and develop with?

We'll assume that you don't have Ruby/Rails/Postgre/Redis installed on your Ubuntu system. Let's begin!

*Although this guide assumes that you are using Ubuntu, but the set-up instructions will work fine for any Debian based ditribution.*

*(If you want to install Discourse for production use, see [our install guide][install_guide])*

## Install Discourse Dependencies

Run [this script][linux_script] in terminal, to setup Rails development environment:

    bash <(wget -qO- https://raw.githubusercontent.com/techAPJ/install-rails/master/linux)

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/9/9df737ab44032f2f671ac15513456bc668314591.png" width="690" height="189"> 

This will install following new packages on your system:

* [Git][git_link]
* [rbenv][rbenv_link]
* [ruby-build][ruby_build_link]
* [Ruby][ruby_link] (stable)
* [Rails][rails_link]
* [PostgreSQL][pg_link]
* [SQLite][sqlite_link]
* [Redis][redis_link]
* [Bundler][bundler_link]
* [ImageMagick][imagemagick_link]

Install Phantomjs:

For 32 bit macine:

    cd /usr/local/share
    sudo wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-linux-i686.tar.bz2
    sudo tar xvf phantomjs-1.9.8-linux-i686.tar.bz2
    sudo rm phantomjs-1.9.8-linux-i686.tar.bz2
    sudo ln -s /usr/local/share/phantomjs-1.9.8-linux-i686/bin/phantomjs /usr/local/bin/phantomjs
    cd

For 64 bit machine:

    cd /usr/local/share
    sudo wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-linux-x86_64.tar.bz2
    sudo tar xvf phantomjs-1.9.8-linux-x86_64.tar.bz2
    sudo rm phantomjs-1.9.8-linux-x86_64.tar.bz2
    sudo ln -s /usr/local/share/phantomjs-1.9.8-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs
    cd

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/0/0781669e092e0bdc29f8ec1830193503e884fd56.png" width="690" height="121"> 

*In case you have any of this package pre-installed and don't want to run entire script, see the [script][linux_script] and pick the packages you don't have currently installed. The script is fine-tuned for Discourse, and includes all the packages required for Discourse installation.*

Now that we have installed Discourse dependencies, let's move on to install Discourse itself.

## Clone Discourse

Clone the Discourse repository in `~/discourse` folder:

    git clone https://github.com/discourse/discourse.git ~/discourse

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/2/23578e144aa4c37d7e577d570d34789add1078f1.png" width="690" height="97"> 

## Setup Database

Open psql prompt as postgre user

    sudo -u postgres psql postgres

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/1/1cb9e5198b2695904204c2b1434427b610468610.png" width="690" height="177"> 
    
Create role **with the same name as your ubuntu system username** with *discourse* as password:

    CREATE ROLE discourse WITH LOGIN ENCRYPTED PASSWORD 'discourse' CREATEDB SUPERUSER;

In the above command, I named the role as **discourse**, this means that my ubuntu system username is **discourse**. (*It is necessary for role name to be same as system username, otherwise migrations will not run*)

Check that you have successfully created **discourse** role:

    \du
    
<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/6/60439a04daa4efc8756a9528873cffb61c327bee.png" width="690" height="176"> 

Create **discourse_development** and **discourse_test** database:

    CREATE DATABASE discourse_development WITH OWNER discourse ENCODING 'UTF8' TEMPLATE template0;
    CREATE DATABASE discourse_test WITH OWNER discourse ENCODING 'UTF8' TEMPLATE template0;
    
<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/1/183b46c7f1ffaa024e7c99884fbcc022da2c91b4.png" width="690" height="136"> 

Exit psql prompt by pressing <kbd>ctrl</kbd><kbd>d</kbd>

Now access psql prompt in **discourse_development** database as **discourse** user:

    psql -d discourse_development -U discourse -h localhost
    
When prompted for password, provide the password which you set at the time of creating role, if you followed the guide as is, the password is **discourse**

Run following commands, separately:

    CREATE EXTENSION pg_trgm;
    CREATE EXTENSION hstore;

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/0/04f4c1e4b3dd8ea1d183f653a77d35baca8c1201.png" width="690" height="300">

Exit psql prompt by pressing <kbd>ctrl</kbd><kbd>d</kbd>

Now access psql prompt in **discourse_test** database as **discourse** user:

    psql -d discourse_test -U discourse -h localhost
    
When prompted for password, provide the password which you set at the time of creating role, if you followed the guide as is, the password is **discourse**

Run following commands, separately:

    CREATE EXTENSION pg_trgm;
    CREATE EXTENSION hstore;

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/d/d2a25de9f227831bf66107ab2ddc1a7abafca2f4.png" width="690" height="302"> 

Exit psql prompt by pressing <kbd>ctrl</kbd><kbd>d</kbd>

You have set-up the database successfully!

## Bootstrap Discourse

Switch to your Discourse folder:

    cd ~/discourse

Install the needed gems

    bundle install

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/e/e1e8390c232c20f6b532c80927cec07185a8e556.png" width="690" height="236"> 

Now that you have successfully configured database connection, run this command:

    bundle exec rake db:migrate db:test:prepare db:seed_fu

Now, try running the specs: 

    bundle exec rake autospec

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/8/8a645e90108980cea7fa06a524ecbf1558e142f1.png" width="690" height="253"> 

Start rails server:

    bundle exec rails server

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/a/a8e7892e23bbfe3e613ebc6062605989de83310c.png" width="690" height="218"> 

You should now be able to connect to discourse app on [http://localhost:3000](http://localhost:3000) - try it out!

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/3/3f2fbcd03c5a30b08c51155130418085da77744e.png" width="690" height="188"> 

## Configure Mail and Create New Account

We will use [MailCatcher][mc] to serve emails in development environment. Install and run MailCatcher:

    gem install mailcatcher
    mailcatcher --http-ip 0.0.0.0

Create new account:

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/1/d/1d2e710b0865e78868c74d6cc54f96d1e2eb9303.png" width="690" height="384"> 

Check confirmation email by going to MailCatcher web interface at http://localhost:1080/

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/2/9/292a2cb247b37770cf4506f8745fdc39753e547e.png" width="690" height="172"> 

*If you did not receive the email, try running this in console*: `bundle exec sidekiq -q default`

Click the confirmation link and your account will be activated!

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/8/8fc06df9b084b4535bcafaaef675799d6ad3e5c9.png" width="690" height="154"> 

## Access Admin

Now, to make your account as admin, run the following commands in rails console:

    RAILS_ENV=development bundle exec rails c
    u = User.last
    u.admin = true
    u.save

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/a/aa5478bc48ef8fef622e09e7948abb8ad8218000.png" width="690" height="441"> 

Once you execute the above commands successfully, check out your Discourse account again:

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/7/72840ed4dbbc02544471649ee4eaa272fde205ef.png" width="690" height="371"> 

Congratulations! You are now the admin of your own Discourse installation!

Happy hacking!

If anything needs to be improved in this guide, feel free to ask on [meta.discourse.org][meta], or even better, submit a [pull request][gh].


  [linux_script]: https://github.com/techAPJ/install-rails/blob/master/linux
  [git_link]: http://git-scm.com/
  [rbenv_link]: https://github.com/sstephenson/rbenv
  [ruby_build_link]: https://github.com/sstephenson/ruby-build
  [ruby_link]: https://www.ruby-lang.org/
  [rails_link]: http://rubyonrails.org/
  [pg_link]: http://www.postgresql.org/
  [sqlite_link]: https://sqlite.org/
  [redis_link]: http://redis.io/
  [bundler_link]: http://bundler.io/
  [imagemagick_link]: http://www.imagemagick.org/
  [meta]: https://meta.discourse.org/t/developers-guide-to-install-discourse-on-ubuntu/14727
  [gh]: https://github.com/techAPJ/discourse-development-ubuntu
  [install_guide]: https://github.com/discourse/discourse/blob/master/docs/INSTALL.md
  [docker_guide]: https://meta.discourse.org/t/beginners-guide-to-deploy-discourse-on-digital-ocean-using-docker/12156
  [mc]: http://mailcatcher.me/
