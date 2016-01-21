---
title: [WIP] List of all the hooks in Discourse
weight: 370
---

Here's the up-to-date list of all the `hooks` available in Discourse:

## Client-side (javascript)
---

#### additionalButtons

Event triggered by the `TopicFooterButtonsView` when rendering the buttons at the bottom of a topic.

How to use it? Read the [How to add a button at the end of a topic?](http://meta.discourse.org/t/plugin-tutorial-2-how-to-add-a-button-at-the-end-of-a-topic/11040) tutorial.

#### appendMapInformation

Event triggered by the `TopicMapContainerView` when rendering the topic map and any relevant information underneath the first post of a topic.

How to use it?

```javascript
Discourse.TopicMapContainerView.reopen({
 onAppendMapInformation: function(container) {
   // your code
 }.on("appendMapInformation")
});
```

#### postViewInserted

Event triggered by the `PostView` when a post is inserted into the DOM.

#### previewRefreshed

Event triggered by the `ComposerView` when the composer's preview renders.

#### Discourse.TopicRoute / setupTopicController

Event triggered by the `TopicRoute` when a topic is being loaded.

How to use it?

```javascript
Discourse.TopicRoute.on("setupTopicController", function(event) {
  // Access the controller via: event.controller
  // Access the model via: event.currentModel
});
```

#### Discourse.ApplicationRoute / activate

Event triggered when the ApplicationRoute is activated. This is useful if you need to do something like create a modal once the application has loaded (activated). 

#### Discourse.PageTracker.current() / change

This event is triggered when the current "page" changes. This is useful if you want to hook into an analytics or tracking package:

```javascript
Discourse.PageTracker.current().on('change', function(url) {
  console.log('the page changed to: ' + url);
});
```


### Dialect

Dialects are Discourse's way to extend our text rendering engine. They are made up of two stages. The first runs functions against the input to emit a JsonML intermediate representation. The second stage post-processes the JsonML before it is rendered to the string.

If you are interested in a custom text processor, you will probably find the functions in [dialect.js](https://github.com/discourse/discourse/blob/master/app/assets/javascripts/discourse/dialects/dialect.js) useful and well documented. There are also examples of using the dialect API in the [dialects directory](https://github.com/discourse/discourse/tree/master/app/assets/javascripts/discourse/dialects) of discourse.

#### parseNode

The `parseNode` hook is for looping through the JsonML tree and modifying it in place. It will be called once per node in the tree so try to keep your function light and fast.

```javascript
Discourse.Dialect.on("parseNode", function(event) {
  var node = event.node,   // current node in the tree
      path = event.path;   // depth path to the current node

  // your logic goes here. 
});
```

## Server-side (ruby)
---

#### before_create_post

Event triggered by the `PostCreator` when a post is about to be created.

How to use it?

```ruby
class Plugin < DiscoursePlugin
  def setup
    listen_for(:before_create_post)
  end

  def before_create_post(post)
    # your code...
  end
end
```

<small class="documentation-source">Source: [https://meta.discourse.org/t/wip-list-of-all-the-hooks-in-discourse/11505](https://meta.discourse.org/t/wip-list-of-all-the-hooks-in-discourse/11505)</small>
