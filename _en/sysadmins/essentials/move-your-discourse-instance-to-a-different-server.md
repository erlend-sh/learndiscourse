---
title: Move your Discourse Instance to a Different Server
---

So you want to move your existing Discourse instance to a new server? 

In this guide we'll move an existing Discourse instance on [Linode][linode] to a new Discourse instance on [Digital Ocean][do], although these steps will work on other cloud providers that also support Docker. Let's start!

## Log In as Admin on Existing Server

Only admins can perform backups, so sign in as an account with admin access on your existing Discourse instance on Linode.

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/a/a43620ca045bbd98613fecb6bf38366cb0d76b2f.png" width="690" height="367"> 

## Update Existing Install

Both the new and old Discourses **MUST BE ON THE EXACT SAME VERSION** to ensure proper backup/export. So the first thing we'll do is update our existing Discourse instance on Linode to the absolute latest version.

Visit `/admin/upgrade` to upgrade.

(If you are running the [deprecated Ubuntu install][dep_ubuntu] you may need to follow [these update instructions][ubuntu_update].)

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/2/2c1bb3582be9f689032f105f61ac09d15c370327.png" width="690" height="440"> 

After successfully upgrading, you should see *You're up to date!*

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/0/0fa50f7c5670369458b4dec9833735910181d2d2.png" width="487" height="127"> 

## Download Your Backup

Visit `/admin/backups` and click **Backup** button.

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/3/3f887f43c9b59debfe0ad644341792c5ed614b69.png" width="690" height="199"> 

You will be prompted for confirmation, press **Yes**.

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/6/6edefc6a061cf5e00f523c8d747528798665a59c.png" width="690" height="180"> 

Once confirmed, you will be able to see the log of backup processing. Once the processing is finished, switch back to **Backups** tab.

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/c/cde298c4eaeb7d557b0c1fb9e298f132f394f754.png" width="690" height="441"> 

Now you will see the newly created backup file. Click **Download** button and save the file, we will need it later for restoration on the new server.

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/1/16039efe9b51ce3e96b841f7dab2ed724c3d68a4.png" width="690" height="229"> 

## Log In as Admin on New Server

Sign up and login on your new Discourse instance at Digital Ocean.

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/0/0ca7c5d1686559e4b3660fc5c12fe7fdf8687aed.png" width="689" height="288"> 

## Enable Restore

Under site settings search for `restore`:

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/0/064182763d10858bb1fe6fda6612b1e5aa16c008.png" width="690" height="243"> 

Enable the `allow_restore` setting, and refresh the page for changes to take effect.

## Restore Backup

Browse to `/admin/backups` and click **Upload** button, select the backup file you downloaded previously from your existing Discourse instance (file name ends with `.tar.gz`):

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/d/d0b6d79209a3e9ab5f9f96e2cdbdb4c5820d8022.png" width="690" height="224"> 

Once the file gets uploaded it will be listed as shown below, click **Restore** button:

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/6/61c1b22c29c8ea5773b0f1036a13082392b1a4dd.png" width="689" height="225"> 

Press **Yes** when prompted for confirmation:

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/5/56930590c5d4a7d255762ce65cf51dc1e6b6e492.png" width="690" height="166"> 

You will see restore process log, it may take some time but it's automagically importing all your existing Discourse instance (Linode server) data.

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/3/3e7061751c4afbd4dd10a910e046f7d96c49736d.png" width="690" height="447"> 

Once the Restore process finishes, you will be logged out.

## Log In and You're Done

Once the restore process finishes, all the data from your previous Discourse instance on Linode server will be imported in your new Discourse instance on Digital Ocean, sign in with your Admin account and you are good to go!

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/3/341ad469fde367b6da3aed7604bc841d0a2efe45.png" width="690" height="375"> 

If anything needs to be improved in this guide, feel free to ask on [meta.discourse.org][meta].


  [do]:               https://www.digitalocean.com/?refcode=5fa48ac82415
  [dep_ubuntu]:       https://github.com/discourse/discourse/blob/master/docs/INSTALL-ubuntu.md
  [ubuntu_update]:    https://github.com/discourse/discourse/blob/master/docs/INSTALL-ubuntu.md#updating-discourse
  [official_install]: http://learndiscourse.org/install
  [do_install]:       https://github.com/discourse/discourse/blob/master/docs/INSTALL-digital-ocean.md
  [linode]:           https://www.linode.com/
  [namecheap]:        https://www.namecheap.com/
  [meta]:             http://learndiscourse.org/move-your-discourse-instance-to-a-different-server

<small class="documentation-source">Source: [https://meta.discourse.org/t/move-your-discourse-instance-to-a-different-server/15721](https://meta.discourse.org/t/move-your-discourse-instance-to-a-different-server/15721)</small>
