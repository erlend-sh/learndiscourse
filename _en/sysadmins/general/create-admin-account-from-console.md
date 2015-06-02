---
title: Create Admin Account from Console
name: create-admin-account-from-console
---

So you want to create/grant Admin privileges or reset user password from console? Great, let's get started!

## Access Console

Connect to your Droplet via SSH, or use [Putty](http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html) on Windows:

    ssh root@192.168.1.1

Replace `192.168.1.1` with the IP address of your Droplet.

Switch to your Discourse folder:

    cd /var/discourse

Enter the container:

    ./launcher enter app
    # or
    ./launcher ssh app

You can perform these three tasks from console:

* Create New Account with Admin Privileges
* Reset Password for Existing Account
* Grant Admin Privileges to Existing Account

Jump to specific section to perform that task.

## Create New Account with Admin Privileges

Run this command from console:

    rake admin:create

You will be asked for *Email*, *Password* and *Confirm Password*.

After providing required information a new account will be created with random username.

Now you will be asked: `Do you want to grant Admin privileges to this account? (Y/n)`. Press <kbd>enter</kbd> to continue.

You will see success message: *Your account now has Admin privileges!*.

That's it, you have created a new account with Admin privileges.

## Reset Password for Existing Account

Run this command from console:

    rake admin:create

You will be asked for *Email*, enter the email of existing account.

Now you will be asked: `User with this email already exists! Do you want to reset the password for this email? (Y/n)`. Press <kbd>enter</kbd> to continue.

Provide the new `password` and `confirm password`.

You will see success message: *Account updated successfully!*.

That's it, you have successfully reset the password for existing account.

## Grant Admin Privileges to Existing Account

Run this command from console:

    rake admin:create

You will be asked for *Email*, enter the email of existing account.

Now you will be asked: `User with this email already exists! Do you want to reset the password for this email? (Y/n)`. Press <kbd>n</kbd> then <kbd>enter</kbd>.

Now you will be asked: `Do you want to grant Admin privileges to this account? (Y/n)`. Press <kbd>enter</kbd> to continue.

You will see success message *Your account now has Admin privileges!*.

That's it, you have successfully granted Admin privileges to existing account.