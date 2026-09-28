---
title: 'Accessing the HPC - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/hpc_access/
scraped_at: 2026-05-04T06:32:29Z
---

# Accessing the HPC

The HPC is accessed via `ssh` from the terminal.

## Basic login

The following is an example of a Research Network user, Jane Doe, connecting via ssh.

```
ssh jdoe@doublehelix.helix.prod.aws.gel.ac
```

You will then be prompted for your password, and once entered, will be connected to the HPC.

The first time you do this, you will be prompted to add this address to your list of known hosts:

```
The authenticity of host 'doublehelix.helix.prod.aws.gel.ac (10.128.12.177)' can't be established.
##### key fingerprint is #####.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no)?
```

Type `yes` to add it. You will then need to input your password.

You will now be logged onto the HPC. You will need to navigate to your [working directory](../home_directory/). To actually use the cluster, you will need to [run jobs](../hpc_jobs/).

## How to make your login automatic

### Using SSH Keys

If you do not want to enter a password each time you connect, you can create a ssh key and ssh config file that will make logging in easier.

Create a ssh key in your .ssh folder, which is located in `/home/<username>/.ssh`. This is not on the HPC, so if you've logged in, please open a new terminal.

```
cd.ssh
ssh-keygen
```

Follow the prompts to name your ssh key (I suggest cluster as a good name) and leave the password blank.

### Creating SSH keys

Next, create a ssh config file called `config` in the .ssh folder,

```
nano config
```

the above will open the file. Add the following information and format:

```
Host cluster
    Hostname doublehelix.helix.prod.aws.gel.ac
    User <your username>
    IdentityFile ~/.ssh/cluster
```

### Sending your key to the remote

Copy your new ssh public key to the HPC

`ssh-copy-id -i cluster.pub cluster`

This will ask for your password, then copy the ssh key to the HPC.

Now, you can connect by typing

`ssh cluster`

July 11, 2025
