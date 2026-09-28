---
title: 'NHS GMS data release change summary - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/gms_change_summary/
scraped_at: 2026-05-04T06:32:17Z
---

# NHS GMS data release change summary

## nhs-gms-release\_v5\_2025-08-28

### New table

Cancer variant tiering information is now available in the [`cancer_tier_and_domain_variants`](../cancer_tiering/) table.

### Changes to existing tables

The `participant` table now includes the column `programme_consent_status`. This field includes the up-to-date consent status (`Consenting`, `Withdrawn (Partial)` or `Withdrawn (Full)`) of the participant. When you start a new research project, you must filter your list of participants to remove any non-consenting participants.

The `cancer_analysis` table now includes a `referral_type` column, which describes whether a cancer case included both germline and somatic samples (`matched_normal`) or only the tumour sample (`tumour_only`). In this release all cases are matched normal.

## nhs-gms-release\_v4\_2024-08-22

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

improved tables

```
| Table          | Field                        | Previous datatype                          | Updated datatype                        |
|----------------|------------------------------|--------------------------------------------|-----------------------------------------|
| sample         | collection_date              | varchar                                    | timestamp (`yyyy-MM-dd` format)           |
|                | din_value_glh                | integer                                    | decimal                                 |
|                | percentage_dna_glh           | integer                                    | decimal                                 |
| panels_applied | panel_identifier             | integer                                    | varchar                                 |
| tiering_data   | father_affected              | boolean                                    | varchar                                 |
|                | mother_affected              | boolean                                    | varchar                                 |
| exomiser       | father_affected              | boolean                                    | varchar                                 |
|                | mother_affected              | boolean                                    | varchar                                 |
|                | poly_phen                    | varchar                                    | decimal                                 |
|                | mutation_taster              | varchar                                    | decimal                                 |
|                | sift                         | varchar                                    | decimal                                 |
| av_patient     | embarkation                  | boolean                                    | varchar                                 |
| sact           | administration_date          | varchar                                    | timestamp (`yyyy-MM-dd` format)           |
|                | date_of_final_treatment      | varchar                                    | timestamp (`yyyy-MM-dd` format)           |
|                | chemo_radiation              | varchar                                    | boolean                                 |
|                | regimen_mod_stopped_early    | varchar                                    | boolean                                 |
|                | regimen_mod_time_delay       | varchar                                    | boolean                                 |
|                | start_date_of_cycle          | varchar                                    | timestamp (`yyyy-MM-dd` format)           |
|                | start_date_of_regimen        | timestamp (`yyyy-MM-dd HH:mm:ss` format)     | timestamp (`yyyy-MM-dd` format)           |
|                | date_decision_to_treat       | varchar                                    | timestamp (`yyyy-MM-dd` format)           |
| rtds           | proceduredate                | timestamp (`yyyy-MM-dd HH:mm:ss` format)     | timestamp (`yyyy-MM-dd` format)           |
|                | timeofexposure               | timestamp (`yyyy-MM-dd HH:mm:ss` format)     | timestamp (`HH:mm:ss` format)             |
|                | treatmentstartdate           | timestamp (`yyyy-MM-dd HH:mm:ss` format)     | timestamp (`yyyy-MM-dd` format)           |
|                | earliestclinappropriatedate  | timestamp (`yyyy-MM-dd HH:mm:ss` format)     | timestamp (`yyyy-MM-dd` format)           |
|                | decisiontotreatdate          | timestamp (`yyyy-MM-dd HH:mm:ss` format)     | timestamp (`yyyy-MM-dd` format)           |
|                | apptdate                     | timestamp (`yyyy-MM-dd HH:mm:ss` format)     | timestamp (`yyyy-MM-dd` format)           |
| av_treatment   | eventdate                    | timestamp (`yyyy-MM-dd HH:mm:ss` format)     | timestamp (`yyyy-MM-dd` format)           |
| v_tumour       | diagnosisdate1               | timestamp (`yyyy-MM-dd HH:mm:ss` format)     | timestamp (`yyyy-MM-dd` format)           |
|                | diagnosisdate2               | timestamp (`yyyy-MM-dd HH:mm:ss` format)     | timestamp (`yyyy-MM-dd` format)           |
|                | diagnosisdatebest            | timestamp (`yyyy-MM-dd HH:mm:ss` format)     | timestamp (`yyyy-MM-dd` format)           |
|                | statusofregistration         | boolean                                    | varchar                                 |
|                | breslow                      | varchar                                    | decimal                                 |
|                | first_hosp_date              | timestamp (`yyyy-MM-dd HH:mm:ss` format)     | timestamp (`yyyy-MM-dd` format)           |
|                | date_first_surgery           | timestamp (`yyyy-MM-dd HH:mm:ss` format)     | timestamp (`yyyy-MM-dd` format)           |
```

