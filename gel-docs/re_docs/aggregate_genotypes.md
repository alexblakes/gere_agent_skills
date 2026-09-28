---
title: 'Querying aggregate VCF files to find participants by genotypes - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/aggregate_genotypes/
scraped_at: 2026-05-04T06:30:57Z
summary: "Use `bedtools` to find the correct AggV2/somAgg chunk, then query with `bcftools` to extract per-sample genotypes at specific loci."
---

# Querying aggregate VCF files to find participants by genotypes

[Give us feedback on this tutorial](https://www.smartsurvey.co.uk/s/UQLCWN/)

The aggregate VCFs, [AggV2 for germline variants](../aggv2/) and [somAgg for somatic variants](../somAgg/), are aggregates of gVCF files. You can query these aggregates for genomic loci.

## Identifying the correct chunk

As these aggregrates are split into 1371 chunks, all queries for loci must begin by identifying the correct chunk in [AggV2](../aggv2_general_information/#identifying-which-chunk-to-use) or [somAgg](../somAgg_code_book_general/#identifying-which-chunk-to-use).

There are BED files listing all the chunks, allowing you to use `bedtools` to intersect against your own BED files. Create a BED file listing your genomic loci of interest, for example:

`chr2 213006985 213006985 variant`

You can then intersect against the AggV2 or somAgg chunk bed files:

AggV2

```
module load bedtools/2.31.0

bedtools intersect -wo -a my_regions.bed -b /gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/additional_data/chunk_names/aggV2_chunk_names.bed | cut -f 1-4,10-11
```

somAgg

```
module load bedtools/2.31.0

bedtools intersect -wo -a my_regions.bed -b /gel_data_resources/main_programme/aggregation/aggregated_somatic_strelka/somAgg/v0.2/additional_data/chunk_names/somAgg_chunk_names.bed | cut -f 1-4,10-11
```

This will give you a tsv file listing the correct chunk to use, for example:

AggV2

```
chr2 213006985 213006985 variant /gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/genomic_data/gel_mainProgramme_aggV2_chr2_211052166_213676386.vcf.gz /gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/functional_annotation/VEP_109/gel_mainProgramme_aggV2_chr2_211052166_213676386_VEPannot.vcf.gz
```

SomAgg

```
chr2 213006985 213006985 variant /gel_data_resources/main_programme/aggregation/aggregated_somatic_strelka/somAgg/v0.2/genomic_data/somAgg_dr12_chr2_211052166_213676386.vcf.gz
```

## Query the VCF

You can then use bcftools to query for your loci in [AggV2](../aggv2_genotype_queries/) or [somAgg](../somAgg_code_book_genotype/).

AggV2

```
module load bcftools/1.16

bcftools query -r chr2:213006985 \
-f '[%SAMPLE\t%CHROM\t%POS\t%REF\t%ALT\t%INFO/OLD_MULTIALLELIC\t%INFO/OLD_CLUMPED\t%FILTER\t%GT\n]' \
/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/genomic_data/gel_mainProgramme_aggV2_chr2_211052166_213676386.vcf.gz > variant_genotypes.tsv
```

somAgg

```
module load bcftools/1.16

bcftools query -r chr2:213006985 \
-f '[%SAMPLE\t%CHROM\t%POS\t%REF\t%ALT\t%INFO/OLD_MULTIALLELIC\t%INFO/OLD_CLUMPED\t%FILTER\t%GT\n]' \
/gel_data_resources/main_programme/aggregation/aggregated_somatic_strelka/somAgg/v0.2/
/genomic_data/somAgg_dr12_chr2_211052166_213676386.vcf.gz > somatic_variant_genotypes.tsv
```

This will give an output like:

```
LP1234567-DNA_A01       chr2    213006985        G       A       .       .       PASS    0/0
LP2345678-DNA_B02       chr2    213006985        G       A       .       .       PASS    0/1
LP3456789-DNA_C03       chr2    213006985        G       A       .       .       PASS    1/1
LP4567890-DNA_D04       chr2    213006985        G       A       .       .       PASS    0/0
LP5678901-DNA_E05       chr2    213006985        G       A       .       .       PASS    0/1
LP6789012-DNA_F06       chr2    213006985        G       A       .       .       PASS    0/0
```

> **Note:**
>
> AggV2 was created in [release 8](../release8/) and completed in [release 10](../release10/), whereas somAgg was created in [release 12](../release12/). This means that neither contain participants who were added to the dataset after those releases and both include some participants who have since withdrawn consent. This means that you should always cross reference any results against the current release to ensure there are no participants in your results who are no longer consented.
>
> Both aggregates only contain genomes that were aligned to GRCh38.

October 24, 2024
