---
title: Redirecting old forum URLs to new Discourse URLs
translations:
tags:
  - Import
---

If you've moved from other forum software to Discourse using [one of our import scripts](https://github.com/discourse/discourse/tree/master/script/import_scripts), then you probably want all your hard-earned Google search results to continue pointing to the same content. Discourse has a built-in way to handle this for you as an alternative to writing nginx rules, using the **permalinks lookup table**.

The permalinks table allows you to set two things: a url to match, and what that url should show. There are a few options for defining where the url should redirect to. Set one of these:

* **topic_id**: to show a topic
* **post_id**: to show a specific post within a topic
* **category_id**: to show a category
* **external_url**: to redirect to a url that may not belong to your Discourse instance

For example, if your original forum's topic urls looked like `http://example.com/discussion/12345`, and the url for that topic after the import is `http://example.com/t/we-moved/987`, then you can setup the mapping like this:

```
cd /var/discourse
./launcher enter app
rails c
Permalink.create(url: '/discussion/12345', topic_id: 987)
```

Discourse will then perform a redirect with [http response status code 301](http://en.wikipedia.org/wiki/HTTP_301) (permanently moved) to the correct url for topic id 345. The 301 should cause search engines to update their records and start using the new urls.

If you want some urls to redirect away from Discourse, you can do so by setting **external_url**:

```
Permalink.create(url: '/discussion/12345', external_url: 'http://archived.example.com/discussion/12345')
```