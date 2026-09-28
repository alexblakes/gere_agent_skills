---
title: 'Release V1 (11/10/2017) - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/release1/
scraped_at: 2026-05-04T06:33:34Z
---

# 100kGP Release V1 (11/10/2017)

## Document history and control

The controlled copy of this document is maintained in the Genomics England internal document management system. Any copies of this document held outside of that system, in whatever format (for example, paper, email attachment), are considered to have passed out of control and should be checked for currency and validity. This document is uncontrolled when printed.

### Version history

| Version | Date | Description |
| --- | --- | --- |
| 0.1 | 06/10/2017 | Initial draft of release note |
| 1.0 | 11/10/2017 | Final version that incorporates feedback |

## Purpose

This document provides a description of the Main Programme Data Release v1 dated 11/10/2017.

This is our first formal release of data into the Research Environment. We intend to release data on a roughly quarterly basis although initial releases may be more frequent. In progressive releases, we will be incorporating new content, enhancing existing content and enabling more effective use of the existing and new data.

These data will be manifested within the current version of Genomics England Research Environment, accessed via the AWS virtual desktop interface and subject to all Genomics England data protection and privacy principles.

## Release Overview

This release provides 19,865 genomes and associated clinical data. Of these, 17,338 are rare disease and 2,527 are cancer genomes.

- Genomic data are manifested in file shares.
- Clinical data are manifested in LabKey.

Some genomic data are currently called against GRCh37 and some against GRCh38, and there is also a mixture of Illuminaâs alignment pipelines v2 and v4, reflecting the versions that were applicable at the time of sequencing. The versions for each genome are identified in the Genome table. We intend to recall all our genomes on a consistent basis in the future.

## Audience

The intended audience for this document is researchers that have access to the Genomics England Research Environment.

## Identifying this data release

The clinical data, secondary data, and tabulated bioinformatic data for this data release, and the paths to the applicable genome files, are found in the following LabKey folder:

`main-programme /main-programme_v2_2017-10-11`

Subsequent releases will be identified by an incremental increase in the version number and the date of data release.

## Scope

### In scope

Data that are in scope for this release:

- Cancer and rare disease data for consented main programme participants with current consent. These data include:
- genomic data
- clinical data for those whom we are providing genomic data
- Hospital Episode Statistics (HES) data for the above subset: HES Accident and Emergency, HES Admitted Patient Care and HES Outpatient Care.

### Out of scope

Data that are out of scope for this release:

- Clinical and genomic data for participants that have withdrawn from the 100,000 Genomes Project.
- Participant data from the pilot phases of the project (ie not main programme).
- Interpretation request data and tiered variants (ie gene panels, interpretation settings and results of the interpretation pipeline).
- Formal pedigree data on rare disease participants although pedigree can be unambiguously derived from the relationship data provided for the large majority of families.
- Data on participants for those whom we do not yet hold sequence data.
- Other sources of secondary data other than HES.

### Quality Notes

- BAM and VCF genomic data files are as they have been delivered to us by our sequencing provider. These have all passed an initial QC check based on sequencing quality and coverage. They have, however, not all undergone our in-house genetic checks and we therefore cannot guarantee against genetic versus reported discrepancies.
- Because of the availability of data at the time of release, some families lack a proband. These families without probands will also lack a diagnosis unless there is a second affected individual in the family. The missing data will be made available in a future release.
- Clinical data and HES data have been provided as submitted and have undergone limited validation.
- We do not yet have a complete HPO dataset for all participants in this release. The missing data will be made available in a future release.

## Change Summary

The change summary below summarises the changes in each release:

| Data release | Description |
| --- | --- |
| main-programme\_v1\_2017-10-11 | \* This data release represents the baseline for subsequent releases. |

## Data release description

Below is a description of the LabKey tables and their associated data fields.

### Common

#### genome

| Field | Description |
| --- | --- |
| assembly | The genome assembly versions in this release. GRCh37 is represented as 37 and GRCh38 as 38 |
| participant\_id | GEL participant ID |
| platekey | The well identifier for the sequence, a composite of plate\_id and well\_id |
| delivery\_id | The ID number of the delivered sequence |
| delivery\_date | The date the sequence was delivered |
| delivery\_version | The illumina pipeline version |
| path | The path to the sequence folder on the genomes drive |
| plate\_id | The ID number of the original plate used for sequencing |
| well\_id | The well of the sequence on the plate |
| laboratory\_sample\_id | The ID number of the sample used for sequencing |
| clinic\_sample\_type | The type of sample sequenced. Possible values: DNA Blood Germline; DNA FF Tumour; DNA FFPE Tumour; DNA; DNA Fibroblast; DNA Saliva; DNA FF Germline |
| type | The type of sample. Possible values: rare disease; cancer germline; cancer tumour; unknown |

#### registration

| Field | Description |
| --- | --- |
| participant\_id | GEL participant ID |
| study\_type | Whether the participants is Rare Disease or Cancer |
| sex\_at\_birth | Gender of participant at birth. 1 = Male; 2 = Female; 9 = Unknown |

#### GECIP\_domain

| Field | Description |
| --- | --- |
| participant\_id | GEL participant ID |
| family\_id | The family ID |
| domain | GECIP domain |

### Rare disease

#### Disorder

| Field | Description |
| --- | --- |
| disease\_group | The disease group as described by the clinician |
| disease\_group\_normalised | The disease group has been standardised using Genomics England naming convention. Note: This may change over time. |
| disease\_subgroup | The disease subgroup as described by the clinician |
| disease\_subgroup\_normalised | The disease subgroup has been standardised using Genomics England naming convention. Note: This may change over time |
| specific\_disease | The specific disease as described by the clinician |
| specific\_disease\_normalised | The specific disease has been standardised using Genomics England naming convention. Note: This may change over time |
| participant\_id | GEL participant ID |

Note: please refer to the GECIP Confluence page for the rare disease data model.

#### participant\_relationship

| Field | Description |
| --- | --- |
| participant\_id | GEL participant ID |
| participant\_type\_id | Whether the participant is a proband, or a relative |
| relative\_biological\_relationship\_to\_proband\_id | The relationship between the participant and the proband, values only present where participant\_type\_id = relative |
| family\_id | The family ID |

Note: please refer to the GECIP Confluence page for the rare disease data model

#### hpo

| Field | Description |
| --- | --- |
| hpo\_term | The accompanying HPO term description |
| hpo\_code | The HPO term identifier |
| participant\_id | GEL participant ID |
| hpo\_term\_presence | Whether the HPO term is present or absent. Possible values: yes; no; unknown |

### Cancer

#### tumour\_type

| Field | Description |
| --- | --- |
| participant\_id | GEL participant ID |
| disease\_type\_id | The cancer type of the tumour sample submitted to Genomics England |
| tumour\_subtype | The subtype of the cancer in question |

Note: please refer to the GECIP Confluence page for the cancer data model.

### Medical history - HES data

HES data tables provided are Admitted Patient Care, Outpatient Care, and Accident and Emergency.

## Contact and Support

For all queries relating to this data release please contact the Genomics England Service Desk portal: [Service Desk](https://www.genomicsengland.co.uk/service-desk) The Service Desk is supported by dedicated GECIP team members for all relevant questions.

However, there is an expectation that GECIP domains are self-organised and self-managing. We will be providing a GECIP chat service that will operate within the Research Environment so that users can collaborate to resolve problems as a community. We will monitor GECIP chat ourselves and if we identify solutions to problems we will share with all users simultaneously.

October 7, 2025
