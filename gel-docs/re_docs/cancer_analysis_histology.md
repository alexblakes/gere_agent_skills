---
title: 'Cancer analysis histology and TGCA study - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/cancer_analysis_histology/
scraped_at: 2026-05-04T06:31:28Z
---

# Cancer analysis histology and TGCA study

The 100kGP `cancer_analysis` table includes the results of bioinformatic sequence analysis, as well as categorisation of the cancer based on histology to TGCA studies.

The disease subtype attempts to classify tumours according to tumour type and was made at the time of registration. Thus, some participants may well have had their histological diagnosis adjusted over the course of treatment based on histology of resection specimens. This has lead to a need to provide additional histological data on cancer genomes alongside a consideration of updating the classification of tumours registered within the 100,000 Genome Project.

The Cancer Genome Atlas (TCGA), a landmark cancer genomics program, molecularly characterised over 20,000 primary cancer and matched normal samples spanning 33 cancer types. This joint effort between NCI and the National Human Genome Research Institute began in 2006, bringing together researchers from diverse disciplines and multiple institutions. In an attempt to continue to develop Genomics England cancer classification and to align with TCGA, we have now added histology from the Public Health England National Cancer Register and allocated a matched TCGA code where possible. The process to match vast volumes of data require clear processes and these have been documented below in the release note.

## Overview and purpose

To classify tumours based on histology, we match details in the `cancer_analysis` first with `av_tumour`, which is considered the main source of truth for tumours, and then `hes_apc`. The `match_rank` criteria is as follows:

| `match_rank` | meaning |
| --- | --- |
| 1 | Information in `cancer_analysis`, `av_tumour` and `apc` all agree with one another. |
| 2 | Information in `cancer_analysis` and `av_tumour` agree |
| 3 | Information in `av_tumour` and `apc` agree |
| 4 | Information in `cancer_analysis` and `apc` agree |
| 5 | There is no linkage between `cancer_analysis`, `av_tumour` and `apc` |

## Pipeline and logic

### Prerequisites

1. `A disease_type_translations` file created by domain experts consisting of four columns: *Study.Abbreviation*, *Study.Name*, *gel\_ca.disease\_type*, *ICD10*, *ICD.O.3*. Here *Study.Abbreviation* and *Study.Name* refer to the TCGA code and corresponding name. *gel\_ca.disease\_type* refers to the cancer\_analysis disease type that this TCGA code falls under.
2. The `av_tumour` LabKey table - This table is needed to find the relevant ICD10 and ICD.O.3 codes for a given participant in cancer\_analysis. Based on `disease_type_translations`, these ICD10 codes and ICD.O.3 codes are then mapped to TCGA codes. There may be multiple rows in `av_tumour` for a given participant, so the row with *diagnosisdatebest* closest to *tumour\_clinical\_sample\_time* is chosen.
3. The `apc` LabKey table - For any participants where there **is no** **data for in `av_tumour`,** ICD10 codes are extracted from `apc` and mapped to possible TCGA codes using 'disease\_type\_translations' file. Again, there may be multiple rows in `apc` for a given participant so the row with *opdate\_01* closest to *tumour\_clinical\_sample\_time* is chosen.
4. The most up-to-date `cancer_analysis` table from LabKey.
5. The participant list for the Data Release version at hand.

### Logic

#### Prepare the data:

1. Read in `cancer_analysis` the original cancer\_analysis table and keep all the columns.
2. Read in the whole `disease_type_translations`
3. Read in `av_tumour` and `apc`. The columns needed are as follows:

   | table | field | use |
   | --- | --- | --- |
   | av\_tumour | \* participant\_id  \* diagnosisdatebest | identifier |
   | av\_tumour | \* site\_coded\_3char  \* histology\_coded  \* histology\_coded\_desc | cross-reference |
   | apc | \* participant\_id  \* opdate\_01 | identifier |
   | apc | \* diag\_01 | cross-reference |
4. Filter `apc` based on diag\_01 code. Firstly select all rows that have a diag\_01 code containing a 'C'. Then remove any trailing X | - | D | - | A characters. and convert the diag\_01 codes to 3 character length. Now `av_tumour`, `apc` and 'disease\_type\_translations' all have 3 character ICD10 codes.

#### Compare av\_tumour and cancer analysis

1. Join `av_tumour` to `cancer_analysis` on *participant\_id.* This provides a table with all the cancer analysis columns plus *diagnosisdatebest, site\_coded\_3char,* *histology\_coded, histology\_coded\_desc* from `av_tumour`. However there are extra rows for given participants based on multiple rows in `av_tumour` for that participant.
2. Create a new column named *av\_tum.date\_difference* representing the absolute difference in days between *diagnosisdatebest* and *tumour\_clinical\_sample\_time.* Replace any null values with a placeholder value of 100000 days.
3. For instances where we have multiple rows in `av_tumour`, select the rows in the joined table with the minimum *av\_tum.date\_difference.* This provides a table with the original cancer\_analysis data and any data from `av_tumour` closest to the *tumour\_clinical\_sample\_time.* Refer to this joined table as '**ca\_av\_tum'.**

