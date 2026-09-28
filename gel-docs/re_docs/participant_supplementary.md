---
title: 'Participant Supplementary Data - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/participant_supplementary/
scraped_at: 2026-05-04T06:33:08Z
---

# Participant Supplementary Data

The `participant_supplementary_data` table contains information about supplementary genetic or phenotype datasets that have been uploaded for a subset of 100kGP participants. This might include new variant calling data using different pipelines and settings, other 'omic data, or specific additional clinical data that was not part of the original data model. This table can be found in [Labkey](../labkey/) from Data Release v12 onwards.

## Where are the data located?

The data can be found in `/gel_data_resources/participant_supplementary_data/RRxxx/`. The `RRxxx` indicates that the Research Registry number is used as a subfolder. This allows us and other researchers to see which research project is associated with the data.

## Using the data

These data have been submitted by Research Network researchers who believe that it is in the interest of the participant that this information becomes available in the research environment. If you wish to use any of the datasets in the `participant_supplementary_data` folder for your research please contact [Service Desk](https://jiraservicedesk.extge.co.uk/servicedesk/customer/portals) to get contact details for the data owner.

## Refresh rate of the data

The `participant_supplementary_data` table may be updated between 100kGP, if requests to add data occur during that time.

## How is consent withdrawal processed for this table?

The `participant_supplementary_data` folder may contain data on withdrawn participants if the data were uploaded for work that began before the participants withdrew. Before you begin new work on these datasets, you **must** filter to include current consented participants only. Consent status can be found in the `participant` table in LabKey for the latest Data Release. Obtaining a list of consented participants can be done by filtering the `programme_consent_status` column against `Withdrawn (Full)`.

## How do I submit a request to enter my own data into the `participant_supplementary_data` table?

If you wish to add data to this table, you can submit a service request via the [Genomics England Service Desk](https://jiraservicedesk.extge.co.uk/servicedesk/customer/portals).

March 26, 2026
