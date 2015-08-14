---
title: How to import a Phorum database (via Vanilla Porter)
weight: 340
---

<small class="documentation-source">Source: [https://meta.discourse.org/t/how-to-import-a-phorum-database-via-vanilla-porter/27538](https://meta.discourse.org/t/how-to-import-a-phorum-database-via-vanilla-porter/27538)</small>

**Here is the problem -**

We have a students forum that we have been running since 2009 on Phorum (LAMP based forum) - 
This solution was great then, but it started to date and lack functionality and support.
On top of that, backing up the database was a bit of a mission (+3Gb of sql data -- phorum is saving avatars and other images in the database).

Discourse provides a lot of forum formats to import from, but not Phorum.

**The solution-**

After a few hours scratching our heads and testing different methods we came up with this solution that actually worked really well:

 1. Export mysql Phorum data to a local file "export-phorum.sql" -- this is the longest part of the process
 2. Setup a local LAMP server (eg MAMP) and import the Phorum database
 2. Install "Simple Machines Forum" on the local server [> link][1]
 3. Install "Phorum to SMF 2" [> link][2]
 4. Install "Vanilla Porter" [> link][3]
 5. Use Vanilla Porter to generate the vanilla-export.txt file
 6. Tricky bit :: search/replace the generated file for category id "1000001" and replace it with "-1" (root category). More details here [> link][5]
 7. Import the modified vanilla file following those instructions [> link][4]
 8. Ta da! We have successfully imported +3000 users +20000 posts +100 categories

**Notes-**

 - The items 1 & 2 are superfluous if you can afford to do temp installs on the production server -- In our case it was a necessity as this server was running a really old version of PHP -- and it feels cleaner ;)
 - After importing all that data, the admin was complaining about a large queue of pending jobs that eventually went away -- gmail avatar collection?
 - We lost the user avatars in the process (we are now looking at scrubbing the Phorum database for avatar data and using the api to upload the missing avatars)
 - All the imported users are now active -- we will use the API to de-activate them.
 - Uploaded files were not moved across -- in our case we are 30 of those that we have re-attached by hand with the admin account.
 - We recommend to thoroughly clean the Phorum database up before going through the process (spammy users and posts, users with no posts, etc)

That's all folks. We thought that it could be interesting to share our process on that one, and even if it sounds heavy, it only took us half a day to get there, including (long) download times and struggling at step 6.

Of course comments and suggestions are welcome.

Have a good one!

  [1]: http://www.simplemachines.org/
  [2]: http://download.simplemachines.org/?converters;software=phorum
  [3]: http://vanillaforums.org/addon/porter-core
  [4]: https://meta.discourse.org/t/how-to-migrate-from-vanilla-to-discourse/27273
  [5]: https://meta.discourse.org/t/import-vanilla-problems/27399
