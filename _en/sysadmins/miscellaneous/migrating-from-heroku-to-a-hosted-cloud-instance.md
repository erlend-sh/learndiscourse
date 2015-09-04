---
title: Migrating from Heroku to a Hosted/Cloud instance
---

<small class="documentation-source">Source: [https://meta.discourse.org/t/migrating-from-heroku-to-a-hosted-cloud-instance/32868](https://meta.discourse.org/t/migrating-from-heroku-to-a-hosted-cloud-instance/32868)</small>

If you ever need to migrate away from Heroku to a currently supported infrastructure by discourse it can be quite troublesome. 

We did the following to be able to create a backup which cloud thereafter be imported by discourses hosted solution. These steps can also be used if you just want to migrate to your own cloud hosted instance.

## Get the data out of Heroku
There are 2 parts you need to backup:

 - Database
 - Images

Note: **Before you continue make sure the heroku version is updated to the last version**

### Export the DB
To export the DB from heroku to your development system follow the instructions here:
https://devcenter.heroku.com/articles/heroku-postgres-import-export

You can also login to the dashboard and create and download a PG dump.

### Get the images
In our case we saved the images to AWS S3. To download all the images at once we used the AWS CLI.

 1. First make sure you have the AWS CLI installed.
http://docs.aws.amazon.com/cli/latest/userguide/installing.html
 2. Use the S3 argument to download your images.
http://docs.aws.amazon.com/cli/latest/reference/s3/index.html

For example:

    aws s3 cp /tmp/foo/ s3://bucket/ --recursive

## Build a new discourse instance
Create a new discourse instance by following the instructions:

https://github.com/discourse/discourse/blob/master/docs/INSTALL-cloud.md

## Start the restore
Assuming that you have a working discourse instance and that the versions of both heroku and the new cloud instance are the same (discourse versions) lets start the import.

### Get your backups from your local system in the docker container.
To get your images and db from your local to the vps I prefer scp. You can also do this with an sftp client if that is your preference.

An example of the SCP command assuming that your public key is set:

    scp /tmp/latest.dump root@xxx.xxx.xxx.xxx:/tmp

### Get the backups in the container
The Container has one volume mounted; `/var/discourse/shared/standalone/`

Copy the backups to this location and you can access them when your inside your container.

### Importing your backups
Before we can start importing we need to convert the **compressed pg dump** that heroku gave us to an sql file. 

Else you get these kinds of issues:
http://stackoverflow.com/questions/10852631/how-to-import-a-heroku-pg-dump-into-local-machine

#### Convert Compressed pg dump
You need to enter the Docker container inside your vps. Thereafter we can convert the dump to an sql file.

Commands:

    cd /var/discourse
    sudo ./launcher enter app
     sudo -u postgres pg_restore -O -f /tmp/latest.sql  /shared/latest.dump
    exit
    exit

Now you should have a file called latest.sql in you tmp folder.

#### Do the restore
Go to the following link and follow the instructions under the **Restore** header.
https://meta.discourse.org/t/advanced-manual-method-of-manually-creating-and-restoring-discourse-backups/18273

#### Rebuild container
Discourse relays heavily on caching. This means we need to rebuild the container after the DB is restored. Outside your cotainer in the root of your vps do:

    cd /var/discourse
    sudo ./launcher rebuild app

## Optional: Resetting your force_hostname value
There is a good chance that you set the force_hostname value to make sure all links are working correct. In the new environment this is no longer needed so you need to unset the value

    cd /var/docker
    sudo ./launcher enter app
    su - discourse
    bundle exec rails c
    SiteSetting.force_hostname = “"
    exit
    exit
    exit
    

Now you should be good to go! Create backups to be imported later or just let it run like this.
