---
title: How to deploy Discourse in 8 minutes with Juju
---

<small class="doc-source">Source: https://meta.discourse.org/t/how-to-deploy-discourse-in-8-minutes-with-juju/20658</small>

I wrote a blog post about how to use [Juju](juju.ubuntu.com) to deploy Discourse:

http://npf.io/2014/10/deploy-discourse-juju/

The nice thing is that the Juju charm install exactly follows the steps in the [Digital Ocean install guide][1], so you're not setting up some frankenstein environment that the Discourse folks won't know what to do with.  But at the same time, it takes a lot of the trial and error out of the process (figuring out how to script the install and exactly what needed to be installed when took me the better part of a week, albeit only 1-2 hours a day).  Also, since it removes a lot of the manual steps of the install guide, it only takes about 8 minutes, and most of that is just waiting for discourse to come up.

Give it a try and feel free to leave comments here or on the blog post if you have any problems.


  [1]: https://github.com/discourse/discourse/blob/master/docs/INSTALL-digital-ocean.md
