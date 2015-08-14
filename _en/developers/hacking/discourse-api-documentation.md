---
title: Discourse API Documentation
weight: 380
---

<small class="documentation-source">Source: [https://meta.discourse.org/t/discourse-api-documentation/22706](https://meta.discourse.org/t/discourse-api-documentation/22706)</small>

# Discourse API

## Overview

This is the very first draft of the API Documentation and should be considered v0.0.1. Most likely the format and the content will change as progress is made. But the most important thing is that we have something to start with to improve upon. 

This document should not be considered complete.

## Current Version

Currently the API is not versioned (v1, v2, etc.). This will change at some point in the future, but could be a while.

https://meta.discourse.org/t/improving-discourse-api/9276/5

## Consuming the API

You can consume the API using cURL commands, but we recommend using the [discourse_api][2] gem so that you can use Ruby.

https://meta.discourse.org/t/using-discourse-api/17587

## Authentication

Some endpoints do not require any authentication, pretty much anything else will require you to be authenticated.

To become authenticated you will need to create an API Key from the admin panel.

Once you have your API Key you can pass it in as a url parameter like this:

    curl http://localhost:3000/c/test/sub-test.json?api_key=test_d7fd0429940&api_username=test_user

***

## Categories

### Get a list of categories

    GET /categories.json

**Example**

    curl http://localhost:3000/categories.json

### List topics in a specific category

    GET /c/:id.json

**Example**

    curl http://localhost:3000/c/14.json

### List the latest topics in a specific category

    GET /c/:id/l/latest.json

**Example**

    curl http://localhost:3000/c/14/l/latest.json

### List new topics in a specific category

    GET /c/:id/l/new.json

**Example**

    curl http://localhost:3000/c/14/l/new.json

### List the top topics in a specific category

    GET /c/:id/l/top.json

**Example**

    curl http://localhost:3000/c/14/l/top.json

### List the topics in a sub-category

    GET /c/:parent_id/:id.json

**Example**

    curl http://localhost:3000/c/12/14.json

### Create a category

    POST /categories

**Parameters**

* name
* color
* text_color

**Example**

    curl -X POST --data "name=bugs&color=3c3945&text_color=ffffff" http://localhost:3000/categories?api_key=test_d7fd0429940&api_username=test_user

## Topics

### Get the latest topics

    GET /latest.json

**Example**

    curl http://localhost:3000/latest.json

### Get a the top topics

    GET /top.json

**Example**

    curl http://localhost:3000/top.json

### Get a single topic

    GET /t/:id.json

**Example**

    curl http://localhost:3000/t/14.json

### Create Topic

    POST /posts

**Parameters**

* title
* raw

**Example**

    curl -X POST -d title="Title of my topic" -d raw="This is the body of my topic" http://localhost:3000/posts?api_key=test_d7fd0429940&api_username=test_user

### Update Topic

    PUT /t/:id

**Parameters**

* topic_id
* title
* category_id

**Example**

    curl -X PUT -d topic_id=14 -d title="This is my new title" http://localhost:3000/t/14?api_key=test_d7fd0429940&api_username=test_user

## Posts

### Create a post

    POST /posts

**Parameters**

* topic_id
* raw

**Example**

    curl -X POST -d topic_id=14 -d raw="This is a post to a topic." http://localhost:3000/posts?api_key=test_d7fd0429940&api_username=test_user

## Users

### Get info about a single user

    GET /users/:username.json

**Example**

    curl http://localhost:3000/users/steve.json

### Update username

    PUT /users/:username/preferences/username

**Parameters**

* new_username

**Example**

    curl -X PUT -d new_username=steve http://localhost:3000/users/bart/preferences/username?api_key=test_d7fd0429940&api_username=test_user

### Update email

    PUT /users/:username/preferences/email

**Parameters**

* email

**Example**

    curl -X PUT -d email=steve123@example.com http://localhost:3000/users/steve/preferences/email?api_key=test_d7fd0429940&api_username=test_user

### Update Custom Field

    PUT /users/:username.json

**Parameters**

* user_fields[:field_id]

**Example**

    curl -X PUT -d 'user_fields[1]=Lorem ipsum' http://localhost:3000/users/steve.json?api_key=test_d7fd0429940&api_username=test_user

### Update trust level

    PUT /admin/users/:user_id/trust_level

**Parameters**

* user_id
* level

**Example**

    curl -X PUT -d user_id=102 -d level=2 http://localhost:3000/admin/users/102/trust_level?api_key=test_d7fd0429940&api_username=test_user

### Create a user

    POST /users

**Parameters**

* name
* username
* email
* password
* active

**Example**

    curl -X POST --data "name=dave&username=dave&email=dave@example.com&password=P@ssword&active=true" http://localhost:3000/users?api_key=test_d7fd0429940&api_username=test_user

### List a User's recent activity

    GET /user_actions.json

**Parameters**

* username
* filter

The `filter` parameter takes a comma-separated list of integers to specify what type of activity to bring back. At the time of writing, the list was something like (grabbed from [User Action Model](https://github.com/discourse/discourse/blob/master/app/models/user_action.rb)):

    LIKE                = 1
    WAS_LIKED           = 2
    BOOKMARK            = 3
    NEW_TOPIC           = 4
    REPLY               = 5
    RESPONSE            = 6
    MENTION             = 7
    QUOTE               = 9
    EDIT                = 11
    NEW_PRIVATE_MESSAGE = 12
    GOT_PRIVATE_MESSAGE = 13
    PENDING             = 14


**Example**

    curl http://localhost:3000/user_actions.json?username=test_user&filter=4,5,6,7,9&api_key=test_d7fd0429940&api_username=test_user

## Badges

### List badges

    GET /admin/badges.json

**Example**

    curl http://localhost:3000/admin/badges.json?api_key=test_d7fd0429940&api_username=test_user

### Grant a badge to user

    POST /user_badges

**Parameters**

* username
* badge_id

**Example**

    curl -X POST -d username=john -d badge_id=101 http://localhost:3000/user_badges?api_key=test_d7fd0429940&api_username=test_user


## Notifications

### List your notifications

    GET /notifications.json

**Example**

    curl http://localhost:3000/notifications.json?api_key=test_d7fd0429940&api_username=test_user

### mark notifications read

 PUT /notifications/mark-read.json

**Example**

    curl http://localhost:3000/notifications/mark-read.json?api_key=test_d7fd0429940&api_username=test_user

### selectively mark notifications read

 POST /topics/timings.json
 POST Body  = topic_id=1234&topic_time=1234&timings[X]=1234 
 Where X = post_number to mark read

**note:** this accepts multiple posts (based on comment a user is viewing) eg. 

    curl -X POST -d  topic_id=1234 -d  topic_time=1234 -d  timings[1]=1234 -d  timings[2]=1234 -d  timings[3]=1234 http://localhost:3000 /topics/timings.json?api_key=test_d7fd0429940&api_username=test_user

   

   will mark comments 1, 2 and 3 read on the topic 1234 

## Private Messages

### List private messages

    GET /topics/private-messages/:username.json

**Example**

    curl http://localhost:3000/topics/private-messages/steve.json?api_key=test_d7fd0429940&api_username=test_user

## Search

### Search for a given query string

    GET /search

**Parameters**

* search
* order
* ascending

Values for the `order` parameter (there may be others, see below):

* category
* posts
* views
* activity

**Examples**

    curl -X GET -d search="new quotes category" http://localhost:3000/search.json

Search for `foo bar` and return results sorted by number of replies from least to most:

    curl -X GET -d search="foo bar" -d order="posts" -d "ascending=true" http://localhost:3000/search.json

Parameters, and values for these parameters, can be determined from the Discourse search page: https://meta.discourse.org/search.

But take note of this comment: https://meta.discourse.org/t/discourse-api-documentation/22706/44. `search` will be replaced with `q`.

  [2]: https://github.com/discourse/discourse_api
