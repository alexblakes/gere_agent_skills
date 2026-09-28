---
title: 'Getting medical records for participants, July 2024 - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/med_hist_jul24/
scraped_at: 2026-05-04T06:32:57Z
---

> **Archive training session:**
>
> Past training sessions may include information that is no longer true, in either the presentation or the Q&A. Please double check against the relevant documentation pages.

# Getting medical records for participants, July 2024

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

16th July 2024

## Materials

You can access the redacted slides and video below. All sensitive data has been censored. You can access and copy code from the Jupyter and R notebooks used in the training at:

`/gel_data_resources/example_scripts/workshop_scripts/medical_history_2024`

### Slides

[Download the slides](../medical_history_2024.pdf)

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

Does your project have to be registered before you can contact a clinician?

Hi Imran, the answer is yes. You should have your project registered and approved before undertaking any substantive work in the Research Environment.

---

Hello, I am a clinical scientist in the oncology field. For my research purposes I need to retrieve patient cancer outcomes in terms of time-to-event outcomes. I have encountered some difficulties in getting these type of data. What would be needed in this context is the time-duration from some starting point to the last follow-up, and whether the event was observed or not (censored or not). Secondly, I would also need the information on treatments. With that I mean the actual name of drugs given and different lines of treatment delivered. I would be great to have some indications on these two aspects. Thank you!

For small numbers of participants you can use Partcipant Explorer to look at this data. To do it programmatically you would query Labkey tables. There is documentation on how to do this on our site and may be covered a bit later here.

---

Hello, I have a question about the scripts in the containers, I cannot work with them because I do not manage to run the script (I fail at the first line when I need to fetch the dataset)

I suggest you raise a ticket with the Genomics England Service Desk.

---

Hello! If I am interested in using the date when participants entered the study, which information should I use? I was considering the date of consent from the participant summary table, but I am not sure if that's the best option. Do you have any suggestions?

The participant table also contains the study âregistration dateâ

---

hi, Are there new participants recruited throughout the years, so the participants in tables from v11 for example would differ in v18. If so, are there any documents that summarises the new participants per disease type / tumour type?

Participants were added over the years but the 100k project stopped recruiting a few years ago (2018?). The last few 100k main programme releases 2019 onwards contain mainly the same participants but some data sets were added over time (and some participants withdrew from research).

To my knowledge, there are no documents summarising the participants in each release by disease or tumour type. Youâd need to run queries against each Labkey release folder data to determine this.

---

When do you think NHS GMS will start including clinical data?

live answered

October 7, 2025
