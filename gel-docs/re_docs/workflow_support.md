---
title: 'Getting workflow support - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/workflow_support/
scraped_at: 2026-05-04T06:34:16Z
---

# Getting workflow support

If you have any trouble running our workflows, please follow the troubleshooting guide here, before getting in contact.

## Primary troubleshooting (before raising a ticket)

### Â I received an error, or my error log contains: "transitioned to state Failed". What can I do?

This means that one of the sub-tasks did not complete and therefore subsequent tasks cannot be performed, causing the workflow to fail.

There are a few things you should try before raising a ticket:

#### Check your LabKey API configuration

1. Confirm that you are able to login to the LabKey application in the RE.
2. Check that you have an updated `.netrc` file in the `/home/<username>/` directory on the HPC. Having the .netrc configuration on the RE home directory is not sufficient.
3. Test your LabKey API access via R on the HPC as followed:

   Open your terminal, login to **the HPC**, and type the following:

   LabKey API test script:

   ```
   library(Rlabkey)
   Sys.info()[4] # This will provide Support with info on which node the user is.
   labkey.executeSql(
   baseUrl = "https://labkey.prod.aws.gel.ac/labkey/",
   folderPath="/main-programme/main-programme_v13_2021-09-30",      
   schemaName="lists", colNameOpt = "rname", maxRows = 100000000,
   sql = "SELECT programme FROM participant ORDER BY RAND() LIMIT 1"
   )
   ```

   If the code returned the following text, your LabKey API was successfully configured on the HPC, and you can proceed to the "**Copy your files to publicly accessible area**" section.

   ```
   programme
   1 Rare Diseases

   === OR ===

   programme
   1    Cancer
   ```

   If the code returned one of the following texts, your LabKey API settings are incorrectly configured.

   ```
   Error in handleError(response, haltOnError) :
   HTTP request was unsuccessful. Status code = 401, Error message = User does not have permission to perform this operation

   === OR ===

   Error: lexical error: invalid char in json text.
                                      <!DOCTYPE html>  <html>  <head>
                    (right here) ------^
   ```

   Go to the [LabKey configuration page](../labkey_api_configuration/) to learn how to rectify this.

   If the above did not resolve the issue, and you are a Research Network user, please read the steps in "**Copy your files to publicly accessible area**".

### Copy your files to publicly accessible area (Research Network Members only)

To help us to troubleshoot, we will need to have a closer look at the workflow files. You can copy your workflow folder to a publicly accessible area, so that we can immediately look into your issue when we receive your ticket.

1. Create a folder in `/re_gecip/shared_allGeCIPs/` . We suggest `/re_gecip/shared_allGeCIPs/<your_username>/`  
   *If you do not have access to the `/shared_allGeCIPs/` folder, please raise a separate ticket as this is an onboarding issue.*
2. Copy your workflow folder and contents into the shared folder.
3. Ensure that the permissions are viewable by the support team. For example by typing: `chmod -R 755 /re_gecip/shared_allGeCIPs/<your_username>/`

### I'm an industry Research Network member, and my LabKey configuration seems to be correct. What do I do?

We have administrative support accounts available for all members, allowing us to access your `discovery_forum` folders. This means you can raise a ticket and give us the file path of your workflow folder.

## Secondary troubleshooting (advanced)

This section is not required before raising a ticket, but you may be interested in deeper functionality of the workflows. We provide this information in case you want to try to troubleshoot the workflow issue yourself in the meantime.

### Killing a currently running workflow

Sometimes you may want to cancel the workflow. While the bkill command can work, we recommend to use the following command: `bkill -s SIGTERM <job_id_of_the_master_job_on_the_inter_node>`

### Look into the std.out file instead of the std.err

The `.stdout` file may give hints at which stage the workflow fails. Similarly, the `/outputs/workflow_logs/` folder containing run logs may also help.

### Cromwell workflow structure

Once you have initiated a workflow run, Cromwell will create various folders including one called `cromwell-executions`. This will contain two additional folders. One called `cromwell-db` (see below), and one with a more Workflow specific folder. Within this folder will be another folder named with a random ID. This is the unique run ID for the workflow that you just ran.

Once inside the specific run ID folder, you will find folders called `call-<task_name>`. These have been the subtasks that each workflow runs and can be different for each Workflow. However, if a certain task failed, subsequent tasks will not run, so this can narrow down the investigation to see where the workflow failed.

Also here, depending on the workflow, there may be subfolders called `shard-0`, or `shard-1`, or even higher numbers. Usually, if it is just 0 and 1, it tends to refer to each genome build that the workflow splits over. So each shard becomes a specific branch. This folder may not be there if the workflow does not split. Once you accessed one of these shard folders we are in the final set of folders. There will be the `execution` and `inputs` folder. In the inputs folder will be the input data that is required by the workflow. Should an input file be empty or erroneous, you will be able to find this here. The executions folder on the other hand will contain the actual submitted script that the workflow submits for this particular task. It also contains the actual `stderr` and `stdout` for these tasks and may therefore be more descriptive. Finally, the output data will also be placed in the executions folder.

### Cromwell database file locked

Whenever a workflow is started, its database will be "locked". Cromwell uses its database to coordinate the workflow and caching. In reality, it means that files in this folder will receive the suffix `.lck`. When this extension is live, a subsequent workflow cannot be submitted, or if it does, it will not initiate any run. In some cases an issue can occur where the database does not unlock after an unsuccessful run. In such cases, we recommend to delete this folder, and rerunning the workflow.

However, please do make sure that you do not submit the same workflow while they are still running.

February 25, 2026
