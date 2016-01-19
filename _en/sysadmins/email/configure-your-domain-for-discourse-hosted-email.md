---
title: Configure your domain for Discourse hosted email
---

Here's how you configure your domain to properly send email when you're hosted here on the www.discourse.org servers. Lucky you!

Both of these changes must take effect on *your* domain name. So if your Discourse instance is at  **community.mydomain.com**, add these settings at your DNS registrar for **mydomain.com**.

### [DKIM](http://en.wikipedia.org/wiki/DomainKeys_Identified_Mail)

Create a TXT record for `discourse._domainkey` with the following value:

    v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCojtk3fqF69pT6SZcIwoYzjQfdOBTFK7AOyxEGBwHLZ+xqwQQlVgfL6xFZ7FhCYAczkGTCjdChX/qf6dg4LrtXrb+apymj9WpLOwPir6P5Mv9FH3t3BgrQeyyCLhAHqDrUk+kU3B2z1uva3oWw3qN9MLZaX8HjR13w9ywVEgzjpQIDAQAB

### [SPF](http://en.wikipedia.org/wiki/Sender_Policy_Framework)

- If you don't yet have an SPF record, you'll want to add one for your domain, of type TXT 

        v=spf1 include:_hostedspf.discourse.org ?all

- If you already have SPF records, you'll need to modify them by adding Discourse's servers  before the last operator, which is usually `?all`, `~all`, or `-all`:

        include:_hostedspf.discourse.org

    make sure the "all" part is at the end.

The two new TXT records in your DNS, once entered, should look something like this (example from CloudFlare)

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/8/2/820eb7d5f92565318f9e0618fafc128e38a1036a.png" width="690" height="110"> 

Once this is done make sure you set `notification email` in your site settings to an email address from your domain.

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/5/8/5868918eaa5d805abb54a3e3c5b8965aabb6c992.png" width="690" height="214">

<small class="documentation-source">Source: [https://meta.discourse.org/t/configure-your-domain-for-discourse-hosted-email/14177](https://meta.discourse.org/t/configure-your-domain-for-discourse-hosted-email/14177)</small>
