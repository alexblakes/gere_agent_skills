---
title: 'GMS cancer-specific clinical data - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/gms_cancer_clinical/
scraped_at: 2026-05-04T06:32:17Z
---

# GMS cancer-specific clinical data

Some tables in LabKey contain data specific to cancer participants. All tables and their fields are described in our [data dictionary](../GMS_data_dictionary/).

> **Primary and secondary data tables:**
>
> Primary clinical data were collected when participants were enrolled in the programme.
>
> Secondary clinical data were obtained from third parties such as NHSE.

Cancer data are presented at the participant level or sample level. All tumour samples have a matched germline sample. One participant might have more than one tumour sample, which, in such a case, could be related to temporal samples, two different tumours or, rarely, biological replicates.

## Central tables

| Name of table/data view | Description | Primary or secondary |
| --- | --- | --- |
| `cancer_analysis` | Once tumour and germline whole genome sequencing data is delivered by our sequencing partners it is run through the Genomics England interpretation pipeline, which realigns the data, and applies further QC, annotation and variant prioritisation steps, together with additional analyses, such as estimating tumour mutation burden and generating mutational signatures. This information is then made available in the `cancer_analysis` table, where each entry corresponds to one tumour sample that has been sequenced and interpreted. Samples are uniquely identified by their `tumour_sample_platekey` number, and matched to the information of their germline, as well as disease type, quality control measures, tumour mutational burden, signatures and paths to the alignment and variant calling files. Note that one participant may have more than one tumour sample, for the same or different tumours. |  |
| `tumour` | Data associated with a tumour in the NHS GMS. |  |
| `tumour_morphology` | Morphology data associated with a tumour in the NHS GMS. |  |
| `tumour_topography` | Topography data associated with a tumour in the NHS GMS. |  |

## NHSE-NCRAS cancer clinical data

Data from the third party NHSE, including data from the [National Cancer Registration and Analysis Service | NCRAS)](https://www.gov.uk/guidance/national-cancer-registration-and-analysis-service-ncras), describing cancer patients' medical history. The NCRAS is responsible for cancer registration in England to support cancer epidemiology, public health, service monitoring and research.

Cancer Registration (AV) is the systematic collection of data about cancer and tumour diseases. In England, this data collection is managed by NCRAS. Every year, NCRAS collects information on over 300,000 cases of cancer, including patient details (including their name, address, age, sex, and date of birth), as well as detailed data about the type of cancer, how advanced it is and the treatment the patient receives. At Genomics England the data are stripped out of identifiable information and associated to a the patient's `participant_id` so that these data can be linked to other clinical and also the genomic data.

This dataset brings together data from more than 500 local and regional datasets to build a picture of an individual's treatment from diagnosis.

> **Note:**
>
> `tumour_ids` in AV tables are assigned to participants by NCRAS and do not link to the `tumour_ids` assigned by Genomics England for sequencing and clinical data. Whilst this may refer to the same cancer, you should be cautious when linking these together.

| LabKey table | Description | Primary or secondary |
| --- | --- | --- |
| `av_patient` | demographics from the Cancer Registration and information about vital status and cause of death, when applicable by the last day of data collection for the AV tables. |  |
| `av_tumour` | medical information about the tumour, including hormonal status (PR, ER and HER2), date of diagnosis, site, morphological and behaviour ICD10 codes as well as histology and grade. Table's `anon_tumour_id` is used to link treatment tables also available in NCRAS. One row per tumour (`av*` table specific `anon_tumour_id`), per participant at the point of registration of that cancer/tumour with NCRAS. |  |
| `av_treatment` | treatment received for each participant. One participant receives more than one treatment, which includes surgery, chemo, immuno and radiotherapy. |  |
| `av_rtd` | routes to diagnosis; these routes have been determined [using a model](https://europepmc.org/article/MED/22996611) that combines AV data with HES data, Cancer Waiting Times (CWT) data and data from the cancer screening programmes. Using these datasets cancers registered in England which were diagnosed in 2006 to 2016 are categorised into one of eight Routes to Diagnosis. |  |
| `av_imd` | income deprivation domain; measures the proportion of the population experiencing deprivation relating to low income. The definition of low income used includes both those people that are out-of-work and those that are in work but who have low earnings. |  |
| `rtds` | [radiotherapy dataset](https://digital.nhs.uk/ndrs/data/data-sets/rtds); is an existing standard (SCCI0111) that has required all NHS Acute Trust providers of radiotherapy services in England to collect and submit standardised data monthly against a nationally defined data set since 2009. The purpose of the standard is to collect consistent and comparable data across all NHS Acute Trust providers of radiotherapy services in England in order to provide intelligence for service planning, commissioning, clinical practice and research and the operational provision of radiotherapy services across England. Data are available from 01/04/2009. |  |
| `sact` | [systemic anti-cancer therapy](https://digital.nhs.uk/ndrs/data/data-sets/sact); contains clinical management on patients receiving cancer chemotherapy, and newer agents that have anti-cancer effects, in or funded by the NHS in England. It covers chemotherapy treatment for all solid tumour and haematological malignancies and those in clinical trials. It relates to all cancer patients, both adult and paediatric, in acute inpatient, day case, outpatient settings and delivery in the community. |  |

March 26, 2026
