---
title: 'I want to develop and test scripts and workflows - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/develop_test/
scraped_at: 2026-05-04T06:32:03Z
---

# I want to develop and test scripts and workflows

The instructions in each section include links to the relevant pages in the documentation. Links are tagged as:

- Tutorials
- Tools - descriptive
- Data - descriptive
- Pre-made workflows
- Reference lists/tables

## Import material to the TRE

You can bring in your own software and data to compare to using either Airlock or containers. We have Singularity on the HPC, which you can use to work with containers on Docker, Quay.io or Sylabs, via our artifactory re-routing.

- [Using the Airlock](../airlock_tool/)
- [Using Singularity](../hpc_containers/)

## Working on the HPC

You will need to work on the HPC for any large-scale analyses. You can learn more about the HPC and how to access it:

- [High Performance Cluster (HPC)](../hpc/)
- [Accessing the HPC](../hpc_access/)

You will find many common bioinformatics tools installed in the HPC, which you can incorporate into your pipelines.

- [Using software on the HPC](../hpc_using_software/)
- [How to submit jobs to LSF](../hpc_jobs/)

There are folders on the HPC for your GECIP domain or company. You should use your relevant folder as your working directory. These are also accessible from the desktop:

- [Home directory contents](../home_directory/)

## Create pipelines

You can analyse and combine these data in any way you choose, using any programming languages that are provided on the HPC. We also provide conda environments for working in Python and R libraries.

- [Personal conda environments](../hpc_conda/)
- [Libraries available in R](../r_packages/)

A number of coding tools are available, including VSCode, Rstudio and Jupyter notebooks.

- [Jupyter Lab on the HPC](../hpc_jupyter/)
- [Using Rstudio on the HPC](../enable_rstudio/)

## Export

The only way to export any scripts or pipelines you build is using Airlock. It is **your** responsibility to ensure your export conforms to the Airlock rules and does not contain any identifying data.

- [Airlock](../airlock/)
- [Using the Airlock](../airlock_tool/)
- [What you can and can't export](../airlock_rules/)

November 6, 2024
