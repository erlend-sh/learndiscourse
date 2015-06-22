---
title: Change tracking branch for your Discourse instance
name: change-tracking-branch-for-your-discourse-instance
subsection: essentials
---

We do not recommend tracking *master* branch for your Discourse instance, because *master* branch is usually bleeding edge or unstable. In this guide we'll describe how to change tracking branch for your Discourse instance to *tests-passed*. Let's get started!

Open configuration file `app.yml`. From console, run these commands:

```
cd /var/discourse
git pull
nano containers/app.yml
```

Configuration file will open in *nano* editor. Search for *version* (with <kbd>Ctrl</kbd>+<kbd>W</kbd>) in the file:

```
params:
  ## Which Git revision should this container use?
  version: HEAD
```

Replace  **HEAD** with **tests-passed**:

```
params:
  ## Which Git revision should this container use?
  version: tests-passed
```

After completing your edits, press <kbd>Ctrl</kbd>+<kbd>O</kbd> then <kbd>Enter</kbd> to save and <kbd>Ctrl</kbd>+<kbd>X</kbd> to exit.

Rebuild the container:

```
git pull
./launcher rebuild app
```

That's it! Your Discourse instance is tracking *tests-passed* branch now!
