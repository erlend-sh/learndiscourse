---
title: Configuring Facebook login for Discourse
---

<small class="doc-source">Source: https://meta.discourse.org/t/configuring-facebook-login-for-discourse/13394</small>

1. Go to [developers.facebook.com][1] and create an app:

2. Click Add Platform, choose Website, and enter `http://forum.example.com` in the Site URL field.

3. Click on Settings on the left. Enter `forum.example.com` in the App Domains field.

4. Enter your email in the Contact Email field

4. Under the Advanced tab (at the top), make sure Client OAuth Login is enabled. Enter `http://forum.example.com/auth/facebook/callback` in the Valid OAuth redirect URIs field.

5. Click the Save Changes button.

6. The App ID and App Secret go in the `facebook_app_id` and `facebook_app_secret` settings in the users section.

7. Go to Status & Review and change "available to the general public" to Yes.

  [1]: https://developers.facebook.com
