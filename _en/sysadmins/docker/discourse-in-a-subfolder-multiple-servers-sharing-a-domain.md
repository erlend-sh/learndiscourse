---
title: Discourse in a subfolder, multiple servers sharing a domain
---

Let's say you have a WordPress blog on `http://www.example.com`, and you want to serve your Discourse forums (which run on a different server) from `http://www.example.com/forum`. How do you do that?

---
**Note**: *This won't work for serving multiple Discourse instances from different folders on the same domain. You need to use different subdomains so that each site can have different cookies.*
---

You're going to need to send all traffic for the domain to one place that can route traffic to the correct server. In this how-to, I'll use [Fastly](https://www.fastly.com/). So, Discourse will be running on one server, and the other parts of your site (like WordPress) will run on one or more other servers.

## Docker container changes

[First, follow the instructions here to serve Discourse from a subfolder](/t/subfolder-support-with-docker/30507).

## Fastly

Now to setup Fastly to send traffic to the right place based on the path. I'll assume that Discourse is being served from `/forum`.

Create a new service pointing to your main website and follow the instructions for updating your DNS settings.

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/6/6/661f361b75f1acdb8f69efb76594d07a96ddba16.png" width="501" height="408"> 

Go to the service and click "Configure". Make sure you have selected Version 2 so that you can make changes. Version 1 is the currently active version and can't be changed.

In the "Hosts" section, add your Discourse server as a second backend.

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/b/3/b3ff903034346f63a02ad0b219ba38a87c4cd0fc.jpg" width="690" height="441"> 

In the Settings tab, add a new entry under Request Settings named "Discourse Pass" with action "Pass".

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/0/6/060dd5804fc8159e530ec1b5092beed65c68bff1.jpg" width="592" height="499"> 

Finally, for each host edit the conditions to specify where to route traffic.

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/d/2/d24700f8cc3a00097d056964b032867ad485e405.png" width="653" height="278"> 

For your main website, non-Discourse URLs should match.

```
req.url !~ "^/forum"
```

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/1/5/15c1096e4d9eb8a1731105a337d8e7f37740051b.jpg" width="690" height="366"> 

For the Discourse host, `/forum` URLs should match.

```
req.url ~ "^/forum"
```

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/d/e/de42fe4884434dbeae4d82e22a544ba7ac698cde.jpg" width="690" height="415">

<small class="documentation-source">Source: [https://meta.discourse.org/t/discourse-in-a-subfolder-multiple-servers-sharing-a-domain/30514](https://meta.discourse.org/t/discourse-in-a-subfolder-multiple-servers-sharing-a-domain/30514)</small>
