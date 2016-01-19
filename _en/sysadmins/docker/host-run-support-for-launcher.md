---
title: Host run support for launcher
---

(advanced topic)

During our provisioning we have a need to run certain commands on the **host**. 

Usually bootstrap runs all the commands inside the containers, however for our internal provisioning we often need to ensure the host has a certain structure. 

To assist this I added host_run support to our container config file. Commands in `host_run` will be executed:

1. Prior to `bootstrap`
2. Prior to `start`

So for example 

```
params:
   name: "Sam"
host_run:
   - "echo $name"
   - ls
   - boom
```

Will output 


    Host run: echo Sam
    Sam
    
    Host run: ls
    bin  cids  containers  image  launcher	README.md  samples  scripts  shared  templates
    
    Host run: boom
    ./launcher: line 179: boom: command not found

Note, if any command fails, execution of launcher will halt.

<small class="documentation-source">Source: [https://meta.discourse.org/t/host-run-support-for-launcher/19771](https://meta.discourse.org/t/host-run-support-for-launcher/19771)</small>
