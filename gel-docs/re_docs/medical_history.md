---
title: 'Getting medical histories for participants - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/medical_history/
scraped_at: 2026-05-04T06:34:43Z
---

# Getting medical histories for participants

These tutorials will take you through the methods you can use to get medical histories for participants. For the purpose of these tutorials, we assume that you have already identified your participant(s) of interest and have their participant ID(s).

You can find medical histories and compare between participants using a no-code interface [Participant Explorer](../pxa/), or you can using the tables in [LabKey](../labkey/) and its associated [APIs](../labkey_api/). These tutorials will cover using these and some of the methods required.

## Ensuring your participant(s) have active consent

Before looking into a participant's medical history, you should check the `participant_consent_status` column of the `participant` table for "Consenting".

## Medical history methods

The following tutorials cover:

- [Accessing and comparing medical history data with Participant Explorer](../medhist_pxa/)
- [Accessing medical history data programmatically](../medhist_api/)
- [Accessing mental health data programmatically](../medhist_mh_api/)

## Sources of data for medical history

Medical history data in the RE comes from [NHS England](../clinical_data/) and this tutorial will cover data available for [all participants](../general_clinical/), including rare disease probands, rare disease family members, cancer participants and Covid participants in [CloudOS only](../cloudos_data/). You should consult with the latest [Data dictionary](../current_release/) for full details of the tables and the columns available.

## Exporting medical history data

The medical histories you're pulling out here are confidential and potentially identifiable data. Therefore, you **cannot** export any of these data from the RE. Medical histories retrieved here are intended as a start point for further analyses. Any attempts to export these tables via [Airlock](../airlock/) will be rejected; you must **not** copy any of these tables by hand.

## Recorded training sessions

You can also find training sessions:

| Topic | Date recorded | Link | Notebook location in RE |
| --- | --- | --- | --- |
| Getting medical records for participants | 16th July 2024 | [materials](../med_hist_jul24/) | `/gel_data_resources/example_scripts/workshop_scripts/medical_history_2024` |

December 17, 2024
