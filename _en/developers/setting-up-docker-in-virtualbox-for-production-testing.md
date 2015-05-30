---
title: Setting up Docker in Virtualbox for 'production' testing
translations:
tags:
  - Hack
---

Continuing the discussion from [What is "Meta"?](https://meta.discourse.org/t/what-is-meta/5249/4):

[quote="codinghorror, post:4, topic:5249"]
Also @riking if you want to exercise our install and see if that's true, please do:

https://twitter.com/codinghorror/status/425548537602920448
[/quote]

I think I will, except I'll use VirtualBox instead of a cloud server. Just to be different than what you suggested :P.

Log:

 - Got ubuntu-13-10-server-amd64.iso
 - Running install right now [15:44 PST]
 - Refusing that silly Ubuntu Landscape™ proposal
 - <strike>On the "Software Selection" screen, I mark only PostgreSQL database.</strike> This is not necessary.
 - [15:50 PST] Install is done, I have a user shell.
 
### Installing Docker
 - The first thing it asks me to do, install linux-image-extra, does nothing but set the image to manually installed. This means I'll have to manually *remove* it if by any chance I do several kernel upgrades in the future and want to clean out old crap.
 - `gpg: "36A1D786925C890F966E92D857A8BA88D21E9 is not a key ID: skipping` well that's wonderful, I mean, I went to all the trouble of typing it in.
 - Aha, if I add the repository to my sources and update, `apt-get` gives me the correct key ID: `because the public key is not available: NO_PUBKEY D8576A8BA88D21E9` (which happens to be the ending part of that long hex string). Running the key fetch-and-add with that shorter hex string (**D8576A8BA88D21E9**) works right away.
 - Done installing Docker, it's [16:01 PST].

### Getting the Discourse docker image
 - As root,  `mkdir /var/docker`, `adduser kane docker`, and `install -g docker -m 2775 -d /var/docker`.
 - Start following the Getting Started section
 - Git clone fails - git isn't installed! Heh.
 - Hmm, it's getting permission denied - I'll just switch into root instead of relying on groups.
 - I guess I'll just put fake info in for the hostname stuff. I do own riking.org, but cba to set it up right now
 - The **ssh_key** is important. It's in the format of the `~/.ssh/id_rsa.pub` file. Surround it in quotes. Example
>ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDSnKNsGL1muizhZ/QN/2xNkIvoeG3AkeWz/0SV/AaVKxnsMvbTHIJXe2vle6lSU/6YRRr/BCsCIrZb4qk0/vlx/p5pJmqhT7Wp8XIYnmBGO5B38PT2aycKoHIWT3Os9ExmyrFfClOrjfcUxzE1pF43myqDD0B7SpmzBWcMLDpl5D2pza4EmsOgF6eB0OGDmM9gBA9wswHa9At2337heZAN/bVRZ49YpAG02gTuQuVdb00ioQpv6rAZUsANiQh0XycqHvE0RBvGlwjfLHGe9GYYPrKLeFPLeKreERbfWnM5PAmexLG0I09WvyY3ChN0X9y6KH5Q1b+vWAMwIV9dyuRZ root@ubuntu

 - [16:12 PST] Starting `./launcher bootstrap app`
 - [16:22 PST] Bootstrap done, (**note that it took 10 minutes**) `./launcher start app` succeeds, a little port forwarding setting in VirtualBox, and:
<img src="/uploads/default/2970/4c9908522930bf17.png" width="690" height="231"> 
# Success! :smile: 