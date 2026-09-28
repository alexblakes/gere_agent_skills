---
title: 'ONT rare disease pilot project - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/rd_ont/
scraped_at: 2026-05-04T06:33:32Z
---

# ONT rare disease pilot project

Genomics England have sequenced 315 rare disease participants with ONT and have generated structural variant calls. The relevant metadata and paths to files can be found in the `rare_disease_ont_cohorts` LabKey table.

The participants are grouped in four cohorts and in one of them (`cohort_pacbio_pilot`) some participants were sequenced more than once using different flow cells:

| Cohort name | Cohort description | Number of sequencing runs | Number of participants | Number of families |
| --- | --- | --- | --- | --- |
| `cohort_CHD` | Long read sequencing in familial and syndromic congenital heart disease | 92 | 92 | 47 |
| `cohort_eye` | Long read sequencing of rare retinal dystrophies | 102 | 102 | 99 |
| `cohort_pacbio_pilot` | Participants selected for [PacBio sequencing](../pacbio_pilot/) and with available DNA were sequenced with ONT to enable comparison of different long-read technologies for diagnostic potential. Therefore, the participants in this cohort also appear in the `rare_disease_pacbio_pilot` table. | 128 | 85 | 55 |
| `cohort_repeat_neuro` | Long read sequencing of familial neurological and neurodegenerative disorders | 36 | 36 | 33 |

## Sequencing information

Sequencing was performed on Oxford Nanopore PromethION 48, using either R9 or R10 flow cells and 4kHz sampling rates. Flow cell types can be found in the `flow_cell_product_code` column in LabKey:

- `FLO-PRO002`: R9 flow cell chemistry
- `FLO-PRO114M`: R10 flow cell chemistry

## Bioinformatics tools used to generate files

Base calling was performed with Guppy, using a qscore filter of 7 and either the `dna_r9.4.1_450bps_hac_prom` or `dna_r10.4.1_e8.2_400bps_hac_prom` model, depending on flow cell chemistry. Guppy version and base calling models can be found in the `basecall_version` and `basecall_model` columns of the Labkey table.

Base called data passing the qscore filter was processed through the GEL R&D long-read pipeline v2.5-2.8 (exact version available in the `pipeline_version` column). Updates between these pipeline versions are purely operational, each version performs alignment to reference genome `GCA_000001405.15_GRCh38_no_alt_analysis_set.fa` (available in the RE as `/public_data_resources/reference/GRCh38/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna`), and structural variant calling with the following software:

- Minimap2: 2.24-r1122
- Sniffles2: 2.0.6

## Quality control checks performed

Sequencing QC values were assigned based on the following criteria:

- `PASS`: Aligned read length N50 >= 5000bps & Total aligned base pairs >= 47,000,000,000 (roughly corresponds to 15X coverage).
- `Low_yield`: Total aligned base pairs < 47,000,000,000 (roughly corresponds to 15X coverage).
- `Low_N50`: Aligned read length N50 < 5000bps.

All data is available regardless of their QC value but data sets flagged as `low_yield` or `Low_N50` may not be optimal for variant calling.

March 19, 2025
