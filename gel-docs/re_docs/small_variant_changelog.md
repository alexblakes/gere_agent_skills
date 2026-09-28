---
title: 'Small variant workflow changelog - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/small_variant_changelog/
scraped_at: 2026-05-04T06:33:52Z
---

# CHANGELOG

## [v3.1.4](../small_variant/)

### latest

- updated submission script `submit.sh` to set singularity cache to `${HOME}/.singularity/cache`
- updated bcftools to [`1.22`](https://github.com/samtools/bcftools/releases/tag/1.22)
- bcftools 1.22 resolves issue regarding haploid-diploid merge fail (see [bcftools issue](https://github.com/samtools/bcftools/issues/1962))
- updated to data release `'main-programme/main-programme_v19_2024-10-31'` (set with `--labkey_project_name`)

---

> **Use the latest workflow version:**
>
> Please always use the [latest available workflow version](#latest), unless explicitly instructed otherwise. All earlier versions are no longer supported. The change history is provided below for reference.

## v3.1.3

- *hotfix*: updated combine annotations process to accept `orf` in HGNC gene symbols
- updated VEP to 112
- removed deprecated `--af_esp` option (see [here](https://www.ensembl.org/info/docs/tools/vep/script/vep_options.html#opt_af_esp))
- added genomic allele frequency option: `--af_gnomadg` (see [here](https://www.ensembl.org/info/docs/tools/vep/script/vep_options.html#opt_af_gnomadg))

## v3.1.2

- use merge flag `--force-single` to allow edge case merge of single file, added in [bftools release 1.20](https://github.com/samtools/bcftools/releases/tag/1.20)

## v3.1.1

- renamed configuration profiles: cluster -> hpc, cloud -> cloudos
- included latest version check and warning
- included message to create scratch dir and update submission script
- added workflow manifest

## v3.1.0

*18 Oct 2024*

- updated Nextflow version
  - Nextflow 24.04.2
  - nf-schema@2.0.0
- updated process containers
  - bcftools 1.20
  - linux 24.04
  - python 3.12.3
- added parameter validation, help, and summary logs
- added samplesheet validation
- updated optional input samplesheet structure. Samplesheet is now a comma-separated values (CSV) file with header (see [Input files](../small_variant_input_files/))
- supported data sources (germline only): 100KGP
- current data release (from which samples are drawn when no samplesheet is supplied): `main-programme/main-programme_v18_2023-12-21`
- configuration profile names changed: cluster -> hpc, cloud -> cloudos

## 3.0.0

*13 June 2024*

- workflow ported to DSL2
- includes pipeline test
- includes modules tests

## 2.0.8

*24 Apr 2024*

*Hotfix*

- paramaterise `project_code`
- update submission script to use `nextflow/22.10.5` module, write LSF log, and nextflow stdout and stderr to `logs/<PID>_smlv*` to more easily find related output

## 2.0.7

*16 Apr 2024*

*Bug Fix*

- revert use of scratch for working directory (`/re_scratch/$USER`)

## 2.0.6

*15 Apr 2024*

- increment default data version to main-programme\_v18\_2023-12-21
- increment module nextflow/22.10.5
- collapse logs in HPC submission
- include pipeline\_info/ timeline, report, trace, and dag
- use scratch as working directory for temp files
- use the users default singularity cache

*Bug Fix*

- correctly count genes in input file without blank line at end of file

## 2.0.5

*6 Oct 2023*

- publish `+fill-tags` and `missing2ref` processed merged files

## 2.0.4

*24 Aug 2023*

- use standalone Nextflow binary

## 2.0.3

*13 Jul 2023 (date of last commit)*

- update s3 locations for data resources

## 2.0.3

*13 Jul 2023 (date of last commit)*

- update s3 locations for data resources

## 2.0.1dev

*30 Jun 2023 (date of last commit)*

- added parameter argument validation
- updated documentation dag

## 2.0

*26 April 2023 (date of last commit)*

- workflow re-written from WDL/Cromwell to Nextflow DSL1
- renamed to Small Variant workflow
- added configuration for both RE (Helix/HPC) and CloudRE (CloudOS)
- implemented dynamic memory/cpus for merge and annotation steps
- updated bcftools to 1.17

## 1.7

*11 Mar 2022 (date of last commit)*

- Containerised all process programs
- Updated VEP version from 99 to 105
- Added CI/CD structure

July 8, 2025
