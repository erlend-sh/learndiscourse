---
title: Using Discourse as a SSO provider
---

So you want to use Discourse as a SSO provider for your own web app? Great! Let's get started.

## Enable SSO provider setting

Under Discourse admin site settings (/admin/site_settings) enable setting `enable sso provider` and set `sso secret` to a secret string (used to hash SSO payloads).

## Implement SSO in your web app:

- Generate a random [nonce](https://en.wikipedia.org/wiki/Cryptographic_nonce). Save it temporarily so that you can verify it with returned nonce value

- Create a new payload with nonce and return url (where the Discourse will redirect user after verification). Payload should look like: `nonce=NONCE&return_sso_url=RETURN_URL`

- Base64 encode the above raw payload. Let's call this payload as `BASE64_PAYLOAD`

- URL encode the above `BASE64_PAYLOAD`. Let's call this payload as `URL_ENCODED_PAYLOAD`

- Generate a HMAC-SHA256 signature from `BASE64_PAYLOAD` using your sso_secret as the key, then create a hex string from this. Let's call this signature as `HEX_SIGNATURE`

## Send auth request to Discourse

Redirect the user to `DISCOURSE_ROOT_URL/session/sso_provider?sso=URL_ENCODED_PAYLOAD&sig=HEX_SIGNATURE`

## Get response from Discourse:

If the above steps are done correctly Discourse will redirect logged in user to the provided `RETURN_URL`. You will get query string parameters with `sig` and `sso` along with some user info. Now follow below steps:

- Compute the HMAC-SHA256 of `sso` using sso_secret as your key.

- Convert `sig` from it's hex string representation back into bytes.

- Make sure the above two values are equal.

- Base64 decode `sso`, you'll get the passed embedded query string. This will have a key called `nonce` whose value should match the nonce passed originally. Make sure that this is the case.

- You'll find this query string will also contain a bunch of user information, use as you see fit.

That's it. By now you should have set up your web app to use Discourse as SSO provider!

### Discourse official "Using Discourse as SSO provider" implementations:

- An http proxy (using golang) that uses Discourse SSO to authenticate users (only Admins): https://github.com/discourse/discourse-auth-proxy (made by @sam)

### Community contributed "Using Discourse as SSO provider" implementations:

- A Go package that implements Discourse as SSO provider: https://github.com/sekhat/godiscuss/blob/master/sso/sso.go (made by @sekhat)

- A PHP script that implements Discourse as SSO provider: https://gist.github.com/paxmanchris/e93018a3e8fbdfced039 (made by @paxmanchris)

<small class="documentation-source">Source: [https://meta.discourse.org/t/using-discourse-as-a-sso-provider/32974](https://meta.discourse.org/t/using-discourse-as-a-sso-provider/32974)</small>
