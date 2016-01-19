---
title: How to create an administrator account after install
weight: 360
---

### The simple way

Make sure either:

-  The env var `DISCOURSE_DEVELOPER_EMAILS` is set to a *comma* delimited list of admin emails. 
 
(OR)

- If using `config/discourse.conf` that `developer_emails` is set to a *comma* delimited list of admin emails. 

For example:

    DISCOURSE_DEVELOPER_EMAILS=user@example.com,user2@example.com rails s


Will **automatically** set the accounts of `user@example.com` and `user2@example.com` to admins after they create accounts. 

### The hard way

You can also use the Rails console to set yourself as an administrator: 

```text
./launcher enter my_app
# rake admin:create
Email:  myemail@example.com
Password:  
Repeat password:  

Ensuring account is active!

Account created successfully with username myemail
Do you want to grant Admin privileges to this account? (Y/n)  Y

Your account now has Admin privileges!
```

<small class="documentation-source">Source: [https://meta.discourse.org/t/how-to-create-an-administrator-account-after-install/14046](https://meta.discourse.org/t/how-to-create-an-administrator-account-after-install/14046)</small>
