---
layout: page
title: About
---

<p class="message">
  This is where we'll temporarily collect Discourse documentation pages. 
</p>

### How are articles categorised?

**Developers & System Administrators** section, at its most basic, requires a rudimentary level of comfort with the command line and simple sysadmin operations. Even though some of these articles are essentially targeted towards admins, they still require an admin to put on their developer-hat to get the job done. Keeping these articles in the developers section underlines the fact that they're not for the faint of heart.

**Designers** section, at its most basic, requires a rudimentary level of comfort with HTML, CSS and JavaScript. 

**Administrators & Moderators** section covers anything you can do from within the comfort of the Discourse admin panel (and administrative user interfaces).

**Users** section covers all the essential features available to normal Discourse users.

### What is the difference between 'Basic' and 'Advanced'?

Simply put, bearing in mind the section you're already in, an Advanced article assumes that you're already well versed in the concepts it explains, since any missteps could have dire consequences.

Basic articles cover topics that most Discourse forum owners will have to familiarise themselves with sooner rather than later.

<p class="message">
  A page's URL should only be affected by which section it is. Whether it's in "Install & Server Configuration" or "Forum Import", or if it's "Basic" or "Advanced" has no effect on the URL. These are just navigational helpers.
</p>

----

## docs.discourse.org/developers

### Install & Setup

