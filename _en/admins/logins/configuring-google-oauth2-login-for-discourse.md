---
title: Configuring Google OAuth2 login for Discourse
name: configuring-google-oauth2-login-for-discourse
---

[The days of easy configuration of Google logins is over][1].

Here's how to configure Discourse to allow login and registration with Google OAuth2.

1. Go to https://console.developers.google.com and create a new Project. Wait a minute as needed for it to appear.

    <img src="/uploads/default/40462/c9e3f1ec6261735a.png" width="528" height="376"> 

2. In the new project, in the menu on the left, click "APIs & auth" > **Credentials**. Click the "Create New Client ID" button on the right side.

    <img src="/uploads/default/40463/92be12b45e5ab4d2.png" width="602" height="398"> 

3. Go ahead and click **Configure Consent Screen** button. Fill as appropriate; we recommend populating all these fields!

    <img src="/uploads/default/40461/bd4a81dc1c1f5b6a.png" width="326" height="500"> 

4. Choose "Web application" as the Application Type. In the Authorized JavaScript Origins section, add your site's base url, including `http://` or `https://`. In the Authorized Redirect URI section, add the base url with `/auth/google_oauth2/callback`. Click the Create Client ID button.

    <img src="/uploads/default/40459/909ac228cce1cf83.png" width="488" height="500">

5. After some time, the web application will appear with its client ID and secret.

    <img src="/uploads/default/40466/4f2d7adf66e47c27.png" width="690" height="207"> 

6. Under "APIs & auth" > APIs, you'll see a huge list. Find "Contacts API" and "Google+ API". Enable both of them.

    <img src="/uploads/default/40465/126b65fcd0db6d93.png" width="690" height="353"> 

7. In your Discourse site settings, uncheck "enable google logins", check "enable google oauth2 logins", and fill in your client id and client secret from step 4.

    <img src="/uploads/default/5179/97684f1402ad3557.jpg" width="667" height="282">

## HTTPS

If you're using SSL and are getting errors when authenticating with Google OAuth2, see [this topic][2].


  [1]: https://meta.discourse.org/t/openid-auth-request-contains-an-unregistered-domain/15843/7?u=neil
  [2]: https://meta.discourse.org/t/invalid-redirect-uri-in-google-oauth2-api-call-http-instead-of-https/18105?u=neil