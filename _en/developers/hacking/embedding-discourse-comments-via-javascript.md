---
title: Embedding Discourse Comments via Javascript
weight: 230
---

<small class="documentation-source">Source: [https://meta.discourse.org/t/embedding-discourse-comments-via-javascript/31963](https://meta.discourse.org/t/embedding-discourse-comments-via-javascript/31963)</small>

Discourse has the ability to embed the comments from a topic in a remote site using a Javascript API that creates an IFRAME. For an example of this in action, check out [Coding Horror's blog](http://blog.codinghorror.com/welcome-to-the-internet-of-compromised-things/#discourse-comments). The blog is run via [Ghost](https://ghost.org/) but the comments are embedded from his [Discourse forum](http://discourse.codinghorror.com/t/welcome-to-the-internet-of-compromised-things/3550).

One important thing to note with this setup is that **users have to navigate to your forum to post replies**. This is intentional, as we feel that the posting interface on a Discourse forum is currently much richer than what we could embed via Javascript.

This guide will show how to set up comment embedding on your own blog or web site.

### How it works

In Discourse, a topic is made up of many posts. When you are *embedding* Discourse on another site, you are linking a document (blog entry, HTML page, etc.) with a single *topic*.  When people post in that topic, their comments will automatically show up on the page you embedded it in.

You have the choice to have Discourse create the topics automatically when a new embedding is found, or you can create the topics yourself in advance. 

### Configuring Discourse for Embedding (simple setup)

The following setup will embed a comment feed on a page on a fake blog URL of `http://example.com/blog/entry-123.html`, from a discourse forum running at `http://discourse.example.com`.

1. Visit **Admin &gt; Customize &gt; Embedding** on your Discourse install.  

2. Enter one or more `embeddable hosts`. This should be the hostname (domain) where you want to embed your comments. In this case the host is `example.com` -- note the lack of `http://` and path.
  
3. Enter the name of a user on your discourse who will create topics in the `embed by username` field. Let's assume our discourse has a user called eviltrout, so the value is `eviltrout`.

4. Insert the following HTML on the web page at `http://example.com/blog/entry-123.html`

```html
<div id='discourse-comments'></div>

<script type="text/javascript">
  DiscourseEmbed = { discourseUrl: 'http://discourse.example.com/',
                     discourseEmbedUrl: 'http://example.com/blog/entry-123.html' };

  (function() {
    var d = document.createElement('script'); d.type = 'text/javascript'; d.async = true;
    d.src = DiscourseEmbed.discourseUrl + 'javascripts/embed.js';
    (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(d);
  })();
</script>
```

The configurable parts of the snippet are in the `DiscourseEmbed` object. `discourseUrl` is the full path to the base of your discourse, including the trailing slash. The `discourseEmbedUrl` is the document that is currently embedding a comment feed.

If you set this up correctly, the first time you visit `http://example.com/blog/entry-123.html` it will try to load comments for the blog post. Since there are none, it will tell the Discourse forum to create a new topic in the background. A new topic will be created by `eviltrout` and the contents of the first post will be crawled from your blog and the text will be extracted automatically.

Once the new topic is created, users can post on it, and their comments will automatically be displayed the next time `http://example.com/blog/entry-123.html` is visited.

### Embedding on more than one page

In the above example we hard coded our `http://example.com/blog/entry-123.html` URL when embedding the snippet of Javascript. This usually won't be enough as many sites have many pages that are generated automatically. For example on a blog each entry typically gets its own page. To support this, put the same snippet on each page you want to display comments on, but replace the value passed to `discourseEmbedUrl` with the current page's URL. On my blog, I use the following value for `discourseEmbedUrl`:  `'http://eviltrout.com<%= current_page.url %>'` -- as new blog pages are created, new topics will be created for them automatically on Discourse.

### Styling your Embedded content

If you are running the latest build of Discourse (or 1.4.0beta9 or 1.4.0 stable once it is released) you have the ability to add a stylesheet for your embedded comments.  Visit **Admin &gt; Customize &gt; CSS/HTML &gt; Embedded CSS** and you can add a custom stylesheet that will be served up with your embedded comments. By default we think the layout looks nice on a white background, but if your site has a unique layout you'll want to style it yourself.

### (Optional) Adding a Feed for Polling

As mentioned above, Discourse will automatically crawl any site it is embedded on. However, sometimes HTML can be hard to parse and it might not extract the contents of your posts correctly. Many blogs and web sites support RSS/Atom feeds for syndication, and Discourse can use this to extract the content of your blog posts more accurately.

If you have a RSS or Atom feed set up on the site you are embedding Discourse into, you can configure Discourse to extract the content of posts from there by enabling the setting `feed polling enabled` and then providing the full URL to the feed in the `feed polling url` setting.

### (Alternate Configuration) Linking to existing topics

Some people prefer to not have Discourse create topics for them automatically on their forums. They'd like to create the topics themselves, then simply tell their embedding code what topic they want to associate with. You can do this by slightly changing your embedding code:

```html
<div id='discourse-comments'></div>

<script type="text/javascript">
  DiscourseEmbed = { discourseUrl: 'http://discourse.example.com/',
                     topicId: 12345 };

  (function() {
    var d = document.createElement('script'); d.type = 'text/javascript'; d.async = true;
    d.src = DiscourseEmbed.discourseUrl + 'javascripts/embed.js';
    (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(d);
  })();
</script>
```

The only difference here is we've replaced `discourseEmbedUrl` with the id of a topic from Discourse. If you do this, no topic will be created and the comments from that topic will automatically be displayed.

### Troubleshooting

The most common issue users have when embedding Discourse is setting the correct value for the `embeddable hosts` option. Make sure to double check that it is only the domain of your site, and contains no extra slashes or invalid characters.
