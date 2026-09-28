---
title: 'NHS genomic medicine service data release v4 (22/08/2024) - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/gms_release4/
scraped_at: 2026-05-04T06:32:21Z
---

# NHS genomic medicine service data release v4 (22/08/2024)

[Data dictionary](../GMS_data_dictionary_v4.xlsx)

## Purpose

This document provides a description of the NHS GMS data release v4 dated 22nd August 2024 and that was updated on 19th December 2024 with secondary clinical data.

Each progressive release incorporates new content, enhances existing content, and enables more effective use of the data.

This data are presented within the Genomics England Research Environment, accessed via the [AWS virtual desktop](../access/) interface and subject to all Genomics England data protection and privacy principles.

Please see the [Research Environment User Guide](../) for detailed documentation on how to use and query the Genomics England dataset. This page also includes instructional videos which can not be viewed from within the Research Environment.

## Release overview

The NHS Genomic Medicine Service (GMS) Data Release Version 4 provides clinical data for 31,985 participants which are part of 18,025 referrals. In summary, this release includes 34,319 genomes from 31,966 participants. There are 30,047 genomes from 29,872 rare disease programme participants and 4,272 genomes from 2,102 cancer programme participants.

We further provide tiering data from 15,857 referrals, and 14,795 interpretations are represented in the Report Outcome Questionnaire of which 24.3% have a case\_solved status of "yes". Within the Report Outcome Questionnaire, cases are included up to 8-05-2024. This release includes 15,882 interpretation requests from the Rare Disease program and 2,136 interpretation requests from the Cancer program.

Table overview of genomic data:

| Type | Genomes count | Participant count |
| --- | --- | --- |
| Rare Disease | 30,047 | 29,872 |
| Cancer Germline | 2,136 | 2,102 |
| Cancer Tumour | 2,136 | 2,102 |
| Cancer Total | 4,272 | 2,102 |
| Genomes Total | 34,319 | 31,966 |

Participants by program(\*) breakdown:

| Programme | Participants | Referrals |
| --- | --- | --- |
| Rare Disease | 29,890 | 15,889 |
| Cancer | 2,102 | 2,136 |

(\*) Participants can be part of multiple referrals and across programs.

## Clinical data in this release

NHS Genomic Medicine Service (GMS) Data Release clinical data is organised into tables found in LabKey. You can find details of these tables and their contents in our [common clinical data documentation](../gms_common_clinical/), [cancer clinical data documentation](../gms_cancer_clinical/) and [data dictionary](../GMS_data_dictionary_v4.xlsx).

### Activity period coverage for the longitudinal secondary data tables

| Source | Category | Dataset | Start | End |
| --- | --- | --- | --- | --- |
| NHSE | Hospital Episode Statistics | op | 01/04/2003 | 31/03/2024 |
| NHSE | Hospital Episode Statistics | apc | 13/09/1995 | 31/03/2024 |
| NHSE | Hospital Episode Statistics | ae | 01/04/2007 | 31/03/2020 |
| NHSE | Hospital Episode Statistics | ecds | 05/04/2017 | 02/04/2024 |
| NHSE | Hospital Episode Statistics | cc | 05/04/2008 | 31/03/2024 |
| NHSE | Other | cancer\_registry | 09/01/1981 | 10/05/2024 |
| NHSE | Office of National Statistics Mortality | mortality | 25/02/2010 | 11/07/2024 |
| NCRAS | NCRAS | sact | 20/02/2013 | 23/08/2022 |
| NCRAS | NCRAS | rtds | 19/08/2009 | 28/02/2022 |
| NCRAS | NCRAS | av\_treatment | 01/04/1995 | 09/05/2022 |
| NCRAS | NCRAS | av\_tumour | 05/05/1995 | 28/12/2019 |

## Change Summary

### Updated 19/12/24 - New secondary clinical datasets

This release includes secondary clinical data, i.e. medical history, including NHSE Hospital Episode Statistics and Office of National Statistics mortality data. The information is provided in the following tables:

- `hes_ae`: Hospital Episode Statistics Accident and Emergency; contains historic records of A&E attendances
- `hes_apc`: Hospital Episode Statistics Admitted Patient Care; contains historic records of admissions into secondary care.
- `hes_cc`: Hospital Episode Statistics Critical Care; contains historic records of admissions into critical care.
- `hes_op`: Hospital Episode Statistics Outpatient; contains historic records of outpatient attendances.
- `cancer_registry`: medical information about the tumour.
- `ecds`: Main dataset of urgent and emergency care. Expands hes\_ae and will replace it entirely in the future.
- `mortality`: Lists the Office of National Statistics' cause of death records.

