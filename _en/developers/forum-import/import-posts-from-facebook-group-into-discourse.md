---
title: Import posts from Facebook group into Discourse
weight: 320
---

<small class="doc-source">Source: https://meta.discourse.org/t/import-posts-from-facebook-group-into-discourse/6089</small>

It's a rake task and some config is needed. All is explained in the file itself.

I need testers. I tested this script on a group with 15 members, 250 posts and 2700 comments. That went well. Now testing on a group with 6000 members and I don't know how many posts. :)

### TODO:
* Import likes
* Import new posts after last import (almost finished)
* Stop sending all those emails

Latest update: v1.6 (June 1st 2013)

https://github.com/sanderdatema/import_facebook_into_discourse

Note:
Importing posts from users from a Facebook group into your Discourse install might be frowned upon. They never signed up for their data to be exported to a new location. Read: privacy concerns.

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/1X/19eb92d9112447cd1c5424b3118f9f4b014617f0.png" width="690" height="175">

