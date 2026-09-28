---
title: 'Release V4 (31/07/2018) - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/release4/
scraped_at: 2026-05-04T06:33:43Z
---

# 100kGP Release V4 (31/07/2018)

[Data dictionary](../r4_data_dictionary.xlsx)

## Document history and control

The controlled copy of this document is maintained in the Genomics England internal document management system. Any copies of this document held outside of that system, in whatever format (for example, paper, email attachment), are considered to have passed out of control and should be checked for currency and validity. This document is uncontrolled when printed.

### Version history

| Version | Date | Description |
| --- | --- | --- |
| 0.1 | 23/07/2018 | Initial draft of release note |
| 1.0 | 25/07/2018 | Final version that incorporates feedback |

## Purpose

This document provides a description of the Main Programme Data Release v4 dated 31/07/2018.

This is the fourth formal release of Main Programme data into the Research Environment. Genomics England will be releasing data on roughly a quarterly basis. Each progressive release will incorporate new content, enhancing existing content, and enable more effective use of the existing and new data.

This data will be manifested within the current version of Genomics England Research Environment, accessed via the AWS virtual desktop interface and subject to all Genomics England data protection and privacy principles.

> **Note:**
>
> The Data Dictionary spreadsheet that explains every table and column in LabKey is available [here](../r4_data_dictionary.xlsx).

## Release Overview

This release provides clinical data for 71,331 participants, and 55,681 genomes from 49,303 of these participants. Of these genomes, 43,997 are rare disease genomes (from 43,570 participants) and 11,684 are cancer genomes (from 5,715 participants).

- Genomic data are manifested in file shares.
- Clinical data are manifested in LabKey.

The clinical data provided in the release comprise a broader set of variables than in the April 2018 Main Programme v3 data release. This release seeks to include all variables that contain (or may contain in future) meaningful data whilst not compromising participant privacy.

Some genomic data are currently aligned against the reference genome version GRCh37 and some against version GRCh38. The alignments were also made using different versions of Illuminaâs alignment pipelines V2 and V4, reflecting the versions that were applicable at the time of sequencing. The versions for each genome are identified in the Sequencing Report table. We intend to provide consistently realigned and recalled version of all our genomes in the future.

## Audience

The intended audience for this document is researchers that have access to the Genomics England Research Environment. This does not include taught students on the MSc Genomic Medicine, who have access to a small subset of Main Programme data.

## Identifying this data release

The clinical data, secondary data, and tabulated bioinformatic data for this data release, and the paths to the applicable genome files, are found in the following LabKey folder:

`main-programme /main-programme_v4_2018-07-31`

Subsequent releases will be identified by an incremental increase in the version number and the date of data release.

## Scope

### In scope

Data that are in scope for this release:

- Cancer and rare disease data for the main programme participants with current consent. These data include:
- Genomic data for participants when available
- Outputs of the Genomics England Bioinformatics interpretation pipeline
  - Tiering data - rare disease
  - GMC outcome data ("exit questionnaire data") - rare disease
  - Interpretation request data - rare disease
  - Multi-sample VCF for interpreted genomes - rare disease
  - Tumour signature and mutational burden data - cancer
  - Tiering, structural and copy number variant report
- Primary clinical data, including formal pedigree data on rare disease participants where it is available; and
- Secondary datasets (medical history), including:
  - Hospital Episode Statistics (HES), including HES Admitted Patient Care, HES Adult Critical Care episodes, HES Accident and Emergency and HES Outpatient care.
  - Diagnostic Imaging Dataset (DID)
  - Patient Reported Outcome Measures (PROMs)
  - Mental Health Services Data Set (MHSDS)
  - Office for National Statistics (ONS)

### Out of scope

Data that are out of scope for this release:

- Clinical and genomic data for participants that have withdrawn from the 100,000 Genomes Project.
- Participant data from the pilot phases of the project (i.e. not main programme).
- Sources of secondary data other than HES, DID, PROMs, MHMDS and ONS.

### Quality Notes

- BAM and VCF genomic data files are as they have been delivered to us by our sequencing provider. These have all passed an initial QC check based on sequencing quality and coverage. They have, however, not all undergone our full in-house genetic checks and we therefore cannot guarantee against genetic versus reported sex and family relationship discrepancies. It should be noted that genomes that have undergone Genomics England in-house QCs, variant calling and interpretation are included in this release.
- Because of the availability of data at the time of release, some rare disease families lack a proband. These families without probands will also lack a diagnosis unless there is a second affected individual in the family. The missing data will be made available in a future release.
- Clinical data and secondary data have been provided as submitted and have undergone limited validation.
- Human Phenotype Ontology (HPO) term entry may be missing or incomplete for some participants. This will be updated in future releases.
- Formal pedigree data are only available in a subset of rare disease participants. This will be updated in future releases. Each participantâs relationship to their familyâs proband is available for all cases; this can be used to determine family relationships instead of formal pedigree data.

### Conditions of Use

> **Note:**
>
> Participants identified as TracerX in the field normalised\_consent\_form in the participant table must not be used by commercial organisations.

## Data Release Description

