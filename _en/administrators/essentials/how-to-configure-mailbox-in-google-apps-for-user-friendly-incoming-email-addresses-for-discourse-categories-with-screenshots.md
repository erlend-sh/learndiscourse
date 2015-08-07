---
title: How to configure mailbox in Google Apps for user-friendly incoming email addresses for discourse categories (with screenshots)
weight: 4
---

<small class="doc-source">Source: https://meta.discourse.org/t/how-to-configure-mailbox-in-google-apps-for-user-friendly-incoming-email-addresses-for-discourse-categories-with-screenshots/15374</small>

I had a bit of trouble figuring out how to set up the mailbox in google apps to work with Discourse so that there is a user-friendly incoming email address for each category. Here are some screenshots that show how I did it. Tested and it seems to be working well.

In summary: assuming the domain name is foo.com, there's an email mailbox discourse@foo.com for handling all discourse-bound mail, using discourse+replykey@foo.com to handle matching replies to topics and aliases for the mailbox to handle incoming mail for eg categoryname matched with nice email address categoryname@foo.com.  

**Google Apps settings from "Manage this Domain"**
<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/2/204affa03adebffffad327e24cdcd04827b77d25.png" width="690" height="495">

**Discourse email settings**
<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/8/844fad9e0dd9c53b22b2d828afeed66da833a67f.png" width="548" height="500">

**Discourse category settings**
<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/1/15482a1f051a4b4a32c8a17ec2c7d75451cd03a4.png" width="486" height="309">
