---
title: 'NHS genomic medicine service data release v5 (28/08/2025) - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/gms_release5/
scraped_at: 2026-05-04T06:32:22Z
---

# NHS genomic medicine service data release v5 (28/08/2025)

[Data dictionary](../GMS_data_dictionary_v5.xlsx)

## Purpose

This document provides a description of the NHS GMS data release v5 dated 28th August 2025.

Each progressive release incorporates new content, enhances existing content, and enables more effective use of the data.

This data are presented within the Genomics England Research Environment, accessed via the [AWS virtual desktop](../access/) interface and subject to all Genomics England data protection and privacy principles.

Please see the [Research Environment User Guide](../) for detailed documentation on how to use and query the Genomics England dataset. This page also includes instructional videos which can not be viewed from within the Research Environment.

## Release overview

The NHS Genomic Medicine Service (GMS) Data Release Version 5 provides clinical data for 38,728 participants which are part of 22,980 referrals. In summary, this release includes 40,968 genomes from 38,728 participants. There are 36,500 genomes from 36,500 rare disease programme participants and 4,468 genomes from 2,228 cancer programme participants.

We further provide tiering data from 18,351 referrals, and 18,291 interpretations are represented in the Report Outcome Questionnaire of which 24.5% have a case\_solved status of "yes". Within the Report Outcome Questionnaire, cases are included up to 01/08/2025. This release includes 20,746 interpretation requests from the Rare Disease program and 2,234 interpretation requests from the Cancer program.

The secondary clinical data (historic records) from NHSE, NCRAS and ONS contains data up to 11/04/2025 (this is variable between datasets, see the 'Activity period coverage for the longitudinal secondary data tables' table below for dates for each).

Table overview of genomic data:

| Type | Genomes count | Participant count |
| --- | --- | --- |
| Rare Disease | 36,500 | 36,500 |
| Cancer Germline | 2,234 | 2,228 |
| Cancer Tumour | 2,234 | 2,228 |
| Cancer Total | 4,468 | 2,228 |
| Genomes Total | 40,968 | 38,728 |

Participants by program(\*) breakdown:

| Programme | Participants | Referrals |
| --- | --- | --- |
| Rare Disease | 36,500 | 20,746 |
| Cancer | 2,228 | 2,234 |

(\*) Participants can be part of multiple referrals and across programs.

## Clinical data in this release

NHS Genomic Medicine Service (GMS) Data Release clinical data is organised into tables found in LabKey. You can find details of these tables and their contents in our [common clinical data documentation](../gms_common_clinical/), [cancer clinical data documentation](../gms_cancer_clinical/) and [data dictionary](../GMS_data_dictionary_v4.xlsx).

### Activity period coverage for the longitudinal secondary data tables

| Source | Category | Dataset | Start | End |
| --- | --- | --- | --- | --- |
| NHSE | Hospital Episode Statistics | op | 01/04/2003 | 31/01/2025 |
| NHSE | Hospital Episode Statistics | apc | 13/09/1995 | 31/01/2025 |
| NHSE | Hospital Episode Statistics | ae | 01/04/2007 | 31/03/2020 |
| NHSE | Hospital Episode Statistics | ecds | 05/04/2017 | 01/02/2025 |
| NHSE | Hospital Episode Statistics | cc | 05/04/2008 | 31/01/2025 |
| NHSE | Other | cancer\_registry | 09/01/1981 | 13/08/2024 |
| NHSE | Office of National Statistics Mortality | mortality | 25/02/2010 | 11/04/2025 |
| NCRAS | NCRAS | sact | 20/02/2013 | 23/08/2022 |
| NCRAS | NCRAS | rtds | 19/08/2009 | 28/02/2022 |
| NCRAS | NCRAS | av\_treatment | 01/04/1995 | 09/05/2022 |
| NCRAS | NCRAS | av\_tumour | 05/05/1995 | 28/12/2019 |

## Change Summary

### New table

Cancer variant tiering information is now available in the [`cancer_tier_and_domain_variants`](../cancer_tiering/) table.

### Changes to existing tables

The `participant` table now includes the column `programme_consent_status`. This field includes the up-to-date consent status (`Consenting`, `Withdrawn (Partial)` or `Withdrawn (Full)`) of the participant. When you start a new research project, you must filter your list of participants to remove any non-consenting participants.

