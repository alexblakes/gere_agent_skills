---
title: 'Working with R packages - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/r_packages/
scraped_at: 2026-05-04T06:33:26Z
---

# Working with R packages

With the Research Environment, you can create and maintain your own R package libraries. There are also many commonly used R packages pre-installed in centralised locations on the RE.

> **Licensing considerations:**
>
> Please note if you install libraries yourself, you will be solely and fully responsible for acquiring any licences required for the use of and access to the relevant software package. Genomics England expect all software to be correctly licensed by you where the self-installation route is employed. In no event shall Genomics England be liable to you or any third parties for any claim, damages or other liability, whether such liability arises in contract, tort (including negligence), breach of statutory duty, misrepresentation, restitution and on an indemnity basis or otherwise, arising from, out of or in connection with software self-installed by the researcher or the use or other dealings by the researcher in the software.
>
> Any links to third party software available on this User Guide are provided âas isâ without warranty of any kind, either expressed or implied, and such software is to be used at your own risk. No advice or information, whether oral or written, obtained by you from us or from this User Guide shall create any warranty in relation to the software.

## Libraries available in R

You can query the R libraries available in the RE using a resource available at:

- locally: `~/gel_data_resources/software_catalogues/R_catalogue/`
- HPC: `/gel_data_resources/software_catalogues/R_catalogue/`

### How to use the R package catalogue

This directory will contain a database of all the R packages that have been installed within the various supported versions of R that are hosted on the HPC. You can query it using the accompanying shell command line script.

### How to use the script

1. Navigate to the containing directory:

   - `cd ~/gel_data_resources/software_catalogues/R_catalogue` From the Research Environment
   - `cd /gel_data_resources/software_catalogues/R_catalogue` From the HPC
2. Call the script with the name of the package you're interested in like:

   `./query_catalogue.sh name_of_package`

   The query is "greedy" and can expand a partial package name.

### Example output

For the above queries you should see the following outputs:

For `Biobase`:

```
 |    | Library   | vs     | R_VS   |
 |---:|:----------|:-------|:-------|
 |  0 | Biobase   | 2.50.0 | 4.0.2  |
 |  1 | Biobase   | 2.46.0 | 3.6.1  |
 |  2 | Biobase   | 2.46.0 | 3.6.2  |
 |  3 | Biobase   | 2.50.0 | 4.0.0  |
 |  4 | Biobase   | 2.50.0 | 4.0.3  |
 |  5 | Biobase   | 2.54.0 | 4.1.0  |
```

The `README.md` file in the catalogue directory will contain a copy of these instructions for ease of use.

## Using pre-installed packages

Pre-installed R packages can be found at:

- `/tools/aws-workspace-ubuntu-apps/ce/R/4.3.3`
- `/tools/aws-workspace-ubuntu-apps/ce/R/4.5.2`

The best practice for using "Community" packages is to add these folder locations to .libPaths in your R session. For example

Please note: it may take ~5 minutes before these packages become visible after the library paths have been mounted to `.libPaths()`.

```
.libPaths(c( .libPaths(), "/tools/aws-workspace-ubuntu-apps/ce/R/4.3.3"))
library(tidyverse)
```

The following code may be run before and after the above commands to check this step has been successful:

```
table(as.data.frame(installed.packages())$LibPath)
print(table)
```

## Installing R packages from CRAN

You can install R packages yourself within the Research Environment from CRAN as we have an internal mirror.

> **Note:**
>
> You can only install R packages from the Desktop environment. You cannot install R packages directly on the HPC. However, we do already have various packages pre-installed. Please see the "Loading R packages" section below.

1. Make a folder where you want to store your R packages for example: `~/re_gecip/yourDomain/R_packages`
2. Install the package and specify the installation path with lib: `install.packages("", lib="~/re_gecip/yourDomain/R_packages")`
3. Load libraries: `library(, lib="~/re_gecip/yourDomain/R_packages")`

All R packages that are located on GitHub require Genomics England admins to install them. Please submit a [service desk ticket](https://jiraservicedesk.extge.co.uk/plugins/servlet/desk) if you require this.

## Installing and configuring packages from BioConductor

You can also install BioConductor packages from within the Research Environment after a once-off configuration as shown in **Configuration of R**. Follow the same setup as CRAN packages by installing them to a shared folder on the HPC (such as `re_gecip`).

Add the following lines to your `.Rprofile`:

```
```
options(
    BIOCONDUCTOR_CONFIG_FILE = "https://artifactory.aws.gel.ac:443/artifactory/bioconductor.org-cache/config.yaml"
)
```

Open R (or RStudio) and run the following:

``` R linenums="1"
library("BiocManager")
BiocManager::install("<package_name>")
library(<package_name>)
```
```

## Loading packages from the HPC environment

To load a pre-installed R package from the HPC environment you can use the following command: `library(, lib="/re_gecip/yourDomain/R_packages")`. Notice the preceding `/` in the HPC environment compared to `~/` in the Desktop environment.

## Work with older versions of R using containers

If you need to use packages which only work with older versions of R, we recommend [using containers](../hpc_containers/). [Rocker](https://rocker-project.org/images/) provides a number of containers for working with different R versions, along with [templates](https://rocker-project.org/images/devcontainer/templates.html) for building your own R containers.

## Creating your own libraries

We suggest creating an `Rpackages` folder within your working directory, either in your personal space or shared between you and your collaborators.

To do this, follow these steps:

1. Set up a personal R package library location using bash (this step can be done using file explorer)

   ```
   cd /path/to/personal_folder
   mkdir Rpackages
   ```
2. Install and load packages from CRAN and BioConductor in R

   ```
   #CRAN
   install.packages("ggplot2", lib="/path/to/personal_folder/Rpackages")
   library("ggplot2", lib.loc="/path/to/personal_folder/Rpackages")

   #BioConductor
   install.packages("BiocManager", lib="/path/to/personal_folder/Rpackages")
   library(BiocManager, lib.loc="/path/to/personal_folder/Rpackages")
   BiocManager::install("GenomicFeatures", lib="/path/to/personal_folder/Rpackages")
   library(GenomicFeatures, lib.loc="/path/to/personal_folder/Rpackages")
   ```
3. Mount library locations to .libPaths() and load packages without specifying lib.loc

   Please note: it may take ~5 minutes before these packages become visible after the library paths have been mounted to .libPaths().

   ```
   .libPaths(c( .libPaths(), "/path/to/personal_folder/Rpackages"))
   library(tidyverse)
   ```

   The following code may be run before and after the above commands to check this step has been successful:

   ```
   table(as.data.frame(installed.packages())$LibPath)
   print(table)
   ```

## Request packages

If you encounter an error when trying to install an R package, please feel free to raise a ticket through the [Service Desk](https://jiraservicedesk.extge.co.uk/servicedesk/customer/portals) portal. In your ticket, please include the following:

- Version of R being used
- Name of the package causing the error
- Command being used
- Relevant error messages or a screenshot of the observed behaviour

January 16, 2026