The Genomics England data are organised into data views (displayed within LabKey as tables) categorised into Quick View, Common, Rare Disease and Cancer.

> **Note:**
>
> The Data Dictionary that describes the table structure and provides data definitions for this release can be found [here](../r4_data_dictionary.xlsx).

### Quick View

Data views that bring together data from several LabKey tables for convenient access:

| Name of Table / Data View | Description |
| --- | --- |
| rare\_disease\_analysis | Data for all rare disease participants including sex, ethnicity, disease recruited for and relationship to proband; as well as build of latest genome, QC status of latest genome, path to latest genomes and whether tiering data are available. |
| cancer\_analysis | Data for all Cancer participants including sex, ethnicity, disease recruited for and diagnosis; as well as tumour ID, build of latest genome, QC status of latest genome and path to latest genomes. This table now includes more information derived from the laboratory\_sample and cancer\_participant\_tumour tables. |

### Common

Data views that are common to both the rare disease and the cancer domains. This data pertains to sample handling, genome sequencing, and participant data.

Data Relating to Participants:

| Name of Table / Data View | Description |
| --- | --- |
| participant | Data on each individual participant in the 100,000 Genomes Project, e.g. personal information (such as relatives or self-reported ethnicity); points of contact with the Project (e.g. handling Genomic Medicine Centre or Trust); and a record of the status of their clinical review. |
| sequencing\_report | For each participant in the 100,000 Genomes Project, this table contains data describing the sequencing of their genome(s) and associated output, as well as the sample type that the sequence is from. |
| domain\_assignment | For each participant in the 100,000 Genomes Project, this table contains data describing the disease type to which they were recruited, the disease panel applied to their genome and the GECIP domain to which their genome has been assigned for the purposes of administering the publication moratorium. |
| genome\_file\_paths\_and\_types | Data that specifies the genomic files and their folder locations for a given a participant. |

Data Relating to Samples:

| Name of Table / Data View | Description |
| --- | --- |
| clinic\_sample | Data describing the taking and handling of participant samples at the Genomic Medicine Centres, i.e. in the clinic, as well as the type of samples obtained. Because of the complexities of handling and managing tumour tissues samples in a clinical setting, there are many fields that are cancer-specific. |
| clinic\_sample\_quality\_check\_result | Data describing the quality control of obtaining and handling participant samples at the Genomic Medicine Centres, i.e. in the clinic. |
| laboratory\_sample | Data describing the handling of samples at the biorepository and in preparation for sequencing, as well as the type of sample. |

### Rare Diseases

Rare Disease data are presented at the level of Rare Disease families (families of probands), Rare Disease pedigrees and participants. Participants are individuals who have consented to be a part of the project with the expectation that a sample of their DNA will be obtained and their genome sequenced. Pedigree members are extended members of the probandâs family, which will include some participants as well as a number of other individuals who will have no contact with the project, have not consented, but for whom a small amount of data are recorded to allow a full picture of the probandâs extended family to be gathered.

All Rare Disease tables are prefixed by âRare\_diseases\_â at the beginning of the table name.

Data at the Level of Rare Disease Families:

| Name of Table / Data View | Description |
| --- | --- |
| rare\_diseases\_family | Data describing the families of rare disease probands participating in the 100,000 Genomes Project. It includes the family group type, the status of the familyâs pre-interpretation clinical review and the settings that were chosen for the interpretation pipeline at the clinical review. |
| rare\_diseases\_pedigree | Data describing the Rare Disease participants, linking pedigrees to probands and their family members. |
| rare\_diseases\_pedigree\_member | Data describing the Rare Disease pedigree members, similar to the data about each individual participant in the COMMON data view. It includes some additional data, such as the age of onset of predominant clinical features; data on links to other family members; as well as data collected only for Phenotypes. |

Data at the Level of Rare Disease Participants.

The data presented in these tables provides information on disease progression and pertinent medical history:

| Name of Table / Data View | Description |
| --- | --- |
| rare\_diseases\_participant\_disease | Data describing the rare disease participants' disease type/subtype assigned to them upon enrolment, and the date of diagnosis. |
| rare\_diseases\_participant\_phenotype | Data describing the Rare Disease participantsâ phenotypes. For each Rare Disease participant in the 100,000 Genomes Project, there are data about whether a phenotypic abnormality as defined by an HPO term is present and what the HPO term is, as well as the age of onset, the severity of manifestation, the spatial pattern in the body and whether it is progressive or not. |
| rare\_diseases\_invest\_genetic | For a proportion of Rare Disease participants in the 100,000 Genomes Project, this table contains information on any genetic tests carried out. Data charaterising the genetic investigation is recorded alongside records of the sample tissue source and the type of testing laboratory. |
| rare\_diseases\_invest\_genetic\_test\_result | For a proportion of Rare Disease participants in the 100,000 Genomes Project, this table contains the results of any genetic tests carried out. Following on from the rare\_diseases\_invest\_genetic table, a summary of the results is presented and contextualised by testing method and scope. |
| rare\_diseases\_invest\_blood\_laboratory\_test\_report | For a proportion of Rare Disease participants in the 100,000 Genomes Project, this table contains the results of any blood tests carried out. Over 400 blood values are recorded alongside type and technique of testing and the status of the participating patient in the care pathway. |

