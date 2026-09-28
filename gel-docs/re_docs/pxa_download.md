---
title: 'Download search results - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/pxa_download/
scraped_at: 2026-05-04T06:33:19Z
---

# Download search results

Select columns from the 'Available Columns' side to include them and download a TSV file with the search results.

## Participant columns

Please refer to the [Participant view](../pxa_participant/) page for details.

Note: the column header for `Programme/Disease Category` in the TSV file is `disease_category`.

## Recruited Disease/Clinical Indication columns

These columns allow selection of the 100kGP style 3 (Rare Disease) or 2 (Cancer) column disease information or
the NHS-GMS single Clinical indication column. For mixed Rare Disease and Cancer cohorts both sets of columns
should be selected.
Typically, a participant is referred for a single disease, but multiple referral diseases are possible (resulting in multiple rows per participant).

| Column | Notes |
| --- | --- |
| Rare Disease Group | The recruited rare disease group (100kGP only) |
| Rare Disease Sub Group | The recruited rare disease sub group (100kGP only) |
| Specific Rare Disease/Clinical Indication | The specific recruited rare disease (100kGP) or clinical indication for rare disease referrals (NHS-GMS). The column header in the TSV file is `specific_rare_disease`. |
| Cancer Type | The recruited cancer type (100kGP) |
| Cancer Sub Type/Clinical Indication | The recruited cancer sub type (100kGP) or clinical indication for cancer referrals (NHS-GMS). The column header in the TSV file is `cancer_sub_type`. |

## Rare Diseases Family Case Report columns

Details of the clinical report delivered for a rare diseases case from the GMC exit questionnaire (100kGP) or report outcome questionnaire (NHS-GMS) tables in LabKey.

In most cases there is only a single report, but multiple reports are possible (resulting in multiple rows per participant).

| Column | Notes |
| --- | --- |
| Interpretation Request ID | The Interpretation Request contains all of the information needed to display and clinically annotate a case. If new data are added (such as an additional family member or gene panel), the case will be re-interpreted and the interpretation request id will be updated. |
| Family Case Solved | Have the results reported explained the genetic basis of the familyâs presenting phenotype(s)? (Yes / No / Partially / Unknown) |
| Family Case Comments | Additional comments regarding the report |

## Genome Sequence columns

Please refer to the [Participant View](../pxa_participant/) page for column details.

Genome sequence columns will generate multiple rows for participants with multiple genome sequence deliveries.

## Condition/Observation/Procedure/Drug columns

These columns are only available when using the search-by-clinical-concept option (see below for Cancer Staging).

Separate rows will be generated for conditions, observations, procedures and drugs ***that matched the search criteria.*** This corresponds to the highlighted rows in the timeline, and includes matches based on subsumption (when descendant codes are implicitly included in the search).

Multiple rows will be generated for participants with multiple (different) codes that ***matched the search criteria.***

| Column | Notes |
| --- | --- |
| Event date | The date of the condition, observation, procedure or drug. |
| Clinical Concept | Whether the code represents a condition, observation, procedure or drug. |
| Code System | The name of the code system the code belongs to, e.g. "ICD-10". |
| Code | The code as displayed in the Participant Explorer. This is a normalised version of the source code. E.g. ICD10 code "E149-" is normalised to "E14.9". See [Data in the Participant Explorer](../pxa_data/) for more details. |
| Description | The description / display value for the code. |
| Source Code | The code as it appears in the source data. |
| Source Table | The name of the table (in the research data release) from which the condition, observation, procedure or drug information was obtained. |
| Encounter Type | The type of encounter during which the condition, observation, procedure or drug occurred. |

## Cancer Staging Columns

These columns are available when using the search-by-clinical-concept option, and can only be selected after selecting at least one column from the "Condition/observation/procedure/drug" category.

Additional columns for staging data associated with cancer diagnoses.

| Column | Notes |
| --- | --- |
| Stage Best | Stage (Best) (NCRAS) |
| Stage Best System | The staging system used for Stage Best (NCRAS) |
| T Stage | The T stage category |
| N Stage | The N stage category |
| M Stage | The M stage category |
| TNM Stage Group | The TNM stage group |
| FIGO | The FIGO stage |
| Dukes | The Dukes stage |

The availability of stage values depend on the source table of the diagnosis data point. See [Data in the Participant Explorer](../pxa_data/) for more details.

## Aggregate columns

| Column | Notes |
| --- | --- |
| Participant Count | The number of distinct participants in the search result with the combination of values in the other selected columns. This column will be disabled (greyed out) if the Participant ID column is selected, and vice versa. |

> **Notes:**
>
> - Only conditions, observations, procedures and drugs that match the search criteria can be downloaded here.
> - The result contains distinct rows only.
> - The result may contain multiple rows per participant, when columns with multiple values are selected. For example, multiple values for Genome Build are rendered as separate rows.
> - Rare Diseases Family Case Report, Condition/Observation/Procedure/Drug and Genome Sequence columns cannot be combined in the same result.
> - The Participant Count column contains the number of participants in the search result for each distinct combination of values in the other selected columns. The Participant Count and Participant ID columns are mutually exclusive.
> - Cancer staging columns can only be selected when one or more Condition/Observation/Procedure/Drug columns are selected.

## Export from TRE

Tables exported from Participant Explorer which include participant identifiers count as identifiable data and cannot be exported from the RE. Tables which include only counts may be able to be exported if all counts are greater than five. You should use [Airlock](../airlock/) for any exports and not copy these by hand.

## Video tutorial

October 2, 2025
