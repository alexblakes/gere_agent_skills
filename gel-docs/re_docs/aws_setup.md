---
title: 'Setting up AWS - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/aws_setup/
scraped_at: 2026-05-04T06:31:25Z
---

# Setting up AWS

We use Amazon WorkSpaces (AWS) to host the RE. You will need to install and set up an AWS client to access the RE.

## Install an AWS client

Amazon WorkSpaces are virtual machines you can access on the web. To use them, you need to install a client, a free software application which can be downloaded online.

[Install an AWS client](https://clients.amazonworkspaces.com/)

Choose the appropriate version for your operating system, click download and follow the prompts to install.

## Check your connectivity

Check your connectivity by clicking on *Connections* on a Mac or the icon in a Windows machine. indications problems with connectivity.

If you can see on the network page, check with your organisation's IT department that the following ports and IP Addresses are whitelisted for your computer's network:

- Port 53 (UDP)
- Port 443 (TCP)
- Port 4172 and 4195 (UDP and TCP)

Note that our workspaces are in the EU-West-2 AWS region.

[More details on these ports from Amazon.](https://docs.aws.amazon.com/workspaces/latest/adminguide/workspaces-port-requirements.html)

Please test this in all your physical work locations (work and home), as firewalls may interfere with your ability to connect. If you encounter an issue, you will need to raise it with your IT department so this can be resolved before you access the RE.

## Video tutorial

November 21, 2023
