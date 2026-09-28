---
title: 'Cancer survival analysis - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/survival/
scraped_at: 2026-05-04T06:34:03Z
---

# Cancer survival analysis

This scripts combines Genomics England secondary data to support survival analysis. This script is meant to be used as an guide on where to find relevant information, keeping in mind that each cohort should be further curated and that real-world evidence requires data cleaning and quality checks.

The code can be found here:

`/gel_data_resources/example_scripts/survival_oncology`

**Please copy it into your dir and edit according to your needs.**

## Summary

The script will provide the basis for a cohort build, estimate time of survival or until last time seen, and combine with genetic data.

| Usage | Variables | Columns | Table | Comment |
| --- | --- | --- | --- | --- |
| cohort building | patient id sample id | participant\_id tumour\_sample\_platekey | cancer\_analysis | This can be further subset. av\_tumour is a great source of information for such. Please make use of the [tutorial on cohort building](../cohorts/) to build you own custom cohorts. |
| survival time | death last seen date of diagnosis | participant\_id date\_of\_death/death\_date |  |  |
| arrivaldate/disdate/apptdate/ccdisdate diagnosis\_date+diagnosis\_icd\_code/  diagnosisdatebest+site\_icd10\_o2 | mortality/death\_details ae/apc/op/cc cancer\_participant\_tumour | Consider selecting only survival <5 years Note that diagnosis code is also select to confirm that the date of diagnosis corresponds to the correct disease |  |  |
| SNV status | mutations on a gene of interest | uses gene\_centric-report, please read here on how to select your variants: [Gene centric SNV report for cancer participants](../gene-centric-snv-report/) |  |  |

> **Missing diagnosis dates:**
>
> For a subset of cases, the diagnosis date is missing. In these cases, the data is imputed.

## Pre-requirements

[Make sure you have LabKey API working on your machine.](../labkey_api/) You also need to install some [R dependencies](../r/). Some of these will only work on R v4.2.1 or later.

## Getting started

Open a terminal and type:

```
module load R/4.3.3
rstudio
```

install the dependencies:

```
dependencies <- c("tidyverse", "lubridate", "survminer", "survival", "Rlabkey", "gdata", "bit64")
install.packages(dependencies, lib = '~/path/to/personal/library/directory')
```

These libraries will have a number of their own dependencies so may take some time to be installed.

## Input

You need to edit the gene of interest, in this case *BRCA2*.

Search for SNVdb to localise the relevant part of code, change the gene name for more information, such as selecting specific variants, look at: [Gene centric SNV report for cancer participants](../gene-centric-snv-report/)

## Output

A survival curve split for reference and alternative alleles of a certain gene.

All tables relevant to retrieve survival, including cleaning how to clean the data should be listed here.

Example of a plot created based on the script above, applying specific changes for the cohort of interest.

August 21, 2025
