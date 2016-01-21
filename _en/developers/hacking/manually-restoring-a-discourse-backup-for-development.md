---
title: Manually restoring a Discourse backup for development
weight: 330
---

You've got yourself a Discourse backup file and want to load it into your development database, without using the web UI, or potentially with a different database name. Cool!

This will assume you already have a Postgres database server running, and you've already run the `createdb` command if appropriate.

Restoring the backup manually is easy, you just need a couple extra SQL statements on the end to switch the schema over.

```bash
$ tar zxvf backup-file.tar.gz
# you now have the dump.sql and meta.json files
$ DATABASE=discourse_development
$ psql $DATABASE < dump.sql
$ psql $DATABASE <<END
DROP SCHEMA IF EXISTS backup CASCADE;
ALTER SCHEMA public RENAME TO backup;
ALTER SCHEMA restore RENAME TO public;
END
$ bundle exec rake db:migrate
```

Guide based off [this post](https://meta.discourse.org/t/deliberately-created-partial-backups-for-local-postgres-queries/20939/3?u=riking).

<small class="documentation-source">Source: [https://meta.discourse.org/t/manually-restoring-a-discourse-backup-for-development/33551](https://meta.discourse.org/t/manually-restoring-a-discourse-backup-for-development/33551)</small>
