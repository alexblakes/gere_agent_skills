---
title: 'Polygenic risk scores (provided by Genomics PLC) - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/prs/
scraped_at: 2026-05-04T06:33:12Z
---

# Polygenic risk scores (provided by Genomics PLC)

We provide polygenic risk scores (PRS) for a subset of our 100,000 Genomes Project participants, as generated from Genomics PLC.

## About Genomics PLC

[Genomics PLC](https://www.genomicsplc.com/) are a registered Genomics England Research Network member and use large-scale genetic information to develop innovative precision healthcare tools, and to bring new understanding to drug discovery. In order to achieve this, Genomics PLC are currently running their proprietary algorithms on Genomics England datasets. The PRS made available were generated as part of project [RR424](https://research.genomicsengland.co.uk/research-registry/browse/Browsetheresearchregistrypublic/?id=4b97e4b8-78d5-ea11-a813-000d3a7ed688).

## Data description

The data provided consists of ~40,000 individuals providing polygenic risk scores for twelve traits. All individuals are part of the [aggV2](../aggv2/) dataset.

## Traits included

The following traits are included:

| Trait | Trait Code |
| --- | --- |
| Atrial Fibrillation | AF |
| Bowel Cancer | CRC |
| Breast Cancer | BC |
| Cardiovascular disease | CVD |
| Epithelial ovarian cancer | EOC |
| Hypertension | HT |
| Ischaemic stroke | ISS |
| Coronary artery disease | CAD |
| Osteoporosis | OP |
| Prostate cancer | PC |
| Primary open angle glaucoma | POAG |
| Type 2 diabetes | T2D |

## Data included and location

#### PRS values

The PRS values are located within LabKey, within the table `genomicsplc_prs_values`. This table can be found within the 100kGP folders under the heading of "Research Community Provided Data".

#### Genotype data

The data used as input for the generation of the provided polygenic risk scores can be found as a multi-sample VCF in the following directory:

`/gel_data_resources/main_programme/prs_values_genomicsplc/100k/20220526/genotypes/`

#### Genotype data preparation (as provided by Genomics Plc)

For PRS validation purposes, the WGS genotypes (~722M variants) were filtered to a variant base list used for PRS model generation, which includes 18,421,839 variants.

Genetic variants used to generate PRS weights were required to have:

- an INFO score > 0.8 in UKB
- not display significant differences in AF between UKB and Gnomad (p>1e-12) and 1KG (p>1e-10)
- an absolute MAF difference between Gnomad and UKB of less than 0.2 per superpopulation, HWE P > 1e-10 per major ancestry group.
- a definitive 1-2-1 mapping between builds 37 and 38.

We then took the union of variants across the super populations. We excluded:

- indels
- the PAR region
- any variants with MAF <0.05 in the 1KG EUR subset for single study runs
- variants with MAF <0.05 across all superpopulations that are included in the PRS generation for cross ancestry runs based on the appropriate 1KG superpopulations.
- not present in the summary statistics with an info score > 0.8 on a trait by trait basis.

Due to 317,092 variants in the WGS data that were not present in our backbone, genotypes were phased (1000G imputation panel) and imputed in order to enable PRS validation using the vader workflow. The 1000G reference panel (v5a) was used for phasing and imputation, which was lifted-over from GRCh37 to GRCh38 using cross-map.

## Using consented data only

This dataset contains information on a subset of participants who may been withdrawn from research since the first release. **Their use in any new analyses is not permitted**. Thus, it is **extremely** important to remove these samples from your analyses and ensure that you are only using samples included in the latest data release.

To facilitate the process of filtering for consent the `genomicsplc_prs_values` LabKey table can be used to identify consented participants from the `participant` table.

## Related publications

- [UK Biobank release and systematic evaluation of optimised polygenic risk scores for 53 diseases and quantitative traits](https://europepmc.org/article/PPR/PPR507709)
- [A systematic evaluation of the performance and properties of the UK Biobank Polygenic Risk Score (PRS) Release](https://europepmc.org/article/MED/39292644)

## Help and support

Please reach out via the [Genomics England Service Desk](../help/) for any queries concerning the PRS values. We will be able to relay these questions to our colleagues at Genomics PLC or answer these ourselves depending on the type of query.

July 15, 2025
