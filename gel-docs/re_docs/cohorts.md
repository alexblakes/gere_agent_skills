---
title: 'Building cohorts - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/cohorts/
scraped_at: 2026-05-04T06:34:30Z
---

# Building cohorts

These tutorial will take you through the methods you can use to build cohorts using phenotypes. You can use this information to build tables of participants who share particular phenotypes and extract information such and their identifiers, genome file locations, phenotypes and covariates such as age, sex and ethnicity.

You can search for participants using a no code interface in [Participant Explorer](../pxa/), or using the tables in [LabKey](../labkey/) and its associated [APIs](../labkey_api/). These tutorials will cover using these and some of the methods required.

## Parameters for cohort building

To build cohorts for **cancer** you will be using the cancer participants and may want to consider:

- Disease type
  - Recruited disease
  - Diagnosis codes in health records
- Staging
- Treatment
- Hormone status

For **rare disease** cohorts, you will use the rare disease participants and might look at:

- Recruited disease
- HPO terms associated with the participant's phenotype
- Diagnosis codes in health records
- If the case has been solved
- If the participant is still alive

**Common disease** cohorts can be constructed from rare disease relatives and cancer participants, considering:

- Diagnosis codes in health records

In all cases you want to build a control cohort. To ensure that you don't accidentally find any cases in your control group, we recommend filtering for your control by excluding those in the super-categories of the more specific categories you use for your case cohort.

For any of these cohort types, you may also want to take into account:

- Sex
- Ethnicity
- Age
- now
- at sampling
- at diagnosis
- at death

## Cohort building methods

You can build cohorts in the RE using [Participant Explorer](../pxa/) or using the [LabKey API](../labkey_api/), or in CloudOS using [Cohort browser](https://lifebit.atlassian.net/wiki/spaces/CD/pages/813106752/Build+a+cohort) or [interactive sessions](https://lifebit.atlassian.net/wiki/spaces/CD/pages/813105209/Interactive+sessions). The following tutorials cover:

- [Building cohorts with Participant Explorer](../pxa_cohorts/)
- [Building cohorts with Cohort Browser in CloudOS](../cb_cohorts/)
- [Building cancer cohorts programmatically](../cancer_cohorts/)
- [Building rare disease cohorts programmatically](../rd_cohorts/)

> **Common disease cohorts:**
>
> To build common disease cohorts programmatically, we recommend you follow the steps in the [rare disease cohort tutorial](../rd_cohorts/), omitting the steps on recruited disease, HPO terms and unsolved cases.

## Exporting cohort data

All the methods for creating cohorts listed here involve pulling out identifiable participant data, such as participant IDs and medical history. Therefore, you **cannot** export any of these tables from the RE. Cohorts created here are intended as a start point for further analyses. Any attempts to export these tables via [Airlock](../airlock/) will be rejected; you must **not** copy any of these tables by hand.

## Recorded training sessions

You can also find training sessions:

| Topic | Most recent session | Link | Notebook location in RE |
| --- | --- | --- | --- |
| Building cancer cohorts and survival analysis | 12th March 2024 | [materials](../cancer_cohorts_mar24/) | `/gel_data_resources/example_scripts/workshop_scripts/cancer_cohort_2024` |
| Building rare disease cohorts with matching control | 14th May 2024 | [materials](../rd_cohorts_may24/) | `/gel_data_resources/example_scripts/workshop_scripts/rd_cohort_2024` |

December 17, 2024
