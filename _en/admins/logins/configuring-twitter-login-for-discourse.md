---
title: Configuring Twitter login for Discourse
name: configuring-twitter-login-for-discourse
---

1. Go to [apps.twitter.com][3] and sign in with a twitter account.

2. Click the Create New App button.

3. Enter a name and description for your forum.

4. Enter `http://forum.example.com` in the Website field.

5. Enter `http://forum.example.com/auth/twitter/callback` in the Callback URL field.

6. Agree to the legal stuff and click the Create button.

7. Click on the API Keys tab. The API key and API secret go in the `twitter_consumer_key` and `twitter_consumer_secret `settings in the Login section (`/admin/site_settings/category/login`).

### Settings

<img src="/uploads/default/38199/fdf39031f965b380.png" width="430" height="500"> 

  [3]: https://apps.twitter.com/