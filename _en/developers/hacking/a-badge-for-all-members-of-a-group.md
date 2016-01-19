---
title: A badge for all members of a group
weight: 280
---

I just created a badge for all the awesome [plugin authors][1]. 

Creating a badge targeting a group is quite easy, just type this into the SQL box:

```
select user_id, created_at granted_at, NULL post_id
from group_users
where group_id = (
  select g.id from groups g where g.name = 'GROUP_NAME_IN_LOWER_HERE'
)
```

I will add a trigger for this at some point so granting is faster, in the mean time just go to /sidekiq/scheduler and kick off the badge job to rush it. 

  [1]: /badges

<small class="documentation-source">Source: [https://meta.discourse.org/t/a-badge-for-all-members-of-a-group/18147](https://meta.discourse.org/t/a-badge-for-all-members-of-a-group/18147)</small>
