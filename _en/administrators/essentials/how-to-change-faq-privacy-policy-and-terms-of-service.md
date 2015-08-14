---
title: How to change FAQ, Privacy Policy, and Terms of Service
---

<small class="documentation-source">Source: [https://meta.discourse.org/t/how-to-change-faq-privacy-policy-and-terms-of-service/18074](https://meta.discourse.org/t/how-to-change-faq-privacy-policy-and-terms-of-service/18074)</small>

Today we changed how the FAQ, Privacy Policy, and Terms of Service pages are managed. Each of them now has a topic where they can be edited and discussed.

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/5/f/5f071dc7b0f63e62ff9b85054d5a74e6c99689b9.png" width="660" height="153"> 

Simply editing the first post in those topics will change the documents that appear at the static urls `/tos`, `/privacy`, and `/faq` (or `/guidelines` if you're redirecting faq to an external page).

The `faq url`, `privacy policy url`, and `faq url` site settings can be used to redirect to external sites instead, as before.

Some sections of the site contents (`/admin/site_contents`) have been removed since they're not used anymore.

## Upgrading

Existing sites that were using "Privacy Policy" and "FAQ" site contents in admin don't need to do anything. They will be copied into the new topics during the upgrade.

However, the "Terms of Service: Content License" and "Terms of Service: Miscellaneous" sections will **not** be copied into the topic automatically. They will continue to be available in admin so that sites that were using them can copy and paste them into the appropriate sections of the Terms of Service topic.

## Translations

Because of this change, the translations have been moved into the standard yml files. Transifex can't handle .html.erb files, and we shouldn't have been translating them that way in the first place. The `faq.*.html.erb`, `privacy.*.html.erb`, etc. files will be going away from the repo and from Transifex soon. I left them so that translators can see them and move them into the appropriate yml file.
