---
title: Migrating to Discourse from another Forum software
weight: 400
---

<small class="documentation-source">Source: [https://meta.discourse.org/t/migrating-to-discourse-from-another-forum-software/16616](https://meta.discourse.org/t/migrating-to-discourse-from-another-forum-software/16616)</small>

So you want to migrate your existing forum to Discourse? That's great! Let's get started!

We recommend setting up a development environment on your machine (or inside a virtual machine) and run the import there instead of inside the docker container. Then you will be able to create a backup and import it on your production instance. Refer the [OS X](https://meta.discourse.org/t/beginners-guide-to-install-discourse-on-mac-os-x-for-development/15772) or [Ubuntu](https://meta.discourse.org/t/beginners-guide-to-install-discourse-on-ubuntu-for-development/14727) installation guide for development.

Discourse currently provide import scripts for vBulletin, bbPress, Drupal & Kunena/Joomla. The import scripts are available under **[script/import_scripts](https://github.com/discourse/discourse/tree/master/script/import_scripts)** folder.

The bbpress and Drupal import script requires database dump to be present and imported in your MySQL database. In the case of the Kunena/Jooma script, a csv file with the users from Joomla is currently required. In the future, the script can be improved by changing it to read from the Joomla users table in MySQL.

We highly recommend to read the script before performing import, as the script is meant for developers. Near the top of the scripts, a connection is made to the MySQL database containing the source data. At a minimum, the connection settings will need to be changed. You may also want to change the SQL queries that fetch the data to import into Discourse. For example, if you want to exclude really old posts, you can add a condition to the where clauses.

After reviewing and modifying, to run the *bbPress* import script you will do:

    cd path/to/your/discourse_folder
    ruby script/import_scripts/bbpress.rb

This process will be similar for other import scripts.

The import scripts are work in progress, new import scripts will be added over time. Contributions are welcome!
