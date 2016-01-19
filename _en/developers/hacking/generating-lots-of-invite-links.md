---
title: Generating lots of Invite Links
weight: 320
---

So you want to generate multiple Invite Links? Great! Let's get started!

## Clone Discourse API Gem

If you already have Git and Ruby installed on your system, you can install Discourse API by running following command from console:

    git clone https://github.com/discourse/discourse_api.git ~/discourse_api

## Generate Master API Key

Generate Master API Key for your Discourse instance by visiting `/admin/api`, to interact with Discourse API.

## Generate multiple Invite Tokens

Now that you have cloned Discourse API gem and generated master API key, let's start generating invite tokens!

Open the `discourse_api/examples/disposable_invite_tokens.rb` file, and modify following information:

- Provide API credentials:

```
client = DiscourseApi::Client.new("http://localhost:3000")
client.api_key = "YOUR_API_KEY"
client.api_username = "YOUR_USERNAME"
```

Replace `http://localhost:3000` with the url of your discourse instance, eg: `http://discourse.example.com`

Replace `YOUR_API_KEY` with the master API key of your discourse instance, eg: `b1f3175cb682b3e9b6ca419db77772120b19af993cbc14ebed80fea08e3bbd66`

Replace `YOUR_USERNAME` with the Admin username of your discourse instance, eg: `codinghorror`

* Provide Invites details:

`invite_tokens = client.disposable_tokens(username: "eviltrout", quantity: 200 , group_names: "security,support")`

Replace `eviltrout` with the username of person whose account you want to be attached with generated invites.

Replace `200` with the quantity of tokens you want to generate.

The `group_names` parameter is optional. If you want invited users to be automatically added to specific group(s), specify the group names separated with comma. eg: `security,support`

Now in console, from `discourse_api` directory run:

    ruby examples/disposable_invite_tokens.rb

This command will generate a `invite_tokens.csv` file inside `discourse_api/examples/` folder.

Open the `invite_tokens.csv` file and *voilà* it will have 100 invite tokens ready to be used instantly!

## Prepare Invitation Links from Invite Token

The Invitation URL will be like:

`http://discourse.example.com/invites/redeem/TOKEN?username=USERNAME&email=EMAIL&name=NAME&topic=TOPICID`

Replace following fields:

- *`discourse.example.com` with the URL of your Discourse instance.
- *`TOKEN` with one of the 200 Invite tokens you just generated.
- *`EMAIL` with the email of user you want to invite
- `USERNAME` with the desired username of invited user
- `NAME` with the first name of invited user
- `TOPIC` with the id of the topic to direct the user to after joining

(*) these fields are required!

[Note that we use [Percent-encoding](http://en.wikipedia.org/wiki/Percent-encoding) in URL, so `space` needs to be specified as `%20`, `+` needs to be specified as `%2B`, etc.]

## Visit Invitation Link

When the user will visit Invitation Link, he will be registered, activated and logged in instantly. If you specified the groups while generating tokens, he will be automatically added to that particular group(s) when logged in.

That's it! Start generating Invite Links for your Discourse instance today!

----

### **Update:** Now you can generate Invite links via UI!

To generate copyable invite link go to your invites page, click on "Send an Invite" button, enter the email of the user you want to invite, now click on "Copy Invite Link" button:

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/c/d/cd5ab6ecdbc5a91dc097fb4f5aae5d09941b3637.png" width="690" height="267"> 

That's it, now you will see copyable invite link:

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/7/d/7d1d54bae9e9c9b2cdc9714b3381603cc0ad352e.png" width="690" height="256"> 

Copy and paste away! :link:

<small class="documentation-source">Source: [https://meta.discourse.org/t/generating-lots-of-invite-links/17563](https://meta.discourse.org/t/generating-lots-of-invite-links/17563)</small>
