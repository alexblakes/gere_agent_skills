---
title: 'Workflows, scripts and containers for data analysis - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/workflows/
scraped_at: 2026-05-04T06:34:53Z
---

# Workflows, scripts and containers for data analysis

This section contains example scripts and code chunks as well as entire analysis workflows to get you up-and-running with analysis in the Research Environment.

Most of these scripts and workflows are present in the Research Environment under the folder: `/gel_data_resources/example_scripts`. Check out the [Getting workflow support page](../workflow_support/) if you run into any difficulties. Many of these scripts and workflows require you to build a cohort as a startpoint, you can learn more about this in our [tutorial](../cohorts/)

Feel free to get in contact with us if you would like further assistance in writing your own scripts or if you have a script or workflow of your own that you would like to share with the research community!

## Workflows

### Association testing

- [Aggregate Variant Testing (AVT) workflow](../avt/) performs rare variant association analysis
- [GWAS pipeline](../gwas/) performs genome-wide common variant association analysis

### Variant screening

- [Small Variant workflow](../small_variant/) extracts and annotates variants within a query gene(s)
- [Structural Variant workflow](../structural_variant/) extracts CNVs and SVs within a query regions defined by gene(s) or coordinates

## Scripts

- [Extract variants by coordinate](../var_by_coord/)
- [Somatic SVs and CNVs for a specific gene](../somatic_sv/)
- [Cancer survival analysis](../survival/)
- [Variant Effect Predictor annotation](../vep/)

## Containers

### Container repositories

- [Docker Hub](https://hub.docker.com/search?q=&type=image)
- [Quay.io](https://quay.io/search)

See the documentation on [Using containers within the Research Environment](../hpc_containers/).

> **Public genome analysis software in the Research Environment:**
>
> A full list of available software can be shown within the Research Environment by typing `module avail` once connected to the HPC.

## Our future plans

You can keep up-to-date with our plans for workflows and scripts in the RE, give us feedback on those plans and make suggestions using [our Productboard roadmap](../productboard/).

February 4, 2025
