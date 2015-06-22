---
title: Configuring GitHub login for Discourse
name: configuring-github-login-for-discourse
subsection: logins
---

1. Click **Settings** (the gear icon), then look for **Applications** in the left menu. Select **Register new application**.

    <img src="/uploads/default/3826/74ce46d82d2f7ce3.png" width="539" height="499">

     Be sure to set the Callback URL to use the path `/auth/github/callback` at your site domain. e.g., `http://discuss.example.com/auth/github/callback`

2. After creating your application, you should see the **Client ID** and **Client Secret**. Enter those in the Discourse fields:

     `github_client_id`  
     `github_client_secret`

That's it!
