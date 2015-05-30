---
title: Create a swapfile for your Linux server
translations:
tags:
  - System Administration
---

Most cloud virtual machine providers do not set up swapfiles as part of their server provisioning.

If you are running the recommended 2 GB of memory for Discourse, a swap file is technically not required, but can be helpful just in case your server experiences memory pressure. With a swap file, rather than randomly terminating processes with an out of memory error, things will slow down instead.

This can be done at any time from the command line on your server.

### Set up a 1 GB swap file

Adding a swap file gives Discourse some extra breathing room during memory-intensive operations. 1GB swap should suffice, though if you are attempting the minimum memory configuration you should set up a 2GB swap.

In the shell you have opened to your droplet, do the following:

1. Create an empty swapfile

        sudo install -o root -g root -m 0600 /dev/null /swapfile

1. write out a 1 GB file named 'swapfile'

        dd if=/dev/zero of=/swapfile bs=1k count=1024k

    if you want it to be 2 GB

        dd if=/dev/zero of=/swapfile bs=1k count=2048k

1. tell linux this is the swap file:

        mkswap /swapfile

1. Activate it

        swapon /swapfile

1. Add it to the file system table so its there after reboot:

        echo "/swapfile       swap    swap    auto      0       0" | sudo tee -a /etc/fstab

1. Set the swappiness to 10 so its only uses as an emergency buffer

        sudo sysctl -w vm.swappiness=10
        echo vm.swappiness = 10 | sudo tee -a /etc/sysctl.conf

The whole thing as a single copy and pastable script that creates a 2GB swapfile:

    sudo install -o root -g root -m 0600 /dev/null /swapfile
    dd if=/dev/zero of=/swapfile bs=1k count=2048k
    mkswap /swapfile
    swapon /swapfile
    echo "/swapfile       swap    swap    auto      0       0" | sudo tee -a /etc/fstab
    sudo sysctl -w vm.swappiness=10
    echo vm.swappiness = 10 | sudo tee -a /etc/sysctl.conf


  [1]: https://github.com/discourse/discourse/blob/master/docs/INSTALL-digital-ocean.md#access-your-droplet