**Note:** *Not all the participants in cancer\_analysis appear in `av_tumour`, or there is no ICD10 code and histology\_code in `av_tumour` for some participants in cancer\_analysis. These are identifiable by looking at null diagnosisdatebest in 'ca\_av\_tum' and these are the participants where additional information from `apc` is required.*

#### Map the ICD10 codes and ICD.O.3 codes from av\_tumour to TCGA codes

1. Join the 'disease\_type\_translations' table with the 'ca\_av\_tum' on the following columns:

   | disease\_type\_translations columns | ca\_av\_tum columns |
   | --- | --- |
   | ICD10 | site\_coded\_3char |
   | ICD.O.3 | histology\_coded |

   The `disease_type_translations` file contains mappings to TCGA codes for many combinations of ICD10 and ICD.O.3 and thus mappings to corresponding `disease_type`s based on these TCGA codes. This means that given a participant in cancer\_analysis, if there is data for that participant in `av_tumour`, then the joined table will have corresponding TCGA code and the relevant disease\_type based on this TCGA code. This acts as a point of comparison between the *disease\_type* in `cancer_analysis` and the additional data provided by `av_tumour`.
2. Temporarily create a `av_tum.gel_match` column acknowledging whether the data in `av_tumour` agrees with the data in cancer\_analysis. Return TRUE if they are in agreement and FALSE otherwise. Note, null values will also return FALSE which is not a problem. This will later be used to aid the match\_rank system.

#### Compare apc and cancer analysis

Repeat similar steps as above but for `apc` instead of `av_tumour`.

1. Join `apc` to `cancer_analysis` on *participant\_id.*
2. Create a new column named *apc.date\_difference* representing the absolute difference in days between *opdate\_01* and *tumour\_clinical\_sample\_time.* Replace null values with a placeholder value of 100000 days.
3. For instances where there are multiple rows in `apc` for a participant in `cancer_analysis`, select the rows in the joined table with minimum *apc.date\_difference.* Refer to this joined table as **'ca\_apc'**.

***Note:** ICD10 codes from diag\_01 in `apc` is the only additional data that can be provided by `apc`. There are some instances where no ICD.O.3 code is needed to determine a unique TCGA code however there are also ambiguous cases where one ICD10 code could map to multiple TCGA codes. In these instances, domain experts manually went through these cases and selected a unique TCGA code based on the information for that participant.*

#### Map ICD10 codes from apc to TCGA codes

1. Reformat the 'disease\_type\_translations' table so that it contains all the possible TCGA codes for a given ICD10 code.
2. Join 'disease\_type\_translations' to 'ca\_apc' on the ICD10 columns:

   | disease\_type\_translations column | ca\_apc column |
   | --- | --- |
   | ICD10 | diag\_01 |

   This results in a table with TCGA codes for cancer\_analysis participants based on ICD10 codes in `apc`.
3. Temporarily create an *apc.gel\_match* column acknowledging whether the data in `apc` agrees with the data in cancer\_analysis. Return TRUE if they agree and FALSE otherwise.

#### Combine ca\_apc and ca\_av\_tum and deduce match\_rankings

1. Join ca\_apc and ca\_av\_tum on all the columns in cancer\_analysis and drop *diagnosisdatebest* and *opdate\_01*. This results in a table with all the columns in cancer analysis and the following fields:

   | table | field |
   | --- | --- |
   | ca\_av\_tum | \* site\_coded\_3char  \* histology\_coded  \* histology\_coded\_desc  \* av\_tum.Study.Abbreviation  \* av\_tum.Study.Name  \* av\_tum.gel\_ca.disease\_type  \* av\_tum.date\_difference  \* av\_tum.gel\_match |
   | ca\_apc | \* diag\_01  \* apc.Study.Abbreviation  \* apc.Study.Name  \* apc.gel\_ca.disease\_type  \* apc.date\_difference  \* apc.gel\_match |

   Where .Study.Abbreviation, Study.Name, gel\_ca.disease\_type refers to the joined TCGA code, name and disease\_type from the disease\_type\_translations file.
2. Now create new columns in the joined table taking the *Study.Abbreviation* from ca\_av\_tum and filling in any null values with the *Study.Abbreviation* from 'ca\_apc'. This prioritises matches with `av_tumour` and fills in any gaps with matches in `apc`.
3. Repeat the above for *Study.Name* and *gel\_ca.disease\_type*.
4. Create a new column named *match\_rank.* Fill it in based on the following conditions:

| match\_rank | condition | meaning |
| --- | --- | --- |
| 1 | if av\_tum.gel\_match == TRUE and apc.gel\_match == TRUE | Information in `cancer_analysis`, `av_tumour` and `apc` all agree with one another. |
| 2 | Omitting all rows with match\_rank 1: if av\_tum.gel\_match == TRUE | Information in `cancer_analysis` and `av_tumour` agree |
| 3 | Omitting all rows with match\_rank 1 and 2: if av\_tum.gel\_ca.disease\_type == apc.gel\_ca.disease\_type | Information in `av_tumour` and `apc` agree |
| 4 | Omitting all rows with match\_rank 1,2 and 3: if disease\_type == apc.gel\_ca.disease\_type | Information in `cancer_analysis` and `apc` agree |
| 5 | Omit rows with match\_rank 1,2,3 and 4 leaves data where there is no linkage between cancer\_analysis, av\_tumour and apc. | No linkage - either there is no data in av\_tumour or apc, or there is no agreement between all 3. |