## nhs-gms-release\_v3\_2024-03-18

### New data sets

This release includes secondary clinical data, i.e. medical history, from the National Cancer Registration and Analysis Service (NCRAS). The information is provided in the following tables:

- `av_imd`: income deprivation domain
- `av_patient`: demographics from the Cancer Registration and information about death
- `av_rtd`: routes to diagnosis
- `av_treatment`: treatment received for each participant
- `av_tumour`: medical information about the tumour
- `rtds`: radiotherapy dataset
- `sact`: systemic anti-cancer therapy

More information on these datasets can be found in the [Cancer-specific clinical data page](../gms_cancer_clinical/#nhse-ncras-cancer-clinical-data)

### Changes to existing tables

**participant**

The `participant` table now contains two additional fields:

- `Category`: this provides the category given to the referral (Cancer/Rare Diseases)
- `Referral id`: this provides the id of the referral submitted to GMS

**observation**

The `observation` table now contains two additional fields:

- `Normalised Hpo Id`
- `Normalised Hpo Term`

**gmc\_exit\_questionnaire**

The `Additional Comments` and `Publications` columns in the `gmc_exit_questionnaire` table now contain information. Personal Identifiable Data (PID) has been masked by replacing it with `'---'`.

## nhs-gms-release\_v2\_2023-02-28

**Some tables have been present in the 100K data and therefore follow a similar format. Based on the 100K format the following changes are present in similarly named tables of the NHS GMS data.**

**While various subtle changes have been made to the NHS GMS tables, we list some of the most important ones below. For example, with NHS GMS release v2 we have reintroduced the cancer\_analysis table.**

### General Changes

- This release sees the introduction of partial referrals. Partial referrals are referrals for more than one participant, and for which only a proportion of the participants have consented for research. This may limit some of the data available for the participants within a partial referral who did consent for research. We are only releasing data for partial referral participants who did consent for research.
- We have had to make a change to our approach of encrypting participant, referral, and sample IDs. Therefore, you will unfortunately not be able to find the same IDs between NHS-GMS release v1 and v2. As the first release contained a relatively minimal dataset, we hope the impact of this change remains minimal. The majority of the participants included in NHS GMS release v1 will be part of release v2, but under different participant and referral IDs.

### Bioinformatics data

**genome\_file\_paths\_and\_types**

- Structural Variant (SV) VCFs for rare disease participants (`*.diploidSV.vcf.gz`) are now provided per individual instead of a single VCF containing SVs of individuals of a given family. As implied, in NHS-GMS release v1 these were still provided at a family basis, but due to the introduction of partial referrals we aimed to maintain the possibility to study SVs as much as possible.

**cancer\_analysis**

- Introduction of `referral_id` as a case reference ID. Participants can be part of multiple referrals.
- NHS GMS columns `clinical_indication_code` and `clinical_indication_full_name` will provide detailed information on the tumour type (also found in the `referral` table).
- 100K column `tumour_id` has been replaced with `tumour_uid` for NHS-GMS. The `tumour_uid` will enable the linking of tumour morphology and topography data across clinical tables.
- 100K column `tumour_clinical_sample_time` has been replaced with `tumour_sample_clinical_sample_date_time` and the germline equivalent added as `germline_sample_clinical_sample_date_time`. However, this data is no longer submitted for every referral, so is absent for many samples.
- NHS GMS columns `somatic_tinc_vcf` and `somatic_tinc_sv_vcf` are currently empty in the cancer\_analysis table. This is not an error and is subject to change in future releases, but we decided to already include the column for this data.
- 100K columns `analysis_csv_filepath` and `analysis_html_filepath` have been replaced with `cancer_report_reported_variants_csv` and `cancer_report_supplementary_html`, respectively. In addition, we have now also provided the smaller summarised report in the `cancer_report_html` column.
- The annotated VCFs, csv's and html's can now be found in a single interpretation folder to increase visibility of data belonging to the same interpretation request.
- While we expect that this table will receive more additions to increase its utility, we look forward to suggestions from the Research Community as to what may be useful columns or information.

**gmc\_exit\_questionnaire**
\* While no changes have been made to this table, we want to reiterate that the columns `additional_comments` and `publications` have been intentionally made NA in this release as well. This remains subject to change in future releases.

### Clinical Data

Three new fields have been added to this release of the clinical datasets:

- `referral.date_submitted`: this provides the date when the referral was first submitted to GMS
- `plated_sample.date_of_dispatch`: this provides the date when the plated sample was dispatched to the sequencing facility
- `referral.category`: this provides the category given to the referral (Cancer/Rare Diseases)
- Several of the extraneous guid fields have been removed from this release of the clinical datasets, specifically:
  - `condition.uid`
  - `observation_component.uid`
  - `participant.uid`
  - `referral.uid`
  - `referral_participant.uid`
  - `referral_test.uid`
  - `tumour_morphology.uid`
  - `tumour_topography.uid`

## nhs-gms-release\_v1\_2022-06-15

***This data release represents the baseline for subsequent releases.***

**Some tables have been present in the 100K data and therefore follow a similar format. Based on the 100K format the following changes are present in similarly named tables of the NHS GMS data.**

- The `participant_id`'s have changed format and are now a string with the following logic: `ppXXXXXXXXXXX`
- `sequencing_report` and `genome_file_paths_and_types`
  - Column `family_id` has been removed. From now on, cases are referred to as referrals and family members will be part of a single referral. Effectively, `referral_id` replaces `family_id`.
  - Column `laboratory_sample_id` has been removed and will not be available for NHS GMS data.
  - Discrepancy between `plate_key` vs `platekey` has been streamlined. From now on, only references to `platekey` are used.
  - Column `associated_interpretation_request_id` has been included. From now on researchers will have a better view on which CRAM files have been used for a given interpretation request.
  - Joint-called VCFs are now readily available in `/gel_data_resources/` and can be queried from either table.
  - Column `data_format` has been included. Within our pipeline, singletons will go through the same pipeline as multi-member families and are thus considered 'joint-called' even when it concerns a singleton. Samples called without other family members are marked as `single_sample` in the data\_format column.
  - More granularity has been provided in the `file_sub_type` column (i.e. more types).
  - Column `delivery_date` has been streamlined across the table and now only contains `YYYY-MM-DD`. Time stamps have been removed.
- `tiering_data` and `exomiser`
  - Columns `rare_diseases_family_id` and `family_id` have been removed. From now on, cases are referred to as referrals and family members will be part of a single referral. Effectively, `referral_id` replaces the utility of `rare_diseases_family_id` and `family_id`.
  - Discrepancy between `sample_id` vs `platekey` has been streamlined. From now on, only references to `platekey` are used.
  - Discrepancy between `genome_build` vs `assembly` has been streamlined. From now on, only references to `genome_build` are used.
  - Columns `full_brothers_affected` and `full_sisters_affected` have been removed. This has been replaced by `full_siblings_affected` and indicates the number of affected full siblings.
  - Column `participant_phenotypic_sex` will be NA in this release. This is subject to change in future releases.
- `panels_applied`
  - Column `rare_diseases_family_id` has been removed. From now on, cases are referred to as referrals and family members will be part of a single referral. Effectively, `referral_id` replaces the utility of `family_id`.
  - Discrepancy between `sample_id` vs `platekey` has been streamlined. From now on, only references to `platekey` are used.
- `tiered_variants_frequency`
  - A large number of columns will not be available for the initial release. The primary reason is their unavailability (may change) in our backend systems as changes have been made between the 100K pipeline and the NHS GMS pipeline. This is subject to change in future releases.
- `gmc_exit_questionnaire`
  - Column `family_id` has been removed. From now on, cases are referred to as referrals and family members will be part of a single referral. Effectively, `referral_id` replaces the utility of `family_id`.
  - Discrepancy between `genome_build` vs `assembly` has been streamlined. From now on, only references to `genome_build` are used.
  - Columns `additional_comments` and `publications` have been intentionally made NA in this release. This is subject to change in future releases.
  - `participant`, `plated_sample` and `sample`
  - A large number of the columns will not be available for this initial release. This is subject to change in future releases.

**The data model for a number of the clinical tables is different to that in the 100,000 Genomes Project main programme releases. The below outlines where you would find the equivalent data in the main programme release.**

- `condition`, `observation` and `observation_component`
  - Data found in these tables can be found in the main programme tables `rare_disease_participant_disease` and `rare_disease_participant_phenotype`
- `referral` and `referral_participant`
  - For NHS GMS, cases are referred to as referrals and family members will be part of a single referral. Effectively, `referral_id` replaces the utility of `family_id` and the referral tables replace the utility of the `rare_disease_pedigree`, `rare_disease_pedigree_member` and `rare_disease_family` tables
  - The concept of `pedigree_member` doesn't exist in NHS GMS, only data on currently consented individuals is included

August 28, 2025
