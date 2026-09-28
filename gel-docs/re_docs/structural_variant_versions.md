---
title: 'Structural variant workflow changelog - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/structural_variant_versions/
scraped_at: 2026-05-04T06:34:02Z
---

# CHANGELOG

## 3.1.0

*23 May 2024*

- updated bcftools to `biocontainers/bcftools:1.20--h8b25389_0`

## 3.1.0

*24 Apr 2024*

- incremented data release version to `'main-programme_v18_2023-12-21'`
- ported DEFINE\_COHORT module script to python and re-wrote LabKey SQL query explicitly including consent
- added process tests to all modules
- parameterised LSF `project_code`
- changed to use default user singularity cache
- included automated test runs in CI/CD

## 3.0

*10 Oct 2023*

- ported from WDL/Cromwell to Nextflow DSL2
- renamed to Structural Variant workflow
- added configuration for both RE (Helix/HPC) and CloudRE (CloudOS)

## 2.0.1

- New possible cohort: **ca-all** so that both cancer somatic and cancer germline can be queried on the same run
- Inclusion of **prevalence report** (summary\_geneName\_sampleType.txt) for main cancer indications
- Inclusion of **MCC** for CNV both germline and somatic on 100kGP genomes. Also, on somatic CNV for dragen realignments
- **CNV\_pass\_only option**: CNV are assigned for the whole genome (some parts are neutral CN = 2). Canvas struggles to call (FILTER = PASS) focal CNVs, but removing PASS can retrieve those. Use it with care!
- Removal of Resultsfailed *files instead one single* *inaccessibleVCF.tsv*\* file list all, if any, vcf could not be accessed (probably due to permission issues, please open a ticket if it happens to you)
- Workflow files are not organised in folders! You only need to change the submit\_script.sh and the files in the **input/ dir**!

October 24, 2024
