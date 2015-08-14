---
title: Changing Max Attachment Size
---

<small class="documentation-source">Source: [https://meta.discourse.org/t/changing-max-attachment-size/26435](https://meta.discourse.org/t/changing-max-attachment-size/26435)</small>

This is guide for newbies (Same as me) that clearly specify what you need to do, to allow more then 1mb for Attachment upload. 

1. Login to your SSH 
2. `cd /var/discourse/`
3. `nano containers/app.yml`
4. Scroll down (line 104) where it says **- exec: echo "Beginning of custom commands"**

Below add these yaml codes (These codes are vaildaded by http://www.yamllint.com/ )

     - replace:
            filename: etc/nginx/conf.d/discourse.conf
            from: /client_max_body_size.+$/
            to: "client_max_body_size 15m;"

Visually should look exactly like this; 

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/a/1/a19dc67087fc907c6fcd995aaa9120cd859cd2e4.png" width="611" height="500"> 

Note: These settings are for 15mb. ( If you wish to increase even more, 
to: "client_max_body_size **15**m;" change number 15m to example; **50**m )

After you done here press CTRL + O (To write that) and CTRL + X (To exit)

If you followed this tutorial from begining you should be now in /var/discourse  if not, get there.

Then simply run `./launcher rebuild app` 

Once that complete, please navigate to www.yoursite.com/admin/site_settings/category/files

and change the max attachment size kb to 15360 (15mb) or your desired number. At this point everything should work perfectly, you can go on and test your upload file size. Cheers
