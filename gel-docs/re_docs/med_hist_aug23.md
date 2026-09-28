---
title: 'Getting medical records for participants, August 2023 - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/med_hist_aug23/
scraped_at: 2026-05-04T06:32:57Z
---

> **Archive training session:**
>
> Past training sessions may include information that is no longer true, in either the presentation or the Q&A. Please double check against the relevant documentation pages.

# Getting medical records for participants, August 2023

The Genomics England dataset includes a rich array of clinical data for all participants, rare disease probands and relatives, and cancer participants. Beyond the phenotypes recorded when participants were recruited into Genomics England, medical history was retroactively retrieved from NHS England for all participants and continues to be updated, allowing you to analyse secondary phenotypes, common disease and risk factors.

This training session will introduce you to the type of data we have available, including hospital episode statistics and mental health data, and the time periods when different data types were collected. We will show you how to access these data in table and graphical format using Participant Explorer, and how to compare medical history between participants. The raw data are stored in LabKey, so we will cover the tables that include these data and their structure, plus how to access these programmatically.

## Timetable

13.30 Introduction and admin  
13.35 NHS Digital data in the RE  
13.45 Mental health data in the RE  
13.50 Accessing NHS Digital data with Participant Explorer  
14.00 Comparing participantsâ medical history with Participant Explorer  
14.10 LabKey tables: Hospital Episode Statistics  
14.20 LabKey tables: Mental Health  
14.30 Accessing medical history programmatically  
14.45 Getting help and questions

## Learning objectives

After this training you will be able to:

- Understand what medical history data is available for participants in the GEL RE
- Visualise and compare medical histories using Participant Explorer
- Access the LabKey tables of medical history data

## Target audience

This training is aimed at researchers:

- working with the Genomics England Research Environment
- (preferably) who can programme in python and/or R (most of the training is suitable for non-programmers)

## Date

22nd August 2023

## Materials

You can access the redacted slides and video below. All sensitive data has been censored.

### Slides

### Video

### Optional exercises

These practice exercises will allow you to try out what you've learned. Feel free to have a go in your own time.

Coding/command line

These exercises are also written into the Jupyter and R notebooks, along with sample code that is a possible answer.

1. Using the LabKey API find all admissions in the hes\_apc table for the participant ID . Get the dates of admission and discharge, all diagnoses and all operations.
2. Filter these apc admissions to only include those who came from A&E, check the admimeth column of hes\_apc and the data dictionary to understand what the codes mean. Cross reference to the hes\_ae table to find the original admission.
3. Find details of all outpatients appointments that occurred in the 28 days following a diagnosis of epilepsy, G40.9.

No code

1. Using Participant Explorer look up the participant ID .
2. View the participant's medical history in table and graphical form. Click through from the table to see an original record in LabKey. Collapse the ontology codes in the graph to see only higher level terms. Download the history data.
3. Compare the medical histories of the participants . Collapse to see only diagnoses shared by five or more participants.

[Give us feedback on this tutorial](https://www.smartsurvey.co.uk/s/F44PKH/)

### Q&A

Q&A

Hi Emily! Just a quick Q before it starts - have you been able to log into workspaces okay the last two days? Mine wonât connect but I canât work out if its a me problem!

Yes, you need to restart your workspace. I had this problem this morning.

---

I would appreciate if you could demonstrate how to compare larger groups of participants. e.g all cancer patients with a particular diagnosis or all patients who received a specific treatment. (it has been something I have struggled with! any help welcome)

There are > 400 patients in the cohort I am interested in. I could find them manually. But it took > 1 hour per patient.

live answered, suggested contacting service desk: https://jiraservicedesk.extge.co.uk/plugins/servlet/desk

Follow up (after training session): I would probably use the code as shown in the training session to pull out medical histories for the participants. Then use analysis in your favourite programming language to compare.

---

is the diagnostic imaging dataset in along with the other HES tables?

Diagnostic imaging dataset is available as well yes.

To clarify we have a diagnostic imagign dataset with the dates and details of scans etc done, but the images are nto currently available

---

Donât have this function in my Airlock

Probably only for Diagnostic Discovery GECIP https://www.genomicsengland.co.uk/service-desk

October 7, 2025