Data output from the Genomics England interpretation pipeline

| Name of Table / Data View | Description |
| --- | --- |
| panels\_applied | For each participant of the 100,000 Genomes Project, this table contains the name and version of the panel(s) that was applied to his or her genome. |
| tiering |  |
| gmc\_exit\_questionnaire | Data reporting back from the Genomic Medicine Centres, for variants reported to them by Genomics England, to what extent a familyâs presenting case can be explained by the combined variants reported to them (including any segregation testing performed); confidence in the identification and pathogenicity of each variant; and the clinical validity of each variant or variant pair in general and clinical utility in a specific case (only the most recent update will be shown and only one questionnaire per report). |

### Cancer

Cancer data are presented for either the patient level cancer diagnosis or âdisease typeâ or the tumour specific sample details of participants in the Cancer arm of the 100,000 Genomes Project.

Data Relating to Cancer Participants:

| Name of Table / Data View | Description |
| --- | --- |
| cancer\_participant\_disease | For each cancer participant in the 100,000 Genomes Project, this table includes data about their cancer disease type and subtype. |
| cancer\_participant\_tumour | For each cancer participantâs tumour in the 100,000 Genomes Project, this table contains data that characterises the tumour, e.g. staging and grading; morphology and location; recurrence at time of enrolment; and the basis of diagnosis. |
| cancer\_participant\_tumour\_metastatic\_site | For each cancer participant in the 100,000 Genomes Project, this table contains the site of their metastatic disease in the body (if applicable) at diagnosis. |
| cancer\_invest\_sample\_pathology | For a subset of cancer participants in the 100,000 Genomes Project, this table contains full pathology reports and other related data on and from their tumour samples around diagnosis and characterisation of the cancer. Please note that much of this information is also found in the clinic\_sample and cancer\_participant\_tumour tables. |
| cancer\_risk\_factor\_general | For a proportion of cancer participants in the 100,000 Genomes Project, this table contains data on general cancer risk factors, namely smoking status, height, weight and alcohol consumption. This table was compiled with input from GECIP members. |
| cancer\_invest\_imaging | For a proportion of cancer participants in the 100,000 Genomes Project, this table contains: coded data on imaging investigations characterising the scan, its modality, anatomical site and outcome; as well as the outcome of the imaging report in free text form. |
| cancer\_PCA\_QC\_stats | The cancer analysis pipeline employs a sequencing quality control check which selects several important statistics associated with the sequencing returned by the sequencing provider, and uses them to check whether or not the sample in question is an outlier with respect to previous samples that have been run through the pipeline. It is, in effect, a safety net that can spot issues that have occurred at the tissue collection stage (i.e. at the GMC (Genomic Medicine Centre)) or at the library preparation step (i.e. at the sequencing provider), both of which may impact upon the final genomic analysis returned to the clinician. |
| tumour\_MB\_signatures | The relative proportions of the different mutational signatures demonstrated by the tumour. Analysis of large sequencing datasets (10,952 exomes and 1,048 whole-genomes from 40 distinct tumour types) has allowed patterns of relative contextual frequencies of different SNVs to be grouped into specific mutational signatures. Using mathematical methods (decomposition by non-negative least squares) the contribution of each of these signatures to the overall mutation burden observed in a tumour can be derived. Further details of the 30 different mutational signatures used for this analysis, their prevalence in different tumour types and proposed aetiology can be found at the Sanger Institute Website. |

### Genomics England Data Resources

Genomics England data resources are available in the following locations:

From the AWS desktop:

`~/gel_data_resources/`

From the high performance compute (HPC) cluster:

`/gel_data_resources/`

The data resources available here are:

**Tiering data for rare disease:** Tiering data are available for rare disease participants who have been through the Genomics England interpretation platform. These data provide information on the pathogenicity of variants that have been identified in the probandâs genome. Tiering data for rare disease probands can also be found in the designated LabKey table outlined above.

**GMC exit questionnaires for rare disease:** Outcomes questionnaire for interpreted genomes generated by Genomics England and Clinical Interpretation Providers.

**Interpretation request data for rare disease:** The following information can be found within the interpretation request JSON file: Family Pedigree and Other Family History, Analysis Panels and versions, Specific Disorder, Tiered Variants and Tiering version, HPO terms, Workspace (NHS GMC or LDP site code), Gene Panel Coverage, Disease Penetrance, Variant Classification.

**Multi-sample VCFs for interpreted rare disease genomes:** Variant call files by family using Platypus variant caller software.

**Tiering, structural, and copy-number variant reports for Cancer:** Annotated in JSON format. The file paths are available in the Quick View titled cancer\_analysis.

## Contact and Support

For all queries relating to this data release please contact the Genomics England Service Desk portal: [Service Desk](https://www.genomicsengland.co.uk/service-desk) (accessible from outside the Research Environment). The Service Desk is supported by dedicated Genomics England staff for all relevant questions.

October 7, 2025
