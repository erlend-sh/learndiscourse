---
title: Migrating an old Discourse install to Docker
---

<small class="doc-source">Source: https://meta.discourse.org/t/migrating-an-old-discourse-install-to-docker/12439</small>

Deploying [Discourse on Docker][1] is currently our recommended setup. It avoids many pitfalls installations have, such as misconfigured nginx, sub-optimal Ruby defaults and so on. 

The Docker based setup ensures we are all on the same page when diagnosing installation issues and completely eradicates a class of support calls. 

Today, all sites hosted by Discourse are on Docker. 

This is a basic guide on how to move your current Discourse setup to a Docker based setup.

## Getting started

First, get a blank site with working email installed. Follow the guide at https://github.com/discourse/discourse_docker and install a new, empty Discourse instance.

**Tips:** 

- Bind the web to a different port than port 80, if you are on the same box. Eg:

        expose:
          - "81:80"

- Be sure to enter your email in the developer email section, so you get admin:

        env:
          # your email here
          DISCOURSE_DEVELOPER_EMAILS: 'my_email@email.com'


- Make sure email is setup and working by visiting `/admin/email` and sending a test email.

- Make sure you have can enter your container `./launcher enter my_container` must work. 

**If any of the above is skipped your migration will fail.**

At the end of this process you will have a working website. Carry on.


## Exporting and importing the old site

- Ensure you are running the absolute latest version of Discourse. We had bugs in the export code in the past, make sure you are on latest before attempting an export.

- On your current instance
  - go to `/admin/backups` and click on the <img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/f/f5dd33b5ebbbe0cc554a4486487ff0c1108cd687.png" width="91" height="30"> button.
  - once the backup is done, you will be able to <img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/8/82911e76f5785a0437566e41a396288f8370b166.png" width="107" height="29"> it.

- On your newly installed docker instance
  - enable the `allow_restore` site setting
  - refresh your browser for the change to be taken into account
  - go to `/admin/backups` and <img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/4/4df78a685ecacb079216ac00ea94dc4e96d125af.png" width="110" height="30"> your backup.
  - once your upload is done, click on the <img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/8/8afc490e0d2c764e58085058928bab112d003684.png" width="93" height="30"> button


- Change port binding so its on 80

- Rebuild container `./launcher rebuild app`

Yay. You are done. 

  [1]: https://github.com/discourse/discourse_docker
