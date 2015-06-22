---
title: Set up reply via email support
name: set-up-reply-via-email-support
subsection: essentials
---

So you'd like to set up reply via email support for your Discourse forum.

Good news! Unlike *outgoing* email, which is completely unsuitable for typical consumer mail services like GMail, Outlook, Yahoo Mail, etc, **incoming reply via-email tends to be extremely low volume**. Unless you have a truly massive forum with a zillion people replying to notification emails, you are probably safe using, say, Gmail.

So here's how to set it up using GMail as an example.

1. Create a new GMail account. Assign it a username like `discourse-replies@example.com` or in my case, `replies@example.com`. Give it a strong password.

2. Log in to this account via http://mail.google.com. Accept the terms of service, enter the CAPTCHA, load the default web interface. Maybe send a test email, receive a test email. Kick the tires.

3. POP3s access is *off* by default in Gmail, so turn it on via Settings, Forwarding and POP/IMAP:

    <img src="/uploads/default/34248/002f26ff28b96ca9.png" width="513" height="133">

    All incoming emails will be retained by default -- but you can tweak as needed.

3. Visit the Discourse settings and check the Email tab.

4. Change the following settings:
   - `reply_by_email_address` enter `replies+%{reply_key}@example.com`
   - `pop3s_polling_username` enter `replies@example.com`
   - `pop3s_polling_password` enter the password of that email account
   - `pop3s_polling_host` set to `pop.gmail.com`
   - `pop3s_polling_enabled` set to true
   - `reply_by_email_enabled` set to true

There is a certain amount of polling that goes on for this account, but we've set it to a low, safe volume -- you can configure the polling intervial via the `pop3 polling period` setting.

We do assume that your email service supports [plus addressing aka address tags](http://en.wikipedia.org/wiki/Email_address#Address_tags), so check that before starting. GMail obviously does.

If everything is working, you should see the footer of all notification mails now tell you that you can reply either by visiting the website, or replying via email:

> To respond, **reply to this email** or visit {topic URL} in your browser.

If things *aren't* working, check the `/logs` path on your Discourse in your web browser and look for email related error messages.

Note: we have seen difficulties when signing up for a GMail account from a different country than your server is located in. For example, if you create the Gmail account from the UK, but the server is in the USA.
