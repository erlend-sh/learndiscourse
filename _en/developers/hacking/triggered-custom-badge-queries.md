---
title: Triggered custom badge queries
weight: 260
---

When defining badges there is this beguiling box "Trigger" with the options:

- Update daily
- When a user acts on a post 
- When a user edits or creates a post
- When a user changes trust level
- When a user is edited or created

The trigger forces badges to run at an interval that is more frequent than daily. We use these triggers in our badges. They ensure users are notified of new badges closer to the time the action happened.

### 2 types of badges

When defining badges you can choose 1 of the 2 flavors, badge that targets posts or a badge that does not.

All badge SQL definitions always **require** you select the columns `user_id` and `granted_at`. 

If your badge targets posts you **must** also select a column named `post_id` 

<small>sometimes these columns are not available, just alias them eg: u.id as user_id</small>


### Triggered badges have 2 extra constraints

Since triggered badges can run once a minute, we require you provide more "hinting" in the badge definition. It is not enough to return the full set of badges, you **must** also provide hinting about how to execute the badge on a subset. 

If your trigger is user based, you must supply a clause on how to filter it base on `:user_ids`, if your trigger is post based, you must supply information on how to trigger it based on `:post_ids` 

Since daily a full backfill runs regardless you must take that into consideration and include handling of the `:backfill` parameter. 

So, you query triggered badge query will always include the :backfill param and either the `:post_ids` param or :user_ids param.

### An example

The following badge is triggered on "when a user acts on a post", this means "delta" applications will get the `:post_ids` parameter.  

```
SELECT p.user_id, p.id post_id, p.updated_at granted_at
FROM badge_posts p
WHERE p.like_count >= 25 AND
(:backfill OR p.id IN (:post_ids) )
```

The clause `(:backfill OR p.id IN (:post_ids) )` allows us to filter the results. When the daily job runs `:backfill` is true so the entire set is scanned. When the delta jobs run `:backfill` is false and `:post_ids` is set. 

### Why can't this be done "automatically" 

Our badge grant query runs your badge query in a "subquery", I fount that often the postgres optimiser is tripping when and scanning the full set when the clause is on the main query. On trivial queries it may be smart enough, but once you start working with aggregates it just does not seem to catch.

To avoid any potential issues this constraint was added, it also allows you to apply the filters in the most correct spot. 

### What if all of this is just too complicated for me? 

If you are having trouble writing a badge query, post a question on meta, describe what you are trying to solve and your work in progress. We will try to help. 

Badge triggers is a complex subject often "daily" updates suffice and all this complex stuff can be skipped.

<small class="documentation-source">Source: [https://meta.discourse.org/t/triggered-custom-badge-queries/19336](https://meta.discourse.org/t/triggered-custom-badge-queries/19336)</small>
