---
title: Migrating to Discourse from another Forum software
weight: 400
---

<small class="documentation-source">Source: [https://meta.discourse.org/t/migrating-to-discourse-from-another-forum-software/16616](https://meta.discourse.org/t/migrating-to-discourse-from-another-forum-software/16616)</small>

So you want to migrate your existing forum to Discourse? That's great! Let's get started!

We recommend **setting up a development environment** on your machine (or inside a virtual machine) and run the import there instead of inside the docker container. Then you will be able to create a backup and import it on your production instance. Refer the [OS X](https://meta.discourse.org/t/beginners-guide-to-install-discourse-on-mac-os-x-for-development/15772) or [Ubuntu](https://meta.discourse.org/t/beginners-guide-to-install-discourse-on-ubuntu-for-development/14727) installation guide for development.

We highly recommend to **read the script** before performing import, as the script is meant for developers, and you will almost certainly **need to modify the script** file before beginning. Near the top of the scripts, a connection is made to the database containing the source data; so at a minimum, the connection settings will need to be changed. You may also want to change the SQL queries that fetch the data to import into Discourse. For example, if you want to exclude really old posts, you can add a condition to the where clauses.

After reviewing and modifying, to run the *SomeForumSoftware* import script you will do:

    cd path/to/your/discourse_folder
    bundle exec ruby script/import_scripts/some_forum_software.rb

This process will be similar for other import scripts.

Discourse currently provides import scripts for a wide range of forum software, including Vanilla, phpBB3, SMF2, bbPress, VBulletin, and others.

Many of these scripts have dedicated tutorials. You can find them [here](https://meta.discourse.org/search?q=category%3Ahowto%20tag%3Aimport).
The exhaustive list of import scripts is available under the [script/import_scripts](https://github.com/discourse/discourse/tree/master/script/import_scripts) folder on GitHub.
