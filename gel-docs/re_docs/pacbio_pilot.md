---
title: 'PacBio rare disease pilot - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/pacbio_pilot/
scraped_at: 2026-05-04T06:33:06Z
---

# Long-read genomic data from PacBio

This is a dataset of <100 rare disease samples from the 100kGP genome project re-sequenced with Pacific Biosciences (PacBio) as an example dataset to to demonstrate the utility of their [HiFi technology](https://www.pacb.com/technology/hifi-sequencing/).

## Data processing

Samples were sequenced on 2-4 SMRT cells per sample.

Data was [processed by PacBio](https://github.com/PacificBiosciences/pb-human-wgs-workflow-snakemake/blob/6a33aa912a199b3cddf138db590976aab76fb623/Tutorial.md), using a [snakemate workflow](https://github.com/PacificBiosciences/pb-human-wgs-workflow-snakemake/tree/6a33aa912a199b3cddf138db590976aab76fb623).

With software versions:

- pbmm2 v1.9.0
- DeepVariant v1.4
- WhatsHap v1.0
- pbsv v2.8.0
- GLnexus v1.4.1

5mCpG pileups were generated using [PacBio repeat catalogues](https://github.com/PacificBiosciences/trgt/tree/main/repeats).

### Phasing

Phasing is based on small variants in reads rather than parent-proband comparisons. Single nucleotide variants and INDELs are identified with DeepVariant and the reads that contain these variants are classified into haplotype group 1 or 2 based on the occurrence of shared variants using [WhatsHap](https://whatshap.readthedocs.io/en/latest/).

This read based phasing is common in long read datasets, and blocks of phasing can extend for considerable distances provided the reads are long enough to span repetitive genomic regions.

In this pipeline de-novo assembly was additionally performed on using only reads that we classified into one haplotype group or the other.

## Datasets in Genomics England

Data is made available via the table in LabKey `rare_disease_pacbio_pilot`.

### Example of the files and description

| File type | Description |
| --- | --- |
| `*.asm.bp.hap1.p_ctg.fasta.gz` | De-novo assemblies - haplotype1 |
| `*.asm.bp.hap2.p_ctg.fasta.gz` | De-novo assemblies - haplotype2 |
| `*.asm.GRCh38.bam` | Alignment of de-novo assemblies to reference |
| `*.asm.GRCh38.bam.bai` | Alignment of de-novo assemblies to reference - index file |
| `*.GRCh38.combined.denovo.bed` | De-novo assemblies |
| `*.GRCh38.combined.denovo.bw` | De-novo assemblies |
| `*.GRCh38.combined.denovo.mincov10.bed` | De-novo assemblies |
| `*.GRCh38.combined.denovo.mincov10.bw` | De-novo assemblies |
| `*.GRCh38.deepvariant.haplotagged.bam` | Aligned hifi reads, phased on small variants |
| `*.GRCh38.deepvariant.haplotagged.bam.bai` | Aligned hifi reads, phased on small variants - index file |
| `*.GRCh38.deepvariant.phased.vcf.gz` | Phased small variant calls |
| `*.GRCh38.deepvariant.phased.vcf.gz.tbi` | Phased small variant calls - index file |
| `*.GRCh38.hap1.denovo.bed` | De-novo assemblies - haplotype1 |
| `*.GRCh38.hap1.denovo.bw` | De-novo assemblies - haplotype1 |
| `*.GRCh38.hap1.denovo.mincov10.bed` | De-novo assemblies - haplotype1 |
| `*.GRCh38.hap1.denovo.mincov10.bw` | De-novo assemblies - haplotype1 |
| `*.GRCh38.hap2.denovo.bed` | De-novo assemblies - haplotype2 |
| `*.GRCh38.hap2.denovo.bw` | De-novo assemblies - haplotype2 |
| `*.GRCh38.hap2.denovo.mincov10.bed` | De-novo assemblies - haplotype2 |
| `*.GRCh38.hap2.denovo.mincov10.bw` | De-novo assemblies - haplotype2 |
| `*.GRCh38.pbsv.vcf.gz` | Structural variant calls |
| `*.GRCh38.pbsv.vcf.gz.tbi` | Structural variant calls - index file |
| `*.hifi_reads.bam` | Unaligned consensus reads, the output of a single hifi sequencing run |
| `*.hifi_reads.bam` | Unaligned consensus reads, the output of a single hifi sequencing run |
| `*.hifi_reads.bam` | Unaligned consensus reads, the output of a single hifi sequencing run |
| `*.hifi_reads.bam` | Unaligned consensus reads, the output of a single hifi sequencing run |

March 19, 2025
