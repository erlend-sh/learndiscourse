---
title: Configuring GitHub login for Discourse
---

<small class="doc-source">Source: https://meta.discourse.org/t/configuring-github-login-for-discourse/13745</small>

1. Click **Settings** (the gear icon), then look for **Applications** in the left menu. Select **Register new application**.

    <img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/9/9c52aee3c875fc216e7f85047243ed67a0c8e124.png" width="539" height="499"> 

     Be sure to set the Callback URL to use the path `/auth/github/callback` at your site domain. e.g., `http://discuss.example.com/auth/github/callback`

2. After creating your application, you should see the **Client ID** and **Client Secret**. Enter those in the Discourse fields:

     `github_client_id`  
     `github_client_secret`

That's it!
