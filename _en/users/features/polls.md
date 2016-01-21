---
title: Polls
---

To add a poll to *any* post, just follow these easy examples: 

Borrowed from @codinghorror's [blog post on the same topic][1]. 

###Single Choice Poll

    [poll]
    - Apples
    - Oranges
    - Pears
    [/poll]

###Multiple Choice Poll

    [poll type=multiple]
    - Apples
    - Oranges
    - Pears
    [/poll]

###Multiple Choice Limited Option Poll

    [poll type=multiple min=1 max=2]
    - Apples
    - Oranges
    - Pears
    [/poll]

###Number Rating Poll

    [poll type=number min=1 max=4]
    [/poll]

###Multiple Polls in one Post
To include several polls in the same post, simply give each poll a name:

    [poll name=fruits]
    - Apples :apple:
    - Oranges :tangerine:
    - Pears :pear:
    [/poll]


  [1]: http://blog.discourse.org/2015/08/improved-polls-in-discourse/

<small class="documentation-source">Source: [https://meta.discourse.org/t/how-to-create-a-poll/34003](https://meta.discourse.org/t/how-to-create-a-poll/34003)</small>
