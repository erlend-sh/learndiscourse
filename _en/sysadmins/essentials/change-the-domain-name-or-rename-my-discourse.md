---
title: Change the domain name or rename my Discourse?
name: change-the-domain-name-or-rename-my-discourse
subsection: essentials
---

You may eventually want to change the domain name of your Discourse instance, from say

`talk.foo.com` &rarr; `talk.bar.com`

Let's get started.

### Set the TTL for your DNS low, and in advance

You need to let everyone know that the domain is about to change, so change the TTL for your domain name to something low, like 60 minutes.

Do this days in advance so the change can propagate throughout the Internet, and the domain name change will take effect quickly.

### Remove old domain name from any site settings

Visit `/admin/site_settings` and query for any settings that contain the old site name.

<img src="/uploads/default/34697/31466cd37d79fe61.png" width="366" height="152">

If you get any hits on the old domain name, make sure you change those values.

### Edit Discourse site name in app.yml

Edit the hostname line in `app.yml`

    ## The domain name this Discourse instance will respond to
    DISCOURSE_HOSTNAME: 'talk.bar.com'

(Also, if you are using a CDN, **turn it off now** by commenting out that line in the `app.yml`. You can turn it back on later.)

After the change, rebuild:

`./launcher rebuild app`

Once you do this, your site will only respond to the new domain name.

### Change Your DNS

- turn off the old domain name

- point your new domain name to the IP of your Discourse.

Everything should come up OK, provided the site name was changed and the instance rebuilt properly in the previous steps.

Verify that the site is up and functioning, but to do that you probably need to log in, right? Which brings us to...

### Fix social logins

Your Twitter, Facebook, Google, Yahoo, GitHub social logins will all need to be edited to reflect the new domain name too. Refer to the respective guides in the howto category here.

Depending on how you logged in, you may need to do this first or you won't be able to log in once the name is changed.

### Replace all instances of the old name with the new name in posts

All the existing posts will still refer to the old domain. Let's fix that:

    ./launcher enter app
    discourse remap talk.foo.com talk.bar.com
    rake posts:rebake

This remaps text in posts from the old URL to the new URL, then regenerates all posts just in case.

And now you're done!

(but don't forget to turn the CDN back on after this, if you had one.)
