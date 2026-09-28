---
title: 'Using pre-built workflows to find participants by genotypes - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/workflows_genotypes/
scraped_at: 2026-05-04T06:34:17Z
---

# Using pre-built workflows to find participants by genotypes

[Give us feedback on this tutorial](https://www.smartsurvey.co.uk/s/UFIZGB/)

We have two workflows available that allow you to find all variants in a gene and all participants with those variants:

- [Small Variant workflow](../small_variant/)
- [Structural Variant workflow](../structural_variant/)

For both workflows you need to create a list of genes of interest. You can easily copy the workflows into your personal folders, change parameters in the submission script to access your gene list and use the correct submission code then run the workflows on the HPC. As output you will retrieve `tsv` files for each gene in your list, including all variants found within those genes, full annotation of consequences and platekeys of participants with those variants.

Both workflows will query genomes mapped to GRCh37 and GRCh38 for your genes of interest.

> **Note:**
>
> NHS GMS data is not currently accessible with either the Small Variant or Structural Variant workflows.

## CloudOS

The [Small Variant workflow](../small_variant/) can also be run as a CloudOS [batch session](https://lifebit.atlassian.net/wiki/spaces/CD/pages/813040723/Run+a+pipeline).

March 26, 2026
