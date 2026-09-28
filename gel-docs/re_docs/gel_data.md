---
title: 'Genomics England Data - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/gel_data/
scraped_at: 2026-05-04T06:34:35Z
---

# Genomics England Data

You can find the outputs of bioinformatics pipelines and analyses run by Genomics England in LabKey and in the `gel_data_resources` folder in the RE filesystem.

## The data

You can find details of the data available on the following pages:

- Aggregated variant calls
  - [Germline aggregation for rare disease and cancer](../aggv2/)
  - [Somatic aggregated variant calls](../somAgg/)
  - [COVID-19 aggregations](../covid_agg/)
- [Genetic similarity to worldwide populations (ancestry) in the UK Biobank](../gen_sim/)
- [De novo variant research dataset](../de_novo_data/)
- Variant prioritisation:
  - [Rare disease tiering](../tiering/)
  - [Cancer tiering](../cancer_tiering/)
  - [Exomiser](../exomiser/)
- [Solved cases (rare disease)](../exit_questionnaire/)
- [HLA variants](../HLA/)
- Cancer data:
  - [Cancer analysis](../cancer_analysis/)
  - [Staging data (cancer)](../cancer_staging/)
  - [Orthogonal standard-of-care (SOC) test data (cancer)](../soc/)
  - [100,000 Genomes Cancer Programme - pan-cancer publication](../pan_cancer_pub/)
- [Long-read sequencing data](../lrs/)

## The `gel_data_resources` folder

The `gel_data_resources` folder contains large files, such as VCFs and JSONs. You can access the `gel_data_resources` folder either from the desktop or the HPC. This folder is read-only.

Genomics England data can be found in the `pilot`, `main_programme` and `gms` folders, which relate to the different projects. Further folders in `gel_data_resources` include scripts and workflows.

Within these data folders, `pilot`, `main_programme` and `gms`, data are categorised into folders by type, then date of release, then further subtypes.

## LabKey

Data that can be easily displayed in tables are available in [LabKey](../labkey/).

November 23, 2023
