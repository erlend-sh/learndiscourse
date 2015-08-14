---
title: Configuring Google OAuth2 login for Discourse
---

<small class="documentation-source">Source: [https://meta.discourse.org/t/configuring-google-oauth2-login-for-discourse/15858](https://meta.discourse.org/t/configuring-google-oauth2-login-for-discourse/15858)</small>

[The days of easy configuration of Google logins is over][1].

Here's how to configure Discourse to allow login and registration with Google OAuth2.

1. Go to https://console.developers.google.com and create a new Project. Wait a minute as needed for it to appear.

    <img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/5/c/5c93f5b6ebad5d4b8e1a611f389214c374597a08.png" width="528" height="376"> 

2. In the new project, in the menu on the left, click "APIs & auth" > **Credentials**. Click the "Create New Client ID" button on the right side.

    <img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/b/6/b6dcef818ee0c18cd14e9244fe26b5695c7580af.png" width="602" height="398"> 

3. Go ahead and click **Configure Consent Screen** button. Fill as appropriate; we recommend populating all these fields!

    <img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/b/a/ba4518181fe96aa5ac92a65a00c031bd5fb1aea5.png" width="326" height="500"> 

4. Choose "Web application" as the Application Type. In the Authorized JavaScript Origins section, add your site's base url, including `http://` or `https://`. In the Authorized Redirect URI section, add the base url with `/auth/google_oauth2/callback`. Click the Create Client ID button.

    <img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/0/0/00e58ab0f22f7d0a0ca043f33c0242cd3f0a5cbc.png" width="488" height="500">

5. After some time, the web application will appear with its client ID and secret.

    <img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/3/9/3965fd76b3af1ddfb511354da1cd0e29bf9a1840.png" width="690" height="207"> 

6. Under "APIs & auth" > APIs, you'll see a huge list. Find "Contacts API" and "Google+ API". Enable both of them.

    <img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/c/a/caefd01448b419d84d7c6202fa9ccb02835ba57e.png" width="690" height="353"> 

7. In your Discourse site settings, uncheck "enable google logins", check "enable google oauth2 logins", and fill in your client id and client secret from step 4.

    <img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/4/4d83c1f0295e529b3e4865c7d9e5935ad0c31116.jpg" width="667" height="282">

## HTTPS

If you're using SSL and are getting errors when authenticating with Google OAuth2, see [this topic][2].


  [1]: https://meta.discourse.org/t/openid-auth-request-contains-an-unregistered-domain/15843/7?u=neil
  [2]: https://meta.discourse.org/t/invalid-redirect-uri-in-google-oauth2-api-call-http-instead-of-https/18105?u=neil
