---
title: Configure automatic backups for Discourse
name: configure-automatic-backups-for-discourse
---

So you'd like to automatically back up all your Discourse data every day? 

Go to the `/admin` settings, backup, and turn on the `backup daily` option.

<img src="/uploads/default/4451/efe294bfd5f02d13.png" width="690" height="64"> 

Backups are always saved on the local server disk by default.

If you want to also automatically upload your backups to Amazon S3, check `enable s3 backups`. You'll need to create a unique private S3 bucket name in `s3 backup bucket` to store your backups.

<img src="/uploads/default/4453/7e42f1b381949e12.png" width="609" height="184"> 

Next, set your S3 credentials under the Files section: `s3 access key id`, `s3 secret access key`, and `s3 region`.

<img src="/uploads/default/4457/e863e6297809dc84.png" width="690" height="204"> 

Backups are always stored on local server disk. Go to the **Backups** tab in the admin dashboard to browse your local server backups -- you can download them any time to do a manual offsite backup.

<img src="/uploads/default/4456/e28983251a1979ab.png" width="690" height="406"> 

If you've enabled S3 backups, check your S3 bucket to find the uploaded backup files:

<img src="/uploads/default/4455/7a0dbed10793b42b.png" width="690" height="292"> 

Note that you can also enable an [automatic move to Glacier bucket lifecycle rule ](http://aws.typepad.com/aws/2012/11/archive-s3-to-glacier.html) to keep your S3 backup costs low.