---
title: 'Building cohorts with Cohort Browser in CloudOS - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/cb_cohorts/
scraped_at: 2026-05-04T06:31:44Z
---

# Building cohorts with Cohort Browser in CloudOS

[Give us feedback on this tutorial](https://www.smartsurvey.co.uk/s/HTBRN7/)

## Searching

The [Cohort Browser application](https://lifebit.atlassian.net/wiki/spaces/CD/pages/813106738/Build+and+export+a+cohort) in [CloudOS](../cloudos/) allows you to search for participants by phenotype and genotype filters. There are two options for search:

- [Source data](../current_release/)
- [OMOP data](https://lifebit.atlassian.net/wiki/spaces/CD/pages/813106814/Build+a+cohort+using+OMOP+data)

### Source data

This is the 100kGP structured data, which follows the [table structure in LabKey](../current_release/). This allows you to create complex searches involving multiple tables and specific searches.

You can [search by](https://lifebit.atlassian.net/wiki/spaces/CD/pages/813106901/Build+a+cohort+using+source+data) clicking through the tables, and filtering by selecting columns. You can pull out the SQL queries from searches created through no code, which you can copy across to use in [programmatic queries in interactive sessions](../cancer_cohorts/). You can also write SQL queries in Cohort Browser.

### OMOP data

This is a [common data model](https://lifebit.atlassian.net/wiki/spaces/CD/pages/813106814/Build+a+cohort+using+OMOP+data) that allows you to search by terms across a simplified structure, allowing searches across federated datasets with different underlying database structures.

## Further use

You can [download or export your cohort](https://lifebit.atlassian.net/wiki/spaces/CD/pages/813107438/Export+a+cohort) from the Cohort Overview page, or you can drop your cohort into an [interactive session](https://lifebit.atlassian.net/wiki/spaces/CD/pages/813107438/Export+a+cohort#Export-your-cohort-into-an-interactive-session).

March 26, 2026
