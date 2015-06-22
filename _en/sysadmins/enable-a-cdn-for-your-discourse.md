---
title: Enable a CDN for your Discourse
name: enable-a-cdn-for-your-discourse
subsection: essentions
---

So you'd like to use a CDN to speed up worldwide access to common assets on your Discourse forum?

Sign up with the CDN of your choice -- we use and strongly recommend [Fastly](http://www.fastly.com/).

The configuration will look something like this:

<img src="/uploads/default/4465/1529d2f2403ade88.png" width="351" height="199">

What you're looking for is three main settings:

1. The **origin address**, which is the URL where your forum is currently located `discourse.example.com`. This is where the CDN will draw all its original content from on first request.

2. The **CNAME**, which is the "friendly" name for your CDN that you'll set up in your DNS, e.g. `discourse-cdn.example.com`

3. The **CDN URL**, which is the "unfriendly" name for where the cached CDN assets will be coming from via the CDN's worldwide network of distributed servers. It will look like `637763234.cdn-provider.com`

You'll need to edit your DNS to map the CNAME to the CDN URL, like so:

`discourse-cdn.example.com IN CNAME 637763234.cdn-provider.com`

(Once you've edited the DNS, give it a little bit of time to propagate.)

The actual Discourse part of the setup is fairly simple. Uncomment the CDN line in your `app.yml` and update it with the CNAME you just set up in your DNS:

    ## the origin pull CDN address for this Discourse instance
    DISCOURSE_CDN_URL: //discourse-cdn.example.com

(If you do not see this line in your app.yml, add it below the other DISCOURSE_ variables)

As with any other changes to your `app.yml`, you need to rebuild the container to reflect changes:

    ./launcher rebuild app

Once you've rebuilt, browse to your Discourse instance in the browser. View source and search for "cdn". You'll see that websites assets are now coming from your CDN:

```
<script src="http://discourse-cdn.codinghorror.com/assets/preload_store-4ea79c2f435becca86ac97a9c038f9c7.js"></script>
<script src="http://discourse-cdn.codinghorror.com/assets/locales/en-7084a68855205a9128245d2d0ce94ed9.js"></script>
```

This topic covers the more common scenario of static asset acceleration. See [this topic](https://meta.discourse.org/t/full-site-cdn-acceleration-for-discourse/21467) for full site (both dyamic and static asset) CDN acceleration.
