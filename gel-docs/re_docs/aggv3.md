---
title: 'Aggregated Variant Calls (AggV3) - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/aggv3/
scraped_at: 2026-05-04T06:34:22Z
summary: "Multi-sample VCFs of 138,406 germline genomes (100kGP, NHS GMS, Covid-19) built with DRAGEN 3.7.8, split into shards; requires consent-filtering via bcftools `-S` flag."
---

# Aggregated Variant Calls (AggV3)

AggV3 is a set of multi-sample VCFs, bringing together short variants in germline genomes from 100kGP, NHS GMS and Covid-19 participants. AggV3 was prepared with by Illumina DRAGEN's Iterative GVCF Genotyper using genomes aligned using the DRAGEN 3.7.8 pipeline. Due to the size of the data, there are actually multiple VCFs, each representing a segment of the genome, known as "shards" and "subshards".

> **Note:**
>
> AggV3 contains information on participants who have since withdrawn consent from research. **You cannot use them in any new analyses**. It is **extremely** important to remove these samples from your analyses and only use samples included in the latest data release.
>
> The latest updated list of samples for consented participants can be found in an S3 bucket within CloudOS (`s3://512426816668-gel-data-resources/dragen3.7.8/AggV3_resources/samples/consented_individuals/2026-01-23/aggv3_consented_samples.txt`). When working within interactive sessions, you will need to mount this file to your session before you can use it. For batch analysis, you can provide the file as a parameter by clicking the button next to the `paramValue` textbox and navigating to the file within the File Explorer interface.
>
> As AggV3 is a cross-programme dataset, you may need to update the list of consented individuals yourself at a later stage. For the 100,000 Genomes Project and NHS-GMS samples, please refer to the latest data release and filtering the `participant` table for `Consenting` in the `programme_consent_status` column. For the COVID19 participants, the list of samples can be used that are part of the latest available release.
>
> To filter the aggregate to these samples, all bcftools commands should include the flag `-S <path_to_consented_participants_list>`.
>
> Submit a ticket to the [Genomics England Service desk](https://www.genomicsengland.co.uk/service-desk) if you are unsure of how to filter the dataset for any other use.

## What data is in AggV3?

AggV3 was created using a new set of variant calls on samples aligned to GRCh38 using the Illumina DRAGEN 3.7.8 pipeline. These comprise all available realigned samples from the [100,000 Genomes Project release 19](../release19/) (including those which were previously only aligned to GRCh37), [NHS GMS release 4](../gms_release4/) and [Covid-19 release 7](../covid7/), plus seven samples from Genome in a Bottle (GIAB), summarised below:

| Source | Data release | Number of participants |
| --- | --- | --- |
| 100kGP | 19 | 86770 |
| NHS GMS | 4 | 30425 |
| Covid-19 | 7 | 21204 |
| GIAB |  | 7 |
| **Total** |  | 138,406 |

For 100kGP and NHS GMS this includes all available realigned and consented germline genomes for the vast majority of rare disease probands, their family members and cancer participants. For Covid-19, this includes all of the available realigned and consented germline genomes for participants that are part of the mild and severe Covid-19 cohorts.

## How many variant sites are there in AggV3?

| Chromosome | Variant sites | Alleles | SNVs | Small insertions and deletions |
| --- | --- | --- | --- | --- |
| chr1 | 52,135,521 | 64,412,505 | 55,715,547 | 8,696,958 |
| chr2 | 55,095,029 | 66,871,297 | 58,257,976 | 8,613,321 |
| chr3 | 45,277,939 | 54,140,780 | 47,268,995 | 6,871,785 |
| chr4 | 43,541,570 | 51,924,248 | 45,194,377 | 6,729,871 |
| chr5 | 40,512,468 | 48,196,252 | 41,949,891 | 6,246,361 |
| chr6 | 37,774,188 | 44,660,368 | 38,552,985 | 6,107,383 |
| chr7 | 37,437,632 | 45,837,979 | 39,706,602 | 6,131,377 |
| chr8 | 34,891,828 | 41,938,958 | 36,805,125 | 5,133,833 |
| chr9 | 29,854,428 | 37,352,835 | 32,704,293 | 4,648,542 |
| chr10 | 31,134,770 | 38,177,494 | 33,153,036 | 5,024,458 |
| chr11 | 32,601,056 | 41,384,156 | 36,451,508 | 4,932,648 |
| chr12 | 31,043,643 | 39,260,200 | 34,050,700 | 5,209,500 |
| chr13 | 22,816,461 | 28,581,436 | 24,753,579 | 3,827,857 |
| chr14 | 19,698,103 | 23,133,814 | 19,933,320 | 3,200,494 |
| chr15 | 19,487,709 | 23,699,783 | 20,547,505 | 3,152,278 |
| chr16 | 21,047,357 | 26,046,028 | 22,690,983 | 3,355,045 |
| chr17 | 19,004,842 | 23,394,860 | 19,938,680 | 3,456,180 |
| chr18 | 20,133,492 | 26,836,347 | 23,827,328 | 3,009,019 |
| chr19 | 13,480,883 | 16,523,836 | 13,744,960 | 2,778,876 |
| chr20 | 15,292,330 | 19,318,002 | 16,762,801 | 2,555,201 |
| chr21 | 8,621,191 | 10,517,589 | 8,943,165 | 1,574,424 |
| chr22 | 9,079,278 | 11,190,690 | 9,497,913 | 1,692,777 |
| chrX | 27,905,402 | 33,537,294 | 29,235,211 | 4,302,083 |
| chrY | 6,160,144 | 8,054,475 | 7,347,408 | 707,067 |
| chrM | 16,503 | 55,951 | 36,899 | 19,052 |
| chrZ (3341 alt contigs) | 31,265,862 | 52,784,150 | 46,321,867 | 6,462,283 |
| autosomes | 639,961,718 | 783,399,457 | 680,451,269 | 102,948,188 |
| autosomes + chrX | 667,867,120 | 816,936,751 | 709,686,480 | 107,250,271 |
| autosomes + chrX + chrY | 674,027,264 | 824,991,226 | 717,033,888 | 107,957,338 |
| autosomes + chrX + chrY + chrM | 674,043,767 | 825,047,177 | 717,070,787 | 107,976,390 |
| autosomes + chrX + chrY + chrM + chrZ | 705,309,629 | 877,831,327 | 763,392,654 | 114,438,673 |

These counts include non-PASS variants.

## How are the VCFs split up?

To make the data more manageable, we have split the VCFs up by genomic regions. They are first split into 102 shards each around 30Mbp, which are further split into subshards of up to 216,753 variant sites, giving a total of 3,166 subshards.

We provide a [shard lookup tool](../aggv3_shard_lookup/) in these documents to allow you to find the relevant shard for your research, as well as bed files of the shards to allow you to look up the correct shard as part of your analysis.

## How can I access AggV3?

AggV3 is only available on [CloudOS](../cloudos/). You will be able to analyse the data in [Interactive sessions](https://lifebit.atlassian.net/wiki/spaces/CD/pages/813105209/Interactive+sessions) and [Batch analyses](https://lifebit.atlassian.net/wiki/spaces/CD/pages/813040367/Advanced+Analytics) in the CloudOS platform. We provide a [Code Book](../aggv3_code_book/) with example code for accessing genomic and functional analysis data.

To get access to CloudOS, please get in touch with [Service Desk](https://jiraservicedesk.extge.co.uk/plugins/servlet/desk).

## Where can I learn more?

You can get more detail on:

- [The methods used](../aggv3_data_overview/)
- [How to work with the dataset](../aggv3_code_book/)

March 13, 2026
