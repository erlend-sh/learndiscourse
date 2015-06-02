---
title: Sending Bulk User Invites
name: sending-bulk-user-invites
---

So you want to invite users to your Discourse instance, but you have so many that sending invites individually would be a huge pain? Good news -- you can send **bulk invites!** Here's how:

## Prepare CSV File

Prepare a CSV file with the users you want to invite. These points should be considered while preparing CSV file:

* One user per line.
* Email is required in the first column, and the email *must* be valid. 
* Any permissions groups you want this user to be a member of should be in second column. For multiple groups, separate group names with a semicolon `group_1;group_2;group_3`
* Normally invited users arrive at the homepage. If you would rather invited users end up on a specific topic, enter that Topic ID in the third column.

The format is:

`name@example.com,group_1;group_2,topic_id`

Note that group names and topic id are completely optional, only email is mandatory. You can have an invite that is just the email alone:

`name@example.com`

It's easy to create CSV files in a spreadsheet, which would look like this:

<img src="/uploads/default/32309/72b2b91247a35cad.png" width="403" height="165"> 

Just be sure to save the file as CSV when you're done.

## Upload CSV File

Go to Invites page and upload the CSV file by clicking **Bulk Invite from File** button.

<img src="/uploads/default/32329/ee7b1a4d6a6b9eb4.png" width="690" height="259"> 

You should see a confirmation message once the file is uploaded.

<img src="/uploads/default/31871/b6242c72a74f17c6.png" width="642" height="149"> 

## Check Bulk Invite Progress Notification

Once the CSV file is processed, you will receive a private message notification with progress report.

<img src="/uploads/default/31868/f0019de11dbda2df.png" width="690" height="445">

The notification will summarize what happened with your bulk invites, including total counts of invites sent and not sent. Check your invites page on your user profile to see a list of the invites that were successfuly sent.

<img src="/uploads/default/32328/b6620439565396b1.png" width="690" height="272"> 

If there were errors reported, you can submit a new bulk invite file with the corrected lines.


## Invites Sent

Each email address will receive an invite email:

> username invited you to join
>
> > **Community Title**
> > 
> > A brief description of this community taken from the `site description` setting.
> 
> If you're interested, click the link below:
> 
> http://discourse.example.com/invites/d377050add482483d24723f14eac4c45
 
Once clicking the confirmation link:

- their account will be immediately activated and associated with this email address
- they will be added to the specified groups (if specified)
- they will be directed to the topic ID (if specified)

If the invites are never clicked, they will expire naturally after 4 days.

Congratulations! That's it, you've successfully sent out bulk invites.