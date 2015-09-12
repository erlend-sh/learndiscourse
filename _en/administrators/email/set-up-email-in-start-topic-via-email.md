---
title: 'Set up "Email In" (start topic via email)'
---

<small class="documentation-source">Source: [https://meta.discourse.org/t/set-up-email-in-start-topic-via-email/27686](https://meta.discourse.org/t/set-up-email-in-start-topic-via-email/27686)</small>


##Introduction
Discourse is intended to be a web-based forum. Its integration with email is good, but not meant to replace its web interface. Nevertheless, when migrating to Discourse a community which is accustomed to another, more email-based, form of communication such as a Listserver, Google Group or similar, as an admin you may be asked to arrange things so users can start a Topic from email. I have recently had to set this up, and while the information IS available in Discourse Meta already (see [this thread][1]), it's wasn't in a clear step by step format, and I initially had some problems with getting Start Topic Via Email to work with multiple different Categories.

NB: If you just need users to be able to Reply to a Topic from email, this isn't the Topic you need. Go to [this topic][2] first.

**It's important that you have set up Reply From Email functionality first, since this Howto will assume that you have all the Reply From Email functionality set up and working.** Go to [this topic][2] first and ensure that replies from email is set up and working.

##HOWTO

1. I'll say it again; Please ensure Reply Via Email is working in your Discourse forum FIRST. Here is the HOWTO for that: http://learndiscourse.org/set-up-reply-via-email-support

1. For the example I will set up Start Topic Via Email for a Discourse forum which monitors the POP3 account discoursereply@example.com for its Reply From Email function. The same POP3 account is used for Start Topic From Email.

1. Decide which Categories you want to set up Start Topic From Email for. If there is only one Category then go ahead and jump to step `X`. If there is more than one Category, you will need to create an email forwarder for each of these Categories. For example, our fictional forum has these categories:
  * Staff
  * Watercooler
  * CIOs

1. So we need email addresses called something like:
  * staffnewtopic@example.com
  * watercoolernewtopic@example.com
  * ciosnewtopic@example.com

1. All of these email addresses should redirect to the email address monitored by Discourse: discoursereply@example.com. Usually you can set up forwarders like this for free on your Domain Registrar's control panel. If you can't, change your registrar :wink: 

1. Now we configure each category. For each category, edit the Category settings. When you're looking at the category, the Edit button is at the top right: <img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/4/5/45d246d26df6c95ec206615006c5486b13ef6dc6.png" width="200" height="30"> 

1. In the Category Settings, go to the Settings tab, and enter the relevant email address in the box. This will be one of the 'forwarder' email addresses. I would also recommend ensuring that the box 'Accept emails from anonymous users with no accounts' is **unchecked** otherwise *anyone* with the email address, including spambots, can post. Do this for each of the Categories that will be accepting incoming New Topics From Email, using the relevant forwarder email address for each Category.

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/3X/9/3/93d72d84dd490763782ee44c784140d96daaf971.png" width="585" height="500"> 
        
The way this works is that Discourse only has to poll **one** email account (discoursereply@example.com), which is I guess much more efficient, but it can still assign new Topics to the right Category because of the multiple forwarder addresses (in this example staffnewtopic@example.com) persist in the forwarded email data, enabling Discourse to match the new Topic to the right Category correctly.

This is the bit that wasn't clear to me when I was setting up this arrangement, hence why I thought a more formal HOWTO would be of benefit, hopefully, to someone.


pacharanero (marcus baw) 

  [1]: https://meta.discourse.org/t/start-a-new-topic-via-email/12477
  [2]: http://learndiscourse.org/set-up-reply-via-email-support
