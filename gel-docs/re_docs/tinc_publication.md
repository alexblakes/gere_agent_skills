---
title: 'Tumour in Normal Contamination publication - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/tinc_publication/
scraped_at: 2026-05-04T06:34:08Z
---

# Clinical application of tumour in normal contamination assessment from whole genome sequencing

This page describes the resource methods that accompany the Nature Communications paper "Clinical application of tumour in normal contamination assessment from whole genome sequencing" Mitchell *et al* 2023.

A selection of supplementary materials are available online (see below Online Supplementary Materials). However, most of the data is located within the [Research Environment](https://www.genomicsengland.co.uk/research), Genomics England's secure workspace.

To access genomic and clinical data within this workspace, you must apply to become a member of the Genomics England Research Network in [academia](https://www.genomicsengland.co.uk/research/academic) or in [industry](https://www.genomicsengland.co.uk/research/research-environment).

The process for joining the Research Network consists of the following steps:

- Your institution will need to [sign a participation agreement](https://files.genomicsengland.co.uk/documents/Genomics-England-GeCIP-Participation-Agreement-v2.0.pdf) and email the signed version to [research-network@genomicsengland.co.uk](mailto:research-network@genomicsengland.co.uk)
- Choose a Research Network of interest and apply to join through the [online form](https://www.genomicsengland.co.uk/research/academic/join-gecip)
- Track your application on the [Research Portal](https://research.genomicsengland.co.uk/)
- The domain lead will review your application within ten working days
- Your institution will validate your affiliation
- You will complete our online Information Governance training and will be granted access to the Research Environment within two hours of passing the online training

## Online code

Source code for the TINC package is available on [github](https://caravagnalab.github.io/TINC/).

Code to recreate the paper figures is available on [Zenodo](https://zenodo.org/records/10200618) and in the RE folder below. You can copy and paste this code into Rstudio in the Research Environment to recreate the figures in the publication.

## Research Environment Supplementary Materials

A master table containing the data required to recreate figures in the paper is located within the [Research Environment](https://www.genomicsengland.co.uk/research/academic/join-gecip) at **/published\_data\_archive/paper\_data/paper\_data\_RR306/**

There are two subfolders in that location: `/published_data_archive/paper_data/paper_data_RR306/TINC-paper-raw-data/`, which contains raw and anonymised data tables with sample ID matching, and `/published_data_archive/paper_data/paper_data_RR306/Zenodo/`, which contains the codes and anonymised data tables which are also publicly accessible via Zenodo.

### Data directory

Within `TINC-paper-raw-data/` subfolder there are the following files:

- `GEL_participant_IDs.tsv` (table matching Genomics England cohort IDs and anonymised IDs)
- `HEMATOCOHORT_realdata_anon.csv`
- `HEMATOCOHORT_realdata.csv`
- `HEMATOCOHORT_realdata.rds`
- `HEMATOCOHORT_synthetic_anon.csv`
- `HEMATOCOHORT_synthetic.csv`
- `HEMATOCOHORT_synthetic.rds`
- `LUNGCOHORT_synthetic_anon.csv`
- `LUNGCOHORT_synthetic.csv`
- `LUNGCOHORT_synthetic.rds`
- `MRD_ALL_anon.csv`
- `MRD_ALL.csv`
- `MRD_ALL.rds`
- `MRD_AML_anon.csv`
- `MRD_AML.csv`
- `MRD_AML.rds`
- `MRD_anon.csv`
- `MRD.csv`
- `MRD.rds`
- `RDS_to_CSV.R` (script transforming original raw RDS to CSV tables which were then anonymised)
- `README`
- `SARCOMA_realdata_anon.csv`
- `SARCOMA_realdata.csv`
- `SARCOMA_realdata.rds`

### Code directory:

Within the `/published_data_archive/paper_data/paper_data_RR335/Zenodo/` subfolder there are the following files:

- codes:
  - `2.1.Hematological_test.R`
  - `2.2.Lung_test.R`
  - `2.3.DeTin.R`
  - `3.1.Hematological_cohort_piechart.R`
  - `3.2.Hematological_cohort_plus_sarcoma.R`
  - `3.3.MRD.R`
  - `4.1.Figure_hematological.R`
  - `4.2.Figure_Synthetic.R`
  - `5.Supplementary Figure Sarcoma.R`
  - `6.Supplementary_Figure_hematological.R`
  - `7.Failure_rate_hematological.R`
  - `8.Supplementary_Figure_synthetic.R`
  - `11.MRD_validation_ALL_excluded.R`
  - `13.Extra MRD_AML_cases.R`
  - `14.Validation_MRD_MainText.R`
  - `auxiliary.R`
  - `figure5_panel_a.R`
  - `setup.R`
- data files:
  - `GL_bioinfor_performance.csv`
  - `GL_bioinfor_performance.csv`
  - `Piechart_germlines_hematological.rds`
  - `Piechart_passfail_hematological.rds`
  - `Plot_MRD_validation.rds`
  - `Plot_MRD_validation_extra.rds`
  - `Plot_performance_synthetic_hematological.rds`
  - `Plot_performance_synthetic_lung.rds`
  - `SNV_tiering_comparison_unflagged_0.05VAF_table_anon.csv`
  - `Scatter_DeTiN_hematological.rds`
  - `Scatter_DeTiN_lung.rds`
  - `plot_subset_hematological_sarcoma.rds`
  - `results`:
    - `Supplementary Table.xlsx`
    - `approved_anonymized_tables`:
      - `CSV_to_RDS.R`
      - `HEMATOCOHORT_realdata.rds`
      - `HEMATOCOHORT_realdata_anon.csv`
      - `HEMATOCOHORT_synthetic.rds`
      - `HEMATOCOHORT_synthetic_anon.csv`
      - `LUNGCOHORT_synthetic.rds`
      - `LUNGCOHORT_synthetic_anon.csv`
      - `MRD.rds`
      - `MRD_ALL.rds`
      - `MRD_ALL_anon.csv`
      - `MRD_AML.rds`
      - `MRD_AML_anon.csv`
      - `MRD_anon.rds`
      - `README`
      - `SARCOMA_realdata.rds`
      - `SARCOMA_realdata_anon.csv`
      - `Source Data.zip`
- figures:
  - `Figure_experimental_validation.png`
  - `Figure_hematological_cohort.png`
  - `Figure_synthetic_tests.png`
  - `Hematological_cohort_piechart_germlines.png`
  - `Hematological_cohort_piechart_passfail.png`
  - `Hematological_cohort_sarcoma_nmin_20.png`
  - `Images`:
    - `fig2a.png`
  - `Supplementary_Figure_ALL_not100K.png`
  - `Supplementary_Figure_piechart_hematological_germlines.png`
  - `Supplementary_Figure_piechart_hematological_passfail.png`
  - `Supplementary_Figure_piechart_sarcoma.png`
  - `Supplementary_material_synthetic.png`
  - `figure4.svg`
  - `figure_4_panel_a.svg`
  - `image_figure4_top.png`
  - `rect485.png`

February 13, 2025
