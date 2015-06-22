---
title: A not so simple Discourse Plugin - Handlebars.registerHelper
name: a-not-so-simple-discourse-plugin---handlebarsregisterhelper
subsection: hacking
---

Inspired from this discussion
`https://meta.discourse.org/t/adding-share-buttons-to-every-post-image/27590`

I decided to look into what would be involved with creating such a plugin.

Expanding on what I've learned previously,
http://community.sitepoint.com/t/a-simple-discourse-plugin/116302

That is, plugin.rb calls in asset files, and config is used to create the Admin CP option toggle.

What is different? The template of interest currently has no plugin-outlet. So I needed to hack the
 app/assets/javascripts/discourse/templates/post.hbs file, adding "in-ccoked"

```
      <!-- keep the classes here in sync with composer.hbs -->
      <div {{bind-attr class="showUserReplyTab:avoid-tab view.repliesShown::contents :regular view.extraClass"}}>
        <div class='cooked'>
          {{{cooked}}}
		  {{plugin-outlet "in-cooked"}}
        </div>
        {{#if cooked_hidden}}
          <a href {{action "expandHidden" this}}>{{i18n 'post.show_hidden'}}</a>
        {{/if}}
```

This plugin requires JavaScript, so I also created a js.es6 file in assets/javascripts/initializers/


    /* for some unknown reason,
    ** regex with captures match func does not return array,
    ** requiring need for hacky regex replace func */
    Handlebars.registerHelper('get_img', function(property, options) {
    	var post = Ember.Handlebars.get(this, property, options),
        cooked = post.get('cooked');
    	var output = "";
    	if (cooked.indexOf("img") != -1) {
    		var expr = /img src="[^"]*"/gm;
    		var matches = cooked.match(expr);
    		if (matches) {
    			output += '<div class="get-img">Post Image Links ';
    			for (var i = 0; i < matches.length; i++) {
    				matches[i] = matches[i].replace(/img src="/, '');
    				matches[i] = matches[i].replace(/"/, '');
    				var domain = window.location.origin;
    				var ext_expr = /http/;
    				if (ext_expr.test(matches[i])) {
    					domain = "";
    				}
    				var filename_expr = /[^\/]*$/gm;
    				var filename_match = matches[i].match(filename_expr);
    				var filename = "";
    				if (filename_match[0]) {
    					filename_match[0] = filename_match[0].replace(/\//, '');
    					filename_match[0] = filename_match[0].replace(/\?(.)*/, '');
    					filename = filename_match[0];
    				}
    				output += '<br /><a href="'
    				+ domain + matches[i]
    				+ '">' + filename + '</a>';
    			}
    			output += '</div>';
    		}
    	}
    	return output;
    });


and for style, an .scss file in assets/stylesheets/


    .in-post {
      margin: 0 10px;
      color: #000;
      font-weight: bold;
    }

that targets the connectors template's div


    {{#if Discourse.SiteSettings.in_post_active}}
    	<div class="in-post">
    		{{#if cooked}}
    			{{{get_img this}}}
    		{{/if}}
    	</div>
    {{/if}}

resulting in
<img src="/uploads/default/23478/fd1dfcf4a3e4c230.png" width="189" height="500">

True, more would be needed to get "image share" links, but it is my hope that this will be of some help for those working on Discourse plugins.