More information on these datasets can be found in the [Common clinical data page](../gms_common_clinical/#general-nhs-gms-clinical-data), or in the Data Dictionary.

Currently, this secondary data is only included for participants who were available in release 3, we do not have secondary data for participants who were added in release 4.

### Changes to existing tables

[`cancer_analysis`](../gms_cancer_clinical/)  
Each participant only has one row per cancer case. An additional filter on the referral status is included in GMS data release v4 to exclude statuses that are not `active`. This fixes an issue in GMS data release v3 which caused duplicate `tumour_uid` to be present.

[`report_outcome_questionnaire`](../exit_questionnaire/)  
This table was previously called `gmc_exit_questionnaire`, and has been renamed as `report_outcome_questionnaire` so that it is more aligned with what the questionnaires are called in GMS.

**LabKey UI datatype changes**  
There have been improvements to the datatypes in the LabKey UI for the following tables.

| Table | Field | Previous datatype | Updated datatype |
| --- | --- | --- | --- |
| sample | collection\_date | varchar | timestamp (`yyyy-MM-dd` format) |
|  | din\_value\_glh | integer | decimal |
|  | percentage\_dna\_glh | integer | decimal |
| panels\_applied | panel\_identifier | integer | varchar |
| tiering\_data | father\_affected | boolean | varchar |
|  | mother\_affected | boolean | varchar |
| exomiser | father\_affected | boolean | varchar |
|  | mother\_affected | boolean | varchar |
|  | poly\_phen | varchar | decimal |
|  | mutation\_taster | varchar | decimal |
|  | sift | varchar | decimal |
| av\_patient | embarkation | boolean | varchar |
| sact | administration\_date | varchar | timestamp (`yyyy-MM-dd` format) |
|  | date\_of\_final\_treatment | varchar | timestamp (`yyyy-MM-dd` format) |
|  | chemo\_radiation | varchar | boolean |
|  | regimen\_mod\_stopped\_early | varchar | boolean |
|  | regimen\_mod\_time\_delay | varchar | boolean |
|  | start\_date\_of\_cycle | varchar | timestamp (`yyyy-MM-dd` format) |
|  | start\_date\_of\_regimen | timestamp (`yyyy-MM-dd HH:mm:ss` format) | timestamp (`yyyy-MM-dd` format) |
|  | date\_decision\_to\_treat | varchar | timestamp (`yyyy-MM-dd` format) |
| rtds | proceduredate | timestamp (`yyyy-MM-dd HH:mm:ss` format) | timestamp (`yyyy-MM-dd` format) |
|  | timeofexposure | timestamp (`yyyy-MM-dd HH:mm:ss` format) | timestamp (`HH:mm:ss` format) |
|  | treatmentstartdate | timestamp (`yyyy-MM-dd HH:mm:ss` format) | timestamp (`yyyy-MM-dd` format) |
|  | earliestclinappropriatedate | timestamp (`yyyy-MM-dd HH:mm:ss` format) | timestamp (`yyyy-MM-dd` format) |
|  | decisiontotreatdate | timestamp (`yyyy-MM-dd HH:mm:ss` format) | timestamp (`yyyy-MM-dd` format) |
|  | apptdate | timestamp (`yyyy-MM-dd HH:mm:ss` format) | timestamp (`yyyy-MM-dd` format) |
| av\_treatment | eventdate | timestamp (`yyyy-MM-dd HH:mm:ss` format) | timestamp (`yyyy-MM-dd` format) |
| v\_tumour | diagnosisdate1 | timestamp (`yyyy-MM-dd HH:mm:ss` format) | timestamp (`yyyy-MM-dd` format) |
|  | diagnosisdate2 | timestamp (`yyyy-MM-dd HH:mm:ss` format) | timestamp (`yyyy-MM-dd` format) |
|  | diagnosisdatebest | timestamp (`yyyy-MM-dd HH:mm:ss` format) | timestamp (`yyyy-MM-dd` format) |
|  | statusofregistration | boolean | varchar |
|  | breslow | varchar | decimal |
|  | first\_hosp\_date | timestamp (`yyyy-MM-dd HH:mm:ss` format) | timestamp (`yyyy-MM-dd` format) |
|  | date\_first\_surgery | timestamp (`yyyy-MM-dd HH:mm:ss` format) | timestamp (`yyyy-MM-dd` format) |

## Audience

The intended audience for this document is researchers that have access to the Genomics England Research Environment.

## Identifying this data release

The clinical data and tabulated bioinformatic data for this data release, and the paths to the applicable genome files, are found in the following LabKey folder:

`nhs-gms-release_v4_2024-08-22`

Subsequent releases will be identified by an incremental increase in the version number and the date of data release.

Relevant genomic data produced by the Genomics England Bioinformatics pipeline (i.e. joint-called VCFs, annotated somatic VCFs) can be found in the your home directory, under the folder `gel_data_resources` and then `gms`.

## Scope

For release v4, the inclusion criteria are as follows:

- Participant has been through a manual consent audit and passed
- Only those participants who had all of their consent documents audited, and all documents consistently confirmed that they were eligible (they had both discussed and consented to inclusion in the NGRL, and were consented as an adult or child) are included.
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
- Report outcome data ("report outcome questionnaire data") â rare disease - up until 08/05/2024.
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

For NHS GMS Data Release Version 4, no cohort has been formally linked to the data. This will change in future releases and the Terms of Use for Specific Cohorts will be amended.

## Data release description

For an overview of the tables available in LabKey please see: [NHS GMS dataset overview](../gms_clinical_data/)

The Genomics England data are organised into data views (displayed within LabKey as tables) categorised into common, bioinformatics and cancer. The [data dictionary](../GMS_data_dictionary_v4.xlsx) describes the table structure and provides data definitions for this release.

## Contact and support

For all queries relating to this data release please contact the Genomics England Service Desk portal: [Service Desk](https://www.genomicsengland.co.uk/service-desk) (accessible from outside the Research Environment). The Service Desk is supported by dedicated Genomics England staff for all relevant questions.

October 7, 2025
