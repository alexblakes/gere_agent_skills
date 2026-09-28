---
title: 'ONT cancer pilot project - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/cancer_ont/
scraped_at: 2026-05-04T06:31:33Z
---

# ONT cancer pilot project

Genomics England is piloting the use of long-read Oxford Nanopore Technologies (ONT) sequencing for genomic characterisation of cancers. ONT sequencing offers many potential advantages to short-read sequencing, including superior characterisation of structural variants and detection of methylated DNA bases (e.g. 5-methylcytosine).

Nanopore sequencing works by drawing a DNA molecule through a tiny pore embedded in a membrane. A current is applied across the membrane and by measuring small changes to the current, the DNA sequence is established. Modified DNA bases are sufficiently different to their unmodified counterparts that they also introduce characteristic changes to the electric signal and this can be used to determine the modification status of the base.

During phase 1 of the long-reads pilot project, samples from 100 cancer patients from the 100,000 Genomes Project were re-sequenced with ONT. In a first pass, basecalling and alignment was performed. Later on the analysis was repeated to add methylation calls.

The relevant metadata and paths to files can be found in the `cancer_ont_cohorts` LabKey table. The participants belong to one of six cancer types and in the majority of cases both regular BAMs and BAMs with methylation calls (modBAMs/methyl BAMs) are provided:

| Cohort name | Cancer type(s) | Regular BAMs (tumour/normal) | Methyl BAMs (tumour/normal) |
| --- | --- | --- | --- |
| `cohort_CML` | Chronic Myeloid Leukemia | 24/23 | 23/23 |
| `cohort_TALL` | Acute Lymphoblastic Leukemia | 7/7 | 7/7 |
| `cohort_TJ` | Paediatric brain tumours | 9/0 | 9/0 |
| `cohort_TNBC` | Triple Negative Breast Cancer | 43/34 | 30/30 |
| `cohort_neuroendocrine` | Neuroendocrine tumours | 9/8 | 9/8 |
| `cohort_neuroendocrine2` | Neuroendocrine tumours | 10/5 | 5/5 |

## Sequencing information

Data were acquired with the PromethION 48 over 72 hours using R9 chemistry.

## Long-read data files available

The `cancer_ont_cohorts` table contains multiple file paths but some of them are based on short read sequencing data. There are two types of files generated using the ONT long-read data:

- BAM files: Regular BAM files generated with Minimap2 are available for germline and tumour samples. The paths of the files can be found in the `lr_germline_alignment_path` and `lr_merged_tumour_alignment_path` columns and all files are located in cohort-specific subdirectories in `/gel_data_resources/LRS_cohort_genomes/`.
- Modified BAM files: These BAM files contain additional information on the methylation status of CpG motifs. The MM and ML tags contain the position of the relevant bases and the probability of methylation respectively. The files are located in `methyl_bams` subdirectories within the relevant cohort directory and the full paths can be found in the `lr_merged_germline_methylation_path` and `lr_merged_tumour_methylation_path` columns.

## Bioinformatics tools used to generate files

Basecalling was performed with Guppy, the version will vary and can be found in the `cancer_ont_cohorts` Labkey table. The column `guppy_version` refers to the version installed on the PromethION during sequencing while `basecall_version` refers to the version used for basecalling after sequencing.

Modified BAM files with cytosine methylation (5mC only) were generated with Guppy 6.3.8 using the `dna_r9.4.1_450bps_modbases_5mc_cg_hac` configuration. With this config, Guppy generates a probability of methylation for each cytosine in a CpG context, using ONT's Remora methylation model.

> **Note:**
>
> The settings used to generate methyl bam files have not been tested for applications other than methylation analysis. For other applications (eg structural variant calling), the regular bam files provided should be used.

In general, two flowcells of DNA were run for each tumour sample and one for the normal sample. Each flow cell was basecalled individually and resulting bam files were merged with samtools.

The `cancer_ont_cohorts` LabKey table captures the specific tools versions and most important basecalling and alignment parameters, alongside the file paths of the modified BAMs. Note that this table has a single line per participant, and so file paths and parameters specific to the methyl BAMs have the prefix "Methylation". In addition, statistics such as number of reads and aligned base pairs were calculated for the regular bam but may slightly differ for methyl BAMs.

## Quality control checks performed

Samples that failed the following criteria were excluded:

- Flow cell N50 > 5000bps.
- Flow cell total aligned base pairs > 47,000,000,000 (roughly corresponds to 15X coverage).

In addition, regular BAMs but not methyl BAMs were required to meet the following criteria:
- Two passing flow cells per tumour sample.

In addition, methyl BAMs but not regular BAMs were required to meet the following criterion:

- One passing flow cells for normal sample.

## Differences between regular and methyl bam files available in RE

For maximum backwards compatibility, we will maintain both versions of the BAM files in the TRE. However, there are differences in the specific files available and in some cases how they were generated.

- Tumour samples for participants lacking a long-read normal sequence do not have a methyl bam (except for cohort\_TJ).
- The guppy version and parameters used are different and can be found in the `cancer_ont_cohorts` Labkey table.
- In some cases, additional flow cells were run and these have been included in the methyl but not regular bam file.

March 19, 2025
