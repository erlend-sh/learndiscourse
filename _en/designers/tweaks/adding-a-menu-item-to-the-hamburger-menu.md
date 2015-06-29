---
title: Adding a menu item to the Hamburger menu
name: adding-a-menu-item-to-the-hamburger-menu
subsection: tweaks
---

I needed to add a menu item to the hamburger :hamburger: menu in top right
<img src="/uploads/default/38200/cae43a8d33aef8ea.png" width="390" height="319">

I needed something that would be:

- Accessible on desktop and mobile view
- Opens in a new window / tab

This did the simple job for me.

###What code do I need?

    <script type='text/x-handlebars' data-template-name='/connectors/site-map-links/shop'>
        <li><a href="http://www.example.com/shop/" title="Some Amazing Club Shop" class="shop-link" target="_blank">Shop</a></li>
    </script>



###Where do I add it?
This goes in the `CSS/HTML` customisations in `</head>`
<img src="/uploads/default/38205/521c5a68ef31fbc6.png" width="690" height="433">

###How does it work?
Simply put it uses Discourse's `plugin-outlet` functionality ([code found here][1]).

This appends our handle bars template with the rest of the `site-map-links` templates (if any) and outputs at the `site-map-links` plugin-outlet point:
https://github.com/discourse/discourse/blob/350554e198084ee241143cc55891e80fd1c8c00a/app/assets/javascripts/discourse/templates/site-map.hbs#L25


###Tested with
Discourse 1.2.0.beta5 - version 4c0129ccddb9037467133d37e5a93520a5f86f77


  [1]: https://github.com/discourse/discourse/blob/master/app/assets/javascripts/discourse/helpers/plugin-outlet.js.es6
