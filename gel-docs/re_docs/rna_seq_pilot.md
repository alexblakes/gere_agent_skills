---
title: 'Transcriptomics data - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/rna_seq_pilot/
scraped_at: 2026-05-04T06:33:49Z
---

# Transcriptomics data - 100kGP Pilot

These are the initial 5,546 samples from 5,546 probands.

## Data available in the Genomics England Research Environment

### DRAGEN output

The data delivered by Illumina from running the DRAGEN RNA Pipeline is available in `/gel_data_resources` with individual deliveries subdivided by delivery dates (see example delivery below). You can generate lists of file paths of interest through the `transcriptome_file_paths_and_types` LabKey table by filtering for specific file type and participants.

Primary folder: `/gel_data_resources/RNASeq_data/Rare_Disease/`

**For each sample** the following output files are available:

```
/gel_data_resources/RNASeq_data/Rare_Disease/DELIVERY_DATE/DELIVERY_ID/
âââ RNA_PLATEKEY
    âââ fastqs
    â   âââ RNA_PLATEKEY_SNN_L001_R1_001.fastq.gz
    â   âââ RNA_PLATEKEY_SNN_L001_R2_001.fastq.gz
    â   âââ ..
    â   âââ ..
    â   âââ RNA_PLATEKEY_SNN_L00N_R1_001.fastq.gz
    â   âââ RNA_PLATEKEY_SNN_L00N_R2_001.fastq.gz
    âââ RNA_PLATEKEY.bam
    âââ RNA_PLATEKEY.bam.bai
    âââ RNA_PLATEKEY.fusion_candidates.final
    âââ RNA_PLATEKEY.quant.genes.sf
    âââ RNA_PLATEKEY.quant.sf
    âââ RNA_PLATEKEY.SJ.out.tab
    âââ md5sum.txt
```

> **Corrupted SJ.out.tab files:**
>
> Due to an error in the Illumina DRAGEN RNA Pipeline v3.8.4, the `RNA_PLATEKEY.SJ.out.tab` files contain incorrect information in the intron motif column. Motifs of type 4, 5 and 6 have been incorrectly assigned to types 1, 2, and 3. The paths to the affected files have been removed from the current data release, but the datasets are still available in the `/RNA_PLATEKEY/` directories. Each `/RNA_PLATEKEY/` directory contains a `README.md` file describing the issue in more detail.

### RNA-Seq QC output

We ran the sample-level RNA sequencing data through an internally developed pipeline, generating quality control metrics across the entire cohort. Evaluation included examining raw read quality, alignment quality, and whole genome DNA-RNA sample matching. Some sample-level output files from the below tools have been aggregated into simple tsv files which have been aggregated together (see below) to allow comparison across the full dataset.

The table below outlines the software employed by the pipeline for generating QC metrics and which output files fed into the aggregated files. FastQC, RNA-SeQC2, RSeQC were used to generate generic quality metrics, whereas Somalier was used to assess the relatedness between WGS and RNASeq data to ensure RNASeq samples matched the expected WGS data.

| Tool | Version | Original output file types |
| --- | --- | --- |
| [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) | 0.11.9 | `summary.txt` |
| [RNA-SeQC 2](https://github.com/getzlab/rnaseqc) | 2.4.2 | `*.bam.metrics.tsv` |
| [RSeQC](https://rseqc.sourceforge.net/) | 5.0.1 | `*.geneBodyCoverage.txt` |
| [Somalier](https://github.com/brentp/somalier) | 0.2.18 | `*.pairs.tsv` `*.samples.tsv` |

Sample-level and aggregated QC files output by the pipeline can be accessed at:

`/gel_data_resources/RNASeq_data/qc_results/main_programme_100kGP/rare_disease_transcriptomics_pilot_dataset/`

Please note that we detected a few outlier values in the RNA-SeQC outputs:

- Two samples have a very high number of "total reads" - note that [RNA-SeQC v2.4.2 actually reports the number of alignments as the "total reads" output](https://github.com/getzlab/rnaseqc/issues/85)
- One sample has all of the RNA-SeQC statistics missing - this sample had a partially corrupted BAM file at one specific location and did not return any RNA-SeQC outputs, however all other programs were able to process that file correctly and therefore the other statistics for that sample are included in our tables

We did include all samples in our release and we encourage you to make your own decisions regarding those samples.

## Help and support

Please reach out via the [Genomics England Service Desk](https://www.genomicsengland.co.uk/service-desk) for any issues related to the RNA-Seq datasets and tables, including "RNASeq" in the title/description of your inquiry.

January 27, 2026
