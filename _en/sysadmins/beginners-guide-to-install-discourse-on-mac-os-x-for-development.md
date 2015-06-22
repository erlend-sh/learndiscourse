---
title: Beginners Guide to Install Discourse on Mac OS X for Development
name: beginners-guide-to-install-discourse-on-mac-os-x-for-development
subsection: general
---

So you want to set up Discourse on Mac OS X to hack on and develop with?

We'll assume that you don't have Ruby/Rails/Postgre/Redis installed on your Mac. Let's begin!

*(If you want to install Discourse for production use, see [our install guide][install_guide])*

## Install Discourse Dependencies

Run [this script][mac_script] in terminal, to setup Rails development environment:

    bash <(curl -s https://raw.githubusercontent.com/techAPJ/install-rails/master/mac)

This script will install following new packages on your system:

* [Git][git_link]
* [rbenv][rbenv_link]
* [ruby-build][ruby_build_link]
* [Ruby][ruby_link] (latest stable)
* [Rails][rails_link]
* [PostgreSQL][pg_link]
* [Redis][redis_link]
* [Bundler][bundler_link]
* [ImageMagick][imagemagick_link]
* [PhantomJS][phantom_link]

*In case you have any of this package pre-installed and don't want to run entire script, see the [script][mac_script] and pick the packages you don't have currently installed. The script is fine-tuned for Discourse, and includes all the packages required for Discourse installation.*

Now that we have installed Discourse dependencies, let's move on to install Discourse itself.

## Clone Discourse

Clone the Discourse repository in `~/discourse` folder:

    git clone https://github.com/discourse/discourse.git ~/discourse

<img src="/uploads/default/5108/b45d6fa50bf04a25.png" width="571" height="142">

`~` indicates home folder, so Discourse source code will be available in your home folder.

## Setup Database

Open psql prompt:

    psql postgres

<img src="/uploads/default/5109/f4979d6b2c87338c.png" width="574" height="148">

Create **discourse_development** and **discourse_test** database with your *[account short name][short_name]* specified as role:

    CREATE DATABASE discourse_development WITH OWNER techapj ENCODING 'UTF8' TEMPLATE template0;
    CREATE DATABASE discourse_test WITH OWNER techapj ENCODING 'UTF8' TEMPLATE template0;

Note that in above commands I specified the role as *techapj*, this means that my [short name][short_name] is *techapj*, **replace this with your own [short name][short_name].**

<img src="/uploads/default/5110/baa6c05969965fea.png" width="573" height="235">

Exit psql prompt by pressing <kbd>control</kbd><kbd>d</kbd>

Now access psql prompt in **discourse_development** database as *your short name* user:

    psql -d discourse_development -U techapj -h localhost

Run following commands, separately:

    CREATE EXTENSION pg_trgm;
    CREATE EXTENSION hstore;

<img src="/uploads/default/5111/648ff254a5ef7492.png" width="571" height="208">

Exit psql prompt by pressing <kbd>control</kbd><kbd>d</kbd>

Now access psql prompt in **discourse_test** database as *your short name* user:

    psql -d discourse_test -U techapj -h localhost

Run following commands, separately:

    CREATE EXTENSION pg_trgm;
    CREATE EXTENSION hstore;

<img src="/uploads/default/5112/d19ad4366459954c.png" width="571" height="205">

Exit psql prompt by pressing <kbd>control</kbd><kbd>d</kbd>

You have set-up the database successfully!

## Bootstrap Discourse

Switch to your Discourse folder:

    cd ~/discourse

Install the needed gems

    bundle install

<img src="/uploads/default/5113/c4a5f73afcafaaa4.png" width="572" height="366">

Now that you have successfully installed gems, run this command:

    bundle exec rake db:migrate db:test:prepare db:seed_fu

Try running the specs:

    bundle exec rake autospec

<img src="/uploads/default/5114/b51c63ae8e6821a4.png" width="574" height="429">

All the tests should pass.

Start rails server:

    bundle exec rails server

<img src="/uploads/default/5115/216f280c66e42381.png" width="575" height="279">

You should now be able to connect with your Discourse app on [http://localhost:3000](http://localhost:3000) - try it out!

<img src="/uploads/default/5116/cd634c38298d7875.png" width="690" height="253">

## Create New Admin

To create a new admin, run the following commands in rails console:

    RAILS_ENV=development bundle exec rake admin:create

Just enter your input as suggested, you can create an admin account.

<img src="https://meta-discourse.global.ssl.fastly.net/uploads/default/4323/fccdb29463e82f23.png" width="690" height="154">

<img src="/uploads/default/5118/a07fb0c84c2b9fce.png" width="690" height="415">

Happy hacking!


  [mac_script]: https://github.com/techAPJ/install-rails/blob/master/mac
  [git_link]: http://git-scm.com/
  [rbenv_link]: https://github.com/sstephenson/rbenv
  [ruby_build_link]: https://github.com/sstephenson/ruby-build
  [ruby_link]: https://www.ruby-lang.org/
  [rails_link]: http://rubyonrails.org/
  [pg_link]: http://www.postgresql.org/
  [phantom_link]: http://phantomjs.org/
  [redis_link]: http://redis.io/
  [bundler_link]: http://bundler.io/
  [imagemagick_link]: http://www.imagemagick.org/
  [install_guide]: https://github.com/discourse/discourse/blob/master/docs/INSTALL.md
  [docker_guide]: https://meta.discourse.org/t/beginners-guide-to-deploy-discourse-on-digital-ocean-using-docker/12156
  [short_name]: http://forums.macrumors.com/showthread.php?t=898855
  [mc]: http://mailcatcher.me/
