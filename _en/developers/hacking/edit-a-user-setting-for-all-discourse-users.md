---
title: Edit a user setting for all Discourse users
name: edit-a-user-setting-for-all-discourse-users
subsection: hacking
---

So you want to edit user setting for all Discourse users? Great, let's get started!

From console, run this command:

    ./launcher enter app

Access Rails console:

    rails c

From Rails console, run the query:

**To set the last seen date for users who have never logged in (never seen):**
```
User.where("last_seen_at IS NULL").update_all(last_seen_at: 1.week.ago)
```

**To default all users to mailing list mode (send an email for every new post):**
```
User.update_all(mailing_list_mode: true)
```

**To default all users to email always mode (do not suppress email notifications when user is active on the site):**
```
User.update_all(email_always: true)
```

That's it, you have edited user setting for all Discourse users!
