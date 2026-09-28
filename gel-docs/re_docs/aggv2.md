---
title: 'Aggregated Variant Calls (AggV2) - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/aggv2/
scraped_at: 2026-05-04T06:34:20Z
summary: "AggV2 is a 78,195-sample germline WGS multi-sample VCF (722M SNVs/indels, GRCh38) from 100kGP release 10, with QC metrics, ancestry, and functional annotation."
---

# Aggregated Variant Calls (AggV2)

AggV2 is an aggregate of a large number of gVCFs. It was made from release 10 of the 100kGP project and comprises **78,195**Â germline genomes. These were all the consented germline genomes that were aligned to GRCh38 and passed quality control available in release 10.

As part of AggV2, we provide:

- [functional annotation files](../functional_annotation/) for all variants
- [variant](../site_qc/) and [sample](../sample_qc/) quality control (QC) metrics
- inferred [sample relatedness information](../principal_components/)
- [Principal Components](../principal_components/)
- [inferred ancestry](../ancestry_inference/)

> **Note:**
>
> AggV2 contains information on participants who have since withdrawn consent from research. **You cannot use them in any new analyses**. It is **extremely** important to remove these samples from your analyses and only use samples included in the latest data release.
>
> The list of samples for the consented participants can be found in the `aggregate_gvcf_sample_stats` table in [LabKey](../labkey/), for the latest data release, or in the current samples file, located in `/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/docs/`.
>
> To filter the aggregate to these samples, all bcftools commands should include the flag `-S /gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/docs/<nameofcurrentfile>`.
>
> Submit a ticket to the [Genomics England Service desk](https://www.genomicsengland.co.uk/service-desk) if you are unsure of how to filter the dataset for any other use.

## Description

We have aggregatedÂ **78,195**Â germline gVCFs ([genomic VCFs](https://sites.google.com/site/gvcftools/home/about-gvcf)) from the 100,000 Genomes Project which we made available as a multi-sample VCF dataset (aggV2). aggV2 comprises overÂ **722 million**Â annotated single nucleotide variants and small indels (â¤50 bp) from quality controlled rare disease and cancer germline whole genomes.

All samples in the dataset were sequenced with 150bp paired-end reads in a single lane of an Illumina HiSeq X instrument and uniformly processed on the Illumina North Star Version 4 Whole Genome Sequencing Workflow (NSV4, version 2.6.53.23); which comprises the [iSAAC Aligner](https://europepmc.org/article/MED/23736529) (version 03.16.02.19) and [Starling Small Variant Caller](https://europepmc.org/article/MED/23736529)(version 2.4.7). Samples were aligned to the Homo Sapiens NCBI GRCh38 assembly with decoys.Â

The dataset was constructed from the aggregation of single-sample gVCFs using the Illumina software [gVCF genotyper](https://github.com/Illumina/gvcfgenotyper)Â (version:Â 2019.02.26). Variant normalisation and decomposition was implemented byÂ [vt](https://europepmc.org/article/MED/25701572/) (version 0.57721). Genomic annotation and calculation of allele statistics (count, frequency etc.) was performed using [Ensembl VEP](https://www.ensembl.org/info/docs/tools/vep/index.html) and [bcftools](https://samtools.github.io/bcftools/bcftools.html) respectively.Â

TheÂ multi-sample VCF is split into **1,371**Â roughly equal 'chunks' across the genome for faster processing. Each chunk contains the full set of samples and is in the VCF.gz file format with accompanying tabix index files (.tbi). Chromosomes 1-22, X, Y, and M are included.Â

### Extended details

Each step of the pipeline to generate aggV2 is documented in the sections below:Â

- [Sample QC](../sample_qc/)
- [gVCF aggregation](../gvcf_agg/)
- [Variant normalisation and representation](../variant_normalisation/)
- [Site QC, FILTER and INFO Fields](../site_qc/)
- [Functional annotation](../functional_annotation/)

### FAQs and code book

An FAQs section regarding all aggV2 queries can be found here:Â [aggV2 FAQ](../aggv2_faqs/)

A code book of popular queries to help you use aggV2 is found here:Â [aggV2 Code Book](../aggv2_code_book/)

## Manifest

The aggV2 dataset comprises four main parts:Â

1. AÂ multi-sample VCF file for each chunk containing the genotypes and per variant quality metrics and filter flags
2. A corresponding VCF file for each chunk containing the functional (genomic) annotation and allele statistics for all variants
3. The `aggregate_gvcf_sample_stats` table in the current 100kGP LabKey folder which contains all sampleÂ quality metrics and accompanying meta-data
4. Associated files, such as Principal Components across all included samples, information on sample relatedness, and assignment of predicted super-population to each sample. Some of this information is also provided in LabKey, in theÂ `aggregate_gvcf_sample_stats` table mentioned above.

## Location

All aggV2 outputs can be found in the following folder within the Genomics England Research Environment:Â

`/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/`

This folder is accessible from the Desktop Environment and from the HPC as shown below:

Desktop:

HPC:

## Phased data for aggV2

As of 100kGP Data Release v15 we have made phased data available on behalf of Sinan Shi from the University of Oxford. Documentation and details can be found here: [Aggv2 Phased Data (Provided by University of Oxford)](../ox_aggv2/)

## Masked pgen files for aggV2

Further to the multi-sample VCF files for aggV2, we also provide masked pgen files (per chunk and per chromosome) in the following directory:

`/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/genomic_data/pgen_allvariants`

For these files, we masked low-quality genotypes by setting them to missing using the bcftools setGT module: For autosomes, we masked genotypes having DP<10 or genotype quality (GQ)<20 or heterozygote genotypes failing an ABratio binomial test with P-value < 10â3. For chrX, we masked females as for autosomes. We masked male genotypes having DP<5 or GQ<20.

Please note that those files contain all variants, bi-allelic and multiallelic. You can find corresponding files containing only bi-allelic variants in the following directory:

`/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/genomic_data/pgen`

## Help and support

> **Note:**
>
> Please reach out via the [Genomics England Service Desk](https://www.genomicsengland.co.uk/service-desk) for any issues related to the aggV2 aggregation or companion datasets, including "aggV2" in the title/description of your inquiry.

January 19, 2026
