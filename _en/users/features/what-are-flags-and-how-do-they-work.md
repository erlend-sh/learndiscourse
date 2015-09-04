---
title: What are Flags and how do they work?
---

<small class="documentation-source">Source: [https://meta.discourse.org/t/what-are-flags-and-how-do-they-work/32783](https://meta.discourse.org/t/what-are-flags-and-how-do-they-work/32783)</small>

Flagging is an in-built moderation measure in Discourse, intended to dissuade bad behavior and spam, as well as to promote civilised discourse. If you want to raise an issue about a post without derailing the topic at hand, the best course of action is usually to flag it.

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/e/f/efd7487ec0d51e538a17e8c75b54efb7aa878108.png" width="690" height="183"> 

By default, clicking the flag button will present a user with the following options:

> - **It's Off-Topic**
> This post is not relevant to the current discussion as defined by the title and first post, and should probably be moved elsewhere.
> 
> - **It's Inappropriate**
> This post contains content that a reasonable person would consider offensive, abusive, or a violation of our community guidelines.
> 
> - **It's Spam**
> This post is an advertisement. It is not useful or relevant to the current topic, but promotional in nature.
> 
> - **Message @codinghorror**
> This post contains something I want to talk to this person directly and privately about. Does not cast a flag.
> 
> - **Something Else**
> This post requires moderator attention for another reason not listed above.


<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/9/a/9a6fd9d9c3c407e7a4a88a57561bdf2952aa4631.png" width="690" height="294"> 

Marking a post as Off-Topic, Inappropriate or Spam will trigger a moderator notification so moderators may review the issue in their *flag queue* (doc pending). Furthermore, this also "casts a flag" on the post, which has other consequences:

- A user with <abbr title="setting: tl3 requires max flagged">5</abbr> "agreed" flags can not reach [TL 3](https://meta.discourse.org/t/what-do-user-trust-levels-do/4924).
- A post with <abbr title="setting: flags required to hide post">3</abbr> flags will be automatically hidden.
- A new (TL0) user whose post is flagged as spam <abbr title="setting: num flags to block new user">3</abbr> times from <abbr title="setting: num users to block new user">3</abbr> different users will have *all* their posts hidden as a result. (TODO: Should probably include inappropriate too)
- If after <abbr title="setting: notify about flags after">48</abbr> hours a flag is still in the flag queue without any action taken, an automatic mail will go out to <abbr title="setting: contact email">contact_email</abbr>.
- A topic with <abbr title="setting: num flags to close topic">12</abbr> unresolved flags from at least <abbr title="setting: num flaggers to close topic">5</abbr> different users will be automatically closed until the moderators can intervene.
