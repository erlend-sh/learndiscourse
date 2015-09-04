---
title: Plugin Tutorial #1 - How to manipulate the text in the composer?
weight: 280
---

<small class="documentation-source">Source: [https://meta.discourse.org/t/plugin-tutorial-1-how-to-manipulate-the-text-in-the-composer/10925](https://meta.discourse.org/t/plugin-tutorial-1-how-to-manipulate-the-text-in-the-composer/10925)</small>

So, you want to manipulate the text in the composer but have no idea how? Let met guide you through the creation of a basic plugin that will turn the text into [Pirate Speak](http://en.wikipedia.org/wiki/International_Talk_Like_a_Pirate_Day).

First of all, you need to create a `plugin.rb` file that will be your entry point.

```ruby
# name: pirate-speak
# about: plugin that transform the text into pirate speak
# version: 0.1
# authors: Régis Hanol

register_asset "javascripts/pirate_speak.js", :server_side
```

I highly recommend that you add at least the following pieces of meta data:

- **name**: the name of your plugin
- **about**: a one line description of your plugin
- **version**: the version of your plugin

Then you can add the code of your plugin. Here, we're only registering a `javascript` asset that will also be used on the server side. Why? Because we use the same javascript code for baking and cooking (ie. post processing) the posts on the client-side and on the server-side. If you want your text-manipulation plugin to work properly, you have to indicate that this file must be used when post-processing the posts on the server, hence the `:server_side` argument.

Let's have a look at the file we've just registered:

```javascript
function piratize (text) {
  return text.replace(/\b(am|are|is)\b/ig, "be")
             .replace(/ing\b/ig, "in'")
             .replace(/v/ig, "'");
}

Discourse.Dialect.postProcessText(function (text) {
  text = [].concat(text);
  for (var i = 0; i < text.length; i++) {
    if (text[i].length > 0 && text[i][0] !== "<") {
      text[i] = piratize(text[i]);
    }
  }
  return text;
});
```

First, there's our core function: `piratize`. It takes a string as argument and uses [regular expressions](http://en.wikipedia.org/wiki/Regular_expression) to transform the text into a basic pirate speak. You are more than welcome to improve that function and submit pull requests ;)

But the most important part is the call to the `Discourse.Dialect.postProcessText` function. This tells Discourse to call our [anonymous function](http://stackoverflow.com/questions/1140089/how-does-an-anonymous-function-in-javascript-work) whenever the text in the composer/post needs to be post-processed. The `text` argument might be a string or an array of string. That's why we use `text = [].concat(text)` at the beginning to convert that string into an array if needs be. Then we go through the array and call our `piratize` function for each element in the array except when the element is an html tag (ie. it starts with a `<`). Finally, we return the text array so that it can be used in the rest of the post-processing pipeline.

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/a/af21e5dfd814ad6d22b614ef4576a8f609f5acfa.png" width="671" height="110"> 

The finished [Pirate Speak plugin source code](https://github.com/discourse/discourse-pirate-speak) is available on GitHub if you want to have a look.

Another great example is @sam's [ALL CAPS plugin](http://meta.discourse.org/t/brand-new-plugin-interface/8793/2) which converts the text to UPPERCASE.

Also, if you want **advanced** text manipulation plugins, you might want to check out

- [MathJax plugin](http://meta.discourse.org/t/brand-new-plugin-interface/8793/43) which adds support for math notations using [MathJax](http://www.mathjax.org/) library.
- [Spoiler Alert plugin](https://github.com/discourse/discourse-spoiler-alert) which allows anyone to prevent [spoiler]spoilers[/spoiler].
