---
title: 'General NHS GMS clinical data - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/gms_common_clinical/
scraped_at: 2026-05-04T06:32:18Z
---

# General NHS GMS clinical data

A number of tables in LabKey are common to all participants, both cancer and rare disease participants. These cover data about the participants themselves, the samples and results of bioinformatic analyses. All tables and their fields are described in our [data dictionary](../GMS_data_dictionary/).

> **Primary and secondary data tables:**
>
> Primary clinical data were collected when participants were enrolled in the programme.
>
> Secondary clinical data were obtained from third parties such as NHSE.

| Name of Table/Data view | Description | Primary or secondary |
| --- | --- | --- |
| participant | Data associated with a patient within the NHS GMS. |  |
| plated\_sample | Data associated with a plated, ready to be sequenced, DNA sample. |  |
| referral | Data associated with a referral within the NHS GMS, including the clinical indication that the participant was recruited for. |  |
| referral\_participant | A patient participating in an NHS GMS referral. |  |
| referral\_test | Data associated with a test within an NHS GMS referral. |  |
| sample | Data associated with a medical sample taken from a patient and submitted to a laboratory for genomic sequencing. |  |
| genome\_file\_paths\_and\_types | Specifies individual genomic files and their folder locations for a given participant. |  |
| sequencing\_report | For each participant, this table provides information on the sequencing of their genome(s) and associated output, as well as the sample type that the sequence is from. |  |

## Participant medical history

Secondary Clinical Data is available for NHS GMS participants with current consent. Clinical data is not available for participants that have withdrawn from the NHS GMS or were otherwise ineligible.

### Hospital Episodes Statistics from NHSE

