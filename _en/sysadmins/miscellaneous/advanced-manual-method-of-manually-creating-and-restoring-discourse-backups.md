---
title: Advanced, manual method of manually creating and restoring Discourse backups
---

As discussed [below][1], a warning for newbies: 

1. this is an advanced method! there is an automated, web UI way to restore from backups at `/admin/backups` which is so much easier. 
2. with the method below, no automatic backup is kept of the `/var/discourse/containers/app.yml` file which contains essential SMTP credentials and SSL customizations. Keep a copy of this offsite whenever you change it.
3. If you are using digital ocean, keep frequent snapshots of your droplets - preferably before each time you run `./launcher rebuild app` or do any upgrades. Unfortunately in my case this takes an hour each time and it's a manual process - but it's totally worth it if you are not familiar with docker and want to avoid a headache later.

----

Continuing the discussion from [Migrate db from old Discourse to new without updating](https://meta.discourse.org/t/migrate-db-from-old-discourse-to-new-without-updating/17956/6):

[quote="sam, post:6, topic:17956, full:true"]
I like this, can you perhaps may a canonical howto here cc @techAPJ
[/quote]

---

Dropping and recreating the schema is required if the current database contains a table or view that the old one does not, because of referential integrity and pg_dump not adding `CASCADE` to its drop statements.
This could be easier if the extensions weren't stored in the public schema.

---

Upgrading Discourse is not very hard, but there is always a risk involved. This is why creating a backup is always a strong recommendation before upgrades are installed -- but what should you do when your current version is so old that it does not have the backup feature?

The safest way to do this is to not attempt any in-place upgrades on the existing, outdated Discourse instance. Instead, we will manually create a backup and import it into a blank but up-to-date Discourse instance.

#### Note regarding default path changes

The default path for the docker manager scripts has recently changed from `/var/docker` to `/var/discourse`. Since the main purpose of this howto is to help admins of *older* versions of Discourse to migrate to a new versions, I will use the old default path name throughout the howto.

If you have a newer version of Discourse and the docker manager, simply switch the path names mentioned above where appropriate.

## Creating the backup

To create the backup, we need access to Discourse's database and uploaded files. This depends a lot on your current setup. If you

1. If your old Discourse...
  - lives in a Docker container, enter it:
`cd /var/docker`
`git pull`
`sudo ./launcher enter app`
`su - discourse`
  - does *not* live in a Docker container, you should at this point ensure that the user you're logged in as can use `pg_sql` to connect to Discourse's production database and has access to the uploaded files. You may also have to adjust the directory and file names below.

1. Export the database and uploaded files:
`pg_dump -xOf /shared/discourse-backup.sql -d discourse -n public`
`gzip -9 /shared/discourse-backup.sql`
`tar -czf /shared/discourse-uploads.tar.gz -C /var/www/discourse/public uploads`

1. Almost done. Type `exit` twice to leave the container, then copy the files `discourse-backup.sql.gz` and `discourse-uploads.tar.gz` from the host's shared folder, typicalls `/var/docker/shared/standalone` and store them somewhere safe. The SQL file contains password-equivalent material, so don't put this file on a webserver and don't send it unencrypted.

## Restoring the backup

As above, this procedure depends on your particular setup, so this howto can only cover the case that you followed the supported setup instructions and have Discourse running in an up-to-date Docker container.

1. Upload the backup files and copy them into `/var/docker/shared/standalone`, then run:
`gzip -d /var/docker/shared/standalone/discourse-backup.sql.gz`

1. As above, enter the container:
`cd /var/docker`
`sudo ./launcher enter app`

1. Flush your new Discourse's database. This step is *destructive*; you must be *absolutely* certain that you are in the correct container, connecting to the correct database and that it contains no important data.
```
sudo -u postgres psql discourse <<END
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;
ALTER SCHEMA public OWNER TO discourse;
CREATE EXTENSION IF NOT EXISTS hstore;
CREATE EXTENSION IF NOT EXISTS pg_trgm;
END
```

1. Restore the backup data:
`su - discourse`
`rm -rf /var/www/discourse/public/uploads`
`tar -C /var/www/discourse/public -xzf /shared/discourse-uploads.tar.gz`
`psql -d discourse -f /shared/discourse-backup.sql`

1. Bring the old database up-to-date by migrating it:
`cd /var/www/discourse`
`RAILS_ENV=production bundle exec rake db:migrate`

1. Exit and restart the container:
`exit`
`exit`
`./launcher restart app`


  [1]: http://learndiscourse.org/advanced-manual-method-of-manually-creating-and-restoring-discourse-backups?u=tobiaseigen

<small class="documentation-source">Source: [https://meta.discourse.org/t/advanced-manual-method-of-manually-creating-and-restoring-discourse-backups/18273](https://meta.discourse.org/t/advanced-manual-method-of-manually-creating-and-restoring-discourse-backups/18273)</small>
