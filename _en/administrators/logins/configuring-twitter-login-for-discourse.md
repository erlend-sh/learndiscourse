---
title: Configuring Twitter login for Discourse
---

<small class="documentation-source">Source: [https://meta.discourse.org/t/configuring-twitter-login-for-discourse/13395](https://meta.discourse.org/t/configuring-twitter-login-for-discourse/13395)</small>

1. Go to [apps.twitter.com][3] and sign in with a twitter account.

2. Click the Create New App button.

3. Enter a name and description for your forum.

4. Enter `http://forum.example.com` in the Website field.

5. Enter `http://forum.example.com/auth/twitter/callback` in the Callback URL field.

6. Agree to the legal stuff and click the Create button.

7. Click on the API Keys tab. The API key and API secret go in the `twitter_consumer_key` and `twitter_consumer_secret `settings in the Login section (`/admin/site_settings/category/login`).

### Settings

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/1/4/14ea772b8422e93cf139866b713e80f7d6eab7c2.png" width="430" height="500"> 

  [3]: https://apps.twitter.com/
