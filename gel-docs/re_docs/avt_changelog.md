---
title: 'The Aggregrate Variant Testing workflow changelog - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/avt_changelog/
scraped_at: 2026-05-04T06:31:18Z
---

# CHANGELOG

> **Note:**
>
> Please always use the latest available version, unless explicitly instructed otherwise - older major version may still be available in the RE but **will not be supported** by our team, and older minor versions may not be fully supported.

## [v4.2.0](../avt/)

*December 2024*

- The sparse GRM for the SAIGE branch now includes all available common variants (plus a sub-sample of the others, as before)
- The default gene list in gene\_mode and chr\_mode is now the Ensembl protein-coding gene list

## v4.1.4

*November 2024*

- Fixed issue with custom gene list in gene\_mode
- Enabled protein coding option
- Fixed exclusion data input file

## v4.1.3

*November 2024*

- Updated default input pgen dataset to use all variants (bi-allelic + multiallelic)

## v4.1.2

*October 2024*

- Fixed bug in user-specified parameter for RVtests options
- Enabled the use of no covariates for SAIGE-GENE, REGENIE
- Updated containers (security, and program versions: SAIGE-GENE v1.3.6, REGENIE v3.4.1, *unchanged* RVtests v2.1.0, see the [parameters page](../avt_parameters/))

## v4.1.1

*September 2024*

- Fixed bug in handling of duplicate variants on different genes for SAIGE-GENE and REGENIE

## v4.1.0

*September 2024*

- Enabled use of arbitrary input aggregate variant datasets

## v4.0.2

*August 2024*

- Fixed minor bugs in input validation and filtering

## v4.0.1

*August 2024*

- Improved memory handling in a few processes
  - CONVERT\_PGEN\_TO\_BED
  - CREATE\_MASK\_LIST

## v4.0.0

*July 2024*

- Re-designed and ported to Nextflow DSL2
- Included nf-test module and pipeline tests
- Updated all process containers
  - PLINK v1.90b7.2, v2.00a6LM
  - SAIGE-GENE v1.3.0
  - regenie v3.3
  - Rvtests v2.1.0

---

## [v3.1](../avt3/)

### New features

This release adds Rvtests as an additional method for running rave variant tests. Note that it is implemented following the method described in [Nature](https://europepmc.org/article/MED/34375979), so not all the functionality of Rvtests is available. In particular, this implementation of Rvtests does not use covariates.

### Bugfixes

Fixed a bug where, during functional annotation filtering, variant consequence was not being taken into account if you were also filtering on an annotation (e.g. gnomAD frequency) and also allowing the inclusion of variants where that annotation was missing. This lead to more variants passing the filter than expected.

Made improvements to the phenotype file processing, so now phenotype files with multiple blank lines at the end no longer cause workflow issues.

### Notes

This version includes new options in the inputs.json file, therefore you will be unable to reuse the inputs.json file from version 3.

## v3.0

Major update and reworking of the entire pipeline. Please see the v3.x documentation page for an overview of all the new features. The below list is just a few highlights.

### New features

Now takes either BGEN or PGEN files as input for genomic data, instead of VCF (annotation input unchanged).

Can now run on any number of phenotypes, as long as all are defined in your phenotype file.

Functional filtering updated to be more flexible, now allows for AND and OR filtering in the same run.

Includes Regenie as an additional program for burden testing.

## v2.3.1

### Bugfixes

Minor updates to the options file.

### New features

New functional annotation files (produced using VEP v99 in July 2021) are now used by default.

## v2.3

### Bugfixes

Fixed the options file, so that now a task job that fails while running (transient job failures, as opposed to jobs executing fully but exiting with an error code) will be run again up to 5 times before stopping the workflow.

### New features

MIT-style license attached.

## v2.2

### Bugfixes

Fixed a bug in differential missingness checks when processing indels.

Empty output is now allowed and does not crash the workflow.

### New features

The workflow is now tested for biallelic indels, too.

New memory and queue requirements make it easier to run on large cohorts with default settings.

## v2.1

### Bugfixes

Changed the default memory value for task create\_regions\_files, which was causing the workflow to crash on large cohorts.

Changed the declaration type of the memory value in the config file from Float to Int, to avoid issues with LSF flags on the HPC.

### New features

New input options make it more clear how to run the workflow using a pre-computed GRM.

A new filter for differential missingness is added to the GRM creation step.

There is a new output file with counts of variants in each MAC category used.

## v2.0.1

### Bugfixes

During the VEP functional annotation filtering step, if the empty string is provided as the value for variable "vep\_severity\_to\_include" then all variants are accepted - this is the same behaviour that " bcftools +split-vep -s worst: " has.

Only autosomes are used to create the GRM for SAIGE-GENE, because some of the chrX files occasionally gave errors similar to [reported bugs in indexing of sex chromosomes](https://github.com/samtools/bcftools/issues/1154).

### New features

You can now use chrX with both the "aggV2" and the "aggV2\_PASS\_UTRplus\_proteincodinggenes" input variant datasets.

## v2.0

### Bugfixes

In case of gene-based input, i.e. "chromosome" file or "gene" file, during the VEP functional annotation filtering step, for each gene all variants are now included or excluded according to the "worst" Consequence on any transcript for that gene. In case or coordinate-based inputs, the "worst" Consequence at each location will be selected, as in previous behaviour. In case of "groups" input, the VEP functional annotation filtering step is skipped.

Input genes, groups, or coordinate blocks that are split across more than one "chunk" of the input variant dataset are now processed as a whole, after the "chunks" are resized appropriately. Therefore, output results do not have a "\_\_chunkXXXX" specification appended to each gene/group/coordinate-block name any more.

### New features

You can now also specify inputs as SAIGE-GENE-like "groups" of variants.

Differential missingness filters have been introduced.

The GRM used by SAIGE-GENE can now be created very quickly by specifying the relevant plink files as an input.

You can choose to use the full "aggV2", or the much smaller "aggV2\_PASS\_UTRplus\_proteincodinggenes", as an input variant dataset.

## v1.0

First release - working by coordinate, i.e. following the boundaries of the input variant dataset's chunks strictly.

January 19, 2026
