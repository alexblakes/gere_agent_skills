---
title: 'Getting medical histories for participants, September 2022 - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/medical_history_september22/
scraped_at: 2026-05-04T06:33:01Z
---

> **Archive training session:**
>
> Past training sessions may include information that is no longer true, in either the presentation or the Q&A. Please double check against the relevant documentation pages.

# Getting medical histories for participants, September 2022

The Genomics England dataset includes a rich array of clinical data for all participants, rare disease probands and relatives, and cancer participants. Beyond the phenotypes recorded when participants were recruited into Genomics England, medical history was retroactively retrieved from NHS England for all participants and continues to be updated, allowing you to analyse secondary phenotypes, common disease and risk factors.

This training session will introduce you to the type of data we have available, including hospital episode statistics and mental health data, and the time periods when different data types were collected. We will show you how to access these data in table and graphical format using Participant Explorer, and compare medical history between participants. The raw data are stored in LabKey, so we will cover the tables that include these data and their structure, plus how to access these programmatically.

## Timetable

14.00 Welcome and introduction  
14.05 NHS England data in the RE  
14.15 Mental health data in the RE  
14.20 Accessing NHS England data with Participant Explorer  
14.30 Comparing participantsâ medical history with Participant Explorer  
14.40 LabKey tables: Hospital Episode Statistics  
14.50 LabKey tables: Mental Health  
15.00 Accessing medical history programmatically  
15.15 Questions

## Learning objectives

After this training you will be able to:

- Understand what medical history data is available for participants in the GEL RE
- Visualise and compare medical histories using Participant Explorer
- Access the LabKey tables of medical history data

## Target audience

Trainees who are familiar with the RE who wish to learn more about finding participantsâ medical histories. This training session will include a short section on accessing data programmatically, so some familiarity with Python or R is helpful but not required.

You are only allowed to attend this session if you are eligible for data access. This means that you are a Research Network member, have met the necessary verification checks and passed our Information Governance training course. If you do not meet these criteria by 19th September 2022, you will be unregistered for this session.

## Time

September 20, 2022 02:00 PM in London

## Materials

You can access the redacted slides and video below. All sensitive data has been censored.

[Slides](../medical_history.pdf)

[Give us feedback on this tutorial](https://www.smartsurvey.co.uk/s/66CVAY/)

Q&A

Is the information as to when these particular data are collected from and to listed anywhere? The data dictionary does not mention that A&E data was discontinued, and that ECDS data is only connected from 2018ish.

The graph of longitudinal period coverings emily showed earlier is present in the release notes. There is also a table below it with the exact date range for each table

---

Are only the ICD10 codes used for the diagnosis? I have read in the guide that before 1995, ICD9 codes were used.

the ICD codes will contain both ICD9 if the entry from before 1995, for entries form 1995 the entry will be ICD10

---

In the cancer registery, is there discharge information?

The table cancer\_register\_nhsd does not contain any discharge information. It has details on registration year, diagnosis date, cancer site, cancer type and cancer behaviour

---

Are comorbidites for participants recorded anywhere before the ecds table was opened?

Unfortunately comorbidities are only currently present in the ecds table

So thereâs no information from prior to 2018?

Sorry, missed this question. There is some comordities data in the NCRAS tables which may be prior to 2018 but NHSE comorbidities are only currently from 2018 in ecds.

I believe their conditions may be listed in a differently named column (don't know it off the top of my head, sorry!)

---

Are these data available for only the probands or are they also available for family members who have genetic data available?

live answered

Brilliant. Thank you!

---

How many patients does GEL have digital records for? Thanks! Amy

There are around 90K participants in the 100,000 genomes project data release.

---

Is there any specific dataset covering intellectual disability participants?

these types of groupings are listed in the rare\_disesases\_participant\_disease table which can be used in conjunction with other tables to help build your cohort

---

Just for confirmation, the date of birth is not available, just the year of birth, right?

Correct

---

If a genomic analysis was done previously, on an earlier release of the aggregate dataset, can you access the correct demographics from LabKey to match with the dataset which you used for the genomic analysis (given the time point when you did that analysis)?

The aggregate is compiled from the delivered genomeVCFs for each participant. It has filters applied to ensure that non-consented participants cannot be selected. There is no dynamic update on the aggV2?

---

Since there are many diagnosis columns, the epistart date to which diagnosis corresponds? (using the hes\_Apc dataset) Since there are many diagnosis columns, the epistart date to which diagnosis corresponds? (using the hes\_Apc dataset)

The multiuple columns allow clinicians to assign miltuiple codes for each participant at each visit. You will find multiuple rows for each participant, that will be one row for each visit or consultation event. Sorting these rows by date will allow you know the timeline for the diagnoses.

---

Does the NCRAS table contains data from the national cancer registry and analysis service? How far back do these records go? Are they less complete than the NHS records?

There are 8 NCRAS tables, av\_treatment and av\_tumour go back the furthest to 1985. The NCRAS tables contain a lot more data than the cancer\_register\_nhsd table

\*11 tables! And to clarify on my previous point, the data does not go back as far but includes data not present in the cancer\_register\_nhsd table such as details of care plans and specific treatments. You can look in the data dictionary for more details on these tables

---

Where are these notebooks? I can find the jupyter notebook but not the R markdown

it may not have the access permissions set just yet

---

How do we get access to Tier1 variants from rare disease in VCF format and query them using bcftools?

Once you have the list of participants that you are interested in you will be able to get the vcf file paths from the genome\_file\_paths\_and\_types table that you will be able to send to BCFtools.

Do we need to do this via HPC?

---

So could it become impossible to access the correct demographics for an earlier aggV2 version?

The aggV2 is purely an aggregated genomeVCF for the 100,000 Genomes Project, the additional data, of the type that Emily has been presenting, will be up to date.

---

What is the difference between the main program data and NHS GMS data released recently? I am not sure I have understood it correctly.

The main programme data is the data on participants recruited as part of the 100K genomes project. The NHS GMS data is data on patients recruited through the NHS GMS. Similar data should be available on both sets of participants, although we do not currently release any NHSE clinical data for the NHS GMS participants

---

Could we get the list of proposed training sessions emailed? I can shared with our team who are all GeCIP trained and we might be able to provide input

live answered

Perfect! Thanks

---

Are cancer registered users able to access rare-disease BAM and VCF files?

The only restriction will be at the participant level, once a participant withdraws their consent we remove their data from future research

---

Is there any limit regarding the queues in the hpc cluster?

the scheduler that we use has a âfair shareâ routine that looks to ensure that all researchers are able to perform their work

---

Where can I find the pedigree information for the probands.

this information is only available for Rare Disease participants in the rare\_diseases\_pedegree\_member table

just to add to this, the Participant Explorer also displays a list of relatives on the participant details page (including a link that opens the pedigree\_member table in labkey)

---

Can you remind me how to find the data dictionaries? Sorry, I zoned out when you showed us

in the RE user guide under âData in the REâ, there is a page for each data release, with links to the data dictionary and release note at the bottom.

---

Thanks for your answers so far - I am still not certain whether it is possible to access the summary demographics for an earlier version of aggv2 There is only 1 version of the aggV2, it contains only variant information.

For demographic information you would need to use the data sources that Emily has presented here

---

Which tables in the medical history are considered the most reliable ones to use?

live answered

---

Please, are you including how to run code scripts (typical examples) with GEL data in the documents you are sending to us?

live answered

---

How can I get detailed information of the variants like for allele 1 and allele 2 for the proband or for the relative for rare disease

https://vimeo.com/manage/videos/742691461/d9fdde40c6

October 7, 2025
