---
title: 'COVID-19 data release v7.0 - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/covid7/
scraped_at: 2026-05-04T06:31:54Z
---

# COVID-19 data release v7.0

[Data dictionary](../covid_19_release7_dictionary.xlsx)

This document describes the COVID-19 data release v7.0, which came out on 13th March 2025.

## Description

We currently have COVID-19 V7.0 release single participant data, split in the following cohorts:

| Cohort | Number of participants | Description |
| --- | --- | --- |
| Severe COVID-19 cohort | 8,286 | Participants who had severe COVID. These were all recruited directly by GenOMICC. |
| Mild COVID-19 cohort | 4,779 | Participants who had mild COVID only. These were recruited directly by Genomics England. |
| REACT-GE COVID-19 cohort | 8,293 | Participants recruited directly by Genomics England and added to the GenOMICC cohort. |
| REACT-LC COVID-19 cohort | 1,850 | Participants who were primarily under the age of 35 at recruitment. There may be a few participants outside this age range. They are **not** part of the GenOMICC cohort. |

### Summary

DNA was extracted from whole-blood using EDTA. Libraries were created using the Illumina TruSeq DNA PCR-Free High Throughput Sample Preparation kit and sequenced with 150bp paired-end reads in a single lane of an Illumina HiSeq X instrument (for 100K samples) or NovaSeq instrument (for COVID samples). Alignment and variant calling of small variants was uniformly performed using the Illumina DRAGEN Pipeline (software version 01.011.269.3.2.22 and hardware version 01.011.269). Samples were aligned to the full *Homo sapiens* NCBI GRCh38 assembly including decoys, ALT contigs, and EBV sequences.

All samples are derived from blood, using EDTA as the DNA extraction method, and prepared for sequencing using the Illumina TruSeq DNA PCR-Free High Throughput Sample Preparation kit.

### Delivery QC

We apply the following quality control measures for all genomes as part of the pipeline:

- Intake QC: Verification of a successful delivery from Illumina
- This includes a check that all expected files have been transferred and an md5 confirmation is sent back to Illumina
- Secondary QC: Sequencing data quality
- Confirmation that the genome data meets minimum criteria of 95% of the genome covered at â¥15x calculated from reads with mapping quality > 10 and > 85x109 bases with Q â¥ 30, after removing duplicate reads and overlapping bases after adaptor and quality trimming. These thresholds are applied to alignment performed at illumina using the Isaac aligner.
- Tertiary QC: Additional sample level checks
- Assessment of germline cross-sample contamination is performed using VerifyBamID and sample with Samples with >3% contamination are considered as being of insufficient quality.
- Sex checks to confirm that the sex reported for a participant is concordant with the sex inferred from the genomic data.

### Realignment and Recalling

Sequencing data alignment and variant calling is performed using genome reference GRCh38. Sequencing read alignment to the genome reference including decoy contigs and alternate haplotypes (ALT contigs) is performed using the DRAGEN aligner, with ALT-aware mapping and variant calling to improve specificity.

Each participant has one of the following file type:

- **Alignments** are stored in CRAM files which contain both mapped and unmapped reads.
- **Small variant calling** (single nucleotide variants (SNVs) and indels) are performed using the DRAGEN small variant caller.
- **Copy number variants** (CNVs) are performed using the DRAGEN CNV caller.
- **Short tandem repeat** (STR) expansions are being detected using ExpansionHunter (v2.5.6) as part of the DRAGEN software.
- **Structural variants** (SVs) are being detected using Manta (v1.5).

## Contact and support

For all queries relating to this data release please contact the Genomics England Service Desk portal: [Service Desk](https://www.genomicsengland.co.uk/service-desk) (accessible from outside the Research Environment). The Service Desk is supported by dedicated Genomics England staff for all relevant questions.

January 29, 2026
