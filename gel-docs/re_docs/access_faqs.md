---
title: 'Accessing the RE FAQs - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/access_faqs/
scraped_at: 2026-05-04T06:30:56Z
summary: "FAQs for login issues, MFA setup, firewall ports, and account access in the GEL Research Environment."
---

# Accessing the RE FAQs

No apps in desktop.

When I log in to the RE, there are no applications on my desktop.

We are working on a permanent fix, but we recommend closing your workspace and re-booting it in the meantime.

I keep getting logged out of the RE.

I am frequently getting logged out of the RE. If I look at another page on my computer for even a short while, I am logged out.

The RE locks after five minutes of inactivity. You can extend this by clicking on the power icon on the top right and going to Settings, Privacy then Screen.

Is my account still active?

I have not logged into the RE for a while and now I can't get access. Is my account still active?

Your account may have been deactivated. Contact [Service Desk](https://jiraservicedesk.extge.co.uk/plugins/servlet/desk) to get help.

I have a new phone

I have a new phone, how do I set up two-factor authentication with my new phone.

Contact [Service Desk](https://jiraservicedesk.extge.co.uk/plugins/servlet/desk) who will enable Okta to add a new device.

Windows Defender has blocked some features

When I attempt to login I see a Windows Defender dialogue box saying it has blocked some features.

Select *Public networks* to gain access. If you are not able to select this and proceed, please check with your IT department.

Unknown error on login

I receive an unknown error message when I attempt to login.

You can check your connectivity by clicking on *Connections* on a Mac or the icon in a Windows machine. indications problems with connectivity. You may wish to send this information to your IT department.

If all connections are fine (), close your AWS client and launch again.

AWS Workspaces installer executable or AWS Workspaces Client launcher

I am using Windows and when installing AWS, I am given the option of installing the AWS Workspaces installer executable or the AWS Workspaces Client launcher. Which should I install?

You should install the AWS Workspaces Client launcher, which has a red cube logo.

"MFA" on the login screen

The login screen prompts me to enter an "MFA Code". What is this code and where do I get it from?

"MFA" stands for "multi-factor authentication". This refers to the code from your Okta or Authy app.

Firewall issues

My organisation's firewall is blocking access to the RE.

You can check your connectivity by clicking on *Connections* on a Mac or the icon in a Windows machine. indications problems with connectivity. You may wish to send this information to your IT department.

Check with your organisation's IT department that the following ports and IP Addresses are whitelisted for your computer's network:

- Port 53 (UDP)
- Port 443 (TCP)
- Port 4172 and 4195 (UDP and TCP)

Note that our workspaces are in the EU-West-2 AWS region.

[More details on these ports from Amazon.](https://docs.aws.amazon.com/workspaces/latest/adminguide/workspaces-port-requirements.html)

Home directory data location

Where is the data that was previously in my home directory?

Most of the data will still be in your home directory. The only exceptions are the configuration files and folders, such as `.ssh`, .`Rprofile`, `.bash_profile` and `.netrc`. These were moved to a folder called `~/conf.Linux` for the migration so as to correctly set up your new environment. You can copy these files and folders back to your home directory to maintain previous configuration.

.ssh key configuration

I had some .ssh keys set up on the RE, but these do not seem to be working on the upgraded RE. Do I need to write them all again.

Configuration files and folders, such as `.ssh`, .`Rprofile`, `.bash_profile` and `.netrc` have been moved from your home directory to a folder called `~/conf.Linux` for the migration. This ensured we could correctly set up your environment. You can copy these files and folders back to your home directory to maintain previous configuration.

Logging on from multiple devices

I want to login to the RE on multiple devices. Do I need multiple registration codes?

No, you can use the same code on multiple devices.

Accessing RE via AWS web access

Can I access the RE via a web browser?

Yes.

Compatibility issue with the Ubuntu OS

I'm having a problem using the AWS application with Ubuntu

If you cannot use AWS on Ubuntu, please use the [AWS web application](https://eu-west-2.webclient.amazonworkspaces.com/login).

login keyring error

I see an error message: "The login keyring did not get unlocked when you logged into your computer:

Enter your password to dismiss the error. Your workspace should function as normal afterwards.

March 31, 2026