- Installing Discourse (https://github.com/discourse/discourse/blob/master/docs/INSTALL.md)
- Basic Cloud Install (https://github.com/discourse/discourse/blob/master/docs/INSTALL-cloud.md)
- https://meta.discourse.org/t/how-to-create-an-administrator-account-after-install/14046
- https://meta.discourse.org/t/enable-a-cdn-for-your-discourse/14857
- https://meta.discourse.org/t/maxcdn-for-discourse/20523
- https://meta.discourse.org/t/troubleshooting-email-on-a-new-discourse-install/16326
- https://meta.discourse.org/t/install-a-plugin/19157
- https://meta.discourse.org/t/move-your-discourse-instance-to-a-different-server/15721/3
- https://meta.discourse.org/t/set-up-email-in-start-topic-via-email/27686
- https://meta.discourse.org/t/set-up-reply-via-email-support/14003
- https://meta.discourse.org/t/how-do-i-update-my-docker-image-to-latest/23325
- https://meta.discourse.org/t/change-the-domain-name-or-rename-my-discourse/16098
- https://meta.discourse.org/t/change-tracking-branch-for-your-discourse-instance/17014


### System Administration

- Advanced Install (https://github.com/discourse/discourse_docker)
- Multisite Configuration (https://meta.discourse.org/t/multisite-configuration-with-docker/14084)
- https://meta.discourse.org/t/create-a-swapfile-for-your-linux-server/13880/2
- https://meta.discourse.org/t/how-do-i-enable-dkim-for-non-hosted-discourse-emails/5487
- https://meta.discourse.org/t/full-site-cdn-acceleration-for-discourse/21467
- https://meta.discourse.org/t/create-admin-account-from-console/17274
- https://meta.discourse.org/t/adjust-discourse-search-to-work-with-cjk-languages/28741
- https://meta.discourse.org/t/beginners-guide-to-install-discourse-on-ubuntu-for-development/14727
- https://meta.discourse.org/t/set-up-discourse-on-amazon-aws/14853/3
- https://meta.discourse.org/t/running-other-websites-on-the-same-machine-as-discourse/17247/31
- https://meta.discourse.org/t/migrating-an-old-discourse-install-to-docker/12439
- https://meta.discourse.org/t/allowing-ssl-for-your-discourse-docker-setup/13847
- https://meta.discourse.org/t/beginners-guide-to-install-discourse-on-mac-os-x-for-development/15772/44
- https://meta.discourse.org/t/advanced-setup-and-administration/15929
- https://meta.discourse.org/t/configure-your-domain-for-discourse-hosted-email/14177
- https://meta.discourse.org/t/redirect-single-multiple-domain-s-to-your-discourse-instance/18492
- https://meta.discourse.org/t/changing-max-attachment-size/26435
- https://meta.discourse.org/t/how-to-use-docker-multiple-containers-without-exposing-ports/22283
- https://meta.discourse.org/t/advanced-manual-method-of-manually-creating-and-restoring-discourse-backups/18273
- https://meta.discourse.org/t/replace-rubygems-org-with-taobao-mirror-to-resolve-network-error-in-china/21988
- https://meta.discourse.org/t/configure-a-firewall-for-discourse/20584
- https://meta.discourse.org/t/host-run-support-for-launcher/19771
- https://meta.discourse.org/t/how-to-configure-discourse-docker-on-higher-end-servers/18569
- https://meta.discourse.org/t/troubleshooting-docker-installation-issues/17224
- https://meta.discourse.org/t/deploying-discourse-to-amazon-and-other-clouds/1632 (Experimental)
- https://meta.discourse.org/t/installing-discourse-on-gentoo/9215 (Experimental)
- https://meta.discourse.org/t/installing-discourse-on-ubuntu-12-04-and-ec2/4893 (Experimental)
- https://meta.discourse.org/t/discourse-on-nginx-passenger-an-exhaustive-howto/7984 (Experimental)
- https://meta.discourse.org/t/how-to-deploy-discourse-in-8-minutes-with-juju/20658 (Experimental)
- https://meta.discourse.org/t/simple-discourse-deployment-with-rubber/10029 (Experimental)
- https://meta.discourse.org/t/deploy-discourse-to-an-ubuntu-vps-using-capistrano/6353 (Experimental)
- https://meta.discourse.org/t/adventures-in-haproxy-and-varnish-with-discourse-because-i-hate-myself/27782 (Experimental)


### Forum Import

- [Discourse Import Essentials](https://meta.discourse.org/t/migrating-to-discourse-from-another-forum-software/16616) - Needs expansive rewrite.
- https://meta.discourse.org/t/my-experience-with-a-successful-migration-hints-for-a-guide/11628 (Should be incorporated into Import Essentials)
- https://meta.discourse.org/t/redirecting-old-forum-urls-to-new-discourse-urls/20930
- https://meta.discourse.org/t/import-posts-from-facebook-group-into-discourse/6089/53
- https://meta.discourse.org/t/how-to-migrate-from-vanilla-to-discourse/27273
- https://meta.discourse.org/t/how-to-import-a-phorum-database-via-vanilla-porter/27538
- https://meta.discourse.org/t/import-from-google-groups-to-discourse/7307/10
- https://meta.discourse.org/t/archive-an-old-forum-in-place-to-start-a-new-discourse-forum/13433

### Hacking Discourse

- https://meta.discourse.org/t/using-discourse-api/17587
- https://meta.discourse.org/t/how-to-reverse-engineer-the-discourse-api/20576
- https://meta.discourse.org/t/create-group-via-api/20572
- http://eviltrout.com/2014/01/22/embedding-discourse.html
- https://meta.discourse.org/t/triggered-custom-badge-queries/19336/3
- https://meta.discourse.org/t/generating-disposable-invite-tokens/17563
- http://community.sitepoint.com/t/a-simple-discourse-plugin/116302
- http://community.sitepoint.com/t/a-not-so-simple-discourse-plugin-handlebars-registerhelper/169496
- https://meta.discourse.org/t/invite-individual-users-to-a-group/15544
- https://meta.discourse.org/t/a-badge-for-all-members-of-a-group/18147/8
- https://meta.discourse.org/t/any-kind-of-data-input-also-anonymous-through-google-forms/21008
- https://meta.discourse.org/t/how-to-test-discourse-in-mobile-screen-emulator/17155
- https://meta.discourse.org/t/message-format-support-for-localization/7035
- https://meta.discourse.org/t/down-for-maintenance-page/8697
- https://meta.discourse.org/t/setting-up-docker-in-virtualbox-for-production-testing/12111/
- https://meta.discourse.org/t/jquery-plugin-to-display-latest-posts/10375
- https://meta.discourse.org/t/edit-a-user-setting-for-all-discourse-users/25162
- https://meta.discourse.org/t/how-to-add-a-new-tab-with-content-from-a-group/17278/2 (Experimental)
- https://meta.discourse.org/t/tuning-ruby-and-rails-for-discourse/4126 (Experimental)


## docs.discourse.org/designers

- https://meta.discourse.org/t/adding-a-menu-item-to-the-hamburger-menu/24466
- https://meta.discourse.org/t/custom-nav-header-like-discourse-org/21053

## docs.discourse.org/admins

### Essentials

- https://github.com/discourse/discourse/blob/master/docs/ADMIN-QUICK-START-GUIDE.md
- https://meta.discourse.org/t/customize-subject-format-for-standard-emails/20801
- https://meta.discourse.org/t/creating-and-submitting-xml-sitemaps-to-google-bing-yandex/22655
- https://meta.discourse.org/t/export-user-information-list/18960
- https://meta.discourse.org/t/configure-automatic-backups-for-discourse/14855
- https://meta.discourse.org/t/sending-bulk-user-invites/16468
- https://meta.discourse.org/t/configure-your-domain-name-for-hosted-discourse/21827
- https://meta.discourse.org/t/how-to-change-faq-privacy-policy-and-terms-of-service/18074
- https://meta.discourse.org/t/configure-custom-emoji/23365m
- https://meta.discourse.org/t/link-user-title-to-a-group/19169
- https://meta.discourse.org/t/how-to-configure-mailbox-in-google-apps-for-user-friendly-incoming-email-addresses-for-discourse-categories-with-screenshots/15374
- https://meta.discourse.org/t/use-one-fastmail-account-to-serve-multiple-discourse-instances/15178
- https://meta.discourse.org/t/setting-up-file-and-image-uploads-to-s3/7229 (Advanced)

### Logins


- https://meta.discourse.org/t/configuring-google-oauth2-login-for-discourse/15858
- https://meta.discourse.org/t/configuring-github-login-for-discourse/13745/
- https://meta.discourse.org/t/configuring-twitter-login-for-discourse/13395
- https://meta.discourse.org/t/configuring-facebook-login-for-discourse/13394/8
- https://meta.discourse.org/t/how-to-cas-authenticate/6963


- 

## docs.discourse.org/users

### Basic Features

- Badges
- Trust Levels
- Post Editor
- Private Messages
- Likes
- ...
- 

### Miscellaneous

- https://meta.discourse.org/t/contribute-a-translation-to-discourse/14882
- asdf

----

## Deprecated Pages

- https://github.com/discourse/discourse/blob/master/docs/INSTALL-digital-ocean.md
- https://github.com/discourse/discourse/blob/master/docs/INSTALL-ubuntu.md
