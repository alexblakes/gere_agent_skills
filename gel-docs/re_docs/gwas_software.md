---
title: 'The GWAS pipeline - Software versions - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/gwas_software/
scraped_at: 2026-05-04T06:32:26Z
---

# The GWAS pipeline - Software versions

The pipeline is set up to run on the LSF cluster or AWS cloud.

As of 29 Sep 2022, the following software is used by the pipeline (v1.2) with the respective versions and usage:

| Software | Version | Usage in pipeline |
| --- | --- | --- |
| Nextflow | 21.10.6 | Workflow language |
| Bcftools | 1.11-GCC-8.3.0 | SiteQC directly on VCF files |
| Plink | 1.9b\_4.1-x86\_64 | Two steps of SiteQC on intermediate plink files: 1) Differential missingness filter. 2) HWE filter on controls. |
| Plink2 | 2.00-devel-20200409-x86\_64 | Format transformations between VCF/bgen/plink |
| bgenix | 1.1.7 | Indexing of bgen files |
| singularity | 3.2.1 | Running of all software via container images |
| SAIGE | 1.0.7 | Mixed model association analysis |
| GCTA | 1.93.3beta2 | Mixed model association analysis |

October 24, 2024
