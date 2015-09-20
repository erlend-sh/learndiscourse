---
title: Recover a user who was deleted as a spammer
---

<small class="documentation-source">Source: [https://meta.discourse.org/t/recover-a-user-who-was-deleted-as-a-spammer/33372](https://meta.discourse.org/t/recover-a-user-who-was-deleted-as-a-spammer/33372)</small>

So you accidentally flagged a post as spam and deleted the user from your site, but want to bring the user back. Oops.

Nuking a spammer from Discourse will automatically block them from signing up based on email address and IP address. So the first thing you need to do to allow the person back onto your site is find them in the screened emails and ip addresses lists in admin.

In the staff action logs, you can find some information to help you find out what happened:

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/d/5/d5b12cb49db2d090619d316db8f84ba78af65e6b.jpg" width="657" height="327">

The date might help you find the correct record in the screened emails list. If you find a match, note the IP address and then click the "Allow" button to stop blocking signups from that email address.

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/3/f/3f1c71e1634f0f67567edcc1c3ab66a3cb3a664e.jpg" width="690" height="211">

If you find a match for the IP address in the screened IP address list, then click the trash can icon to **delete the record**. Don't click Allow.

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/3/9/39ee5ea49fcaa62f2c9f712e029d937c0f531b24.jpg" width="690" height="290">

From that last screenshot, you can see that the user who was accidentally deleted and banned has tried to register on the site 51 times. Oops, sorry! :blush: 

Now they should be able to register for a new account again. The old user is gone so we can't recover it, but they can use the same email address and username as the deleted user.

When a user is nuked as a spammer, the posts are marked as deleted and have no author. So you'll need to find those posts and assign them to the new user.

By clicking on the Show link from the staff action logs table (the first screenshot), you'll see which topic had a post belonging to that user. That's a place to start. As an admin, you'll see where the post was like this:

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/0/6/06bca1e0cb7aa61ea6e413a7e0bec7018f4756a6.png" width="690" height="63">

Click it to reveal the post.

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/3/6/366b59a3507148766665e65591b0b3799b319c42.jpg" width="690" height="252">

Now you can assign the post to the new user by clicking the wrench icon on the right, selecting the post (or multiple posts if they had more than one in that topic), and changing the ownership to the new user. Once that's done, recover the posts so they are visible again.
