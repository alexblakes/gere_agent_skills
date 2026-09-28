---
title: 'Cancer analysis - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/cancer_analysis/
scraped_at: 2026-05-04T06:31:27Z
---

# Cancer analysis

The 100kGP `cancer_analysis` table contains one entry for every sequenced tumour sample with results of the Genomics England interpretation pipeline. When the samples have been sequenced and had variants called by the Illumina pipeline Genomics England passes the samples through its interpretation pipeline, which will apply further QC and annotate on the called variants and perform analyses, such as estimating tumour mutation burden and compute mutational signatures.

Samples are uniquely identified by their `tumour_sample_platekey` number, and matched to the information of their germline, as well as disease type, quality control measures, tumour mutational burden (`somatic_coding_variants_per_mb`), signatures and path to bam and vcf files. Note that one participant may have more than one tumour sample, for the same or different tumours.

## TGCA study and histology

Details of histology codes and [TGCA](https://www.cancer.gov/ccg/research/genome-sequencing/tcga) studies are included. Histology codes are taken directly from the [`av_tumour` table](../cancer_clinical/#nhse-ncras-cancer-clinical-data) table, while TGCA studies are deduced based on the `av_tumour` histology codes or, if these are not available, ICD10 codes in [`hes_apc`](../general_clinical/#hospital-episodes-statistics-from-nhse). To help you understand the quality of this information, the difference in dates between `av_tumour` or `hes_apc` and the sampling date is included, along with a `match_rank` code indicating how well these tables match. Details of this analysis are found in [this document](../cancer_analysis_histology/)

## Tumour mutational burden (TMB)

For each tumour sample, TMB is calculated as the total number of non-synonymous small somatic variants divided by the total length of coding sequence (32.61 Mb). Small somatic variants are somatic SNVs and indels smaller than 50 bp. TMB is found on the `somatic_coding_variants_per_mb` column.

## Somatic mutational signatures

Somatic mutational are the consequence of multiple mutational processes that the human body is subjected to throughout life. Each different process generates a unique combination of mutation types that are called [mutation signatures](https://cancer.sanger.ac.uk/cosmic/signatures_v2). Genomics England computes mutational signatures using the R package nnls. For further information on how the signatures are computed, check [Alexandrov *et al*, 2013](https://europepmc.org/article/MED/23318258).

For more information on QC metrics and how variants that are called for the tumour sample, please refer to the [Cancer Analysis Technical Information Document](../further_reading/).

## Small variant annotation

SNVs and small indels were normalised (left aligned, trimmed, multiallelic variants decomposed), annotated using Cellbase with the Ensembl (version 90/GRCh38), COSMIC (version v86/GRCh38) and ClinVar (October 2018 release) databases. CellBase takes advantage of the data integrated in its database to implement a rich and high-performance variant annotator (with 99.9991% concordance with Ensembl VEP Consequence Types across 1000 genomes phase 3 variants). Only variants annotated with the following consequence types in canonical transcripts (see List of canonical transcripts v1.10) are reported:

| SO term | Consequence type |
| --- | --- |
| SO:0001893 | transcript ablation |
| SO:0001574 | splice\_acceptor\_variant |
| SO:0001575 | splice\_donor\_variant |
| SO:0001587 | stop\_gained |
| SO:0001589 | frameshift\_variant |
| SO:0001578 | stop\_lost |
| SO:0002012 | start\_lost |
| SO:0001889 | transcript\_amplification |
| SO:0001821 | inframe\_insertion |
| SO:0001822 | inframe\_deletion |
| SO:0001650 | Inframe\_variant |
| SO:0001583 | missense\_variant |
| SO:0001630 | splice\_region\_variant |

## A note on germline flagged variants

We have observed that in some germline VCFs pathogenic variants have been called, and that these are present in many of the cancer participants. We have provided a list of known germline variants that are filtered out in our own clinical tiering pipelines.

## Location

This information can be found in LabKey under a table called `cancer_analysis` under the quick view tab. `cancer_analysis` connects to other tables via the `participant_id`. If divergences are found between `cancer_analysis` and other tables, the data on the former is the most reliable one, since the interpretation pipeline assures validation.

January 19, 2026
