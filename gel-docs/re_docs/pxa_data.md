---
title: 'Data in Participant Explorer - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/pxa_data/
scraped_at: 2026-05-04T06:33:19Z
---

# Data in Participant Explorer

## Data sources

### Participant data

Participant clinical data is obtained from the source data in the most recent versions of the [100kGP data release](../current_release/) and [NHS\_GMS data release](../current_gms/). Please see the Participant Explorer [release notes](../pxa_release/) for the current data versions.

The source data are imported into a Postgres database and mapped to a standard data model (HL7 FHIR) using SQL. The Participant Explorer UI operates on top of the FHIR model, but hides the technical details of FHIR (such as element names and extension URLs) to create a user-friendly, intuitive interface. A detailed overview of the mapping from source tables and columns to elements in the UI is given below.

Various elements in the Participant Explorer UI also provide clickable deep links to the source data into LabKey.

### Reference data

Terminology reference data is provided by a FHIR terminology server, developed by the [AEHRC](https://aehrc.com/research/software/ontoserver/). For details of the terminology server instance we are using, see the [Terminology Server](../terminology_server/) page.

## Conceptual data model

The diagram below depicts the clinical data model used for representing participant data in the Participant Explorer. This model is based on the HL7 FHIR resource model.

| Participant Explorer Label | FHIR Resource Type | Definition (from [FHIR](https://www.hl7.org/)) | Meaning in terms of the 100kGP/NHS-GMS datasets |
| --- | --- | --- | --- |
| Participant | Patient | Demographics and other administrative information about an individual receiving care or other health-related services. | All consenting participants including probands and their relatives. |
| Referral | ServiceRequest | A record of a request for service such as diagnostic investigations, treatments, or operations to be performed | The referral to the Genomics Medicine Service for a genomic test for a specific clinical indication (NHS-GMS) or the recruitment to the 100kGP project for one of the eligible diseases. |
| Condition | Condition | A clinical condition, problem, diagnosis, or other event, situation, issue, or clinical concept that has risen to a level of concern. | Diagnoses from primary clinical data (including the recruited disease) and secondary data. |
| Observation | Observation | Measurements and simple assertions made about a patient | Phenotypic observations (HPO terms), Tumour morphology and stage observations |
| Procedure | Procedure | An action that is or was performed on or for a patient. This can be a physical intervention like an operation, or less invasive like long term services, counselling, or hypnotherapy. | Procedure and operation codes from primary and secondary data |
| Encounter | Encounter | An interaction between a patient and healthcare provider(s) for the purpose of providing healthcare service(s) or assessing the health status of a patient. | Grouping of conditions, observations and procedures by visit/event |
| Family Member | FamilyMemberHistory | Significant health conditions for a person related to the patient relevant in the context of care for the patient. | Key details and affected-status of family members of rare disease probands (Note: family members who are also participants will also have a patient/participant record) |
| Genome Sequence | DiagnosticReport | The findings and interpretation of diagnostic tests performed on patients, groups of patients, devices, and locations, and/or specimens derived from these. | Sequencing report meta information |
| Family Case Report | DiagnosticReport | The findings and interpretation of diagnostic tests performed on patients, groups of patients, devices, and locations, and/or specimens derived from these. | GMC exit questionnaire (case status and additional comments) |
| Drugs, Drug Group | MedicationAdministration | Describes the event of a patient consuming or otherwise being administered a medication. | SACT (chemotherapy) drug administrations |

## Code systems overview - using the right codes

The following table can help you select the code systems to use when searching by clinical concept, depending on your area of interest and scope. It also indicates whether the "include mapped concepts" feature may be of use. Below the table are examples involving each code system.

Note that OMIM and ORPHA codes, present in NHS-GMS referral data, are not yet searchable in Participant Explorer so are not described here. However, they are displayed in the Participant Details and Download pages.

| Code System Short Name | Description | Primary Clinical Data (data associated with referrals) | Secondary Data (longitudinal data independent of referrals) | Concept Maps Available? |
| --- | --- | --- | --- | --- |
| **100kGP Rare Disease** | Rare disease groups, subgroups and specific diseases for which participants were recruited in the Genomics England 100kGP | Rare diseases groups, subgroups and specific diseases (100kGP only) | N/A | No |
| **100kGP Cancer Type** | Cancer disease types for which participants were recruited in the Genomics England 100kGP | Cancer disease types (100kGP only) | N/A | No |
| **100kGP Cancer Subtype** | Cancer disease subtypes for which participants were recruited in the Genomics England 100kGP | Cancer disease subtypes (100kGP only) | N/A | No |
| **NHS-GMS Clinical Indication** | Clinical indications for which participants were referred to the NHS-GMS | Referral clinical indications (NHS-GMS only) | N/A | No |
| **ICD10** | ICD-10, WHO International Classification of Diseases | Cancer diagnoses (100kGP only) | - NHS inpatient/outpatient hospital diagnoses - NHS causes of death - NCRAS cancer diagnoses - NHS mental health services diagnoses (100kGP only) | Yes, SNOMED to ICD10 |
| **HPO** | Human Phenotype Ontology | Observed phenotypes (rare disease referrals, "present" phenotypes only) | N/A | Yes, SNOMED to ICD10 |
| **ICDO** | ICD-O-3, WHO International Classification of Diseases for Oncology | Tumour morphology and topography (100kGP only) | NCRAS tumour morphology | No |
| **OPCS** | OPCS-4 Classification of Interventions and Procedures | Cancer imaging and surgery (100kGP only) | - NHS inpatient/outpatient hospital operations - NCRAS cancer treatments | Yes, SNOMED to OPCS |
| **SNOMED** | SNOMED CT (UK Edition) | - Tumour morphology and topography - Rare disease and cancer imaging (100kGP only) | - NHS emergency care diagnoses and treatments - NHS imaging procedures (100kGP only) - NHS mental health services diagnoses and observations (100kGP only) | Yes, SNOMED to ICD10, OPCS and HPO. |
| **SACT Drug Group** | Drugs used in treatments recorded in the SACT data | N/A | NCRAS chemotherapy drugs | No |

### Examples

**100kGP Rare Disease | Intellectual Disability:** selects participants who were *recruited in the 100kGP* for intellectual disability (including affected relatives)

**100kGP Cancer Type | Lung:** selects participants who were *recruited in the 100kGP* for lung cancer.

**NHS-GMS Clinical Indication | R29: Intellectual Disability:** selects participants who were *referred to the NHS-GMS* with a clinical indication of intellectual disability (including affected relatives)

**HPO | HP:0012622: Chronic kidney disease:** selects participants with an observed phenotype of chronic kidney disease *in their 100kGP or NHS-GMS referral* (rare disease referrals only, including relatives, "present" phenotypes only).

**ICD10 | C50: Malignant neoplasm of breast:** selects participants with a diagnosis of breast cancer, either in their referral data or longitudinal data (this can include participants who are referred for a rare disease or other cancer types).

**OPCS | J01: Transplantation of liver:** selects participants with a liver transplantation record in their referral data or longitudinal data.

**SCT | 241620005: Cardiac MRI**: selects participants with a record of a cardiac MRI in their referral data or longitudinal data.

**SCT | 38341003: Hypertensive disorder (with mapped concepts DISABLED)**: select participants with a diagnosis of hypertensive disorder in their longitudinal emergency care or mental health services data, because SNOMED diagnoses codes are currently only available in these data sets.

**SCT | 38341003: Hypertensive disorder (with mapped concepts ENABLED):** adds equivalent ICD10 and HPO codes for hypertensive disorder to the search criteria, and consequently selects participants with a record of hypertension in their referral data or longitudinal data. Disclaimer: the concept maps underlying this feature are not complete and can be inaccurate. Please review the included mapped concepts carefully, when using this feature.

**ICDO | 80109: Carcinomatosis** plus **SCT | 307593001: Carcinomatosis:** selects participants with this tumour morphology in their referral data or longitudinal data (this can include participants who are referred for a rare disease or other cancer types). Because tumour morphology/topography may be coded with ICD-O or SNOMED, it is advised to include both code systems when searching for a specific tumour morphology or topography.

## Mapping of 100kGP and NHS-GMS data releases to data in the Participant Explorer

The tables below show how each data element in Participant Explorer is obtained from source tables in LabKey, including a description of any normalisation or filters applied in the Notes column.

Note: when downloading condition, observation, procedure or drug codes from Participant Explorer, the "Source Code" column contains the original source value, pre-normalisation.

For detailed information on tables and columns in the 100kGP and NHS-GMS data releases, please refer to the relevant data dictionaries of the [100kGP Data Release](../current_release/) / [NHS\_GMS data release](../current_gms/), and the Participant Explorer [release notes](../pxa_release/) for the data release versions available in Participant Explorer.

### Participant

| Participant Explorer | Source Dataset | Source Table | Source Column | Notes |
| --- | --- | --- | --- | --- |
| Participant ID | Both | participant | participant\_id |  |
| Year of Birth | 100kGP | participant | year\_of\_birth |  |
|  | NHS-GMS | participant | participant\_year\_of\_birth |  |
| Stated Gender | 100kGP | participant | participant\_stated\_gender |  |
|  | NHS-GMS | participant | administrative\_gender |  |
| Phenotypic Sex | 100kGP | participant | participant\_phenotypic\_sex |  |
|  | NHS-GMS | participant | phenotypic\_sex |  |
| Ethnic Category | 100kGP | participant | participant\_ethnic\_category |  |
|  | NHS-GMS | participant | ethnicity\_description |  |
| Life Status | 100kGP | death\_details | death\_date | if different from mortality, the value from mortality is used |
|  | NHS-GMS | participant | participant\_year\_of\_death | if different from mortality, the value from mortality is used |
|  | Both | mortality | date\_of\_death | takes precendence |

### Referral

| Participant Explorer | Source Dataset | Source Table | Source Column | Notes |
| --- | --- | --- | --- | --- |
| Referral ID / Family ID | 100kGP | participant | rare\_diseases\_family\_id / gel\_case\_reference | Rare Disease / Cancer |
|  | NHS-GMS | referral | referral\_id | Both Rare Disease and Cancer |
| Proband/Relative | 100kGP | participant | participant\_type |  |
|  | NHS-GMS | referral\_participant | referral\_participant\_is\_proband |  |
| Disease Category/ Programme | 100kGP | participant | programme |  |
|  | NHS-GMS | referral | category |  |
| Clinical Indication/ Recruited Disease | 100kGP | rare\_diseases\_participant\_disease | normalised\_specific\_disease |  |
|  | 100kGP | cancer\_participant\_disease | cancer\_disease\_type + cancer\_disease\_sub\_type |  |
|  | NHS-GMS | referral | clinical\_indication\_full\_name |  |
| Family Case Solved | 100kGP | gmc\_exit\_questionnaire | case\_solved\_family |  |
|  | NHS-GMS | report\_outcome\_questionnaire | case\_solved\_family |  |
| Referral Date | 100kGP | N/A |  | Not populated for 100k, as for families the choice of date is unclear. In practice other registration events on the timeline show the likely period for the referral. |
|  | NHS-GMS | referral | date\_submitted |  |
| Family Members Tested | 100kGP | rare\_diseases\_family | family\_group\_type |  |
|  | NHS-GMS | referral\_test | referral\_test\_expected\_number\_of\_participants |  |
| Family Members Available | 100kGP | participant | N/A | count of participants with family id |
|  | NHS-GMS | referral | N/A | count of participants with referral id |

### Referral Members/Family Details

| Participant Explorer | Source Dataset | Source Table | Source Column | Notes |
| --- | --- | --- | --- | --- |
| Relationship to Proband | 100kGP | rare\_diseases\_pedigree\_member | father\_id, mother\_id | First-degree relationships are derived from father\_id and mother\_id. Others are displayed as "Family Member". |
|  | NHS-GMS | referral\_participant | relationship\_to\_proband |  |
| Affection Status | 100kGP | rare\_diseases\_pedigree\_member | affection\_status |  |
|  | NHS-GMS | referral\_participant | disease\_status |  |
| Stated Gender | 100kGP | participant | participant\_stated\_gender | not available for non-participants |
|  | NHS-GMS | participant | administrative\_gender |  |
| Phenotypic Sex | 100kGP | participant / rare\_diseases\_pedigree\_member | phenotypic\_sex, father\_id, mother\_id | rare\_diseases\_pedigree\_member entry is used for non-participants, otherwise participant table participant\_phenotypic\_sex overrides. |
|  | NHS-GMS | participant | phenotypic\_sex |  |
| Participant ID | 100kGP | rare\_diseases\_pedigree\_member | participant\_id |  |
|  | NHS-GMS | referral\_participant | participant\_id |  |
| Pedigree Member ID | 100kGP | rare\_diseases\_pedigree\_member | rare\_diseases\_pedigree\_member\_id | only available for 100kGP |

### Rare disease family case report

| Participant Explorer | Source Dataset | Source Table | Source Column | Notes |
| --- | --- | --- | --- | --- |
| Family Case Comments | 100kGP | gmc\_exit\_questionnaire | additional\_comments |  |
|  | NHS-GMS | report\_outcome\_questionnaire | additional\_comments |  |
| Position of "Family case report" on the timeline | Both | gmc\_exit\_questionnaire or report\_outcome\_questionnaire | event\_date |  |
| Medical Review Date | 100kGP | rare\_diseases\_family | family\_medical\_review\_date |  |

### Genome sequence report

| Participant Explorer | Source Dataset | Source Table | Source Column | Notes |
| --- | --- | --- | --- | --- |
| Delivery ID | Both | sequencing\_report | delivery\_id |  |
| Plate Key | Both |  | plate\_key |  |
| Type | Both |  | type |  |
| Delivery Version | Both |  | delivery\_version |  |
| Genome Build | Both |  | genome\_build |  |
| Delivery Date | Both |  | delivery\_date |  |
| Path | Both |  | path |  |
| Sample Date | 100kGP | clinic\_sample | clinic\_sample\_datetime | sequencing\_report is linked to clinic\_sample via the lab\_sample\_id and clinic\_sample\_sk in the laboratory\_sample table |
|  | NHS-GMS | sample | collection\_date | sequencing\_report is linked to sample via the referral\_id |

### Condition

| Participant Explorer | Source Dataset | Source Table | Source Column(s) | Code System | Notes |
| --- | --- | --- | --- | --- | --- |
| Condition Code | Both | av\_tumour | site\_icd10\_o2 | ICD-10 | Normalised[1](#fn:1) |
|  | 100kGP | cancer\_invest\_sample\_pathology | primary\_diagnosis\_icd\_code | ICD-10 | Normalised[1](#fn:1) |
|  | 100kGP | cancer\_participant\_disease | cancer\_disease\_type cancer\_disease\_sub\_type | Genomics England |  |
|  | 100kGP | cancer\_participant\_tumour | diagnosis\_icd\_code | ICD-10 | Normalised[1](#fn:1) |
|  | 100kGP | cancer\_registry | cancer\_site | ICD-10 | Normalised[1](#fn:1) |
|  | NHS-GMS | condition | code | OMIM or ORPHANET |  |
|  | Both | ecds | diagnosis\_code\_1 - diagnosis\_code\_12 | SNOMED CT | if diagnosis\_qualifier\_n = 410605003 ("confirmed") |
|  | Both | hes\_apc | diag\_01 - diag\_20 | ICD-10 | Normalised[1](#fn:1) |
|  | Both | hes\_op | diag\_01 - diag\_12 | ICD-10 | Normalised[1](#fn:1) |
|  | 100kGP | mhmd\_v4\_event mhldds\_event | ic\_eve\_primarydiagnosis ic\_eve\_secondarydiagnosis | ICD-10 ICD-10 | Normalised[1](#fn:1) |
|  | 100kGP | mhsds\_medical\_history\_previous\_diagnosis | prevdiag diagschemeinuse | ICD-10 / SNOMED | Normalised[1](#fn:1) If diagschemeinuse is 1, 2, 02, ID, 4, 6 or 06 |
|  | 100kGP | mhsds\_provisional\_diagnosis | provdiag diagschemeinuse | ICD-10 / SNOMED | Normalised[1](#fn:1) If diagschemeinuse is 1, 2, 02, ID, 4, 6 or 06 |
|  | 100kGP | mhsds\_primary\_diagnosis | primdiag diagschemeinuse | ICD-10 / SNOMED | Normalised[1](#fn:1) If diagschemeinuse is 1, 2, 02, ID, 4, 6 or 06 |
|  | 100kGP | mhsds\_secondary\_diagnosis | secdiag diagschemeinuse | ICD-10 / SNOMED | Normalised[1](#fn:1) If diagschemeinuse is 1, 2, 02, ID, 4, 6 or 06 |
|  | 100kGP | mhsds\_care\_activity mhsds\_indirect\_activity | codefind findschemeinuse | ICD-10/ SNOMED | If diagschemeinuse is 1, 2, 02, ID, 4, 6 or 06 |
|  | 100kGP | rare\_diseases\_participant\_disease | normalised\_disease\_group normalised\_disease\_sub\_group normalised\_specific\_disease | Genomics England |  |
|  | Both | mortality | icd10\_underlying\_cause | ICD-10 | Normalised[1](#fn:1) |
|  | Both | mortality | icd10\_multiple\_cause\_code\_1 ... 15 | ICD-10 | Normalised[1](#fn:1) |
|  | Both | rtds | radiotherapydiagnosisicd | ICD-10 | Normalised[1](#fn:1) |
|  | Both | sact | primary\_diagnosis | ICD-10 | Normalised[1](#fn:1) |
| Condition Source Code | Both |  |  |  |  |
| Body Site Code | 100kGP | cancer\_invest\_sample\_pathology | topography\_snomed\_ct\_code | SNOMED CT |  |
| TNM Stage Group | 100kGP | cancer\_participant\_tumour | integrated\_tnm\_stage\_grouping |  |  |
|  | 100kGP | cancer\_participant\_tumour | ajcc\_stage |  |  |
|  | Both | sact | sact\_stage\_at\_start |  |  |
| Stage Best | Both | av\_tumour | stage\_best |  |  |
| Stage Best System | Both | av\_tumour | stage\_best\_system |  |  |
| T Stage | Both | av\_tumour | t\_best |  |  |
|  | 100kGP | cancer\_participant\_tumour | component\_tnm\_t |  |  |
| M Stage | Both | av\_tumour | m\_best |  |  |
|  | 100kGP | cancer\_participant\_tumour | component\_tnm\_m |  |  |
| N Stage | Both | av\_tumour | n\_best |  |  |
|  | 100kGP | cancer\_participant\_tumour | component\_tnm\_n |  |  |
| Dukes | Both | av\_tumour | dukes |  |  |
|  | 100kGP | cancer\_participant\_tumour | modified\_dukes\_stage |  |  |
| FIGO | Both | av\_tumour | figo |  |  |
|  | 100kGP | cancer\_participant\_tumour | final\_figo |  |  |

### Observation

| Participant Explorer | Source Dataset | Source Table | Source Column(s) | Code System | Notes |
| --- | --- | --- | --- | --- | --- |
| Observation Code | Both | av\_tumour | histology\_coded | ICD-O-3 |  |
|  | Both | av\_tumour | stage\_best | STAGE |  |
|  | Both | av\_tumour | figo | STAGE |  |
|  | Both | av\_tumour | dukes | STAGE |  |
|  | Both | av\_tumour | t\_best n\_best m\_best | TNM STAGE | Concatenated |
|  | 100kGP | cancer\_analysis | histology\_coded | ICD-O-3 | Removing the / character for technical reasons |
|  | 100kGP | cancer\_participant\_tumour | morphology\_snomed\_ct\_code morphology\_icd\_code | SNOMED CT ICD-O-3 |  |
|  | 100kGP | cancer\_participant\_tumour | integrated\_tnm\_stage\_grouping | STAGE |  |
|  | 100kGP | cancer\_participant\_tumour | ajcc\_stage | STAGE |  |
|  | 100kGP | cancer\_participant\_tumour | final\_figo | STAGE |  |
|  | 100kGP | cancer\_participant\_tumour | modified\_dukes\_stage | STAGE |  |
|  | 100kGP | cancer\_participant\_tumour | component\_tnm\_t component\_tnm\_n component\_tnm\_m | TNM STAGE | Concatenated |
|  | Both | cancer\_registry | cancer\_type cancer\_behaviour | ICD-O-3 | Concatenated |
|  | 100kGP | mhsds\_care\_activity | codeobs obsschemeinuse | SNOMED | if obsschemeinuse = 3 |
|  | NHS-GMS | observation | normalised\_hpo\_id | HPO | filter value\_code = present |
|  | 100kGP | rare\_diseases\_participant\_phenotype | hpo\_id | HPO | filter hpo\_present = true |
|  | Both | sact | morphology | ICD-O-3 |  |
|  | Both | sact | sact\_stage\_at\_start | STAGE |  |
|  | NHS-GMS | tumour | tumour\_type, presentation | - | date from tumour\_diagnosis\_day, tumour\_diagnosis\_month, tumour\_diagnosis\_year |
|  | NHS-GMS | tumour\_morphology | morphology | SNOMED CT | date from parent tumour table |
|  | NHS-GMS | tumour\_topography | actual\_body\_site | SNOMED CT | date from parent tumour table |
|  | NHS-GMS | tumour\_topography | primary\_body\_site | SNOMED CT | date from parent tumour table |
| Observation Code Description | Both | av\_tumour | histology\_coded\_desc | ICD-O-3 |  |
| Body Site Code | Both | av\_tumour | site\_coded | ICD-O-3 | if coding\_system\_desc starts with "ICD-O-3" |
|  | 100kGP | cancer\_participant\_tumour | topography\_snomed\_ct\_code topography\_snomed\_code, topography\_snomed\_version topography\_icd\_code | SNOMED CT SNOMED CT ICD-O-3 |  |
| Body Site Description | Both | av\_tumour | site\_coded\_desc | ICD-O-3 |  |

### Procedure

| Participant Explorer | Source Dataset | Source Table | Source Column(s) | Code System | Notes |
| --- | --- | --- | --- | --- | --- |
| Procedure Code | Both | av\_treatment | eventcode | NCRAS |  |
|  | Both |  | opcs4\_code | OPCS-4 |  |
|  | Both |  | radiocode | NCRAS |  |
|  | Both |  | imagingcode | NCRAS |  |
|  | Both |  | imagingsite | OPCS-4 |  |
|  | 100kGP | cancer\_invest\_imaging | imaging\_code\_snomed\_ct\_code | SNOMED CT |  |
|  | 100kGP | cancer\_surgery | primary\_procedure | OPCS-4 | Ignore '.' |
|  | 100kGP | rare\_diseases\_imaging | procedure\_other\_snomed\_ct | SNOMED CT |  |
|  | Both | ecds | treatment\_code\_1 - treatment\_code\_12 | SNOMED CT |  |
|  | Both | hes\_apc | opertn\_01-24 | OPCS-4 | Z-chapter codes mapped to body site and grouped with preceding non-Z-chapter code |
|  | Both | hes\_op | opertn\_01-24 | OPCS-4 | Z-chapter codes mapped to body site and grouped with preceding non-Z-chapter code |
|  | Both | rtds | primaryprocedureopcs | OPCS-4 |  |
|  | Both | sact | opcs\_procurement\_code opcs\_delivery\_code | OPCS-4 | If 3 digits: prefix with "X" Uppercase ignore "N/A" |
|  | 100kGP | did | did\_snomedct\_code | SNOMED CT |  |
| Procedure Code Description | Both | av\_treatment | eventdesc | NCRAS |  |
|  | Both |  | radiodesc | NCRAS |  |
|  | Both |  | imagingdesc | NCRAS |  |
| Body Site Code | 100kGP | cancer\_invest\_imaging | anatomical\_site | OPCS-4 | Split comma-separated values into multiple codes for the same procedure |
|  | Both | hes\_apc | opertn\_01-24 | OPCS-4 | Z-chapter codes mapped to body site and grouped with preceding non-Z-chapter code |
|  | Both | hes\_op | opertn\_01-24 | OPCS-4 | Z-chapter codes mapped to body site and grouped with preceding non-Z-chapter code |
|  | Both | rtds | rttreatmentanatomicalsite | OPCS-4 |  |
|  | 100kGP | did | ic\_sub\_syscomp\_id ic\_sub\_sys\_id ic\_system\_id ic\_sub\_region\_id ic\_region\_id | SNOMED CT | Only using the most specific system code and the most specific region code. I.e., when both a region\_id and sub\_region\_id are present, only include the sub\_region\_id in the body site coding. |

### Medication administration

| Participant Explorer | Source Dataset | Source Table | Source Column(s) | Code System | Notes |
| --- | --- | --- | --- | --- | --- |
| Code | Both | sact | drug\_group | SACT Drug Group | Non-printable characters removed and converted to title-case |

### Encounter

| Participant Explorer | Source Dataset | Source Tables | Source Column | Notes |
| --- | --- | --- | --- | --- |
| Encounter Date | Both | av\_treatment | eventdate |  |
| Encounter Type | Both |  | "National Cancer Registration" |  |
| Encounter Date | Both | av\_tumour | diagnosisdatebest |  |
| Encounter Type | Both |  | "National Cancer Registration" |  |
| Encounter Date | Both | participant | registration\_date date\_of\_consent | registration\_date if available; otherwise date\_of\_consent Also used for recruited diseases |
| Encounter Type | Both |  | "Genomics England" |  |
| Encounter Date | 100kGP | cancer\_participant\_tumour | diagnosis\_date |  |
| Encounter Type | 100kGP |  | "Genomics England" |  |
| Encounter Date | 100kGP | cancer\_invest\_sample\_pathology | event\_date |  |
| Encounter Type | 100kGP |  | "Genomics England" |  |
| Encounter Date | 100kGP | cancer\_invest\_imaging | imaging\_date |  |
| Encounter Type | 100kGP |  | "Genomics England" |  |
| Encounter Date | 100kGP | cancer\_invest\_sample\_pathology | event\_date |  |
| Encounter Type | 100kGP |  | "Genomics England" |  |
| Encounter Date | 100kGP | cancer\_surgery | procedure\_date |  |
| Encounter Type | 100kGP |  | "Genomics England" |  |
| Encounter Date | Both | cancer\_analysis | tumour\_clinical\_sample\_time |  |
| Encounter Type | Both |  | "Genomics England" |  |
| Encounter Date | Both | cancer\_registry | event\_date |  |
| Encounter Type | Both |  | "National Cancer Registration" |  |
| Encounter Date | 100kGP | rare\_diseases\_participant\_phenotype | phenotype\_report\_date |  |
| Encounter Type | 100kGP |  | "Genomics England" |  |
| Encounter Date | 100kGP | rare\_diseases\_imaging | date |  |
| Encounter Type | 100kGP |  | "Genomics England" |  |
| Encounter Date | Both | ecds | arrival\_date arrival\_time |  |
| Encounter Date | Both |  | departure\_date departure\_time |  |
| Encounter Type | Both |  | "Emergency" |  |
| Encounter Date | Both | hes\_apc | admidate |  |
| Encounter Type | Both |  | "Inpatient" |  |
| Encounter Type | Both | hes\_op | "Outpatient" |  |
| Encounter Date | Both |  | apptdate |  |
| Encounter Type | 100kGP | did | "Diagnostic Imaging" |  |
| Encounter Date | 100kGP |  | did\_date3 |  |
| Encounter Date | 100kGP | mhmd\_v4\_event mhldds\_event | mhd\_eventdate |  |
| Encounter Type | 100kGP |  | "Mental Health Services" |  |
| Encounter Date | 100kGP | mhsds\_medical\_history\_previous\_diagnosis mhsds\_primary\_diagnosis mhsds\_secondary\_diagnosis | diagdate |  |
| Encounter Type | 100kGP |  | "Mental Health Services" |  |
| Encounter Date | 100kGP | mhsds\_provisional\_diagnosis | provdiagdate |  |
| Encounter Type | 100kGP |  | "Mental Health Services" |  |
| Encounter Date | 100kGP | mhsds\_indirect\_activity | indirectactdate |  |
| Encounter Type | 100kGP |  | "Mental Health Services" |  |
| Encounter Date | 100kGP | mhsds\_care\_activity | carecontdate |  |
| Encounter Type | 100kGP |  | "Mental Health Services" |  |
| Encounter Date | Both | mortality | event\_date |  |
| Encounter Type | Both |  | "Office of National Statistics" |  |
| Encounter Type | Both | rtds | "Radiotherapy" |  |
| Encounter Date | Both |  | decisiontotreatdate | For diagnosis codes |
| Encounter Type | Both | rtds | "Radiotherapy" |  |
| Encounter Date | Both |  | proceduredate |  |
| Encounter Date | Both | sact | date\_decision\_to\_treat | For diagnosis, morphology and staging codes |
| Encounter Type | Both |  | "Chemotherapy" |  |
| Encounter Date | Both | sact | administration\_date |  |
| Encounter Type | Both |  | "Chemotherapy" |  |
| Encounter Date | NHS-GMS | observation | observation\_effective\_from |  |
| Encounter Type | NHS-GMS |  | "Genomics England" |  |
| Encounter Date | NHS-GMS | tumour tumour\_morphology tumour\_topography | tumour date fields (see notes) | tumour\_diagnosis\_day/tumour\_diagnosis\_month/tumour\_diagnosis\_year. If day not present then 01 is used. If month not present, data point is not used on the timeline. |
| Encounter Type | NHS-GMS |  | "Genomics England" |  |

---

1. ICD-10 codes are normalised so that they match the ICD-10 reference data. This includes the removal of any non-numeric characters other than the first character, and inserting a dot at the fourth position (for example, a coded value of "E149D" is normalised to "E14.9"). The original values can be obtained via the "Source Code" column.Â [â©](#fnref:1 "Jump back to footnote 1 in the text")[â©](#fnref2:1 "Jump back to footnote 1 in the text")[â©](#fnref3:1 "Jump back to footnote 1 in the text")[â©](#fnref4:1 "Jump back to footnote 1 in the text")[â©](#fnref5:1 "Jump back to footnote 1 in the text")[â©](#fnref6:1 "Jump back to footnote 1 in the text")[â©](#fnref7:1 "Jump back to footnote 1 in the text")[â©](#fnref8:1 "Jump back to footnote 1 in the text")[â©](#fnref9:1 "Jump back to footnote 1 in the text")[â©](#fnref10:1 "Jump back to footnote 1 in the text")[â©](#fnref11:1 "Jump back to footnote 1 in the text")[â©](#fnref12:1 "Jump back to footnote 1 in the text")[â©](#fnref13:1 "Jump back to footnote 1 in the text")[â©](#fnref14:1 "Jump back to footnote 1 in the text")[â©](#fnref15:1 "Jump back to footnote 1 in the text")

October 2, 2025
