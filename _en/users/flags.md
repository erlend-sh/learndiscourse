---
title: Flags
name: flags
subsection: essentials
---

Flags is an in-built moderation measure in Discourse, intended to dissuade bad behavior and spam, as well as promoting civilised discourse. The general rule is that if there is a post with wich you have an issue that does not pertain to the topic discussion at hand, you *flag* it instead.

<img src="../public/resources/flags_button.png" />

By default, clicking the flag button will present a user with the following options:

- It's Off-Topic
This post is not relevant to the current discussion as defined by the title and first post, and should probably be moved elsewhere.

- It's Inappropriate
This post contains content that a reasonable person would consider offensive, abusive, or a violation of our community guidelines.

- It's Spam
This post is an advertisement. It is not useful or relevant to the current topic, but promotional in nature.

- Message @codinghorror
This post contains something I want to talk to this person directly and privately about. Does not cast a flag.

- Something Else
This post requires moderator attention for another reason not listed above.

<img src="../public/resources/flags_dialog.png" />

Marking a post as Opp-Topic, Inappropriate or Spam will trigger a moderator notification so moderators may review the issue in their [flag queue](). Furthermore, this also "casts a flag" on the post, which has other consequences:

- A user with 5 flags can not reach [TL 3]()
- A post with 3 flags will be automatically hidden.
- A *new* user (COMMENT NEEDED: Does this mean TL0?) whos post is flagged 3 times will have *all* their posts hidden as a result.
- If after 48 hours a flag is still in the flag queue without any action taken, an automatic mail will go out to contact_email.

COMMENT NEEDED: Relationship between `num flags to block new user` and  `num users to block new user` needs better explanation.