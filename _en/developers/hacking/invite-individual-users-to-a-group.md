---
title: Invite individual users to a group
name: invite-individual-users-to-a-group
subsection: hacking
---

Users may be invited to the site and prestaged in a group.

Upon account creation the user will be added to this group.

This feature is useful when you wish to invite a group of private beta testers, employees, etc.

**This feature is only available to forum admins**

Using the UI:

<img src="/uploads/default/4944/ce6e0e08d81c391d.png" width="690" height="250">

Using [the API][1]:

```
require 'discourse_api'
client = DiscourseApi::Client.new("somesite",port)
client.api_key = "your key"
client.api_username = "an_admin"

client.topic_invite_user(topic_id: 1, email: "bob@bob.com", group_ids: "1,2,3")
client.topic_invite_user(topic_id: 1, email: "bob@bob.com", group_names: "bugs,cars,testers")
```

**Limitations**

At the moment you may not invite users to predefined groups such as, trust level groups, admin, mod or staff groups.


  [1]: https://github.com/discourse/discourse_api
