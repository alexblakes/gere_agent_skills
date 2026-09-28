---
title: 'AggV2 Principal Components and genetically inferred relatedness - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/principal_components/
scraped_at: 2026-05-04T06:33:11Z
---

# AggV2 Principal Components and genetically inferred relatedness

Using the multi-sample VCFs from aggV2, we have generated Principal Components (PCs) for participants in aggV2 and calculated pairwise relatedness amongst samples. Results from these analyses can be found as flatfiles in the RE and in the `aggregate_gvcf_sample_stats` table in LabKey.

## Generation of high confidence independent SNPs

We generated a set of 195,829 of high confidence LD-pruned biallelic SNPs to be used on all downstream analyses. The SNPs were selected based on the following criteria:

1. Include autosomal, bi-allelic SNPs only
2. Keep variants which are common (MAF>1%) in both aggV2 and the 1KGP3Â
3. Missingness < 1%
4. Median GQ â¥ 30
5. Median DepthÂ  â¥ 30
6. AB Ratio â¥Â  0.9
7. Completeness â¥ 0.9
8. Exclude variants in complex regions, as defined in the ['high LD exclusion regions' file](../aggv2_file_manifest/)Â
9. Remove all SNPs where the ref/alt combination was AT or GC (A/T, T/A, G/C, C/G), to avoid ambiguous allele swaps
10. LD prune using plink version v1.9 with an r2Â  0.1, 500kb window
11. Remove all SNPs which are out of Hardy Weinberg Equilibrium (HWE) in any of the `afr`, `eas`, `eur` or `sas` super-populations, with a p-value cutoff ofÂ pHWE < 1e-5

More information on the above filters can be found in the INFO field section of theÂ [Site QC, FILTER and INFO Fields](../site_qc/)Â page. For the final step, we used a set of 30k high confidence SNPs derived from our aggV1, we [inferred ancestry](../ancestry_inference/) for our aggV2 participants based on this set of SNPs, and filtered for SNPs with a pHWE > 1e-5 in each of the `afr`, `eas`, `eur` or `sas` super-populations. An overview of this process can be found in on theÂ [Site QC, FILTER and INFO Fields](../site_qc/)Â page.

The 1KGP3 files used for the intersection with our aggV2 dataset are located at:

`/public_data_resources/1000-genomes/20130502_GRCh38/*.vcf.gz`

We provide two sets of high-confidence independent SNPs, with a MAF cut-off of 5%, and a MAF cut-off of 1%. These sets comprise 63,523 and 127,747 SNPs respectively. Both sets of high confidence sites can be found in binary plink file format at:Â

`/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/additional_data/HQ_SNPs`

## PCs - aggV2 participants

We run PCA as implemented in GCTA versionÂ 1.92.4 using the 63,523 high confidence SNPs with MAF>5%. We calculated PCs based on the set ofÂ 55,603 unrelated individuals. Members of the unrelated set are defined in theÂ `aggregate_gvcf_sample_stats` LabKey table (value of 1). We then projected the remainingÂ 22,592 related individuals onto these PCs with GCTA.

The first 20 PCs are provided in theÂ `aggregate_gvcf_sample_stats` LabKey table. The first 50 PCs are also provided in the following directory:

`/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/additional_data/PCs_relatedness/PCA/GEL_PCs`

## Relatedness inference

Using these SNPs, we generated a pairwise kinship matrix using the [PLINK2 implementation](https://www.cog-genomics.org/plink/2.0/distance) of the [KING-Robust algorithm](https://europepmc.org/article/MED/20926424).Â

These were then partitioned into related (up to, and including third degree relationships) and unrelated sample lists using the PLINK2 `--king-cutoff` relationship-pruning algorithm, with a threshold of 0.0442.Â

The kinship matrix, along with the list of related and unrelated samples, can be found in:

`/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/additional_data/PCs_relatedness/relatedness`

This folder contains the following files:

```
#Kinship coefficients in KING table (wide) format for pairwise relationships with kinship coefficient â¥ 0.0442
GEL_aggV2_MAF5_mp10_0.0442.kin0

#Full kinship matrix of all aggV2 pairs in plink triangular binary format
GEL_aggV2_MAF5_mp10.king.bin
GEL_aggV2_MAF5_mp10.king.id

#Lists of unrelated and related individuals
GEL_aggV2_MAF5_mp10.king.cutoff.unrelated.id
GEL_aggV2_MAF5_mp10.king.cutoff.related.id
```

## aggV2 PC plots

Below we show the first four PCs, derived from PCA on the aggV2 samples.Â The graphs show, from top to bottom - samples coloured by their [inferred super-population](../ancestry_inference/) (using a threshold of T=0.8), self-reported ancestries (as found in LabKey), and 'best-guess' ancestry based on their inferred super-population. Finally, we show the percentage of variance explained by the first ten PCs.

## Help and support

> **Note:**
>
> Please reach out via the [Genomics England Service Desk](https://www.genomicsengland.co.uk/service-desk) for any issues related to the aggV2 aggregation or companion datasets, including "aggV2" in the title/description of your inquiry.

October 24, 2024
