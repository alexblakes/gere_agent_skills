---
title: 'Pathology synoptic reports dataset - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/synoptic/
scraped_at: 2026-05-04T06:34:05Z
---

# Pathology synoptic reports dataset

Synoptic reports dataset consolidates the efforts of a team of pathologists manually extracting medical entities from free-text pathology reports (collected by and received from the National Disease Registration Service) into versioned, structured document following the guidelines set by the Royal College of Pathologists (RCPath). These reports use a synoptic proforma, meaning they present pathology findings in a standardised checklist-style format rather than as free-text descriptions.

## Structure

The dataset covers 8370 participants with a wide variety of cancers, including good coverage of colorectal and breast cancer cohorts.

Examples of what can be found in the synoptic reports include biomarkers, invasion, biomarkers, lymph node status/counts, staging, metastasis.

## How to find the data

You can find the reports in the LabKey table `synoptic_path_reports`.

Each row in the dataset represents a section value taken from a report section for a given case and participant. Reports are versioned and carry a specific report name , reflecting the specimen or tissue type.

### Example

| Participant ID | Case ID | Report Name | Report Version | Section Path | Label | Value |
| --- | --- | --- | --- | --- | --- | --- |
| P001 | P001-1 | BreastÂ ExcisionÂ (RCPath) | 9.2.1702.89 | HiddenÂ RegistryÂ FieldsÂ ::HERÂ 2Â Status | HERÂ 2Â Status | Negative |
| P002 | P002-1 | BreastÂ CoreÂ BiopsyÂ (RCÂ Path) | 9.2108.0.58 | InvasiveÂ Carcinoma | InvasiveÂ Carcinoma | Present |

March 26, 2026
