---
title: '100,000 Genomes Cancer Programme - pan-cancer publication - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/pan_cancer_pub/
scraped_at: 2026-05-04T06:33:06Z
---

# Insights for Precision Oncology from the 100,000 Genomes Cancer Programme

â
This page describes the resource methods that accompany the paper ["Insights for precision oncology from the 100,000 Genomes Cancer Programme" Sosinsky et al. 2023](https://www.nature.com/articles/s41591-023-02682-0.epdf?sharing_token=iqqL-H4pDOvtHRSmxgE5_tRgN0jAjWel9jnR3ZoTv0PZ4zZ343fUWGzzy8-S-SS326GnkLnHC1VQMpvHbRZnca9qo0AK6e231rN03N5cInTSBrGZa3_KHRz6A3487Y37QcEmONHMQOBAvM_iqI6YlXL0O_izSlUTgWdYis8-Er4%3D).

A selection of supplementary materials are available online (see below Online Supplementary Materials). However, most of the data is located within the [Research Environment](https://www.genomicsengland.co.uk/research), Genomics England's secure workspace.

To access genomic and clinical data within this workspace, you must apply to become a member the [Genomics England Research Network](https://www.genomicsengland.co.uk/join-us).

The process for joining the Research Network consists of the following steps:

- Your institution will need to [sign a participation agreement](https://www.genomicsengland.co.uk/assets/documents/Research-Network-Access-Agreement-Academic-v1-October-2024-form-fields-1_2024-10-30-144528_sckg.pdf) and email the signed version to [research-network@genomicsengland.co.uk](mailto:research-network@genomicsengland.co.uk)
- Choose a Research Network of interest and apply to join through the [online form](https://www.genomicsengland.co.uk/research/academic/join-gecip)
- Track your application on the [Research Portal](https://research.genomicsengland.co.uk/)
- The domain lead will review your application within ten working days
- Your institution will validate your affiliation
- You will complete our online Information Governance training and will be granted access to the Research Environment within two hours of passing the online training

### Online code

Code to recreate the paper figures is available on [gitlab](https://gitlab.com/genomicsengland/genomics_england_publications/100k_cancer_programme/) and [zenodo](https://doi.org/10.5281/zenodo.8311292). You can copy and paste this code into Rstudio in the Research Environment to recreate the figures in the publication.

### Research Environment Supplementary Materials

A master table containing the data required to recreate figures in the paper is located within the [Research Environment](https://www.genomicsengland.co.uk/research/academic/join-gecip) at **/published\_data\_archive/paper\_data/paper\_data\_RR335/**

There are two subfolders in that location: `/published_data_archive/paper_data/paper_data_RR335/data/` and `/published_data_archive/paper_data/paper_data_RR335/code/`.

#### Data directory

Within `data/` subfolder there are the following files:

- `pan_cancer_master_table_2023-08-30.tsv` (master table)
- `pan_cancer_master_table_data_dictionary.xlsx` (data dictionary for master table)
  â

#### Code directory

Within the `/published_data_archive/paper_data/paper_data_RR335/code/` subfolder there are the following files:

- `README.md` (description of code)
  â
- `figure_1/`
  - `pan_cancer_figure_1e_stage_vs_disease_type.R`
  - `pan_cancer_figure_1e_treatment_status_vs_disease_type.R`
  - `pan_cancer_figure_1e_tumour_purity_vs_disease_type.R`
    â
- `figure_2/`
  - `pan_cancer_figure_2_small_variants_somatic.R`
  - `pan_cancer_figure_2_copy_number_aberrations.R`
  - `pan_cancer_figure_2_structural_variants.R`
  - `pan_cancer_figure_2_hrd.R`
  - `pan_cancer_figure_2_tmb.R`
  - `pan_cancer_figure_2_mmr_signatures.R`
  - `pan_cancer_figure_2_small_variants_germline.R`
  - `pan_cancer_figure_2_pharmacogenomic_variants.R`
    â
- `figure_3/`
  - `pan_cancer_figure_3a_tmb_cosmic_signatures_and_hr_status.R`
  - `pan_cancer_figure_3b_survival_curves_hr_and_mmr_status.R`
  - `pan_cancer_figure_3c_survival_curves_skcm_and_luad.R`
    â
- `figure_4/`
  - `pan_cancer_figure_4a_small_variants_and_copy_number_aberrations.R`
  - `pan_cancer_figure_4b_survival_curves_gene_alterations.R`
    â
- `utilities/`
  - `get_actionability_plot.R`
  - `get_actionable_targets.R`
  - `get_filepaths.R`
  - `get_master_table.R`
  - `get_pan_cancer_code_order.R`
  - `get_public_sample_ids.R`
  - `get_study_code_order.R`
  - `get_treatments.R`
  - `get_vardata_counts_splits.R`
    â
- `data/`
  - `CANCER_CENSUS_GENES.tsv`
  - `Inherited-Cancer-NGTD-MR-October-2021-22.xlsx`
  - `Somatic-Cancer-NGTD-MR-October-2021-22.xlsx`
  - `clinical_indication_to_pan_cancer_code_mapping.xlsx`
  - `pan_cancer_code_definitions.tsv`

â

February 13, 2025
