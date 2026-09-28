---
title: 'somAgg code book - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/somAgg_code_book/
scraped_at: 2026-05-04T06:34:48Z
---

# somAgg code book

This code book provides some sample snippets to help you use somAgg in your analyses.Â These include using BEDtools to find the correct chunk file to use, and using BCFtools to query the aggregate files themselves.

## Overview

The code snippets assume that you are working in the **HPC environmentÂ and that you submit jobs to the cluster**. Please seeÂ [In-Depth Guide to HPC Usage](../hpc/) for more information.

> **Feedback and requests:**
>
> For any feedback and requests to the somAgg code book, or if you encounter issues running one of the examples, please reach out via the [Genomics England Service Desk](https://www.genomicsengland.co.uk/service-desk) including "somAgg" in the title/description of your inquiry.

## Applications

The majority of queries to aggV2 can be implemented using the applications below:Â

| Application | Description |
| --- | --- |
| [bcftools](https://samtools.github.io/bcftools/bcftools.html) | A set of utilities that manipulate variant calls in the Variant Call Format (VCF). Use version 1.16 viaÂ  `module load bcftools/1.16` |
| [split-vep](https://samtools.github.io/bcftools/howtos/plugin.split-vep.html) | A bcftools plug-in to parse VEP annotation (comes with bcftools version 1.16. |
| [LabKey APIs](https://cnfl.extge.co.uk/display/GERE/Using+the+LabKey+API) | The LabKey client libraries (APIs) provide programmatic access to the clinical/phenotype data.Â |
| [R](https://www.r-project.org/) / [Python](https://www.python.org/) | For downstream processing.Â |
| [bedtools](https://bedtools.readthedocs.io/en/latest/) | To intersect, merge, count, complement, and shuffle genomic intervals. Use versionÂ 2.31.0 viaÂ `module load bedtools/2.31.1` |

## Code book structure

We have divided the code book into the following sections:

- [somAgg code book general information](../somAgg_code_book_general/)
- [somAgg code book genotype queries](../somAgg_code_book_genotype/)
- [somAgg code book phenotype queries](../somAgg_code_book_phenotype/)

February 20, 2025
