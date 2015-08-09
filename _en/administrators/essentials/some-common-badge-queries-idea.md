---
title: Some common badge queries idea
---

<small class="doc-source">Source: https://meta.discourse.org/t/some-common-badge-queries-idea/31859</small>

Here are some common badge queries which you can use to create your own awesome badge!

- Grant a badge if user has created at least one topic in the "foo" category

```
SELECT p.user_id, min(p.created_at) granted_at, MIN(p.id) post_id
FROM badge_posts p
JOIN topics t ON t.id = p.topic_id
WHERE category_id = (
  SELECT id FROM categories WHERE name ilike 'foo'
) AND p.post_number = 1
GROUP BY p.user_id
```

- Grant a badge if user has created 5 topics in the "foo" category

```
SELECT p.user_id, min(p.created_at) granted_at, MIN(p.id) post_id
FROM badge_posts p
JOIN topics t ON t.id = p.topic_id
WHERE category_id = (
  SELECT id FROM categories WHERE name ilike 'foo'
) AND p.post_number = 1
GROUP BY p.user_id
HAVING count(*) > 4
```

- Grant a badge if user has replied to at least one topic

```
SELECT
DISTINCT ON (p.user_id)
p.user_id, min(p.created_at) granted_at, MIN(p.id) post_id
FROM badge_posts p
JOIN topics t ON t.id = p.topic_id
GROUP BY p.user_id
```

- Grant a badge if user has replied to 10 topics

```
SELECT
DISTINCT ON (p.user_id)
p.user_id, min(p.created_at) granted_at, MIN(p.id) post_id
FROM badge_posts p
JOIN topics t ON t.id = p.topic_id
GROUP BY p.user_id
HAVING count(*) > 9
```

- Grant a badge if user has created 500 posts

```
SELECT user_id, 0 post_id, current_timestamp granted_at 
FROM badge_posts  
WHERE (:backfill OR user_id IN (:user_ids) OR 0 NOT IN (:post_ids) )
GROUP BY user_id 
HAVING count(*) > 499
```

- Grant a badge to all the members of the group "foobar"

```
SELECT user_id, created_at granted_at, NULL post_id
FROM group_users
WHERE group_id = (
  SELECT g.id FROM groups g WHERE g.name = 'foobar'
)
```
- Grant a badge to the first 100 users of the forum

```
SELECT id AS user_id, created_at AS granted_at, NULL AS post_id
FROM users WHERE id > 0
ORDER BY created_at ASC LIMIT 100
```

I have wiki'd this post, so feel free to add more awesome badge queries here!
