---
title: Creating and Submitting XML Sitemaps to Google, Bing & Yandex
---

<small class="documentation-source">Source: [https://meta.discourse.org/t/creating-and-submitting-xml-sitemaps-to-google-bing-yandex/22655](https://meta.discourse.org/t/creating-and-submitting-xml-sitemaps-to-google-bing-yandex/22655)</small>

While not necessary, submitting a sitemap will make your site appear faster on search indexes.
This Howto covers submitting sitemaps to Google, Bing and Yandex.

---

## Generating the Sitemap
Open http://www.web-site-map.com/ and generate your sitemap. While the site may seem a bit scammy, it works just fine. It will output a sitemap.xml and a broken_links.txt if there are any.

Open the sitemap.xml and change the root site (for example meta.discourse.org)'s frequency to daily and other sites too as you see fit.

## Uploading the Sitemap to your Discourse installation
Navigate to your discourse installation's settings and search for `extensions`. Add `xml` as an authorized extension and click apply. 

Navigate to your site assets topic (only visible for staff) and reply to the first post. Click the upload button and upload the previously generated `sitemap.xml`. You will see something like

```
<a class="attachment" href="/uploads/default/17/d86d639b474069e9.xml">sitemap.xml</a> (5.5 KB)
```
Copy the URL to the sitemap, e.g `/uploads/default/17/d86d639b474069e9.xml` and continue with the next step.

## Submitting the sitemap

Create accounts at Google, Bing and Yandex and submit the sitemap. Should be self-explanatory, each service has their own help pages.

http://webmaster.yandex.com/site/
http://www.bing.com/toolbox/webmaster/
https://www.google.com/webmasters/tools/home

### Where will my site's pages get found now?

Google, Yahoo, Bing, Yandex, Duckduckgo etc. will now index your site! :surfer: :smiley:
