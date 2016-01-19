---
title: Official Single-Sign-On for Discourse
weight: 90
---

Discourse now ships with official hooks to perform auth offsite. 

### The Problem

Many sites wish to integrate with a Discourse site, however want to keep all user registration in a separate site. In such a setup all Login operations should be outsourced to a different site. 

### What if I would like SSO in conjunction with existing auth?

The intention around SSO is to replace Discourse authentication, if you would like to add a new provider see existing plugins such as: https://meta.discourse.org/t/vk-com-login-vkontakte/12987

### Enabling SSO

To enable single sign on you have 3 settings you need to fill out:

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/e/e79ff70dff74f97fc700d8a17b8e00ef4060f158.png" width="690" height="207"> 

`enable_sso` : must be enabled, global switch
`sso_url`: the **offsite** URL users will be sent to when attempting to log on
`sso_secret`: a secret string used to hash SSO payloads. Ensures payloads are authentic.

Once `enable_sso` is set to true:

- Clicking on login or avatar will, redirect you to `/session/sso` which in turn will redirect users to `sso_url` with a signed payload.
- Users will not be allowed to "change password". That field is removed from the user profile.
- Users will no longer be able to use Discourse auth (username/password, google, etc)

### What if you check it by mistake?

If you check `enable_sso` by mistake and need to revert to the original state and no longer have access to the admin panel

run:

```
./launcher enter app
rails c
irb > SiteSetting.enable_sso = false
irb > SiteSetting.enable_local_logins = true
irb > exit
exit
```

### Implementing SSO on your site

> :warning: Discourse uses emails to map external users to Discourse users, and assumes that external emails are secure. **IF YOU DO NOT VALIDATE EMAIL ADDRESSES BEFORE SENDING THEM TO DISCOURSE, YOUR SITE WILL BE EXTREMELY VULNERABLE!**

Alternatively, if you insist on sending unvalidated emails **BE SURE** to set `require_activation=true`, this will force all emails to be validated by Discourse. 

Discourse will redirect clients to `sso_url` with a signed payload: (say `sso_url` is `https://somesite.com/sso`)

You will receive incoming traffic with the following

`https://somesite.com/sso?sso=PAYLOAD&sig=SIG`

The payload is a Base64 encoded string comprising of a [nonce][1]. The payload is always a valid querystring. 

For example, if the nonce is ABCD. raw_payload will be:

`nonce=ABCD`, this raw payload is [base 64][2] encoded.

The endpoint being called must

1. Validate the signature, ensure that HMAC-SHA256 of sso_secret, PAYLOAD is equal to the sig
2. Perform whatever authentication it has to
3. Create a new payload with **nonce**, **email**, **external_id** and optionally (username, name) 
4. Base64 encode the payload
5. Calculate a HMAC-SHA256 hash of the payload using sso_secret as the key and Base64 encoded payload as text 
6. Redirect back to `http://discourse_site/session/sso_login?sso=payload&sig=sig`

Discourse will validate that the nonce is valid, and if valid, it will expire it right away so it can not be used again. Then, it will attempt to:

1. Log the user on by looking up an already associated **external_id** in the SingleSignOnRecord model
2. Log the user on by using the email provided (updating external_id)
3. Create a new account for the user providing (email, username, name) updating external_id

###Security concerns

The nonce (one time token) will expire automatically after 10 minutes. This means that as soon as the user is redirected to your site they have 10 minutes to log in / create a new account. 

The protocol is safe against replay attacks as nonce may only be used once.

###Reference implementation

Discourse contains a reference implementation of the SSO class:

https://github.com/discourse/discourse/blob/master/lib/single_sign_on.rb

A trivial implementation would be:

```
class DiscourseSsoController < ApplicationController
  def sso
    secret = "MY_SECRET_STRING"
    sso = SingleSignOn.parse(request.query_string, secret)
    sso.email = "user@email.com"
    sso.name = "Bill Hicks"
    sso.username = "bill@hicks.com"
    sso.external_id = "123" # unique id for each user of your application
    sso.sso_secret = secret

    redirect_to sso.to_url("http://l.discourse/session/sso_login")
  end
end
```

### Transitioning to and from single sign on.

The system always trusts emails provided by the single sign on endpoint. This means that if you had an existing account in the past on Discourse with SSO disabled, SSO will simply re-use it and avoid creating a new account. 

If you ever turn off SSO, users will be able to reset passwords and gain access back to their accounts. 

### Real world example:

Given the following settings:

Discourse domain: `http://discuss.example.com`  
SSO url : `http://www.example.com/discourse/sso`  
SSO secret: `d836444a9e4084d5b224a60c208dce14`  
Email validated: No (add require_activation=true to the payload)

**User attempt to login**  

- Nonce is generated: `cb68251eefb5211e58c00ff1395f0c0b`

- Raw payload is generated: `nonce=cb68251eefb5211e58c00ff1395f0c0b`

-  Payload is Base64 encoded: `bm9uY2U9Y2I2ODI1MWVlZmI1MjExZTU4YzAwZmYxMzk1ZjBjMGI=\n`

- Payload is URL encoded: `bm9uY2U9Y2I2ODI1MWVlZmI1MjExZTU4YzAwZmYxMzk1ZjBjMGI%3D%0A`

- HMAC-SHA256 is generated on the Base64 encoded Payload: `2828aa29899722b35a2f191d34ef9b3ce695e0e6eeec47deb46d588d70c7cb56`

Finally browser is redirected to:

`http://www.example.com/discourse/sso?sso=bm9uY2U9Y2I2ODI1MWVlZmI1MjExZTU4YzAwZmYxMzk1ZjBjMGI%3D%0A&sig=2828aa29899722b35a2f191d34ef9b3ce695e0e6eeec47deb46d588d70c7cb56`

**On the other end**

1. Payload is **validated** using HMAC-SHA256, if the sig mismatches, process aborts. 
2. By reversing the steps above nonce is extracted. 

User logs in:

```
name: sam
external_id: hello123
email: test@test.com
username: samsam
require_activation: true
```

- Unsigned payload is generated:

`nonce=cb68251eefb5211e58c00ff1395f0c0b&name=sam&username=samsam&email=test%40test.com&external_id=hello123&require_activation=true`

<small>order does not matter, values are URL encoded</small>

- Payload is Base64 encoded

`bm9uY2U9Y2I2ODI1MWVlZmI1MjExZTU4YzAwZmYxMzk1ZjBjMGImbmFtZT1zYW0mdXNlcm5hbWU9\nc2Ftc2FtJmVtYWlsPXRlc3QlNDB0ZXN0LmNvbSZleHRlcm5hbF9pZD1oZWxsbzEyMyZyZXF1aXJl\nX2FjdGl2YXRpb249dHJ1ZQ==\n`

- Payload is URL encoded

`bm9uY2U9Y2I2ODI1MWVlZmI1MjExZTU4YzAwZmYxMzk1ZjBjMGImbmFtZT1zYW0mdXNlcm5hbWU9%0Ac2Ftc2FtJmVtYWlsPXRlc3QlNDB0ZXN0LmNvbSZleHRlcm5hbF9pZD1oZWxsbzEyMyZyZXF1aXJl%0AX2FjdGl2YXRpb249dHJ1ZQ%3D%3D%0A`

- Base64 encoded Payload is signed

`1c884222282f3feacd76802a9dd94e8bc8deba5d619b292bed75d63eb3152c0b` TODO update example - this is not correct signature

- Browser redirects to:

`http://discuss.example.com/session/sso_login?sso=bm9uY2U9Y2I2ODI1MWVlZmI1MjExZTU4YzAwZmYxMzk1ZjBjMGImbmFtZT1zYW0mdXNlcm5hbWU9%0Ac2Ftc2FtJmVtYWlsPXRlc3QlNDB0ZXN0LmNvbSZleHRlcm5hbF9pZD1oZWxsbzEyMyZyZXF1aXJl%0AX2FjdGl2YXRpb249dHJ1ZQ%3D%3D%0A&sig=1c884222282f3feacd76802a9dd94e8bc8deba5d619b292bed75d63eb3152c0b`

### Synchronizing SSO records 

You can use the POST admin endpoint `/admin/users/sync_sso` to synchronize an SSO record, pass it the same record you would pass to the SSO endpoint, nonce does not matter. 

### Logging off users

You can use the POST admin endpoint `/admin/users/{USER_ID}/log_out` to log out any user in the system if needed.

### Search users by `external_id`

User profile data can be accessed using the `/users/by-external/{EXTERNAL_ID}.json` endpoint. This will return a JSON payload that contains the user information, including the `user_id` which can be used with the `log_out` endpoint.

### Future work

- We would like to gather more reference implementations for SSO on other platforms. If you have one please post to [the Extensibility / SSO category](https://meta.discourse.org/category/extensibility/sso).

- Add session expiry and/or revalidation logic, so users are not logged in forever. 

- Consider adding a discourse_sso gem to make it easier to implement in Ruby. 

### Advanced Features

- You can pass through custom user field now: https://meta.discourse.org/t/custom-user-fields/14956
- You can pass `avatar_url` to override user avatar (`sso_overrides_avatar` needs to be enabled). Avatars are cached so pass `avatar_force_update=true` to force them to update: https://github.com/discourse/discourse/pull/2670
- By default the welcome message will be sent to all new users created through SSO. If you wish to suppress this you can pass `suppress_welcome_message=true`

## Updates:

**2-Feb-2014** 

- use [HMAC][3]-SHA256 instead of SHA256. This is more secure and cleanly separates key from payload.
- removed return_url, the system will automatically redirect users back to the page they were on after login 

**4-April-2014**

- Added example

**24-April-2014**

- Make note of custom user fields.

**01-August-2014**

- Changed Rails console instructions to assume Docker setup

**22-August-2014**

- Added option to override user avatar.

**23-Oct-2014**

- Added end point for synchronizing SSO

  [1]: http://en.wikipedia.org/wiki/Cryptographic_nonce
  [2]: http://en.wikipedia.org/wiki/Base64
  [3]: http://en.wikipedia.org/wiki/Hash-based_message_authentication_code

<small class="documentation-source">Source: [https://meta.discourse.org/t/official-single-sign-on-for-discourse/13045](https://meta.discourse.org/t/official-single-sign-on-for-discourse/13045)</small>
