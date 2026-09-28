---
title: 'Accessing the RE - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/access/
scraped_at: 2026-05-04T06:34:20Z
---

# Accessing the RE

To access the RE you will need to install an AWS client, set up two-factor authentication with Okta and login using the credentials sent by Genomics England.

This guide takes you through getting access to the RE for the first time, including:

- Access AWS
- Adding the RE WorkSpace to AWS
- Logging in
- Setting up two-factor authentication
- Logging out

If you have any issues with access, please take a look at our [FAQs](../access_faqs/).

## Access AWS

Amazon WorkSpaces are virtual machines you can access on the web. To use them, you can either install a client, a free software application which can be downloaded online, or access the workspace via a web-browser.

[Go to AWS](https://clients.amazonworkspaces.com/)

To use an AWS client, choose the appropriate version for your operating system, click download and follow the prompts to install. If you prefer to work in a web browser, just select Web Access.

## Add the RE WorkSpace to AWS

To add the workspace, you will need an access code in the form `wslhr+######`. This will have been sent to you by email when you registered.

You will need to either launch your AWS client.

Or start from the web browser.

Using a downloaded AWS clientUsing a web browser

If you are using Amazon WorkSpaces for the first timeIf you already use Amazon Workspaces for other things

If this is the first time you have used AWS and you don't have any other workspaces set up, you will see a dialogue box where you can input the access code you have been sent:

Then click *Register*.

If you already have your AWS client installed with other workspaces you access, you will need to add the RE as a new workspace.

1. When you launch your AWS client, you will reach the login screen for your other workspace. Click on *Change Registration Code*.

1. Here you will see a drop-down where you can select from existing workspaces. This is also a text box where you can overwrite the code with the access code you have been sent.

   Then click *Register*.
2. Use *Change Registration Code* when you open AWS to select the correct workspace.

### Give your workspaces nicknames

If you have multiple workspaces, you may find it easier to give your workspaces nicknames.

1. Go into *Settings* then *Manage Login Information*.
2. Here you can add nicknames, making it easier to choose your workspace when you login in future.

If you are using Amazon WorkSpaces for the first timeIf you already use Amazon Workspaces for other things

If this is the first time you have used AWS and you don't have any other workspaces set up, you will see a dialogue box where you can input the access code you have been sent:

Then click *Register*.

If you already have your AWS client installed with other workspaces you access, you will need to add the RE as a new workspace.

1. When you launch your AWS client, you will reach the login screen for your other workspace. Click on *Change Registration Code*.
2. Here you will see a drop-down where you can select from existing workspaces. This is also a text box where you can overwrite the code with the access code you have been sent.

   Then click *Register*.
3. Use *Change Registration Code* when you open AWS to select the correct workspace.

### Give your workspaces nicknames

If you have multiple workspaces, you may find it easier to give your workspaces nicknames.

1. Go into *Settings*
2. Here you can add nicknames, making it easier to choose your workspace when you login in future.

## Set up two-factor authentication

Login to the RE requires two-factor authentication (2FA) with the **Okta Verify** app. You can do this on your smartphone **or** on your computer.

On your smartphone using Okta VerifyOn your computer using Authy

1. Install the **Okta Verify** app on your smartphone. You can find this in the App Store or Google Play.
2. Go to <https://ngisengland.okta.com>
3. Login to activate your Okta account using the following details:
   Your OKTA username is your email address
   Your OKTA password is your Genomics England password (same as your Research Portal)
4. Click your name in the top right and go to settings.
   After authentication in Okta, scroll down to Extra Verification
5. Select 'Set Up for Okta Verifyâ.
6. Open your app and scan the QR code on your computer screen.
7. You will now see a six-digit code in your Okta app listed under `ngisengland.okta.com`, with your username. This code refreshes every 30 seconds. You will use this code every time you login.
8. Use this code to verify the setup. Your account will not activate until you have done this.

1. Download the [Authy app](https://authy.com/) and install it on your desktop.
2. Go to <https://ngisengland.okta.com>
3. Login to activate your Okta account using the following details:
   Your OKTA username is your email address
   Your OKTA password is your Genomics England password (same as your Research Portal)
4. Click your name in the top right and go to settings.
   After authentication in Okta, scroll down to Extra Verification
5. Select 'Set Up for Okta Verifyâ.
6. Choose `Can't scan?` at the QR code, then navigate through to get to an Okta Verify unique secret key code.
7. In your Authy app, you should see an option or plus sign to `Add an account`, then add the secret key code.
8. The next page will provide you with a list of different app accounts, please scroll through and select the Okta option (the token code length can be kept to six-digits) and click Save.
9. You will now see a six-digit code in your Authy app listed under `ngisengland.okta.com`, with your username. This code refreshes every 30 seconds. You will use this code every time you login.

## Login to the RE

Using a downloaded AWS clientUsing a web browser

After this you can login. Use your Genomics England username (not your email address) in the form *initial+lastname*, eg *jdoe*, then click Next.

Now input your password and click Next.

You will now be prompted to add your verification code. Input the six-digit code that refreshes every 30 seconds in your two-factor authentication app.

The workspace will now launch, it can a couple of minutes to load.

After this you can login. Use your Genomics England username (not your email address) in the form *initial+lastname*, eg *jdoe*, then click Next.

Now input your password and click Next.

You will now be prompted to add your verification code. Input the six-digit code that refreshes every 30 seconds in your two-factor authentication app.

The workspace will now launch, it can a couple of minutes to load.

## Logging out

To log out of the RE, click on the power icon  at the top right of the screen:

If you select *Log Out*, you will be able to log back in straight away. However if you select *Power Off*, there will be a delay of several minutes before you can log back in.

## Video tutorial

January 19, 2026
