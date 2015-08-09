---
title: How to test Discourse in mobile screen emulator
weight: 200
---

<small class="doc-source">Source: https://meta.discourse.org/t/how-to-test-discourse-in-mobile-screen-emulator/17155</small>

After some trial and error, I came to the conclusion that the built-in [Mobile Emulation][1] in Chrome is the best way to quickly preview Discourse pages on a mobile device.

Sure you can also just append `?mobile_view=1` to an URL, but the emulator has the added benefit of letting you select the screen profile of a specific device.

I also tested all of the most popular online screen emulators, but unfortunately Discourse doesn't work on any of these. I assume they're not made to handle JavaScript-heavy apps.

Edit: I asked Screenfly why Discourse wasn't working, this is their reply:

> Screenfly doesn't work on every website.  Most commonly, this is a security setting on the web server that disallows display inside of frames (like those used in Screenfly).

http://quirktools.com/screenfly/
http://cybercrab.com/screencheck/
http://www.viewlike.us/

  [1]: https://developer.chrome.com/devtools/docs/mobile-emulation