[**Hospital Episodes Statistics (HES)**](http://content.digital.nhs.uk/hes) contain details of all admissions, outpatient appointments, critical care and A&E attendances at NHS hospitals in England. Each data entry is collected during a patient's time in hospital and are submitted to allow hospitals to be paid for the care they deliver. HES data are designed to enable secondary use, that is use for non-clinical purposes, of these administrative data.

It is a records-based system that covers all NHS trusts in England, including acute hospitals, primary care trusts and mental health trusts. HES information is stored as a large collection of separate records and Genomics England receives regular partial exports of HES data held for each of the participants within the NHS GMS, which are linked with their Participant ID. HES data are presented in LabKey as separate datasets.

The HES data are presented in LabKey with each row representing a separate period of care for that participant. Therefore, each participant may have one or more rows of data. Often there will be empty fields, due to the way the data is structured.

| LabKey table | Description | Primary or secondary |
| --- | --- | --- |
| `hes_ae` | accident and emergency; contains historic records of A&E attendances |  |
| `hes_apc` | admitted patient care; contains historic records of admissions into secondary care. |  |
| `hes_cc` | critical care; contains historic records of admissions into critical care. |  |
| `hes_op` | outpatient; contains historic records of outpatient attendances. |  |
| `ecds` | Main dataset of urgent and emergency care. Expands hes\_ae and will replace it entirely in the future. |  |
| `mortality` | lists the Office of National Statistics' cause of death records. |  |

Some data-points, such as diagnoses and treatments, are split across multiple columns since there will be multiple entries per visit. There are also columns that concatenate these values together, making them easier to search.

Concatenated columns available

The concatenated columns in each of the tables are shown in the table below:

| Table | Concatenated Column Name | Source Columns |
| --- | --- | --- |
| `ecds` | `care_professional_tier_all` | `care_professional_tier_01` - `care_proffessional_tier_10` |
| `ecds` | `classification_all` | `classification_01` - `classification_04` |
| `ecds` | `comorbidities_all` | `comorbidities_01` - `comorbidities_10` |
| `ecds` | `diagnosis_code_all` | `diagnosis_code_01` - `diagnosis_code_12` |
| `ecds` | `diagnosis_qualifier_all` | `diagnosis_qualifier_01` - `diagnosis_qualifier_12` |
| `ecds` | `drug_alcohol_code_all` | `drug_alcohol_code_01` - `drug_alcohol_code_04` |
| `ecds` | `investigation_code_all` | `investigation_code_01` - `investigation_code_12` |
| `ecds` | `treatment_code_all` | `treatment_code_01` - `treatment_code_12` |
| `hes_apc` | `acpdisp_all` | `acpdisp_1` - `acpdisp_9` |
| `hes_apc` | `acpdqind_all` | `acpdqind_1` - `acpdqind_9` |
| `hes_apc` | `acploc_all` | `acploc_1` - `acploc_9` |
| `hes_apc` | `acpout_all` | `acpout_1` - `acpout_9` |
| `hes_apc` | `acpsour_all` | `acpsour_1` - `acpsour_9` |
| `hes_apc` | `acpspef_all` | `acpspef_1` - `acpspef_9` |
| `hes_apc` | `diag_all` | `diag_01` - `diag_20` |
| `hes_apc` | `opertn_all` | `opertn_01` - `opertn_24` |
| `hes_ae` | `diag_all` | `diag_01` - `diag_12` |
| `hes_ae` | `diag2_all` | `diag2_01` - `diag2_12` |
| `hes_ae` | `diaga_all` | `diaga_01` - `diaga_12` |
| `hes_ae` | `diags_all` | `diags_01` - `diags_12` |
| `hes_ae` | `invest_all` | `invest_01` - `invest_12` |
| `hes_ae` | `invest2_all` | `invest2_01` - `invest2_12` |
| `hes_ae` | `treat2_all` | `treat2_01` - `treat2_12` |
| `hes_ae` | `treat_all` | `treat_01` - `treat_12` |
| `hes_op` | `diag_all` | `diag_01` - `diag_12` |
| `hes_op` | `opertn_all` | `opertn_01` - `opertn_24` |
| `mortality` | `icd10_multiple_cause_all` | `icd10_multiple_cause_01` - `icd10_multiple_cause_15` |

Diagnosis and treatment codes

### ICD-10

ICD-10 is a classification of diseases that allows systematic recording, analysis, interpretation and comparison of mortality and morbidity data. It is the international standard diagnostic classification for all general epidemiological and many health-management purposes. Although the ICD is primarily designed for the classification of diseases and injuries with a formal diagnosis, not every problem or reason for coming into contact with health services can be categorised in this way.

ICD-10 codes must be used in the manner set forth in [Volume 2: | | Instruction Manual of the International Statistical Classification of Diseases and Related Health Problems, Tenth Revision](http://apps.who.int/classifications/icd10/browse/Content/statichtml/ICD10Volume2_en_2016.pdf). You are responsible for ensuring that the codes are properly used in this manner.

For more information on ICD-10, please see the ['International statistical classification of diseases and related health problems (ICD-10)'](https://www.who.int/publications/i/item/WHO-SDE-OEH-99.11) document.

ICD codes and code descriptions are deposited in the Research Environment under the folder: | | `/gel_data_resources/licenced_resources/ICD10`

### ICD-O-3

The [International Classification of Diseases for Oncology (ICD-O)](http://codes.iarc.fr/) is internationally recognised as the definitive classification of neoplasms. It is used by cancer registries throughout the world to record incidence of malignancy and survival rates, and the data produced are used to inform cancer control, research activity, treatment planning and health economics. The classification of neoplasms used in ICD-O links closely to the definitions of neoplasms used in the WHO/IARC Classification of Tumours series, which are compiled by consensus groups of intenational experts and, as such, the classification is underpinned by the highest level of scientific evidence and opinion.

ICD-O consists of two axes (or coding systems), which together describe the tumour:

- the [`topographical`](http://codes.iarc.fr/topography/) code, which describes the anatomical site of origin (or organ system) of the tumour
- the [`morphological`](http://codes.iarc.fr/codegroup/) code, which describes the cell type (or histology) of the tumour, together with the behaviour (malignant or benign).

### SNOMED

[SNOMED](https://en.wikipedia.org/wiki/SNOMED) was started in 1965 as a Systematised Nomenclature of Pathology (SNOP) and was further developed into a logic-based health care terminology. SNOMED CT was created in 1999 by the merger, expansion and restructuring of two large-scale terminologies: SNOMED Reference Terminology (SNOMED RT) and the Clinical Terms Version 3 (CTV3) (formerly known as the [Read codes](https://en.wikipedia.org/wiki/Read_codes)), developed by the NHS.

December 6, 2024
