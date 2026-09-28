---
title: 'Labkey API Configuration - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/labkey_api_configuration/
scraped_at: 2026-05-04T06:32:54Z
---

# Labkey API Configuration

To access the LabKey API, you need to provide your credentials to the API so that you can access the data you are allowed. These credentials will be stored in a file called `.netrc` (dot net r c), located in your home directory.

1. Obtain the `.netrc` **template**.

   1. To use the API on the desktop, open the terminal and copy the following folder:

      ```
      cp -rf /gel_data_resources/example_config_files/Workspaces/. ./
      ```
   2. To use the API on the HPC [ssh onto the HPC](../hpc_access/) and copy:

      ```
      cp -rf /gel_data_resources/example_config_files/Double_Helix/. ./
      ```
   > **Note:**
   >
   > The copy task listed there will provide you with additional files that may be required depending whether you will use the R or Python client. They will not hurt your overall session configuration.
2. Open the file called `.netrc` (to use on both the desktop and the HPC, you'll need to open and edit both). The file contents are:

   ```
   machine labkey-embassy.gel.zone
   login yourusername
   password yourPasswordHere

   machine labkey.prod.aws.gel.ac
   login yourusername
   password yourPasswordHere
   ```
3. replace `yourusername` and `yourPasswordHere` with the same username and password that you use to login the Research Environment.
4. Once the information is entered, save the file.
5. Because the file contains your password, it should be set to read-write only for yourself.
   - The file permissions can be checked by entering `ls -alh` in the terminal.
     - You should see a line like the following: `-rw------- <username> <username> .netrc`
   - If the permissions are in any other form, e.g. `-rw-rw-rw-`, they are visible to others and need to be changed.
   - This can be done with the following command: `chmod 600 .netrc`, which will set read-write to you only.

> **Note:**
>
> The Research Environment has a **12GB RAM limit**. It is designed for exploratory work only. For larger analyses, please use the [HPC](../hpc/).

### Video walkthrough

## Troubleshooting: Potential errors upon incorrect setup (i.e. DOCTYPE, user permission denied, curl\_fetch\_memory)

LabKey DOCTYPE error

I tried loading in a LabKey table, however I ran into a lexical `<!DOCTYPE html> error (invalid char in JSON text)`. Can I resolve this?

Several aspects may cause this, however, the examples below are the most likely the root causes of this error. If the issue persists after you ruled out these two issues, [please contact the service-desk so we can investigate](https://jiraservicedesk.extge.co.uk/servicedesk/customer/portals).

### 1) `folderPath` issue (R users) or `container_path/project_name` issue (Python users)

The first fix consists in simply checking the path to the data programme is correct in your API call.

For R Labkey users, this is an issue with the  argument in the  function. Below you will see a screenshot where the folderPath of the first query is correctly spelled as "/main-programme/main-programme\_v19\_2024-10-31" whereas in the second query the folderPath is "/main-programme/main-programme\_notcorrect". The error generated is a primary example of a !DOCTYPE error as it cannot connect to the right files due to the folderPath being incorrect.

For Python users, the situation is similar: simply make sure that the second argument you pass to the "`labkey.utils.create_server_context`" function is spelled out correctly. This parameter is called "`container_path`" in the function specification, and it is usually a variable called "`project_name`" in our documentation. A typical example of **correct** spelling is this line, which you will find in our example scripts:

project\_name = "/main-programme/main-programme\_v19\_2024-10-31" # The data we want to access. This will change depending on your study

### 2) `.netrc` setup (related: recent password change)

The second fix relates to the `.netrc` file, which needs to be setup prior to using the LabKey API. This file needs to be present and to contain the correct information, including your up-to-date username and password, as explained [here](../labkey_api/).

This is shown here in an example (this uses R, but the situation is similar if you use Python).

Below you can see a correct query, with the  library properly loaded (It is the same query as above for reference) but the output is a <!DOCTYPE html> error. So, in this case my password is incorrectly typed within the `.netrc` file. After I corrected my password, I resubmitted the code without actually modifying it. You will see that the output is correct, and the LabKey table has been loaded.

*If you changed your password in the middle of an Rstudio session, it may be possible that you have to restart your Rstudio to recognise this change.*

If this does not resolve the issue, and you still have problems using the R LabKey API, please contact the Service Desk.

March 30, 2026
