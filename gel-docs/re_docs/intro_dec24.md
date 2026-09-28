---
title: 'Introduction to the Research Environment, December 2024 - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/intro_dec24/
scraped_at: 2026-05-04T06:32:45Z
---

> **Archive training session:**
>
> Past training sessions may include information that is no longer true, in either the presentation or the Q&A. Please double check against the relevant documentation pages.

# Introduction to the Research Environment, December 2024

The Genomics England Research Environment provides access to Genomics England data, including genomes, variants and phenotypic data from rare disease and cancer patients from the 100,000 Genomes project and NHS Genomic Medicine Service. Due to the sensitive nature of the data, all analyses on these data must be carried out within the Research Environment and only non-identifiable aggregate data can be exported. To enable this, a variety of tools are available within the Research Environment to segment and analyse the data.

This training session is aimed at newcomers to the Genomics England Research Environment and will introduce what is in the Research Environment, both in terms of data and tools. The basic functionality of the tools will be covered, along with how you can export data and the restrictions on doing this.

## Timetable

13.30 Welcome and introduction  
13.35 Sources and type of data in the Research Environment  
13.50 Tools in the Research Environment  
14.10 Programmatic access to Genomics England data  
14.20 Running command line tools and pipelines using our HPC cluster  
14.30 The Airlock, restricted import and export of data  
14.45 Getting help and questions

## Learning objectives

After this training you will know:

- what data can be accessed in the Genomics England Research Environment
- the functions of the Participant Explorer, LabKey, IVA and IGV
- what APIs are available for exploring the data
- the kinds of jobs you can run on the HPC cluster and when you might use it
- how to import and export data from the Genomics England Research Environment using Airlock
- how to use the documentation to learn more

## Target audience

This training is aimed at researchers:

- new to the Genomics England Research Environment

## Date

10th December 2024

## Materials

You can access the redacted slides and video below. All sensitive data has been censored.

### Slides

[Slides](../intro_dec24.pdf)

### Video

[Give us feedback on this tutorial](https://surveys.genomicsengland.co.uk/s/I3YP1V/)

Q&A

Does the dataset in the Main-Propgramme in Labkey contain the datasets from NHS-GMS? If not, is there an interphase that allows one to query both datasets at the same time?

The two programmes are separate, they are contained in different sets of tables, essentially as different databases.

Cross querying these will not be possible given that there are differing data models for the two databases are different. In adition the secondary data for NHS-GMS is not as complete so you may be limiting your work if you where to perform this type of cross-querying within dataframes.

The best approach may be to perform the analysis work in parallel and compare/contrast the resutls.

---

How do you find specific patients in the NGRL? For 100KGP you have the 9 digit codes. What do you use for GMSA patients?

NHS-GMS participants will have their own participant IDs, the participant table in the NHS-GMS release will provide you with the full list of participants fo thtat release.

In addition to the participants themselves each sample will be identified by a platekey which can be used within IVA

---

When we get WGS results for our GMSA patients, who have also consented for their data to be put into the NGRL, the report has a p and r number. However, these do not match anything in the RE GMSA data tables, if I want to look at their WGS data myself.

Participant IDs in LabKey will start with a âpâ and referal IDs in LabKey will start with an ârâ.

The re-identification of participants in the Research Environment is strictly prohibited. Attempts to do so could jeapardise your access.

---

Are there GPU resources on the HPC?

we donât have any unfortunately

https://re-docs.genomicsengland.co.uk/hpc/#double-helix-specifications

In that case, is there a procedure to import a pretrained neural network through the airlock?

---

do we have all the variants in IVA or do we need to use VEP to find variants that is not reprted

live answered

October 7, 2025
