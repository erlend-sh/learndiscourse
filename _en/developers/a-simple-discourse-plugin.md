---
title: A Simple Discourse Plugin
translations:
tags:
  - Hack
---

That's "simple" as in "doesn't do much". 
The main intent of this tutorial is to help those unfamiliar with writing a Discourse plugin. 

**Background** 
Some Discourse template files now have "plugin outlets" to make things easier for plugin authors. 
This tutorial will show how to write a plugin that allows Admins to add content to the hamburger's list of site links. 
The core template file is located at 
`app/assets/javascripts/discourse/templates/site-map.hbs` 
and has the outlet 
`{{plugin-outlet "site-map-links"}}` 
inside of UL tags, but _not_ inside of LI tags. 

**Files** 
There are 2 required files. 
The plugin.rb file which is needed to let Discourse know where to get needed assets. 
The handlebars template file which is the point of this plugin. 

There are also 4 "good to have" files. 
3 config files that allow plugin users to enable / disable the plugin, and alter the inserted content without needing to hack the template file with hard-coded content. 
A readme that hopefully will help any that may have problems. 

**Comments** 
Files are not required to have comments in them, but they are important. 

**Naming** 
It is a good idea to have descriptive names. Except for when required for Discourse to do it's "magic" eg. "plugin.rb", I prefer to use dashes in folder and file names, and underscores in variable and function names. 
But there is usually a lot of leeway here if you prefer otherwise. 
For simplicity and lack of imagination, I named this plugin "below-sitemap" even though technically it should probably be "in-sitemap-links". 

**File and Folder Location** 
As mentioned the core template is located at 
`app/assets/javascripts/discourse/templates/site-map.hbs`
For the plugin to work, this path is somewhat replicated within the plugin's folder except there needs to be a "connectors" folder inside of the templates folder with a "site-map-links" (the plugin-outlet name) inside of that where the plugin's handlebars file will go. 

The structure is as so 

    below-sitemap
      plugin.rb			// main plugin file
      /assets
        /javascripts
          /discourse
            /templates
              /connectors
                /site-map-links 	// same name as the plugin-outlet
                  site-map-links.hbs	// inserted into site links
      /config
        settings.yml		// variable objects
        /locales
          client.en.yml		// adds inputs to ACP UI
          server.en.yml		// variable values
      README.md			// helpful information

**plugin.rb** 
Not much here, but the path needs to be correct 
```
# name: below-sitemap
# about: plugin to insert content into hamburger menu link list
# version: 0.1
# authors: Mittineague


register_asset "javascripts/discourse/templates/connectors/site-map-links/site-map-links.hbs"
```

\* YAML files are extremely sensitive to whitespace (spaces, indentation, newlines) so it's a good idea to run them through a validator 

**settings.yml** 
Adds two Admin inputs, a boolean and a text 
```
# below-sitemap

plugins:
  below_sitemap_active:
    default: false
    client: true
  below_sitemap_content:
    default: ''
    client: ''
```

**client.en.yml** 
Lets Discourse know where to put the site setting inputs. 
In this case, Admin -> Settings -> Plugins and Admin -> Plugins -> Settings
```
# below-sitemap

en:
  admin:
    site_settings:
      categories:
         plugins: "Below Sitemap"
```

**server.en.yml** 
Text to show next to the inputs
```
# below-sitemap

en:
  site_settings:
    below_sitemap_active: "Show Content in Hambuger Menu"
    below_sitemap_content: "Content to show in Hambuger Menu. Individual items need to be enclosed in LI tags."
```

**site-map-links.hbs** 
If below_sitemap_active is checked, show below_sitemap_content
```
{{#if Discourse.SiteSettings.below_sitemap_active}}
	{{{Discourse.SiteSettings.below_sitemap_content}}}
{{/if}}
```