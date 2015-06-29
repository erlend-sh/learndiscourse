---
title: Use one Fastmail account to serve multiple Discourse instances
name: use-one-fastmail-account-to-serve-multiple-discourse-instances
subsection: essentials
---

Discourse uses POP to extract mails from your mailbox and then deletes them. Any mail not recognized will be dropped. This could be a problem if you - for whatever reason - have only one mailbox to spare and want different domains aliases for that mailbox.

[Fastmail](https://www.fastmail.fm/) has the option to make a user login to a specific folder in stead of the whole account. This is very useful.

 1. Create a folder in your mailbox for every Discourse instance you have.
 2. Make sure each Discourse mail address is forwarded to the main mailbox. You can do that on the management page.
 3. Create a rule for every incoming `incoming@discourseinstance.domain.ext` to forward to each respective folder.
 4. Have each Discourse instance use their own `incoming+%{reply_key}@discourseinstance.domain.ext`. Do the same for incoming mail for categories.
 5. Have each Discourse instance use `mailbox+<folder_name>@main.account.ext` as username to login to the POP server. Change `<folder_name>` to the folder of the Discourse instance in the mailbox. This will restrict Discourse to only see messages in that folder.

I don't know of any other mail provider that has this way of logging in to POP accounts, but it works perfectly for me. Of course you can make lots of free mailboxes with Gmail, etc. But I didn't want to.
