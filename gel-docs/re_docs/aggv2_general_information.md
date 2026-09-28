---
title: 'aggV2 code book - general information - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/aggv2_general_information/
scraped_at: 2026-05-04T06:31:01Z
summary: "aggV2 is split into 1371 genomic chunks; use the chunk BED file at `/gel_data_resources/.../aggV2_chunk_names.bed` with bedtools intersect to locate genotype and VEP annotation VCFs for your region."
---

# aggV2 code book - general information

aggV2 is split into **1371** 'chunks' across the genome. To work with aggV2, you need to first identify the correct chunk for your region of interest. You can also use the FILTER, INFO and FORMAT fields for many queries.

## AggV2 chunks

To make it more manageable, aggV2 comprises 1371 chunks. This is true for both the genotype VCFs and the functional annotation VCFs; where the chromosome, start, and stop chunk names are identical across data types.

To analyse the VCF for any particular region, gene or variant, you first need to identify the correct chunk.

Chunks are named in the following format:

**Genotype VCFs:**

`gel_mainProgramme_aggV2_chromosome_start_stop.vcf.gz`  
e.g. `gel_mainProgramme_aggV2_chr1_146620016_147701894.vcf.gz`

**Functional Annotation VCFs:**

`gel_mainProgramme_aggV2_chromosome_start_stop_VEPannot.vcf.gz`  
e.g. `gel_mainProgramme_aggV2_chr1_146620016_147701894_VEPannot.vcf.gz`

### List of chunk names and aggV2 VCF files

The list of chunk names and full file paths to both the genotype and functional annotation VCFs can be found here.

`/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/additional_data/chunk_names/aggV2_chunk_names.bed`

Each of the 1371 chunks is on a separate line and each line contains seven fields:

| Column number | Description | Example |
| --- | --- | --- |
| 1 | Chromosome | chr1 |
| 2 | Chunk start | 1 |
| 3 | Chunk stop | 506426 |
| 4 | Chromosome, start, stop (format 1) | chr1\_1\_506426 |
| 5 | Chromosome, start, stop (format 2) | chr1:1-506426 |
| 6 | Full path to genotype annotation VCF | /gel\_data\_resources/main\_programme/aggregation/aggregate\_gVCF\_strelka/aggV2/genomic\_data/gel\_mainProgramme\_aggV2\_chr1\_1\_506426.vcf.gz |
| 7 | Full path to functional annotation VCF | /gel\_data\_resources/main\_programme/aggregation/aggregate\_gVCF\_strelka/aggV2/functional\_annotation/VEP\_109/gel\_mainProgramme\_aggV2\_chr1\_1\_506426\_VEPannot.vcf.gz |

### Identifying which chunk to use

To find the right chunk file, you will need to:

1. Create a BED file of your regions of interest.
2. Intersect your BED file against the chunk BED file.

#### Create your own BED file

You firstly must create a regions file of your genes, variants or regions of interest. This must be a three or column tab-delimited file of chromosome, start, and stop (with an option fourth column of an identifier - i.e. a gene name). The file should have the .bed extension. There is no limit to how many lines you can have in this file.

> **Sort:**
>
> Please pre-sort your data by chromosome and then by start position (`sort -k1,1 -k2,2n in.bed in.sorted.bed`)

**Example:**

```
chr2    213005363   213151603   IKZF2
chr7    50304716    50405101    IKZF1
```

#### Intersect the two files

Now you can intersect the bed file of chunk names with your regions file using bedtools as shown below:

```
#!/bin/bash

module load bedtools/2.31.0

bedtools intersect -wo -a my_regions.bed -b /gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/additional_data/chunk_names/aggV2_chunk_names.bed | cut -f 1-4,10-11
```

This will print out a six column tab-delimited file with the number of lines equalling the number of inputs in the regions file. It will have the following format:

| Column number | Description | Example |
| --- | --- | --- |
| 1 | Chromosome | `chr2` |
| 2 | Region start | `213005363` |
| 3 | Region stop | `213151603` |
| 4 | Region identifier | `IKZF2` |
| 5 | Full path to genotype annotation VCF | `/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/genomic_data/gel_mainProgramme_aggV2_chr2_211052166_213676386.vcf.gz` |
| 6 | Full path to functional annotation VCF | `/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/functional_annotation/VEP_109/gel_mainProgramme_aggV2_chr2_211052166_213676386_VEPannot.vcf.gz` |

The full array of columns can also be printed by omitting the `cut` command.

## FILTER, INFO and FORMAT fields in aggV2

You can also query aggV2 using the FILTER, INFO and FORMAT tags within the VCFs (both the genotype VCFs and the functional annotation VCFs).

- The FILTER field shows the per variant flag indicating which of a given set of filters the variant has passed or failed (such as median coverage).
- The INFO filed shows the per variant list of key-value pairs describing the variation (such as variant allele frequency and variant median depth).
- The FORMAT field shows and extensible list of fields for describing the samples per variant (such as sample genotype, sample depth).

You can extract all tags per field using the code below which uses bcftools to view the header of a single chunk then extracts the specific field:

```
#!/bin/bash

module load bcftools/1.16

cd /gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/genomic_data

# This command will print out all of the FILTER tags in the VCF
bcftools view -h gel_mainProgramme_aggV2_chr7_48864936_51531027.vcf.gz | grep '#FILTER'

# This command will print out all of the INFO tags in the VCF
bcftools view -h gel_mainProgramme_aggV2_chr7_48864936_51531027.vcf.gz | grep '#INFO'

# This command will print out all of the FORMAT tags in the VCF
bcftools view -h gel_mainProgramme_aggV2_chr7_48864936_51531027.vcf.gz | grep '#FORMAT'
```

August 8, 2025
