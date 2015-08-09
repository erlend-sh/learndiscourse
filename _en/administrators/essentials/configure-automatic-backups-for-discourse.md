---
title: Configure automatic backups for Discourse
---

<small class="doc-source">Source: https://meta.discourse.org/t/configure-automatic-backups-for-discourse/14855</small>

So you'd like to automatically back up all your Discourse data every day? 

Go to the `/admin` settings, backup, and turn on the `backup daily` option.

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/c/cdebee5626392e3869cba8a3cddc977822f951ff.png" width="690" height="64"> 

Backups are always saved on the local server disk by default.

If you want to also automatically upload your backups to Amazon S3, check `enable s3 backups`. You'll need to create a unique private S3 bucket name in `s3 backup bucket` to store your backups.

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/3/318564bc2aae3345039b00b1c457b7561be21325.png" width="609" height="184"> 

Next, set your S3 credentials under the Files section: `s3 access key id`, `s3 secret access key`, and `s3 region`.

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/2/23bbd09157cae94b04601a00d5b2169a0f7175f8.png" width="690" height="204"> 

Backups are always stored on local server disk. Go to the **Backups** tab in the admin dashboard to browse your local server backups -- you can download them any time to do a manual offsite backup.

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/9/9adda5bcde9fb1cd913cbb1aaa53a9489519b3ba.png" width="690" height="406"> 

If you've enabled S3 backups, check your S3 bucket to find the uploaded backup files:

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/0/0ec8819200c1307216ec11591e4548c01cfebcb1.png" width="690" height="292"> 

Note that you can also enable an [automatic move to Glacier bucket lifecycle rule ](http://aws.typepad.com/aws/2012/11/archive-s3-to-glacier.html) to keep your S3 backup costs low.
