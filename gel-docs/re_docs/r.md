---
title: 'R, RStudio, and R libraries - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/r/
scraped_at: 2026-05-04T06:33:25Z
---

# R, RStudio, and R libraries

R and RStudio are available within the Research Environment. You can use the latest version of R, as well as specifying previous versions if you like.

## R versions

The default install of R and R within Rstudio on the Desktop is version 4.5.2. While you are free to use this version of R and Rstudio this version will not have all packages available. If you wish to use the pre-installed packages, you will need to manually load your preferred version of R.

### Specifying another version of R

To use a specific version of R in RStudio, open the terminal app on the Desktop and enter the following commands:

```
module avail R/
module load R/4.3.3 #select your version here
rstudio
```

This will firstly scan for all available versions of R and then load RStudio using R 4.3.3.

This is important, as there are different libraries available for the different versions of R. For more information on loading and installing R packages, see *Installing R packages from CRAN* on this page.

## Configuration of R

On the desktopOn the HPC

Because the Research Environment and the HPC are closed environments, you will have to perform a small number of steps to correctly configure your R instances. The configuration files will need to reside in your home directory `${HOME}`. This is required to access databases such as our internal CRAN mirror, Bioconductor, and other rerouting.

Please follow the steps below to configure your R:

1. Open the terminal application from the Desktop in the Research Environment.
2. Type in (or copy-and-paste) the following lines to the file open in the terminal:

   ```
   cd $HOME
   cp -rf ~/gel_data_resources/example_config_files/Workspaces/. .
   ```
3. Done!

> **Note:**
>
> The command prompts a warning message. This is expected and normal and just means that it has copied the timestamps of the original files because it comes from a mounted file system. You will not see this prompt in the HPC configuration.

### Contents of the added files

For the configuration of R on the Research Environment, three files are added. The contents are displayed here for reference:

.Renviron.Rprofile.netrc

```
no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com,.gel.zone"
```

```
myrepo = getOption("repos")
myrepo["CRAN"] = "https://artifactory.aws.gel.ac/artifactory/cran"
options(repos = myrepo, BioC_mirror = "https://artifactory.aws.gel.ac:443/artifactory/bioconductor.org")
rm(myrepo)
```

```
machine labkey.prod.aws.gel.ac
login yourusername
password yourPasswordHere
```

If you wish to setup your R instances on the HPC, please follow the steps below.

1. Open the terminal application from the Desktop in the Research Environment.
2. Login to the [HPC](../hpc/)
3. Type in (or copy-and-paste) the following lines to the file open in the terminal:

   ```
   cp -rf /gel_data_resources/example_config_files/Helix/. ./
   ```
4. Done!

> **Note:**
>
> The command used for the HPC is slightly different (~) and refers to different files and folders. This is due to how the file systems are mounted on the HPC vs on the Research Environment sessions. The .netrc files remain the same, however the .Renviron file will be different.

### Contents of the added files

For the configuration of R on the the HPC, three files are added. The contents are displayed here for reference:

.Renviron.Rprofile.netrc

```
http_proxy=http://pfsense.int.corp.gel.ac:3128
ftp_proxy=http://pfsense.int.corp.gel.ac:3128
rsync_proxy=http://pfsense.int.corp.gel.ac:3128
https_proxy=http://pfsense.int.corp.gel.ac:3128
no_proxy=localhost,127.0.0.1,localaddress,.localdomain.com,.gel.zone,.cluster
```

```
myrepo = getOption("repos")
myrepo["CRAN"] = "https://artifactory.aws.gel.ac/artifactory/cran"
options(repos = myrepo, BioC_mirror = "https://artifactory.aws.gel.ac:443/artifactory/bioconductor.org")
rm(myrepo)
```

```
machine labkey.prod.aws.gel.ac
login yourusername
password yourPasswordHere
```

## Loading R packages

We have provided a range of R packages, which you can load with `library(library_name)` or by selecting them in the "**Packages**" tab in RStudio. It is also possible to [install R packages](../r_packages/) from both CRAN and BioConductor using the internal mirror.

It is your responsibility to resolve any dependencies by installing other relevant packages.

February 25, 2026
