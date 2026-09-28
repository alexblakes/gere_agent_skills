---
title: 'Backup retention policy - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/backup/
scraped_at: 2026-05-04T06:31:26Z
---

# Backup retention policy

Many folders in the RE are backed up regularly. We recommend storing your results in backed-up folders to ensure your data is kept safe.

## Shared folders

**The Research Environment drives that are fully backed up are the re\_gecip and re\_df shared folders.** Please see below for details â whether they are recoverable depends on how long the file existed before it was deleted and how long the delay is between deleting it and needing to recover it.

### Research Environment back up policy for shared folders

| Snapshot | Retention | Meaning |
| --- | --- | --- |
| Daily | Seven days | If you create and delete your work within the same day it is not likely to be recoverable. If you delete it after the daily back up, it will be recoverable for 7 days. |
| Weekly | 30 days | If your data have lasted long enough to be captured in a weekly back up (i.e. you didnât create and delete within a week), they will be recoverable for a month. |
| Monthly | One year | If your data were captured in a monthly back up, you have a year in which to recover it, although we do not guarantee that we will be able to maintain this policy forever. |

If you wish to recover files that have been accidentally deleted, please email [contact the Service Desk](https://www.genomicsengland.co.uk/service-desk).

We ask that wherever possible you **use the scratch folders for transitory outputs** so that these donât get captured in backups and waste finite resources.

## Home directories

You have two home directories â one for the HPC and one based on the desktop. The contents of these are separate. **No critical, irreplaceable data should be kept on home directories.**

We do take daily snapshots of the HPC Home directory, and these are retained for 30 days. We also take weekly snapshots and these are retained for three months.

Data deleted more than three months ago will not be recoverable.

The **desktop Home directory** is backed up weekly, and these snapshots are retained for 30 days.

There is a 10 GB limit on your desktop home folder. If you exceed this, you will no longer be able to login to the Research Environment and will need to raise a Service Desk ticket to have space cleared to allow you to log in again. We would discourage you from saving files to this home drive and instead suggest that you create a subdirectory in the relevant space within **re\_gecip** and **discovery\_forum**, where more space is available and the files are backed up regularly.

March 26, 2026
