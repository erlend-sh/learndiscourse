---
title: Using Discourse API
weight: 400
---

<small class="doc-source">Source: https://meta.discourse.org/t/using-discourse-api/17587</small>

So you want to use Discourse API? Great! Let's get started!

## Clone Discourse API Gem

If you already have Git and Ruby installed on your system, you can install Discourse API by running following command from console:

    git clone https://github.com/discourse/discourse_api.git ~/discourse_api

## Generate Master API Key

Generate Master API Key for your Discourse instance by visiting `/admin/api`, to interact with Discourse API.

## Provide API Credentials

Now that you have cloned Discourse API gem and generated master API key, let's start using it!

Open the `discourse_api/examples/example.rb` file, and modify following information:

```
client = DiscourseApi::Client.new("http://localhost:3000")
client.api_key = "YOUR_API_KEY"
client.api_username = "YOUR_USERNAME"
```

Replace `http://localhost:3000` with the url of your discourse instance, eg: `http://discourse.example.com`

Replace `YOUR_API_KEY` with the master API key of your discourse instance, eg: `b1f3175cb682b3e9b6ca419db77772120b19af993cbc14ebed80fea08e3bbd66`

Replace `YOUR_USERNAME` with the Admin username of your discourse instance, eg: `codinghorror`

## Access Discourse API

Now in console, from `discourse_api` directory run:

    ruby examples/example.rb

This command will print out latest topics from your Discourse instance.

That's it. Start using Discourse API today.
