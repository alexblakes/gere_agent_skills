---
title: 'Using Rstudio on the HPC - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/enable_rstudio/
scraped_at: 2026-05-04T06:32:05Z
---

# Using Rstudio on the HPC

To work on the HPC in Rstudio, you will first need to enable the terminal, login to the HPC within the terminal, set your working directory and, optionally, set up keyboard shortcuts to send your code to the terminal.

Here you will find a video walkthrough and the same information as step-by-step instructions.

## Video walkthrough

## Enable the terminal in Rstudio

### Step 1: Starting up Rstudio

Open Rstudio (Double click the icon).

This should now load Rstudio, and should look something like this. The style and layout can be different based on your preference, but it is not necessary (If this is of interest, you can explore Tools > Appearance or Tools > Panel Layout).

### Step 2: Enabling the Terminal tab

Enable the Terminal viewer by clicking in the top: Tools > Terminal > New Terminal.

You should now see an additional tab named "Terminal" next to the original R console.

## Logging into the HPC and setting up your environment

Within Rstudio you can set up an interactive session on the HPC within the terminal.

If you don't set up a session, you will be running R on the login node, which can be unstable. If you do this by accident, your process may be automatically shut down.

### Step 1: Logging into the HPC

After [opening a terminal in Rstudio](./), you can login to the HPC.

Use your [normal HPC login](../hpc_access/) credentials. Your screen will now look something like this:

### Step 2: Starting an interactive session

Next, start an [interactive session](../hpc_jobs/). You can do so by typing the following command:

`bsub -q inter -P <YOUR_PROJECT_CODE> -Is -n 1 -R rusage[mem=1000] -M 1000 /bin/bash`

Replacing `<YOUR_PROJECT_CODE` with [your project code](../lsf_codes/).

This will set an interactive session with 1 GB of RAM. If you require more memory, you can change the options in the above command.

Now you will see:

### Step 3: Working with R

Now load the R module:

`module load R/4.3.3`

Start R with: `R`

It should now look like the screen below.

Now you can send code to the terminal to run on the HPC and use libraries available on the HPC. You may want to change your keyboard shortcuts to make this easier.

## Set your working directory in RStudio

You should set your work directory accordingly to your respective `/re_gecip` or `/discovery_forum` folders. From within R, you can use the `setwd("<my_working_path>")` command.

## Change keyboard shortcut

To run code in RStudio on the HPC, you need to send it to the terminal. You may find it useful to set up an easy keyboard shortcut to do this, particularly if you use a Mac.

To do this you will need to:

1. Navigate to the keyboard shortcut menu. Click on Tools > Modify Keyboard Shortcut.
2. Find the shortcut you need. Use filter search box to type "send" to help you filter through all the various shortcuts. This should narrow down the options.
3. Select "Send Selection to Terminal"
4. Set to Ctrl+Cmd+Enter, or any preferred setting. Look out for keyboard shortcuts that already do other things, for example Ctrl+Enter or Cmd+Enter that are already used to sending your selection or line to the R console.
5. Click on Apply, and close the screen by clicking on Cancel.

August 21, 2025
