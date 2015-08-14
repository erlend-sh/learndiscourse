---
title: Customize subject format for standard emails
---

<small class="documentation-source">Source: [https://meta.discourse.org/t/customize-subject-format-for-standard-emails/20801](https://meta.discourse.org/t/customize-subject-format-for-standard-emails/20801)</small>

So you want to customize subject format for standard emails? Great, let's get started!

The subject for standard emails can be customized from: `Admin` / `Settings` / `Email` / `email subject`

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/4/d/4d6ff202f5422d3720b909b23aea6dc2b2cadd03.png" width="598" height="77"> 

Available formatting options are:

`%{optional_re}[%{site_name}] %{optional_pm}%{optional_cat}%{topic_title}`

* `%{optional_re}` &rarr; Re: (applicable if the post is a Reply)

* `%{site_name}` &rarr; Community Title

* `%{optional_pm}` &rarr; [PM] (applicable if the post is a Personal Message)

* `%{optional_cat}` &rarr; [category] / [category/subcategory] {not applicable for uncategorized topics and PM)

* `%{topic_title}` &rarr; Topic title

Complied subject for typical email notification: 

> [Community Title] [category] Topic title

*Please note that a trailing whitespace will automatically be appended to `%{optional_re}`, `%{optional_pm}` and `%{optional_cat}`*.

For Example, let's consider this post:

https://meta.discourse.org/t/how-to-update-to-discourse-1-0/19328

The email subject formatting for *Reply* notification of above topic will be:

* `%{optional_re}` &rarr; Re:

* `%{site_name}` &rarr; Discourse Meta

* `%{optional_pm}` &rarr; (Not Applicable)

* `%{optional_cat}` &rarr; [howto]

* `%{topic_title}` &rarr; How to update to Discourse 1.0?

Complied subject for the above topic will be: 

> Re: [Discourse Meta] [howto] How to update to Discourse 1.0?

That's it! You have successfully customized subject format for standard emails.
