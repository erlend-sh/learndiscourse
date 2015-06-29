---
title: How to configure mailbox in Google Apps for user-friendly incoming email addresses for discourse categories (with screenshots)
name: how-to-configure-mailbox-in-google-apps-for-user-friendly-incoming-email-addresses-for-discourse-categories-with-screenshots
subsection: essentials
---

I had a bit of trouble figuring out how to set up the mailbox in google apps to work with Discourse so that there is a user-friendly incoming email address for each category. Here are some screenshots that show how I did it. Tested and it seems to be working well.

In summary: assuming the domain name is foo.com, there's an email mailbox discourse@foo.com for handling all discourse-bound mail, using discourse+replykey@foo.com to handle matching replies to topics and aliases for the mailbox to handle incoming mail for eg categoryname matched with nice email address categoryname@foo.com.  

**Google Apps settings from "Manage this Domain"**
<img src="/uploads/default/4831/56df4c0899ef2aac.png" width="690" height="495">

**Discourse email settings**
<img src="/uploads/default/4834/1fc798c0a79c0777.png" width="548" height="500">

**Discourse category settings**
<img src="/uploads/default/4835/9aee4e4bcee4a550.png" width="486" height="309">
