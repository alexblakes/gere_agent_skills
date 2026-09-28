---
title: 'Filesystem - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/home_directory/
scraped_at: 2026-05-04T06:32:27Z
---

# Filesystem

The filesystem in the RE contains folders that you can access from both the HPC and the desktop. These include your working directory, the genomic data and other data resources. You should use the mounted `~/re_gecip` or `~/discovery_forum` folders as your working directory.

## Home directory structure

The Home directory can be accessed from the desktop

> **Your working directory:**
>
> The desktop home directory contains various folders, such as documents and downloads. You should not use these are your working folders as they are not accessible on the HPC. Your working directory should be either your `~/re_gecip` (academia) or `~/discovery_forum` (industry) folder. You can access these from either the HPC or the desktop. They have significant amounts of storage, allowing you to store your working data, scripts and results.
>
> There is a 10 GB limit on your home directory on the AWS desktop environment and on the login node the HPC. You should avoid using these because if you fill them up you may be unable to login to the RE. You also cannot access the desktop home directory from the HPC or the login node from the desktop.

In your home directory a number of important folders are bookmarked. These folders are:

| Folder | Read | Write | Desktop Path | Mounted on HPC | HPC Path | Description |
| --- | --- | --- | --- | --- | --- | --- |
| genomes |  |  | `~/genomes` |  | `/genomes` | All the [genomic data](../genomic_data/) provided by our sequence partner Illumina . |
| gel\_data\_ resources |  |  | `~/gel_data_resources` |  | `/gel_data_resources` | Outputs from the [Genomics England internal pipelines](../gel_data/) |
| pgen\_public\_ data\_resources |  |  | `~/pgen_public_data_resources` |  | `/pgen_public_data_resources` | [Public data resources](../public_data/) such as 1,000 genomes data, reference genomes, example scripts etc. |
| specific shared folder |  |  | `~/<group_name>` |  | `/<group_name>` | Backed-up working space for each group (e.g. `re_gecip`). There are several petabytes of storage space for use and collaboration. |

All of these folders are also mounted on the HPC at root ( / ) so you can access them when running programs on the HPC. Your home folder in the Research Environment desktop is **NOT** available on the HPC. Please use the specific group share instead.

> **Note:**
>
> If you attempt to write anything to `genomes`, `gel_data_resources` or `pgen_public_data_resources` you will get a '**permission denied'** error. Please note that this will happen if an attempt is made to gunzip a file with no output directory specified. Consider using the following command instead: `gunzip -c file_name > /path/to/output.file`

## Using the `/genomes/` folder

Genomes are stored in the `/genomes/by_date/` folder. Any given `/genomes/by_date/<YYY-MM-DD>` directory can hold several hundred deliveries of data.

To find the relevant genomic files for your project, you should use our [LabKey tables](../general_clinical/#results-of-bioinformatic-analysis) or [Participant Explorer](../pxa_participant/#genome-sequence).

> **Note:**
>
> Do not traverse through the `/genomes/` directory to locate inputs for your studies, as you risk finding genomes of participants who have since withdrawn their consent. Any request to export these data via Airlock will be rejected. You should always consult LabKey to retrieve the latest list of consented genomes.

## Research Network shared working space

If you are a member of Research Network, you will be able to read and write to the `re_gecip` folder. Use this folder as your working space. Within this folder, are sub-folders categorised by GECIP domain (e.g. neurology, cardiovascular, skin, etc. You will be able to see all of these sub-folders, however you will only have read-write access to the sub-folders that you are a member of.

> **Note:**
>
> We are in the process of updating the `re_gecip` folders to match the new Research Network structure.

The `re_gecip` folder is mounted on the HPC, so any files and folders you save here, will be accessible from the HPC. We recommend saving all your work to your domain folder within the `re_gecip` folder as you have much more storage allocation. How you organise the domains shared working space is entirely up to you!

## Discovery forum shared working space

Each industry Research Network company will have their own specific shared folder in `discovery_form` which should be used as the shared working space. This folder has several petabytes of storage available and is mounted on the HPC at root. The folder has restricted access to each particular member.

## Temporary files

Please be aware that some tools within the Research Environment will require the production of transient or temporary files. The configuration of the HPC means that the `/tmp` location on the cluster can rapidly become unavailable and severely impact other users of the resource. You should create a directory within the `/re_scratch/` location for your temporary files, we have generated the `re_gecip` and `discovery_forum` parent directories, you should find your GECIP or discovery forum location within these and create your own directory at the end of the path. The resulting path for your TMPDIR would be:

`/re_scratch/re_gecip/<your_GECIP>/<your_username>`

and set the location for this temporary file directory in your `.bashrc` or as an environment variable within your script:

`export TMPDIR=/re_scratch/re_gecip/<your_GECIP>/<your_username>`

We recommend that you set this in your `.bashrc` so that the environment variable is generally accessible to your profile. Using a private scratch location will ensure that your files temporary files will remain both accessible and private.

> **Note:**
>
> As the scratch location is designed to be used for the temporary storage of transient and intermediary files needed by analyses, we are not able to guarantee that these files will be covered by the Research Environment's backup processes or would be recoverable beyond one month. We strongly advise that the location be reviewed prior to launching new analyses to ensure that any files that are no longer required are cleared from the location.

July 14, 2025
