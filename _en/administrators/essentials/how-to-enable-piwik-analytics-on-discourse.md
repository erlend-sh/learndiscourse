---
title: How to enable Piwik analytics on Discourse
---

[Piwik][1] is an open source analytics platform. Users can choose between self-hosting or paying for professional hosting in the cloud.

To enable Piwik analytics on your Discourse forum, all you have to do is insert your tracking code in the right place.

Go to `Admin / Customize / CSS/HTML / </body>` and insert:

```
<!-- Piwik -->
<script type="text/javascript">
  var _paq = _paq || [];
  _paq.push(['enableLinkTracking']);
  (function() {
    var u="//<!-- URL HERE -->";
    _paq.push(['setTrackerUrl', u+'piwik.php']);
    _paq.push(['setSiteId', <!-- WEBSITE ID HERE -->]);
    var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0];
    g.type='text/javascript'; g.async=true; g.defer=true; g.src=u+'piwik.js'; s.parentNode.insertBefore(g,s);
  })();
  
  require('discourse/lib/page-tracker').default.current().on("change", function(url) {
  _paq.push(["setCustomUrl", url]);
  _paq.push(["setDocumentTitle", document.title]);
  _paq.push(["trackPageView"]);
  });
</script>
<!-- End Piwik Code -->

```

**Be sure to change these two:**

1. `var u="//<!-- URL HERE -->";`
2. `_paq.push(['setSiteId', <!-- WEBSITE ID HERE -->]);`

That's it!

*Courtesy of @mattab & co.* 

  [1]: http://piwik.org/

<small class="documentation-source">Source: [https://meta.discourse.org/t/how-to-enable-piwik-analytics-on-discourse/33090](https://meta.discourse.org/t/how-to-enable-piwik-analytics-on-discourse/33090)</small>