#### Drop unneeded columns leaving the following schema

from cancer\_analysis:

- all columns

from av\_tumour:

- histology\_coded
- histology\_coded\_desc

from disease\_type\_translations:

- Study.Name
- Study.Abbreviation

calculated columns:

- av\_tum.date\_difference
- apc.date\_difference
- match\_rank

##### Code lists

| Study Abbreviation | Study Name | Genomics England Disease type |
| --- | --- | --- |
| GBM | Glioblastoma multiforme | ADULT\_GLIOMA |
| LGG | Brain Lower Grade Glioma | ADULT\_GLIOMA |
| NEURO | Neurological other | ADULT\_GLIOMA |
| BLAD | Bladder other | BLADDER |
| BLCA | Bladder Urothelial Carcinoma | BLADDER |
| BRCA | Breast invasive carcinoma | BREAST |
| COAD | Colon adenocarcinoma | COLORECTAL |
| CRC | Colorectal other | COLORECTAL |
| GINET | Colorectal and Upper GI neuroendocrine | COLORECTAL |
| READ | Rectum adenocarcinoma | COLORECTAL |
| ACC | Adrenocortical carcinoma | ENDOCRINE |
| ENDO | Endocrine other | ENDOCRINE |
| THCA | Thyroid carcinoma | ENDOCRINE |
| UCEC | Uterine Corpus Endometrial Carcinoma | ENDOMETRIAL\_CARCINOMA |
| UCESC | Uterine Corpus Endometrial Serous Carcinoma | ENDOMETRIAL\_CARCINOMA |
| UTE | Uterine other | ENDOMETRIAL\_CARCINOMA |
| AML | Acute myeloid Leukaemia | HAEMONC |
| DLBC | Lymphoid Neoplasm Diffuse Large B-cell Lymphoma | HAEMONC |
| HAEM | Haematological malignancy other | HAEMONC |
| LYMP | Lymphoid | HAEMONC |
| MYEL | Myeloid | HAEMONC |
| CHOL | Cholangiocarcinoma | HEPATOPANCREATOBILIARY |
| HPB | Hepatopancreatobiliary other | HEPATOPANCREATOBILIARY |
| LIHC | Liver hepatocellular carcinoma | HEPATOPANCREATOBILIARY |
| PAAD | Pancreatic adenocarcinoma | HEPATOPANCREATOBILIARY |
| LCNEC | Lung neuroendocrine | LUNG |
| LUAD | Lung adenocarcinoma | LUNG |
| LUG | Lung other | LUNG |
| LUSC | Lung squamous cell carcinoma | LUNG |
| MESO | Mesothelioma | LUNG |
| THYM | Thymoma | LUNG |
| SKCM | Skin Cutaneous Melanoma | MALIGNANT\_MELANOMA |
| UVM | Uveal Melanoma | MALIGNANT\_MELANOMA |
| HAN | Head and Neck other | ORAL\_OROPHARYNGEAL |
| HNSC | Head and Neck squamous cell carcinoma | ORAL\_OROPHARYNGEAL |
| DERM | Other malignant neoplasms of skin | OTHER |
| EDOC | Ovarian endometrioid adenocarcinoma | OVARIAN |
| HGSOC | High grade Ovarian serous cystadenocarcinoma | OVARIAN |
| LGSOC | Low grade Ovarian serous carcinoma | OVARIAN |
| OVAR | Ovarian other | OVARIAN |
| PRAD | Prostate adenocarcinoma | PROSTATE |
| PROS | Prostate other | PROSTATE |
| KICH | Kidney Chromophobe | RENAL |
| KIRC | Kidney renal clear cell carcinoma | RENAL |
| KIRP | Kidney renal papillary cell carcinoma | RENAL |
| NEPH | Renal other | RENAL |
| SARC | Sarcoma | SARCOMA |
| TEST | Testicular other | TESTICULAR\_GERM\_CELL\_TUMOURS |
| TGCT | Testicular Germ Cell Tumors | TESTICULAR\_GERM\_CELL\_TUMOURS |
| EAC | Esophageal adenocarcinoma | UPPER\_GASTROINTESTINAL |
| ESCA | Esophageal squamous cell carcinoma | UPPER\_GASTROINTESTINAL |
| SMIN | Small Intestine Neoplasm | UPPER\_GASTROINTESTINAL |
| STAD | Stomach adenocarcinoma | UPPER\_GASTROINTESTINAL |
| INSIT | In-situ and pre-malignant lesions |  |
| Other | Other/ Unmatched/ NA |  |

February 13, 2025
