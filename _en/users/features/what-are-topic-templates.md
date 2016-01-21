---
title: Topic Templates
---

Topic templates are a useful tool to reinforce forum conventions or to guide new users.

### Category-specific topic template

Some categories might follow a strict pattern. One such example would be a Movies category, wherein you'd like users to start new topics according to a certain template:

> I saw: *insert movie title*
> 
> I think it was worth: *how many stars* out of 4 stars
> 
> Review here:

To apply this template to all new topics posted in this category, go to a category, click "Edit" and find "Topic Template" in the top menu.

You can see a live example of this if you register on our Try sandbox forum and post a new topic to the [Movies category](http://try.discourse.org/c/movies).


### Pre-fill topic by URL

It's also possible to create URL that, when clicked, will open a pre-filled topic. To compose a new pre-filled topic, modify URL params like this:

    http://discourse.example.com/new-topic?title=topic%20title&body=topic%20body&category=category/subcategory

This will open composer window pre filled with topic title, body and desired category.

This can also be tested live on try.discourse.org:

https://try.discourse.org/new-topic?title=topic%20title&body=topic%20body&category=discourse

Also, instead of providing category/subcategory name, you can also specify category_id, like:

https://try.discourse.org/new-topic?title=topic%20title&body=topic%20body&category_id=11

Note that if both category_id and category is passed as param then priority is given to category_id.

<small class="documentation-source">Source: [https://meta.discourse.org/t/what-are-topic-templates/38295](https://meta.discourse.org/t/what-are-topic-templates/38295)</small>
