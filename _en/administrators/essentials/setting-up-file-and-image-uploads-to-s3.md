---
title: Setting up file and image uploads to S3
---

<small class="documentation-source">Source: [https://meta.discourse.org/t/setting-up-file-and-image-uploads-to-s3/7229](https://meta.discourse.org/t/setting-up-file-and-image-uploads-to-s3/7229)</small>

So, you want to use S3 to handle image uploads? Here's the *definitive* guide:

## S3 registration

Head over to http://aws.amazon.com/s3/ and click on <img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/a/a0c2f6b515d2a23c2133cad85fdb3f5aa6506ae2.png" width="216" height="37">.

During the create account process, make sure you provide payment information, otherwise you won't be able to use S3. There's no registration fee, you will only be charged for [what you use](http://aws.amazon.com/s3/#pricing), if you exceed the [free usage tier](http://aws.amazon.com/free/).

## User creation

### Creating a user account

Sign in to [AWS Management Console](https://console.aws.amazon.com/) and click on <img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/c/c25b3287095d7eaa85491ebcaa7e4a3929993a3f.png" width="176" height="40"> to access the [AWS Identity and Access Management (IAM)](https://console.aws.amazon.com/iam/home#users) console which enables you to manage access to your AWS resources.

We need to create a user account, so click on the `Users` link on the left handside and then the <img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/6/6d137a9431ec338ce71cae8beb10298f320b6d6f.png" width="159" height="38"> button. Type in a descriptive user name and make sure the "Generate an access key for each User" checkbox is checked.

Here's the critical step: make sure you either download the credentials or you copy and paste somewhere safe both `Access Key ID` and `Secret Access Key` values. We will need them later.

### Setting permissions

Once the user is created, we need to set him permission. Select the user you've just created in the upper panel, click on the `Permissions` tab in the lower panel and then click the <img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/8/82477b8186ac3439b54196ec401c9a0365006a3c.png" width="115" height="26"> button.

In the "Manage User Permissions" popup, select the <img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/7/74082da7e2cf321e1b8fa695a40c230800c716cf.png" width="146" height="26"> radio button and click the select button to manually enter the permission.

Type in a descriptive name for the policy and use the following piece of code as a template for your policy document:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": [
        "arn:aws:s3:::name-of-your-bucket",
        "arn:aws:s3:::name-of-your-bucket/*"
      ]
    }
  ]
}
```

First, some warnings about your bucket name:

- it should be [all lowercase](http://docs.aws.amazon.com/AmazonS3/latest/dev/BucketRestrictions.html)
- it should *not* contain periods as this will cause [huge https problems for you](http://shlomoswidler.com/2009/08/amazon-s3-gotcha-using-virtual-host.html)

Make sure you change **both** references to "`name-of-your-bucket`" with the name of the bucket you will use for your Discourse instance before applying the policy.

## Discourse configuration

Now that you've properly set up S3, the final step is to configure your Discourse forum. Make sure you're logged in with an administrator account and go the **Settings** section in the admin panel.

Type in "S3" in the textbox on the right to display only the relevant settings:

<img src="//discourse-meta.s3-us-west-1.amazonaws.com/original/2X/9/91b3d48c3427f3c87f41144e6093bc36eba45287.png" width="690" height="432"> 

You will need to:

- Check the "`enable_s3_uploads`" checkbox to activate the feature
- Paste in both "`Access Key Id`" and "`Secret Access Key`" in their respective text fields
- Enter the name of the bucket you've authorized in the "`s3_upload_bucket`"

The "`region`" setting is optional and defaults to "`us-east-1`". You should enter the location (eg. eu-west-1, sa-east-1, etc...) that is nearest to your users for better performances.

## Enjoy

That's it. From now on, all your images will be uploaded to and served from S3.

Note how you did **not** have to create your S3 bucket? That's because Discourse will *automagically* create it for you if it doesn't already exists. :wink:
