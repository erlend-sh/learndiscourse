---
title: Troubleshooting Docker Installation Issues
---

<small class="doc-source">Source: https://meta.discourse.org/t/troubleshooting-docker-installation-issues/17224</small>

In most cases, installing docker is fairly painless and easy. However, there are some things that can cause the installation to fail, and thus prevent you from running Discourse on Docker.

##Supported Configurations
------------------------------------------------------------------------

For docker to work, you will need a system or VPS with at least the following specifications.


 - 1GB of RAM.
 - *5GB of storage.*
 - Ubuntu 12.04 or later; Debian 6 or later; Fedora 19 or later*
 - 64 bit kernel.
 - Support for loading kernel modules.
 - Private networking
<sup>*[Or any listed on this page.][1] You will have to install docker manually, then continue installing normally.</sup>


The last two may not be as common. Docker needs to load additional kernel modules to function correctly, and needs the ability to bind to an internal IP address. This mainly impacts OpenVZ hosts; but be sure your host supports these features. Almost all cloud providers do.


##Troubleshooting
-------------------

```bash
Cannot connect to the Docker daemon. Is 'docker -d' running on this host?
```
This error occurs when the docker service is not running on the server. We can try to run the command the error specifies to see any details in interactive mode. Enter `docker -d` into the terminal. 

If you see:
```
[/var/lib/docker..] -job acceptconnections() = OK (0)
```

without a prompt for more commands Docker is now running correctly. You can hit <kbd>Ctrl</kbd>-<kbd>c</kbd> now, and can try rebooting your server to restart the Docker service. 

If you see any other kind of messages, there is an issue with your Docker installation. They should give more of a clue to what has gone wrong.

##Common Docker Errors
--------------------

```
WARNING: You are running linux kernel version V.V.V-generic, which might be unstable running docker. Please upgrade your kernel to V.V.V.
```
Your host may not support loading other kernels; or you may not have upgraded your kernel recently. Check the documentation for your distribution to upgrade kernel versions.

```bash
-job init_networkdriver() = ERR (1) Could not find a free IP address range for interface 'docker0'. Please configure its address manually and run 'docker -b docker0'
```
Your host may not allow assigning an internal IP address, or the server is restricted from assigning addresses. Check that your host supports docker and private networking.

  [1]: https://docs.docker.com/installation/
