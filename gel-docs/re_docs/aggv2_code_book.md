---
title: 'AggV2 code book - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/aggv2_code_book/
scraped_at: 2026-05-04T06:34:21Z
summary: "BEDtools and BCFtools code snippets for querying aggV2 aggregate gVCF chunks on the GEL HPC, with withdrawn-participant filtering guidance."
---

# AggV2 code book

This code book provides some sample snippets to help you use aggV2 in your analyses.Â These include using BEDtools to find the correct chunk file to use, and using BCFtools to query the aggregate files themselves.

> **Note:**
>
> This aggregate dataset contains information on a subset of participants who have since been withdrawn from research. **Their use in any new analyses is not permitted**. Thus, it is **extremely** important to remove these samples from your analyses an ensure that you are only using samples included in the latest data release.
>
> The list of samples for the consented participants can be found in the `aggregate_gvcf_sample_stats` table in the labkey, for the latest data release.
>
> For the main programme version 19 (31st October 2024) data release, the list of consented samples are detailed in the samples file located in the folderÂ /gel\_data\_resources/main\_programme/aggregation/aggregate\_gVCF\_strelka/aggV2/docs/

## Overview

The code snippets assume that you are working in the **HPC environmentÂ and that you submit jobs to the cluster**. Please seeÂ [About the HPC](../hpc/) for more information.

> **Feedback and Requests:**
>
> Please reach out via the [Genomics England Service Desk](https://www.genomicsengland.co.uk/service-desk) for any issues related to the aggV2 aggregation or companion datasets, including "aggV2" in the title/description of your inquiry.

## Applications

The majority of queries to aggV2 can be implemented using the applications below:Â

| Application | Description |
| --- | --- |
| [bcftools](https://samtools.github.io/bcftools/bcftools.html) | A set of utilities that manipulate variant calls in the Variant Call Format (VCF). Use version 1.10.2 viaÂ  `module load bcftools/1.16` |
| [split-vep](https://samtools.github.io/bcftools/howtos/plugin.split-vep.html) | A bcftools plug-in to parse VEP annotation (comes with bcftools version 1.10.2-GCC-8.3.0). |
| [LabKey APIs](https://cnfl.extge.co.uk/display/GERE/Using+the+LabKey+API) | The LabKey client libraries (APIs) provide programmatic access to the clinical/phenotype data.Â |
| [R](https://www.r-project.org/) / [Python](https://www.python.org/) | For downstream processing.Â |
| [bedtools](https://bedtools.readthedocs.io/en/latest/) | To intersect, merge, count, complement, and shuffle genomic intervals. Use versionÂ 2.31.0 viaÂ  `module load bedtools/2.31.0` |

## Test data

We provide test data comprising the header, and first 1000 lines of several chunks for all samples in aggV2. Index (".csi") files are also provided. The data are **not synthetic**, therefore they should be treated with the same considerations as other participant data.

These files should be used for building and prototyping of scripts and workflows as run times are much lower than running on full size aggV2 chunks. The files can be found at:

`/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/additional_data/test_data`

## Code book structure

We have divided the Code Book into the following sections:

- [aggV2 Code Book::General Information](../aggv2_general_information/)
- [aggV2 Code Book::Genotype Queries](../aggv2_genotype_queries/)
- [aggV2 Code Book::Functional Annotation Queries](../aggv2_functional_annotation_queries/)
- [aggV2 Code Book::Phenotype Queries](../aggv2_phenotype_queries/)
- [aggV2 Code Book::Combining Queries](../aggv2_combining_queries/)

October 24, 2024
