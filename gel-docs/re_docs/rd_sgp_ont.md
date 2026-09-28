---
title: 'Long-read SGP genomic data - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/rd_sgp_ont/
scraped_at: 2026-05-04T06:33:33Z
---

# Scottish Genomes Partnership (SGP) Rare Disease Long-Read Sequencing Study

The [Scottish Genomes Partnership (SGP)](https://www.scottishgenomespartnership.org/) is a national research initiative aligned with the Genomics England 100,000 Genomes Project, aiming to improve diagnosis for Scottish patients with rare Mendelian disorders.

Initially, short-read sequencing (SRS) of 999 genomes from 394 families was performed, identifying potentially pathogenic SNVs and small indels using Genomics Englandâs gene-panel clinical pipeline. This yielded an overall diagnostic rate of 23%.

To explore whether undiagnosed cases might involve structural variants (SVs) missed by short reads, 24 unresolved families from the SGP cohort underwent whole-genome long-read sequencing (LRS) using Oxford Nanopore Technologies (ONT) platforms and SV analysis. The complete study has been published in a [pre-print](https://www.medrxiv.org/content/10.1101/2025.08.19.25333674v1).

## Sequencing and sample preparation

Sequencing was conducted at Edinburgh Genomics using Oxford Nanopore Technologies (ONT) platforms.

| Platform | Flow Cell | Kit | Model | Samples |
| --- | --- | --- | --- | --- |
| PromethION Beta | R9.4.1 | SQK-LSK109 | V9 ligation | 73 |
| PromethION 24 | R10.4.1 (FLO-PRO114M) | SQK-LSK114 | V14 ligation | 28 (resequenced) + 1 new |

In total, 74 samples were sequenced for the family-based SV study.

## Basecalling and read processing

- Basecalling/Demultiplexing:
  - Guppy v5.1.13+b292f4d (PromethION Beta)
  - Guppy v6.5.7+ca6d6af (PromethION 24)
- QC: Reads <1000 bp, read quality score <9, were discarded and 40 bp and 20 bp were chopped off from start and end of the reads respectively using NanoFilt v2.8.0 and lambda genome reads were removed using NanoLyse v1.2.0.
- Alignment: Reads aligned to GRCh38 using minimap2 v2.23-r1111 with parameters `-x map-ont --MD --secondary=no`.
- Post-processing: BAMs coordinate-sorted and indexed via samtools v1.15.1.
- Merging: Samples sequenced on both flow cell types were merged into a single BAM per individual for variant calling.

## Unmerged BAM files for SNV/Indel calling

Unmerged BAM files have been made available to researchers, as BAM merging is not recommended for SNV/indel variant calling. Variant callers such as Clair3 utilise run-specific machine learning models which vary between flow cell chemistries (e.g., R9.4.1 vs. R10.4.1).

## Structural variant calling and filtering

Multisample SV calling was performed across all 74 SGP LRS samples using Sniffles v2.0.6:

1. snf file generation - Parameters: `--long-del-length 1000000 --long-ins-length 1000000 --long-dup-length 1000000 --minsvlen 50 --tandem-repeats`
2. Joint genotyping: Combined 74 snf files to produce a multisample, fully genotyped VCF.

## Filtering criteria

- Removed SVs overlapping genome gaps (short\_arm, heterochromatin, telomere, contig, scaffold).
- Excluded monomorphic loci, and variants with >90% missing data.
- Excluded sites with mean depth <10 or >56 (to remove artifacts).
- Removed SVs with QUAL <25.
- Retained SVs â¥50 bp (including translocations).

Filtering performed using BCFtools v1.15.1 and bedtools v2.30.0. After performing read depth filtering and other filtering procedures, a total of 60,022 SVs remained across autosomes and sex chromosomes.

## Annotation and frequency analysis

- Annotation: VEP v110.1 used for functional impact prediction.
- SV frequency annotation: SVAFotate v0.1.0 (`-f 0.5 --cov 0 --lim 1000000 -a mis`) annotated population-level allele frequencies using:
  - CCDG
  - gnomAD-SV
  - 1000 Genomes
  - TopMed SVs

> **Ethical edjustment:**
>
> Following multisample VCF generation, one sample was removed due to ethical reasons.
>
> To maintain consistency with the preprint, allele count (AC), allele frequency (AF), and allele number (AN) metrics were retained to reflect the original 74-sample values. This ensured that the metrics remained consistent with those reported in the studyâs preprint version.

## Files available

Aligned BAM files from 73 samples, family specific SV VCFs from 24 families, multi-sample SV VCF file consisting of 73 samples.

> **Note:**
>
> As usual, the associated Labkey table only contains the paths for single-sample and family-level files. The multi-sample SV VCF file can be found in the following folder:  
> `/gel_data_resources/LRS_cohort_genomes/Rare_Disease/SGP2_LRS/Aggregate_VCF/`

## Help and support

Please reach out via the [Genomics England Service Desk](https://www.genomicsengland.co.uk/service-desk) for any issues related to the LRS datasets and tables, including "LRS" in the title/description of your inquiry.

December 4, 2025
