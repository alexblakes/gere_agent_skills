---
title: 'AggGIAB: A small aggregate with public data to test your workflows - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/aggv3_agg_giab/
scraped_at: 2026-05-04T06:31:03Z
summary: "Seven-sample GIAB aggregate (AggGIAB) at `s3://512426816668-gel-data-resources/dragen3.7.8/AggGIAB_resources/` for testing workflows against AggV3-format VCF/PGEN data."
---

# AggGIAB: A small aggregate with public data to test your workflows

Within our aggregate dataset, we have integrated seven Genome-in-a-Bottle (GIAB) samples to allow you to validation against other aggregated resources. Additionally, there is a separate aggregate containing only these seven GIAB samples, which you can use to explore the data format and test workflows on a smaller scale. This GIAB-specific set has been processed through the same pipeline as our main aggregate dataset.

## Sample composition

The following samples are included in the aggregated GIAB dataset.

| Sample ID | Sex | Sex (desc) | Family | Type |
| --- | --- | --- | --- | --- |
| HG001 | 2 | Female | AJ1278 | Singleton |
| HG002 | 1 | Male | AJ Trio | offspring/proband |
| HG003 | 1 | Male | AJ Trio | father |
| HG004 | 2 | Female | AJ Trio | mother |
| HG005 | 1 | Male | CHN Trio | offspring/proband |
| HG006 | 1 | Male | CHN Trio | father |
| HG007 | 2 | Female | CHN Trio | mother |

## Location and data format

In terms of format and folder layout, it is effectively identical to our [main aggregate dataset](../aggv3/).

Tables listing the genomic regions and corresponding VCF and PGEN file paths are available at `s3://512426816668-gel-data-resources/dragen3.7.8/AggGIAB_resources/manifests/genomic_data/`.

## Differences between AggGIAB and AggV3

While AggGIAB is a good representative aggregate dataset to AggV3, there are some minor differences in its file composition:

1. Due to the size of AggV3, each of the shards was further subsharded. However, because AggGIAB only consists of seven samples, each shard only consists of one subshard. The number of total shards remains the same between AggGIAB and AggV3 (n = 102).
2. Due to the smaller file size of AggGIAB, there is actually a concatenated chromosome-level multiallelic msVCF. But as this does not exist for AggV3, we do not recommend using this file for developing your pipelines. For any work that your pipeline may need to do on the multiallelic msVCFs, we recommend you to work on the subshard-level msVCFs so it takes into account the shard boundaries.

| Type | Region-type | Name | AggGIAB | AggV3 |
| --- | --- | --- | --- | --- |
| biallelic msVCF | Subshard-level | `dragen.vcf.gz` | Yes | Yes |
| multiallelic msVCF | Subshard-level | `dragen.vcf.gz` | Yes | Yes |
| biallelic site VCF | Subshard-level | `dragen.sites.vcf.gz` | Yes | Yes |
| multiallelic site VCF | Subshard-level | `dragen.sites.vcf.gz` | Yes | Yes |
| biallelic msVCF | Chromosome-level | `dragen.vcf.gz` | Yes | Yes |
| multiallelic msVCF | Chromosome-level | `dragen.vcf.gz` | Yes | No |
| biallelic site VCF | Chromosome-level | `dragen.sites.vcf.gz` | Yes | Yes |
| multiallelic site VCF | Chromosome-level | `dragen.sites.vcf.gz` | Yes | Yes |
| biallelic PGEN files | Subshard-level | `dragen.pgen`, `dragen.psam`, `dragen.pvar` | Yes | Yes |
| biallelic PGEN files | Chromosome-level | `dragen.pgen`, `dragen.psam`, `dragen.pvar` | Yes | Yes |
| multiallelic PGEN files | Subshard-level | `dragen.pgen`, `dragen.psam`, `dragen.pvar` | Yes | Yes |
| multiallelic PGEN files | Chromosome-level | `dragen.pgen`, `dragen.psam`, `dragen.pvar` | Yes | Yes |

March 13, 2026
