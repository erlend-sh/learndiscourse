---
title: Configuring Twitter login for Discourse
---

1. Go to [apps.twitter.com][3] and sign in with a twitter account.

2. Click the Create New App button.

3. Enter a name and description for your forum.

4. Enter `http://forum.example.com` in the Website field.

5. Enter `http://forum.example.com/auth/twitter/callback` in the Callback URL field.

6. Agree to the legal stuff and click the Create button.

7. In the Settings tab, check "Allow this application to be used to Sign in with Twitter" and click Update Settings.

8. In the Permissions tab, choose "Read Only" and click Update Settings.

9. Click on the "Keys And Access Tokens" tab. The API key and API secret go in the `twitter_consumer_key` and `twitter_consumer_secret `settings in the Login section (`/admin/site_settings/category/login`).

### Settings

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/d/f/df006c02ad6c1632abb934b0cdb9e74cc83f56ac.png" width="480" height="499">

  [3]: https://apps.twitter.com/

<small class="documentation-source">Source: [https://meta.discourse.org/t/configuring-twitter-login-for-discourse/13395](https://meta.discourse.org/t/configuring-twitter-login-for-discourse/13395)</small>
