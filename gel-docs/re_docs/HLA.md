---
title: 'HLA variants - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/HLA/
scraped_at: 2026-05-04T06:30:54Z
summary: "HLA-LA and HIBAG inferred classical HLA types at G-group resolution for class I and II genes."
---

# HLA variants

We have used HLA-LA and HIBAG on samples included in our [aggregated VCF data](../aggv2/) for variant calling on the human leukocyte antigen (HLA) genes.

The human leukocyte antigen (HLA) system is a complex of genes on chromosome 6 encoding cell-surface proteins that regulate the immune system. The HLA genes are highly polymorphic due to their role in fine tuning the adaptive immune system, meaning bespoke tools are needed for accurate variant calling.

You can access the data here:

- `/gel_data_resources/main_programme/hla_type_inference_hla-la`
- `/gel_data_resources/main_programme/hla_type_inference_hibag`

Descriptions of the data above can be found in README files in the respective folders and on this page.

## HLA-LA

HLA-LA (version fe00f82) was used with GRCh38 IMGT population reference graphs to infer classical HLA types at G-group resolution for the three class I genes (A, B, C) and five class II genes (*DQA1*, *DQB1*, *DRB1*, *DPA1*, *DPB1*). HLA-LA implements a graph alignment model for HLA type inference, based on the projection of linear alignments onto a variation graph. Whole-genome sequencing BAM files containing unmapped reads were used as input.

Please note that the imputed/inferred HLA alleles in this folder have not been subject to validation and are provided as-is, with no assurances about the calls quality.

Single sample results can be found using the file manifest: `/gel_data_resources/main_programme/hla_type_inference_hla-la/GRCh38/20230605/hla-la-fe00f82_illumina_nsv4_aggV2_aggregated/aggV2_20230524_hlala_manifest.tsv`

Aggregated results can be found at: `/gel_data_resources/main_programme/hla_type_inference_hla-la/GRCh38/20230605/hla-la-fe00f82_illumina_nsv4_aggV2_aggregated/aggV2_20230524_aggregation_bestguess_hlala.tsv`

## HIBAG

HLA types were imputed at two field (4-digit) resolution for the following loci: *HLA-A*, *HLA-C*, *HLA-B*, *HLA-DRB1*, *HLA-DQA1*, *HLA-DQB1*, and *HLA-DPB1* using the [HIBAG package](http://bioconductor.org/packages/release/bioc/html/HIBAG.html) in R: [hibag1](https://europepmc.org/article/MED/23712092), [hibag2](https://europepmc.org/article/MED/29858808).

We used pre-fit classifiers trained for the [Illumina 1M Duo genotyping array](https://hibag.s3.amazonaws.com/download/HLARES/Illumina1M-European-HLA4-hg19.RData) and [index](https://hibag.s3.amazonaws.com/hlares_index.html).

The pre-fit classifier (European, African or Asian) for each sample was picked on the basis of their inferred genetic ancestry.

HIBAG requires genotyped data in plink format as input. We lifted over the variant calls from aggV2 for the xMHC region to GRCh37, keeping the variants included in the pre-trained classifiers for the seven HLA loci which were present in both the aggv2 and aggCOVID\_v4.2 callsets to ensure that the variants used for the imputation were the same across the two datasets.

The imputations were produced as part of the HLA analysis in the [Kousathanas *et al*. paper in Nature](https://europepmc.org/article/MED/35255492).

The data are provided in a table with a row per participant, with the HLA imputations at each locus at a 4-digit level, followed by the posterior probabilities for each pair of calls. For example, for HLA-A locus, columns HLA\_A\_a1 and HLA\_A\_a2 contain the two calls (imputed alleles) at that locus, and column HLA\_A\_prob contains the posterior probability for that pair of calls. A minimum threshold is typically placed on the posterior probability to increase accuracy prediction at the expense of reducing call rates. A call threshold of 0.5 is used by the authors in their paper and can be considered for your analyses.

Aggregated results can be found at: `/gel_data_resources/main_programme/hla_type_inference_hibag/aggv2_dr17_HIBAG_HLA_imputations.txt`

## Agreement between HLA-LA and HIBAG on Genomics England samples

You may want to only use samples in your analysis where the two sets of calls from HIBAG and HLA-LA agree or run a different inference or imputation method for samples where calls are discordant.

The agreement between the two approaches is >90% for HLA-A, HLA-C, HLA-B and >95% for HLA-DQA1 and HLA-DQB1. The agreement is lower for HLA-DRB1 calls (~82%), where a common mismatch is that of samples called as 04:01 or 07:01 homozygotes by HIBAG but as 04:01-15:13 and 07:01-15:13 respectively by HLA-LA.

October 24, 2024
