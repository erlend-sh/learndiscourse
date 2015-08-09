---
title: How to migrate from Vanilla to Discourse!
weight: 360
---

<small class="doc-source">Source: https://meta.discourse.org/t/how-to-migrate-from-vanilla-to-discourse/27273</small>


I know there are a lot of posts about importing contents from a vanilla forum, but theres a lack of **comprehensive guide**!

Not everyone can afford to hire a developer to migrate their forums and this is my way of giving back to this community :smile: 

So here it goes:

**You Need:**

 1. Terminal (if mac) or alternative for windows
 2. A mind strong enough to understand and follow this guide!
 3. Patience
 4. A cup of coffee


### Step 1: Getting the Importer file!

Use this addon to get the porter file: [Vanilla Porter Addon][1]

This will give you a .gz file. Extract it. 
Now rename the newly extracted file to something short and easy and change the extension to .txt.

>For example: "export_blabla_fdata_20150312_052004.txt" becomes "export.txt"
>
**(For clarity in this guide, and less typing, rename it to export.txt.)**


### Step 2: Uploading the Importer file!

Now you need to upload this file to your server: (A lot of people ask me how to do this on Fiverr :o )
On Terminal (MAC) use this command:

    scp path/to/exporter.txt root@[IP Address of your droplet]:/var/discourse/shared/standalone

Here's an example:

    scp user/desktop/exporter.txt root@104.236.198.206:/var/discourse/shared/standalone
>Hit enter and then input the root password of your droplet!

Voila, your importer file is now on the server!

For Windows users, you can use [WinSCP](http://winscp.net/eng/download.php) or FileZilla if you already have it. Connect with port 22.

### Step 3: Make sure import file has correct permissions

First SSH into your server

    ssh root@[ip-address of your server/droplet]
It will then ask you the root password. Enter it!

Now that you are in the server. 
Navigate to the place where you uploaded the txt file.
To do so:
Run this command:
>cd /var/discourse/shared/standalone/uploads

Now lets assign 666 chmod to the exporter file we just uploaded:

> chmod 666 export.txt

Hit enter and you are done! On to the next step

### Step 4: Setting the mood for some migration ;)

Run these commands:

> cd /var/discourse/
./launcher enter app
su discourse
cd /var/www/discourse

If you are curious. These commands are just first switching you to the discourse folder, then entering the app, then changing the user to discourse etc.  Im sleepy so wont elaborate.

### Step 5: Running the importer script!

>RAILS_ENV=production ruby script/import_scripts/vanilla.rb /shared/export.txt

Had you been following this guide correctly and obtained a "correct" export file from the vanilla forum.
Everything should work out and Congrats!

**You just migrated your forum from Vanilla to Discourse!** Congrats!


Now if you have any questions, Or if you are stuck somewhere; Please feel free to post your issue below! I would try to help!
If you spot a mistake or wish to suggest an improvement to this course do let me know! (How to turn this into wiki post?)


[1]: http://vanillaforums.org/addon/porter-core
