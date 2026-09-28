---
title: 'AggV3 code book - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/aggv3_code_book/
scraped_at: 2026-05-04T06:34:22Z
summary: "BCFtools and BEDtools code snippets for querying AggV3 genotype, QC, and functional annotation VCF subshards."
---

# AggV3 code book

This code book provides some sample snippets to help you use aggV3 in your analyses. These include using BEDtools to find the correct chunk file to use, and using BCFtools to query the aggregate files themselves. You can use this code interactively in an [interactive session in CloudOS](https://lifebit.atlassian.net/wiki/spaces/CD/pages/813105195/Run+interactive+analysis), [run as a bash script](https://lifebit.atlassian.net/wiki/spaces/CD/pages/1499922433/Run+script+as+Bash+app) or incorporate it into a [nextflow pipeline](https://www.nextflow.io/docs/latest/overview.html) to run as a [batch job](https://lifebit.atlassian.net/wiki/spaces/CD/pages/813040685/Add+new+pipelines+and+tools)..

> **Downstream phenotypic analysis ofNHSGMSsamples:**
>
> NHS GMS phenotypic data is not available in CloudOS. To continue your analysis of NHS GMS participants, you need to [download your list](https://lifebit.atlassian.net/wiki/spaces/CD/pages/1282768899/Use+the+File+explorer) of participants to the Research Environment.

## AggV3 files

AggV3 is split in several ways:

- **VCF purpose:** There are three sets of VCFs for different purposes:
  - Genotype VCFs, containing genotypes for the participants in AggV3 for the variants.
  - Functional annotation VCFs, containing VEP annotation of variants.
  - Quality control VCFs, containing site QC and frequencies of alleles and genotypes.
    You will find Code Books for working with each VCF purpose.
- **[Shards and subshards](../aggv3_data_overview/#sharding):** To make it more manageable, aggV3 comprises 3,166 subshards. This is true for all VCF types, with the chromosome, start, stop and shard names identical across data types. Each VCF purpose has its own BED file, which you can use to identify the s3 filepath of the relevant shard for your analysis
- **[Multi-allelic and bi-allelic VCFs](../aggv3_data_overview/#multiallelic-vs-biallelic):** where variants have more than two alleles, they can be represented with all alleles on one line in multiallelic VCFs, or with each alternative allele on its own line in biallelic VCFs. Both multiallelic and bi-allelic VCFs are available for genotype VCFs, whereas only bi-allelic VCFs are available for functional annotation VCFs and QC VCFs.

## Using the code book

For any query using AggV3, you must start with [identifying the correct subshard](../aggv3_code_book_shards/). You can do this using our [online shard selection tool](../aggv3_shard_lookup/), or using bedtools as [detailed in our guide](../aggv3_code_book_shards/).

We provide further guides for specific tasks:

- [Genotype queries](../aggv3_code_book_genotype/)
- [Querying QC metrics](../aggv3_code_book_qc/)
- [Functional annotation queries](../aggv3_code_book_functional_annotation/)
- [Combining QC and genotype queries](../aggv3_code_book_qc_genotype/)

## Working in CloudOS interactive sessions

When you launch a [CloudOS interactive session](https://lifebit.atlassian.net/wiki/spaces/CD/pages/813105209/Interactive+sessions), you will need to choose your instance configuration. In most cases, we suggest using a [VSCode instance](https://lifebit.atlassian.net/wiki/spaces/CD/pages/1713799198/Run+a+VSCode+session), but if you want to carry out downstream analysis of your query results, you may prefer to use a Jupyter or RStudio instance, which allows you to launch either a Jupyter notebook or an Rstudio session, alongside your terminal.

March 13, 2026