The `cancer_analysis` table now includes a `referral_type` column, which describes whether a cancer case included both germline and somatic samples (`matched_normal`) or only the tumour sample (`tumour_only`). In this release all cases are matched normal.

## Audience

The intended audience for this document is researchers that have access to the Genomics England Research Environment.

## Identifying this data release

The clinical data and tabulated bioinformatic data for this data release, and the paths to the applicable genome files, are found in the following LabKey folder:

`nhs-gms-release_v5_2025-08-28`

Subsequent releases will be identified by an incremental increase in the version number and the date of data release.
Relevant genomic data produced by the Genomics England Bioinformatics pipeline (i.e. joint-called VCFs, annotated somatic VCFs) can be found in your home directory, under the folder `gel_data_resources` and then `gms`. Use the `genome_file_paths_and_types` table to identify the files.

## Scope

For release v5, the inclusion criteria are as follows:

- Participant has been through a manual consent validation and passed
- Only those participants who had all of their consent documents validated, and all documents consistently confirmed that they were eligible (they had both discussed and consented to inclusion in the NGRL, and were consented as an adult or child) are included.
- Any participants who were consented as children but were already 16 at the time of consent, or have since turned sixteen (but are not deceased) are deemed ineligible. Unless they have been reconsented as an adult.
- Participant is part of an eligible referral
- Eligible referrals refer to closed cases that contain at least one eligible participant.

### In scope

Below we provide an overview of the data in scope for this release. By definition, this relates to cancer and rare disease data for participants enrolled in NHS GMS that consented for research. These data include:

- Genomic data for participants when available.
- This data contains closed case data only. This means that all referrals have gone through interpretation.
- Whole genome sequencing (WGS) family-based quality control for rare disease.
- Outputs of the Genomics England Bioinformatics rare diseases interpretation pipeline
- Tiering data â rare disease
- Exomiser results for interpreted genomes â rare disease
- Report outcome data ("report outcome questionnaire data") â rare disease - up until 01/08/2025.
- Outputs of the Genomics England Bioinformatics cancer interpretation pipeline
- 'Gold standard' cancer genomes which have been through interpretation and passed quality checks
- Annotation and tiering of small variants
- Primary clinical data, including recruited disease and primary tumour types
- Secondary datasets (medical history) from National Cancer Registration and Analysis Service (NCRAS)

### Out of scope

Additional time is required to update the applications/tools that are available in the RE to the current data release, e.g. IVA, Participant Explorer. Please refer to the [Application Data Versions](../tool_versions/) page for the data release version used in the RE products and services.

Data out of scope for this release:

- Clinical and genomic data for participants that have withdrawn from research after enrolment to the Genomic Medicine Service, or were otherwise ineligible.
- Participant data from the pilot phases of the 100,000 Genomes Project (i.e. not main programme).
- Participant data from the 100,000 Genomes Project (main programme).

### Quality notes

This section will be amended for future releases as more documentation becomes available.

#### Note on Labkey platekey query limitations

Aggregation or Distinct queries including *specifically* the platekey column (e.g. `SELECT DISTINCT participant_id, platekey FROM <table_name>`) in Labkey will intentionally fail with a `'Status code = 500' error , UnauthorizedException or 'Unable to locate required logging column Key'`. This can initially be circumvented by pulling in the entire data with `SELECT * FROM <table_name>` and subsetting or filtering your data downstream. We will continue to monitor the impact of the issue.

### Terms of use for specific cohorts

For NHS GMS Data Release Version 5, no cohort has been formally linked to the data. This will change in future releases and the Terms of Use for Specific Cohorts will be amended.

## Data release description

For an overview of the tables available in LabKey please see: [NHS GMS dataset overview](../gms_clinical_data/)

The Genomics England data are organised into data views (displayed within LabKey as tables) categorised into common, bioinformatics and cancer. The [data dictionary](../GMS_data_dictionary_v5.xlsx) describes the table structure and provides data definitions for this release.

## Contact and support

For all queries relating to this data release please contact the Genomics England Service Desk portal: [Service Desk](https://www.genomicsengland.co.uk/service-desk) (accessible from outside the Research Environment). The Service Desk is supported by dedicated Genomics England staff for all relevant questions.

August 28, 2025
