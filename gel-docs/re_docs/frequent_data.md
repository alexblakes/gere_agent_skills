---
title: 'Frequent data releases - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/frequent_data/
scraped_at: 2026-05-04T06:32:06Z
---

# Frequent data releases

From March 2020 to September 2021 we collected NHSE COVID-19 test results for our participants. These data were stored in the top-level Labkey project 'Frequent-Release'. These were updated at a more frequent schedule than was supported by the 100kGP release schedule. The data in the table is for participants in the 100kGP and can be joined with that in the latest 100kGP release.

## Data dictionary

This describes extracts from the NHSE microbiology results database, known as SGSS, following linkage to external cohort studies. Linkage is made by NHS number, and all positive and negative results are included. The export is in CSV format, and if commas are included in a value, then the value will be quoted.

| Field Name | Description |
| --- | --- |
| `participant_id` | The NHS number. This is not present in the UK Biobank extract. |
| `patient_sex` | Participant gender, as provided by the cohort linked to. This is not used for record linkage but it returned as a sanity check to QC linkage on NHS number. |
| `patient_yob` | Participant year of birth. |
| `specimen_date` | The date the specimen was taken. |
| `specimen_type_desc` | The specimen type as recorded on the laboratory request form. |
| `lab_name` | The laboratory processing the sample. |
| `inpatient_indicator` | This is a derived field but is included in case it is helpful. Set to either True (`1`) or False (`0`). The NHSE Microbiology data source (SGSS) is not linked to hospital admission data. However, an indicator of whether the patient was an inpatient when the sample was taken can be obtained. If `INPATIENT_INDICATOR` is set, this can be interpreted as "There is evidence from the microbiological records that the patient was an inpatient". If it is not set, this can be interpreted as "There is no evidence in the microbiological record that the patient has been an inpatient, but they may have been as the microbiology data source is not linked to admissions data". `Inpatient_indicator` is based on information provided on the specimen request form as to specimen location, and other information: if the specimen is marked as being from an Acute (emergency) care provider, an Accident and emergency department, from an inpatient location, or resulted from health care associate infection, it is recorded as an inpatient sample. The fields from which this indicator is derived are included in the extract. |
| `rqsting_organistion_type_desc` | The requesting organisation description, if provided. This is used in the construction of INPATIENT\_INDICATOR. |
| `acute_flag` | Set true (`1`) if the requesting organisation is from an organisation known to provide acute (emergency) care otherwise not true (`0`). |
| `hospital_acquired_indicator` | Whether the sample is recorded as being hospital acquired. `U` = unknown (default), `N` = no, `Y` = yes. |
| `sarscov2_positive` | Whether the sample was reported as positive (`1`) or negative (`0`) for SARS-CoV-2. |
| `patient_death_date` | The patient's death date. This is ascertained by ONS data linkage. Null entries indicate that patient is not registered by Office for National Statistics as having died. Linkage occurs daily, but death ascertainment may lag behind actual mortality. |

Please be aware that:

- PHE is integrating data from a large number of NHS laboratories and third party organisations, at a very rapid rate.
- Not all laboratories are reporting negative results.
- It is possible that duplicate entries may exist, because some laboratories' results may reach SGSS via several different routes.
- Results from NHS providers are all integrated at present.
- There is a plan to integrate data from the Milton Keynes Superlab and similar academic/industry partnerships. These initiatives are at present being used predominantly to test Health Care Workers, but these results are not currently integrated
- As of 16th March 2020, when the UK entered the 'delay' phase of the outbreak, testing was largely restricted to those referred to hospital, who are likely to be on the severe end of the disease spectrum. Admission to hospital for infection control reasons alone has not been practiced in the delay phase. Therefore, positive results from those for whom there is evidence (from the microbiology record) of hospitalisation are likely to be derived from cases of clinically significant COVID disease.
- The SGSS database does not contain clinical information
- The date of death is obtained by Office for National Statistics linkage on the date of the extract
- When we extract weekly data, we will re-extract all records linking to the NHS number list in the external cohort

March 26, 2026
