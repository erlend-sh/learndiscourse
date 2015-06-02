---
title: Deploying Discourse to Amazon (and other clouds)
name: deploying-discourse-to-amazon-and-other-clouds
---

# What?

This is a work in progress still, but I've been working on making Discourse dead simple to deploy to the cloud (AWS, OpenStack, etc) with [Juju][1]. You can find the progress so far on [Juju Charms site][2] and mirrored on [Github](https://github.com/marcoceppi/discourse-charm); <s>there is still a bit of work left to get this working 100% but figured I put this out there if people were interested.</s> This now works to get discourse running, future updates are simply to streamline the deployment and management of discourse.

The goal is to have something like this when all said and done:

    juju deploy discourse
    juju deploy postgresql
    juju add-relation discourse postgresql:db-admin
    juju expose discourse

If you're interested in helping to test this, check out [getting started][3] with Juju, pull requests are always welcome!

# Current usage

If you want to try this out as it is, first check what is still left to be done so you can set appropriate expectations.

## Install Juju

If you don't have access to juju (IE: You don't have Ubuntu anywhere to use) you can use one of these [vagrant boxes](http://cloud-images.ubuntu.com/vagrant/precise/current/) that include the latest Juju application.

Once you have Juju installed you'll need to type `juju boostrap` then edit `~/.juju/environments.yaml` (You can use vim, nano, or any other command-line editor). Then either follow the instructions for [Amazon AWS](https://juju.ubuntu.com/get-started/amazon/), [HP Cloud](https://juju.ubuntu.com/get-started/hp-cloud/), or [OpenStack](https://juju.ubuntu.com/get-started/openstack/). If you don't have an account with any of these cloud providers you can use the local provider. However, the local provider will not work in the vagrant box.

## Deploying

Use the following commands to deploy discourse and postgresql to your cloud:

    juju deploy cs:~marcoceppi/discourse
    juju deploy postgresql

The discourse charm isn't yet in the charm store since it's not done, so you can deploy from my personal branch for now. Once those are deployed you'll need to relate postgresql to discourse

    juju add-relation discourse postgresql:db-admin

Finally, expose discourse

    juju expose discourse

At any time you can check the status of your environment by typing `juju status` if each node is marked as `started` and there are no errors, you can proceed.

## I need admins

You can change the admins at anytime by running the following command:

    juju set discourse admins="marcoceppi"

This will set the account `marcoceppi` as an admin. If you want more than one admin do the following:

    juju set discourse admins="marcoceppi,codinghorror,eviltrout"

You can have as many admins as you'd like just provide them in a comma separated string. If you want to remove an admin, simply remove them from the list:

    juju set discourse admins="codinghorror,eviltrout"

## TODO

* <strike>Create an upstart/init.d script</strike>
* Make sure discourse can scale
* <strike>Test redis-master charm connection</strike>
* configuration option for web servers (apache/nginx)
* <strike>configuration option for repository</strike>
* Version pinning and proper upgrade paths

  [1]: http://juju.ubuntu.com
  [2]: http://jujucharms.com/~marcoceppi/precise/discourse
  [3]: https://juju.ubuntu.com/get-started/