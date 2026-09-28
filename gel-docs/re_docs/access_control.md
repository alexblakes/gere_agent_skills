---
title: 'Access Control - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/access_control/
scraped_at: 2026-05-04T06:30:55Z
summary: "Use `setfacl`/`getfacl`/`chmod`/`chown` to manage Linux ACL permissions on shared RE filesystem files and directories."
---

# Access Control

Linux Access Control Lists (ACL) is avilable on the shared filesytem of the RE. You can apply and check access control using the `setfacl` and `getfacl` commands respectively.

## Checking the permissions on files and directories

There are two ways to check existing permissions on files and directories. The standard BASH list command will accept flags that will display these permissions:

```
$ ls -lah /path/to/directory
total X.YG
drwxr-sr-x 1 username       Group          0 Jan 27 11:28 .
drwsrwsr-x 1 other.username Group          0 Jan 24 11:25 ..
drwx--S--- 1 username       Other-Group    0 Nov 20 09:31 dir_namme
-rw------- 1 username       Group       515K Oct 10  2024 file.txt
drwxrwsr-x 1 username       Group          0 Jan 27 11:30 Dir_name
```

where `ls` is the list command, `-l` provides the Long information, `-a` shows all content including hidden files and directories and `-h` returns human readable size information.

The second approach is the `getfacl` command. This command will return less information than the `ls` command as it is focused on a single entity. The command will return the following information:

```
$ getfacl /path/to/directory
# file: .
# owner: username
# group: Group
# flags: -s-
user::rwx
group::r-x
other::r-x
```

where:

- `file:` is the selected file or directory
- `owner:` is the username of the creator or current owner
- `group:` indicates the current group ownership
- `flags:` indicates the presence of
- `user::` provides the user permissions
- `group::` provides the group permissions
- `other::` provides the world/any other user permissions
- `r` indicates read permissions present
- `w` indicates write permissions present
- `x` indicates execute permissions present
- `-` indicates the absence of a permission for that entity

## Setting permissions on files and directories

There are two methods for setting permissions on files with the filesystem. The first method provides more broad spectrum control of file access. The built-in `chmod`, `chown` and `chgrp`.

- `chmod`: used to modify the read, write and execute permissions on files and directories
- `chown`: used to change file and directory ownership
- `chgrp`: used to change the group ownership of files and directories

A practical method of setting permissions is to use the numerical shorthand for the permissions i.e.:

```
# set read only permissions for owner and group members only
$ chmod 440 /path/to/file

# set read, write permissions for the owner and execute permissions for all users
$ chmod 701 /path/to/file

# change the group ownership of a file or directory
$ chgrp NewGroup /path/to/file

# change ownership for all files in a directory
$ chown new_username /path/to/directory/*
```

The `setfacl` command provides a finer grain control of access permissions. This allows you to control which specific individuals can access directories or files as well as what the specific permissions each individual can have.

> **Note:**
>
> Only the owner of a file, or directory, will be able to set and modify access permissions using `setfacl`. You can only set Linux Access Control Lists on locations designed for the sharing of data, which means that they are limited to the current locations:
>
> - `/re_gecip/<your_gecip>`
> - `/re_gecip/shared_allGECIPs/<your_directory>`
> - `/discovery_forum/df_<your_organisation>`
> - `/pgen_shared_all/<share_location>`

To change the permissions using `setfacl`:

```
# provide read only permissions to a single other user
$ setfacl -m u:<username>:r /path/to/file

# provide execute only permissions to a group
$ setfacl -m g:<GroupName>:x /path/to/file

# set permissions recursively for a directory
$ setfacl -R -m u:<username>:rx /path/to/directory/

# remove any permissions set using setfacl
$ setfacl -b /path/to/file
```

Linux provide [more information on setting ACL](https://linux.die.net/man/1/setfacl) and [reading existing access control lists](https://linux.die.net/man/1/getfacl).

August 15, 2025
