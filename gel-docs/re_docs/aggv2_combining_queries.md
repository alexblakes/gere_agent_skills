---
title: 'AggV2 code book - combining queries - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/aggv2_combining_queries/
scraped_at: 2026-05-04T06:30:58Z
summary: "Intersect aggV2 genotype VCFs with VEP functional annotation VCFs using bcftools isec to extract samples matching combined genotype and variant filters."
---

# AggV2 code book - combining queries

To extract variants and samples that comply to both a set of genotype and functional annotation filters, you must intersect the genotype VCFs with the functional annotation VCFs in two steps.

An example question would be: "I want to extract the samples in aggV2 who are homozygous alt for missense (or worse) rare variants within the gene *IKZF1*".

`/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/genomic_data`

> **bcftools version:**
>
> Please use bcftools version 1.16 via: `module load bcftools/1.16`

> **Snippets:**
>
> Within each snippet shown below, most lines end with the '\' character. This is not part of the command but a shorthand notation meaning "keep reading the next line as part of a single command." We do this to split each snippet over multiple lines so it is easier to read.

## Step A: Extract variants by functional annotation

The first step is to extract variants in the functional annotation VCF that are missense or worse of the gene of interest. The output is a VCF.gz file called `my_annotation.vcf.gz`.

```
#!/bin/bash

module load bcftools/1.16

bcftools +split-vep -i 'SYMBOL="IKZF1"' \
-c SYMBOL -s worst:missense+ -S additional_data/vep_severity_scale/VEP_severity_scale_2020.txt \
functional_annotation/VEP_109/gel_mainProgramme_aggV2_chr7_48864936_51531027_VEPannot.vcf.gz -Oz -o my_annotation.vcf.gz

# The output VCF.gz must also be tabix indexed
bcftools index -t my_annotation.vcf.gz
```

## Step B: Intersect functional annotation VCF with genotype VCF

The second step is to intersect the variants from the functional annotation filter VCF (`my_annotation.vcf.gz`) with the genotype VCF for the correct chunk. This is done using bcftools *isec* which will match variants in both VCFs by chrom, pos, as well as ref and alt alleles.

Make sure that the genotype VCF is passed in first and the functional annotation VCF passed in second.

The *-i* command specifies inclusion criteria for the genotype VCF - in this case we retrieve homozygous alt genotypes with an allele frequency < 0.05. The *-e-* command specifies that no inclusion/exclusion criteria is needed for the functional annotation VCF. The *-p* option sets the output folder name (called intersect in this case). The *-n=2* option specifies that variants outputted much be present in both files.

We write a VCF.gz file called `0000.vcf.gz` in the intersect folder which will contain rare missense or worse variants in *IKZF1* for which there is at least one sample with a homozygous alt genotype.

```
#!/bin/bash

module load bcftools/16.0

bcftools isec -i 'GT="AA" & INFO/AF<=0.05' \
-e- -p intersect -n=2 -Oz \
/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/genomic_data/gel_mainProgramme_aggV2_chr7_48864936_51531027.vcf.gz my_annotation.vcf.gz
```

## Step C: Process results

We can now process the intersected results to find these samples of interest using bcftools query as shown below. This will print out a tab-delimited file called `my_results.tsv`.

```
#!/bin/bash

module load bcftools/16.0

bcftools query -i 'GT="AA"' -f '[%SAMPLE\t%CHROM\t%POS\t%REF\t%ALT\t%INFO/OLD_MULTIALLELIC\t%INFO/OLD_CLUMPED\t%FILTER\t%GT\n]' 0000.vcf.gz > my_results.tsv
```

**Output:**

```
...
LP1234567-DNA_A01       chr7    50327751        G       T       .       .       PASS    1/1
LP2345678-DNA_B02       chr7    50368157        C       A       .       .       PASS    1/1
LP3456789-DNA_C03       chr7    50400079        G       C       .       .       PASS    1/1
...
```

## Pulling data on a subset of samples

A common query involves wanting to find variants for a subset of participants. The code below takes an input list of samples, pulls data for variants where AC in the subset of samples is greater than one, and finally queries the functional data for these variants. This is done across the genome and submitted as an array job, with 100 permitted to run at a time. This means that all the chunks run in parallel, which is critical for querying the whole aggregate.

The subset of samples must be supplied as a tab-separated, single column file with one platekey per line.

If you wanted to do this for a subset of chunks, then you must change the input file (named bedfile in the script below). Then update the number of array jobs to submit the relevant number of jobs.

```
#!/usr/bin/env bash

#BSUB -q short
#BSUB -P bio
#BSUB -J "pull_functional[1-1371]%100"
#BSUB -o %J_%I.stdout
#BSUB -e %J_%I.stderr
#BSUB -cwd .
#BSUB -n 1
#BSUB -R "rusage[mem=8000]"
#BSUB -M 8000

module purge
module load bcftools/16.0

wd=$(pwd)
mkdir -p ${wd}/logs

#Location of gel data
gelpath="/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/"

#Bedfile with chunknames
bedfile=${gelpath}additional_data/chunk_names/aggV2_chunk_names.bed
sample_list="tst_sample_list"

#Sample list must be tab separated, single column of plate keys, e.g.
#sample1
#sample2

infile=`sed -n "${LSB_JOBINDEX}p" ${bedfile} | awk '{print $(NF-1)}'` #store the name of the vcf we are working on
functional_file=`sed -n "${LSB_JOBINDEX}p" ${bedfile} | awk '{print $(NF)}'` #and the relevant functional data
#If running interactively, the variables infile and functional_file can be assigned the full-path of a chunk directly.

i=`echo $infile | awk -F "_" 'sub(/.vcf.gz/,"",$NF) {print $(NF-2)"_"$(NF-1)"_"$NF}'` #extract the chr_pos_pos

#This code subsets the vcf to samples wanted
#Then filters to variants with AC > 1 in this subset and strips genotype data, outputs to intermediary file
#Intermediary file is indexed
#Intersect with functional data, using exact allele match
#Use split-vep to extract data wanted
bcftools view -S $sample_list $infile | \
bcftools view -G -i 'AC > 0' -Oz -o subset_data_${i}.vcf.gz \
&& bcftools index -t subset_data_${i}.vcf.gz
bcftools isec ${functional_file} subset_data_${i}.vcf.gz -n =2 -w 1 | \
bcftools +split-vep \
-d \
-f '%CHROM\t%POS\t%REF\t%ALT\t%SYMBOL\t%Feature\t%Consequence\t%Existing_variation\n' \
-c SYMBOL,Feature,Consequence,Existing_variation \
-s worst:intergenic+ \
-S ${gelpath}additional_data/vep_severity_scale/VEP_severity_scale_2020.txt \
-o output_${i}.txt

#Cleanup
rm subset_data_${i}.vcf.gz
```

October 24, 2024
