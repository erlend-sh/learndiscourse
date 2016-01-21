---
title: Adding plugin-outlets using site customizations
weight: 350
---

In [Plugin System Upgrades][1] @eviltrout introduced a system for extending Discourse HTML using plugin outlets. 

Plugin outlets are tagged areas in our application that allow you to inject a template. The template has access to the backing controller so it can be dynamic. 

Our customization system in `/admin/customize/css_html` allows you to define custom CSS and HTML. 

When injecting HTML into your page you can also inject templates, this gives you a very simple mechanism for injecting content into various plugin outlets. 

To inject into an outlet

1. Find out the outlet name, you can do so by digging through our source or using the [plugin outlet location][2] plugin. 

2. Define a handlebars template in the `</head>` section. 

An example of this is:

```
<script type='text/x-handlebars' data-template-name='/connectors/header-after-home-logo/add-header-links'>
  {{#unless showExtraInfo}}
       <a class="nav-link " href="http://google.com" target="_blank">My Site</a>
  {{/unless}}
</script>
```

This will result in adding a navigation link in the header that only exists when the header is not in extra info mode (which happens when you scroll down a topic) 

:mega: **Naming is critical**

Your template must have the `data-template-name` attribute identify the outlet. It is named like so:

`/connectors/OUTLET-NAME/UNIQUE-ID`

If you stray from that naming your template will not be picked up or injected. 


TODO (add screenshots) 

Using this technique even business and standard customers can heavily extend Discourse without needing plugins. 


:warning: When possible always prefer solutions that inject into a plugin outlet, over solutions that override an entire template, that allows your customisation to be far more robust and "future proof".




  [1]: https://meta.discourse.org/t/plugin-system-upgrades/16120
  [2]: https://meta.discourse.org/t/plugin-outlet-locations/29589

<small class="documentation-source">Source: [https://meta.discourse.org/t/adding-plugin-outlets-using-site-customizations/32727](https://meta.discourse.org/t/adding-plugin-outlets-using-site-customizations/32727)</small>
