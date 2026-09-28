---
title: 'Release V2 (30/01/2018) - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/release2/
scraped_at: 2026-05-04T06:33:42Z
---

# 100kGP Release V2 (30/01/2018)

## Document history and control

The controlled copy of this document is maintained in the Genomics England internal document management system. Any copies of this document held outside of that system, in whatever format (for example, paper, email attachment), are considered to have passed out of control and should be checked for currency and validity. This document is uncontrolled when printed.

### Version history

| Version | Date | Description |
| --- | --- | --- |
| 0.1 | 24/11/2017 | Initial draft of release note |
| 1.0 | 25/01/2018 | Final version that incorporates feedback |

## Purpose

This document provides a description of the Main Programme Data Release v2 dated 31/01/2018.

This is the second formal release of Main Programme data into the Research Environment. Genomics England will be releasing data on roughly a quarterly basis. Each progressive release will incorporate new content, enhancing existing content, and enable more effective use of the existing and new data.

This data will be manifested within the current version of Genomics England Research Environment, accessed via the AWS virtual desktop interface and subject to all Genomics England data protection and privacy principles.

## Release Overview

This release provides clinical data for 53,190 participants, and 31,384 genomes from 28,632 of these participants. Of these genomes, 26,159 are rare disease genomes (from 26,101 participants) and 5,225 are cancer genomes (from 2,531 participants).

- Genomic data are manifested in file shares.
- Clinical data are manifested in LabKey.

The clinical data provided in the release comprises a far broader set of variables than in the October 2017 Main Programme data release. This release seeks to include all variables that contain (or may contain in future) meaningful data whilst not compromising participant privacy.

Some genomic data are currently aligned against the reference genome version GRCh37 and some against version GRCh38. The alignments were also made using different versions of Illuminaâs alignment pipelines v2 and v4, reflecting the versions that were applicable at the time of sequencing. The versions for each genome are identified in the Sequencing Report table. We intend to provide consistently realigned and recalled version of all our genomes in the future.

## Audience

The intended audience for this document is researchers that have access to the Genomics England Research Environment. This does not include taught students on the MSc Genomic Medicine, who have access to a small subset of Main Programme data.

## Identifying this data release

The clinical data, secondary data, and tabulated bioinformatic data for this data release, and the paths to the applicable genome files, are found in the following LabKey folder:

`main-programme /main-programme_v2_2018-01-31`

Subsequent releases will be identified by an incremental increase in the version number and the date of data release.

## Scope

### In scope

Data that are in scope for this release:

- Cancer and rare disease data for the main programme participants with current consent. This data includes:
- Genomic data for all participants for whom we currently hold it;
- Primary clinical data, including formal pedigree data on rare disease participants where it is available; and
- Secondary datasets, including:
  - Hospital Episode Statistics (HES), including HES Accident and Emergency, HES Admitted Patient Care, and HES Outpatient Care.
  - Diagnostic Imaging Dataset (DID)
  - Patient Reported Outcome Measures (PROMs)
  - Mental Health Services Data Set (MHSDS).

### Out of scope

Data that are out of scope for this release:

- Clinical and genomic data for participants that have withdrawn from the 100,000 Genomes Project.
- Participant data from the pilot phases of the project (i.e. not main programme).
- Outputs of the Genomics England Bioinformatics interpretation pipeline. This will be provided in future releases.
- Sources of secondary data other than HES, DID, PROMs, MHMDS and ONS.

### Quality Notes

- BAM and VCF genomic data files are as they have been delivered to us by our sequencing provider. These have all passed an initial QC check based on sequencing quality and coverage. They have, however, not all undergone our full in-house genetic checks and we therefore cannot guarantee against genetic versus reported sex and family relationship discrepancies. It should be noted that genomes that have undergone Genomics England in-house QCs, variant calling and interpretation are included in this release.
- Because of the availability of data at the time of release, some rare disease families lack a proband. These families without probands will also lack a diagnosis unless there is a second affected individual in the family. The missing data will be made available in a future release.
- Clinical data and secondary data have been provided as submitted and have undergone limited validation.
- Human Phenotype Ontology (HPO) term entry may be missing or incomplete for some participants. This will be updated in future releases.
- Formal pedigree data are only available in a subset of rare disease participants. This will be updated in future releases. Each participantâs relationship to their familyâs proband is available for all cases; this can be used to determine family relationships instead of formal pedigree data.

## Change Summary

The change summary below summarises the changes in each release:

| Data release | Description |
| --- | --- |
| main-programme\_v1\_2017-10-11 | \* This data release represents the baseline for subsequent releases. |
| main-programme\_v2\_2018-01-30 | The dataset includes 31,384 genomes â an increase of 11,519 genomes from the first release.  \* Clinical data are also provided for participants with and without a sequenced genome, for a total of 53,190 participants.  \* A far broader set of clinical data are provided for participants, comprising 16 tables in LabKey.  \* In addition to Hospital Episode Statistics (HES), the secondary datasets Diagnostic Imaging Dataset (DID), Patient Reported Outcome Measures (PROMs) and Mental Health Services Data Set (MHSDS) are included in the release.  \* There have been significant changes to the data structure of the LabKey tables. Refer to the Data Dictionary that accompanies this release for further details. |

## Contact and Support

For all queries relating to this data release please contact the Genomics England Service Desk portal: [Service Desk](https://www.genomicsengland.co.uk/service-desk) The Service Desk is supported by dedicated GECIP team members for all relevant questions.

However, there is an expectation that GECIP domains are self-organised and self-managing. We will be providing a GECIP chat service that will operate within the Research Environment so that users can collaborate to resolve problems as a community. We will monitor GECIP chat ourselves and if we identify solutions to problems we will share with all users simultaneously.

October 7, 2025
