---
title: 'AggV2 gVCF Aggregation - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/gvcf_agg/
scraped_at: 2026-05-04T06:32:23Z
---

# AggV2 gVCF Aggregation

Single sample gVCFs were aggregated usingÂ [gvcfgenotyper](https://github.com/Illumina/gvcfgenotyper) (Illumina, version:Â 2019.02.26), with post processing with [bcftools](https://github.com/samtools/bcftools) and [vt](https://genome.sph.umich.edu/wiki/Vt) to create the multi-sample VCF of 78,195 samples. The aggregation workflow itself was written in the [WDL language](https://github.com/openwdl/wdl/blob/master/versions/1.0/SPEC.md) and executed using [Cromwell](https://cromwell.readthedocs.io/).Â

The samples included in the aggregate can be found in the LabKey table `aggregate_gvcf_sample_stats`.Â

## Genome chunks

The genome was split up into **1,371** genomic regions or 'chunks' by physical position, to process the aggregation in parallel and to ensure that the resulting output files are not so large as to make them unworkable. These chunks were determined by investigating the number of variants per chunk in aggV1 (the previous gVCF aggregation). Doing so resulted in 1,371 chunks that were comparable in size and number of variants. AllÂ 78,195 samples are in each chunk.Â

> **Chunk names:**
>
> Chunks are named in the following format:Â *gel\_mainProgramme\_aggV2***chromosome*****start*****stop**.vcf.gz\_
>
> For example: *gel\_mainProgramme\_aggV2***chr1*****146620016*****147701894**.vcf.gz\_

## gVCF aggregation workflow overview

A schematic of the aggregation process is presented in the diagram below.Â

### Split by genome region

The genome was split into 1,371 regions so that each region can be processed in parallel.

### Split input into batches

The input file list, containing the locations of all single sample gVCF files to be included, was split into batches of 1,000 samples. This was determined to be the optimal size in terms of resource usage and compute speed for this run. Each batch of 1,000 samples was used in every region.

### First joint aggregation

In this step, each batch of 1,000 samples is aggregated, and all the unique variants (in terms of chromosome, position, reference, and alternative alleles) for each batch are included in the output. This ensures that we capture every variant site in the cohort.

### Merge consensus sites (synchronisation step)

The outputs of the first joint aggregation are merged to provide a final list of variants per genome region.

When splitting the input samples into batches, there will be variants in oneÂ batch that are not present in any other. The final output would therefore only contain the genotypes from the subset of the batch where it was found. The variant for all other genotypes would be set to missing, whereas most other samples will in truth carry the reference allele.Â The synchronisation step ensures that all variants are included for all samples, instead of only in the batch where the variant was found.

### Second joint aggregation

Each batch of 1,000 samples is aggregated with gvcfgenotyper, and the list of variants from the **Merge consensus sites** step is used to force genotype each batch. This ensures that all variants are genotyped in all samples.

### Merge regions

All batches of 1,000 samples per genomic region are merged with bcftools into a single VCF.GZ file per genomic region, resulting in a single VCF.GZ file with 78,195 samples per genomic region.

### Normalise regions

The output of **Merge regions** is a VCF.gz file that contains unnormalised variants represented in their multiallelic format; where one variant can have many ALT alleles. We use the softwareÂ [vt](https://genome.sph.umich.edu/wiki/Vt)Â to normalise and decompose all variants so that they are represented in their normalised bi-allelic format. Please see theÂ [Variant Normalisation](../variant_normalisation/)Â page for full details.Â

## Help and support

> **Note:**
>
> Please reach out via the [Genomics England Service Desk](https://www.genomicsengland.co.uk/service-desk) for any issues related to the aggV2 aggregation or companion datasets, including "aggV2" in the title/description of your inquiry.

January 19, 2026
