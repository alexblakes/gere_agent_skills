---
title: 'Building cohorts with Participant Explorer - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/pxa_cohorts/
scraped_at: 2026-05-04T06:33:17Z
---

# Building cohorts with Participant Explorer

[Give us feedback on this tutorial](https://www.smartsurvey.co.uk/s/MWUGE5/)

Participant Explorer is an ontology-aware no code tool for searching for participants. You can use it to search for phenotypes using natural language and combine terms in quite complex queries.

## Searching

To build a cohort, you can use the Search by Clinical Concept option in Participant Explorer. This allows you to search by phenotypes, diseases and treatments. You don't need to know any code systems for these searches, as Participant Explorer will search with natural language and fill in the codes for you. You can include descendant concepts of those you select and mapping to synonyms in other code systems.

You can add multiple phenotypes to your search, choosing and/or logic.

To add in covariates, you can also use the Search by Participant Details. This allows you to add in things like year of birth, sex, ethnicity, if a rare disease case is solved and if the participant is still alive.

There are more details on searching on [this page](../pxa_search/).

### Control cohorts

To build a control cohort, you can easily return to your search and switch your 'Has any of' filters to 'Has none of'. We recommend that you also search using parent terms of the terms you used for the case cohort, as this will ensure no related cases will end up in your control cohort.

## Verifying

To verify any data in Participant Explorer, you can go into a participant record and click on the links to LabKey. These will open up the LabKey tables which contain the data, filtered to only show the relevant rows.

You can learn more about the participant page in [this document](../pxa_participant/).

## Downloading

You can download tables of data about your cohort by clicking on Download from the results table. Here you can select the columns you want to include in your download, including participant information and genome file locations.

There is more information on this [here](../pxa_download/).

October 24, 2024
