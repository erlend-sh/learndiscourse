---
title: Full site CDN acceleration for Discourse
---

<small class="documentation-source">Source: [https://meta.discourse.org/t/full-site-cdn-acceleration-for-discourse/21467](https://meta.discourse.org/t/full-site-cdn-acceleration-for-discourse/21467)</small>

[Fastly][1] , [CloudFlare][2] and a few other CDNs offer a mode where they accelerate dynamic content. 

In a nutshell you point your domain IP address at the CDN and the CDN will intelligently decide how to deal with the request.

- Static content can be easily served from cache
- Dynamic content can be routed to the site. 

This provides some advantages over only shipping static assets which is covered in [the CDN howto][3].

- You can elect for "[shielding][4]" that protects your site from traffic spikes. 
- Dynamic content can be accelerated using techniques like [railgun][5]. (note: in general our paylod fits in 1 RTT so this has less of an impact) 
- SSL negotiation can happen at the edge cutting on expensive round trips for negotiation.

If you enable full site acceleration with a CDN it is critical you follow 3 rules

1. The "message bus" **must** be served from the origin.

2. You need to set up X-Forwarded-For trust. For Cloudflare, add `cloudflare.template.yml` to your `app.yml` file.

2. Be extra careful with techniques that apply optimisation to the site, stuff like Rocket Loader can stop Discourse from working. Discourse is already heavily optimised, this is not needed. 

To server "[long polling][6]" requests from a different domain, set the Site Setting **long polling base url** to the origin server. 

For example, if your site is on "http://forum.example.com" you should set up **`http://forum-direct.example.com/`** to plug into the site setting. If you don't your site will be broken. 

If you are fronting Discourse using Varnish you probably want to follow the same trick here and bypass Varnish for the message bus requests. 

### Boring technical notes:

Achieving a working message bus on a completely different domain is quite challenging. Our message bus is aware of which user is polling, the other domain may have no cookie set up so untouched there are two issues. Firstly, you can't even make standard ajax requests cross domain without a huge [CORS][7] dance.

Secondly, we needed a mechanism to inform the other domain who the user is so we can poll for the correct information. 

When long polling base url is changed, Discourse ships an extra meta tag that shares a "cross domain" auth token. This token is passed using a custom header back to the message bus. The token expires after 7 days or as soon as the user logs off. In future we are probably going to amend it so the token has N uses and is automatically reissued after they pass. 

You can see most of the implementation here: https://github.com/discourse/discourse/commit/aa9b3bb35accce498438e22344a3c352a9bc6592


  [1]: http://www.fastly.com/
  [2]: https://www.cloudflare.com
  [3]: https://meta.discourse.org/t/enable-a-cdn-for-your-discourse/14857
  [4]: http://www.fastly.com/products/origin-shield/
  [5]: https://www.cloudflare.com/railgun
  [6]: http://en.wikipedia.org/wiki/Comet_%28programming%29
  [7]: http://en.wikipedia.org/wiki/Cross-origin_resource_sharing
