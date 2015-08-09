---
title: 'What is "Infinite Scrolling"?'
---

<small class="doc-source">Source: https://meta.discourse.org/t/what-is-infinite-scrolling/30804</small>

"Infinite Scrolling" is a term for what is happening if you're scrolling through a page filled with content and - as, or *before*, you reach the bottom - more content is loaded automatically

http://learndiscourse.org/public/resources/infinite-scrolling.mp4

Discourse attempts to utilise infinite scrolling in a way that solely adds to the user's reading experience, and never detracts from it.

- Discourse takes full advantage of HTML5's [History API][1].
- As you scroll, the browser address bar is updated according to your reading position.
- Back/forward buttons work as expected.
- The [pagination widget](#) tells you how far along you are, and lets you jump to the beginning, end, or an exact postID of your choice.
- Only JSON calls are made. No site elements need to be redrawn in order to load more content, which means minimal bandwidth usage.

### Further Reading

- [Infinite Scrolling That Works](http://eviltrout.com/2013/02/16/infinite-scrolling-that-works.html) - *eviltrout.com*
- [Infinite Scrolling - Let's get to the bottom of this](http://www.smashingmagazine.com/2013/05/03/infinite-scrolling-lets-get-to-the-bottom-of-this/) - *smashingmagazine.com*


  [1]: https://developer.mozilla.org/en-US/docs/Web/Guide/API/DOM/Manipulating_the_browser_history
