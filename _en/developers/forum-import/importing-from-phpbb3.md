---
title: Importing from phpBB3
weight: 380
---

<small class="documentation-source">Source: [https://meta.discourse.org/t/importing-from-phpbb3/30810](https://meta.discourse.org/t/importing-from-phpbb3/30810)</small>

This guide describes how to use the [phpBB3 import script][1] for importing from phpBB **3.0.x** and **3.1.x**.

The script used in this Howto is included in Discourse since **v1.4.0.beta5** and in the `master` or `tests-passed` branches.

## What data will be imported?
- Users
  - Avatars *(optional)*
  - Anonymous users (either as user "system" or as suspended users)
  - Password hashes that can be used with the [migratepassword plugin][6] *(optional)*
- Categories and Forums
- Topics and Posts
  - Polls *(optional)*
  - Smilies
  - BBCodes
  - Internal links to topics and posts
- Sticky topics and (global) announcments
- Private Messages *(optional)*
- Attachments *(optional)*
- Bookmarks *(optional)*


## Importing using development environment
1. Setup your development environment (e.g. by following the guides for [Ubuntu][2] or [Mac OS X][3])
   The following instructions assume that you are using Ubuntu.

1. Make sure that neither Discourse nor Sidekiq are running.

1. Install some dependencies:

    ```bash
    sudo apt-get update
    sudo apt-get install libmysqlclient-dev
    cd ~/discourse
    echo "gem 'mysql2'" >> Gemfile
    echo "gem 'ruby-bbcode-to-md', :github => 'nlalonde/ruby-bbcode-to-md'" >> Gemfile
    bundle install
    git checkout Gemfile Gemfile.lock
    ```

1. Configure your import. There's an [example settings file][4] at `~/discourse/script/import_scripts/phpbb3/settings.yml`

1. Start your import (change the path to your settings file if you put your custom settings somewhere else):

    ```bash
    cd ~/discourse/script/import_scripts
    ruby phpbb3.rb phpbb3/settings.yml
    ```

1. Wait until the import is done. You can restart it if it slows down to a crawl.

1. Start your Discourse instance: `bundle exec rails server`

1. Start Sidekiq and let it do its work: `bundle exec sidekiq -q default`
   Depending on your forum size this can take a long time. You can monitor the progress at [http://localhost:3000/sidekiq][5] 


## Roadmap
Here's a list (in no particular order) of things that are still missing from the importer:

- Imported text that looks like Markdown should be escaped
- Close topics that are closed in phpBB3
- Import unapproved posts as hidden posts
- Import read status for each post
- Import custom profile fields
- Import groups
- Improve the BBCode to Markdown converter ([ruby-bbcode-to-md][7])
- Support custom patterns for internal links to topics and posts (SEO optimized URLs)
- *(in progress)* Provide an easy solution for importing within a Docker container
- *(in progress)* Add support for more database sources: MS SQL Server, Oracle, PostgreSQL

Feel free to start your favorite Ruby IDE and help making the importer even better. :wink:   


## FAQ
**I have a heavily modded forum. Will the import script still work?**
  Maybe. It depends on what changes those mods made to the database. You'll have to give it a try.

**I have custom smilies in my forum. Are they imported?**
  Yes. You can map them to Emojis in the settings file, otherwise they'll get imported as images. All the default smilies (except <img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/4/4/442e459c5ced45cb70e8a05e77e07cea6fee4928.gif" width="15" height="17" title="Mr. Green">, <img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/5/a/5ab5dab9a2b10cda0879d36b4794bf6f0f0bb7bc.gif" width="17" height="17" title="Geek"> and <img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/6/0/60aa0bc609d6c1cf1242a151e9c1410e4f9e6e44.gif" width="17" height="18" title="Uber Geek">) have already an Emoji mapping.

**The importer warns about invalid votes. What is wrong?**
  This happens when the votes in your database reference users or poll options that do not exist. The cause for the latter is usually a migration from phpBB2 to phpBB3. You can fix this with a [simple UPDATE in your database][8] if you still have a backup of your old phpBB2 database. Otherwise you'll have to ignore those warnings.


  [1]: https://github.com/discourse/discourse/blob/master/script/import_scripts/phpbb3.rb
  [2]: http://learndiscourse.org/beginners-guide-to-install-discourse-on-ubuntu-for-development
  [3]: http://learndiscourse.org/beginners-guide-to-install-discourse-on-mac-os-x-for-development
  [4]: https://github.com/discourse/discourse/blob/master/script/import_scripts/phpbb3/settings.yml
  [5]: http://localhost:3000/sidekiq
  [6]: https://github.com/discoursehosting/discourse-migratepassword
  [7]: https://github.com/nlalonde/ruby-bbcode-to-md
  [8]: https://gist.github.com/gschlager/c6ba58bdd2fa2839aebd
