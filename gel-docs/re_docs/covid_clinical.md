---
title: 'COVID-19 clinical data - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/covid_clinical/
scraped_at: 2026-05-04T06:31:56Z
---

# COVID-19 clinical data

The clinical datasets made available in Genomics England CloudOS include:

- Data collected at the point of recruitment ('Primary' data )
- Longitudinal records of treatment provided by the NHS ('Secondary' data )
- Non-genomic data curated by GEL.

Combined clinical data is available for both COVID-19 and 100kGP participants, including:

- Severe COVID-19 cohort (admitted to ITU for COVID-19).
- Mild COVID-19 cohort (not admitted to ITU for COVID-19).
- 100kGP cohort (not admitted to ITU for COVID-19).

## Data De-Identification

Not all variables/columns in the raw datasets received from NHSE, or other providers, are included in the release. In particular, some will be personal identifiable data (PID) and so are not present in the de-identified data within the Research Environment.

## Mechanisms for access

There are two main ways to access the Clinical Data from within [CloudOS](../cloudos/):

- As raw files in s3 buckets - via the `Data & Results > GEL Structured Data` section of [CloudOS](../cloudos/)
- [The Cohort Browser GUI](https://lifebit.atlassian.net/wiki/spaces/CD/pages/813106752/Build+a+cohort)

This clinical data in the `Data & Results` section of GEL CloudOS includes the latest version of the clinical data available: 100K v17.0 and COVID-19 v6.0 clinical data as of date freeze on 21-08-2023. However, the Cohort Browser currently only includes an older version of 100kGP data, 100kGP v14.0 and COVID-19 v4.0. This asynchrony is the result of a delay in ingestion processes. In the near future, we will synchronise data refreshes between CloudOS (s3) and the Cohort Browser, to avoid such discrepancies.

## Data Available

This section refers to the COVID-19 branch of data in GEL CloudOS (s3) as highlighted in blue in the diagram above. This is the COVID-19 (and 100k) data at release v6.0.

The v6.0 data release contains the following datasets:

| Dataset name | File Name in CloudOS/S3 | Description | Cohorts |
| --- | --- | --- | --- |
| GenOMICC Participants and Demographics | `genomicc_participants_and_demographics_covid_19.tsv` | Contains information on all COVID Severe participants up to data release | severe |
| GenOMICC Mild Participants and Demographics | `genomicc_mild_participants_and_demographics_covid_19.tsv` `genomicc_mild_react_lc_participants_and_demographics_covid_19.tsv` | Contains information on all COVID Mild participants up to data release | mild |
| GenOMICC Parents Participants and Demographics | `genomicc_parents_participants_and_demographics_covid_19.tsv` | Contains family information on COVID participants up to data release | severe mild |
| GenOMICC Mild Symptoms | `genomicc_mild_symptoms_covid_19.tsv` | Contains information on COVID symptoms for Mild participants | mild |
| ISARIC | `genomicc_international_severe_acute_respiratory_and_emerging_infection_consortium_covid_19.tsv` | Contains information on participants in the ISARIC study. There is no secondary data for these participants. |  |
| PHOSP | `genomicc_post_hospitalisation_covid_19.tsv` | Contains information on participants in the PHOSP study. There is no secondary data for these participants. |  |
| Intensive Care National Audit and Research Centre | `intensive_care_national_audit_and_research_centre_covid_19.tsv` | Contains information about participants that got COVID-19 whilst in intensive care | severe mild 100kGP |
| NHS D GPES Data for Pandemic Planning and Research | `nhs_d_general_practice_extraction_service_gpes_data_for_pandemic_planning_and_research_covid_19.tsv` | Contains GP information for COVID-19 planning and research | severe mild |
| NHS D GPES Data for Pandemic Planning and Research Reference | `nhs_d_general_practice_extraction_service_gpes_data_for_pandemic_planning_and_research_reference_covid_19.tsv` | Reference for GP information for COVID-19 planning and research | severe mild |
| COVID 19 Hospitalisation in England Surveillance System | `phe_covid_19_hospitalisation_in_england_surveillance_system_covid_19.tsv` | Contains the demographic, risk factor, treatment and outcome for patients admitted to hospital with a confirmed COVID-19 diagnosis as recorded by NHSE | severe mild |
| Second Generation Surveillance System (SGSS) is the National Laboratory Reporting System | `phe_second_generation_surveillance_system_sgss_is_the_national_laboratory_reporting_system_covid_19.tsv` | Contains the demographic and diagnostic information from laboratory test reports for patients tested for the suspected and confirmed causative agent for COVID-19 as recorded by NHSE | severe mild |
| Viral Genomes | `gel_cog_alignment_covid_19.fasta` `gel_cog_all_covid_19.fasta` `gel_cog_unmasked_alignment_covid_19.fasta` `gel_cog_metadata_covid_19.tsv` `gel_naive_variant_table_covid_19.tsv` | Datasets and FASTA files containing information on participants viral genomes | severe |

Also included in the COVID dataset are the Secondary datasets from NHS England, as in the [100kGP dataset](../general_clinical/#participant-medical-history).

| Dataset name | File Name in CloudOS/S3 | Description | Cohorts |
| --- | --- | --- | --- |
| NHS D Cancer Registry | `nhs_d_cancer_registry_covid_19.tsv` | Contains tumour level records for participants | severe mild 100kGP |
| NHS D Diagnostic Imaging Metadata | `nhs_d_diagnostic_imaging_linkage_covid_19.tsv` | Links participants to Diagnostic Imaging Data (does not contain actual images) | severe mild 100kGP |
| NHS D Diagnostic Imaging Linkage | `nhs_d_diagnostic_imaging_metadata_covid_19.tsv` | Contains historic diagnostic imaging records for participants (does not contain actual images) | severe mild 100kGP |
| NHS D Emergency Care Dataset | `nhs_d_emergency_care_dataset_covid_19.tsv` | Contains emergency care data to help understand A&E activity (replacing HES AE from April 2020) | severe mild 100kGP |
| NHS D Hospital Episodes Statistics Accident and Emergency | `nhs_d_hospital_episodes_statistics_accident_and_emergency_covid_19.tsv` | Contains historic records of A&E attendances for participants (replaced by ECDS from April 2020) | severe mild 100kGP |
| NHS D Hospital Episodes Statistics Admitted Patient Care | `nhs_d_hospital_episodes_statistics_admitted_patient_care_covid_19.tsv` | Contains historic records of admissions into secondary care for participants | severe mild 100kGP |
| NHS D Hospital Episodes Statistics Critical Care | `nhs_d_hospital_episodes_statistics_critical_care_covid_19.tsv` | Contains historic records of admissions into critical care for participants | severe mild 100kGP |
| NHS D Hospital Episodes Statistics Outpatient | `nhs_d_hospital_episodes_statistics_outpatient_covid_19.tsv` | Contains historic records of outpatient attendances for participants | severe mild 100kGP |
| NHS D Mental Health Services Datasets | `nhs_d_mental_health_services_dataset_**` where `**` refers to any of the MHSDS tables. Those with `curated` prefix are ones made by GEL to compile key information from the datasets into logical groupings. The dataset flags table provides an overview of which tables a certain participant appears in. | Contains historic records of a participant's interaction with mental health services | severe mild 100kGP |
| Office of National Statistics Mortality | `office_of_national_statistics_mortality_covid_19.tsv` | Contains the causes of death records for participants according to the Office of National Statistics | severe mild 100kGP |

> **Note:**
>
> Datasets may appear to be in CloudOS more than once, however they are not actually the same datasets. This is because datasets may appear in the COVID DSA and the RE1.0 DSA. Therefore, they will differ in participants and schemas slightly. These datasets will differ in name with the suffix that follows the file name with '\_covid\_19' for datasets in COVID-19 DSA and '\_100k' following datasets in RE1.0 DSA. In future releases, NHSD and PHE data for Mild participants will be included.

February 13, 2025
