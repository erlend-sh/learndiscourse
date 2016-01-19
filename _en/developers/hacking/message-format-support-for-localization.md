---
title: Message Format support for localization
weight: 220
---

For the feature I was working on yesterday, @codinghorror wanted a rather complex sentence. 

"There is 1 unread and 9 new topics remaining, or browse other topics in [category]"

This seemingly simple sentence was a royal nightmare to localize with our existing localization system. Think through all the permutations:

"There are 2 unread and 9 new topics remaining, or browse other topics in [category]"  
"There are 2 unread and 1 new topic remaining, or browse other topics in [category]"  
"There is 1 unread and 1 new topic remaining, or browse other topics in [category]"  

Trouble with our current system was that you have no sane way of building these kind of sentences, see: http://stackoverflow.com/questions/16825932/clean-pattern-for-localizing-sentences-in-rails-i18n , you can only easily localize one count in a non compound sentence. 

--- 

To alleviate this I introduce a new mechanism that is available (optionally) client side. The above sentence is localized using: 

```text
There {UNREAD, plural, 
   one {is <a href='/unread'>1 unread</a>} 
   other {are <a href='/unread'># unread</a>}
} and {NEW, plural, 
  one {<a href='/new'>1 new</a> topic} 
  other {<a href='/new'># new</a> topics}} remaining, or browse other topics in {catLink}
```

--- 

The client localization file has a special rule, if a key ends with _MF it is interpreted as a MessageFormat message, then to access it on the client you use:

```javascript
I18n.messageFormat("topic.read_more_in_category_MF", {"UNREAD": unreadTopics, "NEW": newTopics, catLink: opts.catLink})
```

---

You can see a few other examples here: 

https://github.com/discourse/discourse/blob/master/spec/components/js_locale_helper_spec.rb


We do not plan at the moment to move to [message format][1] style localization everywhere, however it is nice to have this extra bit of flexibility that lets us generate interesting sentences. 

--- 

On a technical note, this feature adds almost no weight to the client side JavaScript, all message format strings are pre-compiled into a JavaScript function with no external dependencies. The tricks used can be viewed here: https://github.com/discourse/discourse/blob/master/lib/js_locale_helper.rb

---

#### 1 minute Message Format primer

```
f = "hello"
f() => "hello"

f = "hello {WORLD}"
f(WORLD: "world") => "hello world" 
f(WORLD: "other world") => "hello other world" 

f = "I have {HATS, plural, one {one hat} other {# hats}}"
f(HATS: 1) => "I have one hat"
f(HATS: 10) => "I have 10 hats" 

f = "I am a {GENDER, select, male {boy}, female {girl}}"
f(GENDER: "male") => "I am a boy"
f(GENDER: "female") => "I am a girl"
```

--- 

Our plan for now is to use this strategically, however it is worth noting that this gives more flexibility in localization, for example in [czech][2], the plural form is rather interesting as @kuba could attest : 

```
MessageFormat.locale.cs = function (n) {
  if (n == 1) {
    return 'one';
  }
  if (n == 2 || n == 3 || n == 4) {
    return 'few';
  }
  return 'other';
};
```

Message Format supports this fine, built in. 


```
f = "I have {HATS, plural, one {one hat} other {# hats} few {# few hats}}"
```

  [1]: https://github.com/SlexAxton/messageformat.js
  [2]: http://en.wikipedia.org/wiki/Czech_declension

<small class="documentation-source">Source: [https://meta.discourse.org/t/message-format-support-for-localization/7035](https://meta.discourse.org/t/message-format-support-for-localization/7035)</small>
