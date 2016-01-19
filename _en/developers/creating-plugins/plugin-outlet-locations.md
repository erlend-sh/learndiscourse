---
title: Plugin Outlet Locations
weight: 290
---

I've still got a lot to learn, and this is a very simple plugin. 

But it is my hope that it will prove useful for others wanting to get into Discourse plugin development 

Any questions or suggestions are more than welcome 
(other than criticizing my poor design skills that is, I _know_ that :smirk:) 

https://github.com/Mittineague/discourse-plugin-outlet-locations.git

# discourse-plugin-outlet-locations

This plugin allows developers to easily see were **plugin-outlet locations** are inserted into hbs templates.   
True, plugin-outlet locations may be used for purposes other than adding visual content, this plugin is only a starting point. 

## Things that may be of interest

admin-menu  
In addition to showing where the plugin-outlet is, it shows a way to allow all staff to see the additional tab, or restrict it to Admins only. 

site-map-links  
Shows a way to add a text input in the ACP Settings page that is used by the plugin. 

topic-admin-menu-buttons  
Shows a way to use the client.en.yml file to add custom text 

## Warnings 

If you are developing your own plugin, please note:  
The plugin.rb file **must** have both the name: and version: comments or the plugin **will break** the Admin Plugins page.  
yml files are **very sensitive** to correct indentation or the **entire app will fail**, please validate your yml files.  

## Tips 

If you are developing your own plugin, please note:  
Although not necessary, having Admin Settings toggles are a courtesy to others so they won't need to uninstalll the plugin to deactivate it.  
To have a link to a plugins "home" page in the Admin Plugins there must be a url: comment in the plugin.rb file.  
Giving template files the hbs extension, (and JavaScript files the es6 extension), allow Discourse to do "magic"

<small class="documentation-source">Source: [https://meta.discourse.org/t/plugin-outlet-locations/29589](https://meta.discourse.org/t/plugin-outlet-locations/29589)</small>
