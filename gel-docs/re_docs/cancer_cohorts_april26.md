---
title: 'Building cancer cohorts, April 2025 - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/cancer_cohorts_april26/
scraped_at: 2026-05-04T06:31:30Z
---

> **Archive training session:**
>
> Past training sessions may include information that is no longer true, in either the presentation or the Q&A. Please double check against the relevant documentation pages.

# Building cancer cohorts, April 2026

Building a cohort is a vital first step in many kinds of genomics studies, such as GWAS, survival analysis and identifying cancer characteristics. The vast array of phenotypic data available in the Genomics England Research Environment, both recruited disease and electronic health records, is a great resource for cohort building and verification.

This training session will go over some of the ways you can build cohorts in the Genomics England Research Environment: Participant Explorer for no-code creation and programmatic construction and verification. Using both methods, we will show how you can pull out the genomic file locations, or the participant identifiers to use with variant aggregation files.

You are only allowed to attend this session if you are eligible for data access. This means that you are a Research Network member that has met the necessary verification checks and passed our Information Governance training course. If you do not meet this criterion by 13th April 2026, you will be unregistered for this session.

## Timetable

13.30 Introduction and admin  
13.35 Parameters and considerations for building a cohort  
13.45 no code cohort building with participant explorer  
13.55 Labkey tables for cohort building in cancer  
14.05 Workinmg programmatically in Python and R
14.25 Getting genomic filepaths for your cohort  
14.35 Using your cohort with aggregate VCFs and bcftools  
14.45 Getting help and questions

## Learning objectives

After this training you will know:

- Where to find phenotypic and covariate data for building cohorts in the Genomics England Research Environment
- How to create cohorts using the Participant Explorer no code interface
- How to use the Labkey API to create and verify cohorts with Python or R

## Target audience

This training is aimed at researchers:

- working with the Genomics England Research Environment
- working in cancer genomics
- who can programme in python and/or R (a small segment of the training is suitable for non-programmers)

## Date

14th April 2026

## Materials

You can access the redacted slides and video below. All sensitive data has been censored.

### Slides

[Download the slides](cancer_april_26.pdf)

### Video

[Give us feedback on this tutorial](https://surveys.genomicsengland.co.uk/s/0A1R02/)

### Code

You can find the notebooks used inside the RE in:
`/gel_data_resources/example_scripts/workshop_scripts/cancer_cohorts_2026`

### Q&A

Q&A

What's the difference between GrCh38 (VSv4) and anotehr version og GRCh38(dragen)?

The main differences will be in the type of aligner used as well as the way the reference genome is processed.

I guess I could find the detail info about the this in the website? such as reference genome version

## Dragen is an Illumina product, I would recommend reaching out to them should you need specific details that are not within the userguide of the tool.

Why canât I log in to the participants explorer? Do I need to request it? my main research is pan-cancer

If you have an issue loging into the Participant Explorer I would recommend raising a Service Desk ticket as our colleagues will be best placed to troubleshoot this issue for you.

---

How could we get the username and passsword for Participant Explorer?

Research Environment tools that require a login will use the same credentials needed to access the Research Environment

---

Is there any readme or cheetsheet for these acronyms in LabKey?

These will be listed in the data dictionary. For ICD10 codes I would recommend using the WHO website.

can we also get the information about the names of each directory? some of the names look not that intuitiveâ¦

The column headers are listed in the data dictionary, LabKey is organised in a table maner which does not use directories.

sorry for the confusion, I mean what kind of patinet data we can find in e.g. âav\_patientâ (not about columns in each table)

av\_patient will only contain information on cancer participants

yes, Iâm looking for that kind of information!
Is there any cheetsheet for the list?

When you log into LabKey there are a set of lists under âData Viewsâ; the tables are classified by content type within those views.

Tables that fall outside of this structure will be identifyable from the name.

---

LabKey listed some participants who withdrew consents after main programme v19 was released. Are they still included in the v19 release? Do we need to manually remove their data? Thanks

You can only use participants who are consented at the point when you started your research, I recommend generating a list of these from the participant table at the start of your work by filtering by the consent status column.

if you have a concern I would check the list of participants that you have against the participant table to see what the current consent status of your cohort members is.

Thanks! Where can I find the consent status column? I pulled cancer analysis table via SQL but did not see such a column

The consent status column in 100,000 Genomes Project is called âProgramme Consent Statusâ will be in the participant table.

## I find that it is best to `JOIN` the tables together to get LabKey to do the filtering for you.

These tables (av\_tumour, av\_treatment, cancer\_staging) have multiple rows per participant\_id, whatâs the best way to reduce them to one per participant?

The information will be updated based on the information that has been provided to Genomics England by the NHS. We cannot comment on the best approach for your project whether this is to use the latest entry or to try to combine these. There are a variety of approaches for acheiving this depending on the output that you need.

---

we can't copy from the chat

you can try copying /gel\_data\_resources/example\_scripts/workshop\_scripts/cancer\_cohorts\_2026/ into the Research Environmentâs terminal

---

When I am trying to open Jupyter notebook it says not installed, I am in HPC and done .ntc labkey step

Please ensure that you are following the instructions listed on this page:
https://re-docs.genomicsengland.co.uk/hpc\_jupyter/

---

can you please give the web address for these helper notebooks?

the example notebooks are not available online, they are only available within the Research Environment on the path that was included above in the Q&A.

---

Is tumour\_clinical\_sample\_time a good surrogate for diagnosis date? Or are frozen tumours sequenced after a while after diagnosis?

I would probably be looking at cross referenting the clinic sample with the with the tumour platekey to see when the biopsy was taken. The data delivery to Genomics England would be very shortly after this, can probably check this by looking at the âgenome file paths and typesâ delivery date column to see what the interval would be.

another option is to use the diagnosis\_date\_best information from av\_tumour

---

I noticed that there could be 10 years' difference between diagnosis\_date\_best information from av\_tumour and tumour\_clinical\_sample\_time. Does that mean the patient could have the tumor sequenced long after diagnosis?

For additional information please raise a Service Desk ticket as my colleagues will have more time to expand upon the subject.

---

what structure should the .netrc file have?

live answered

April 15, 2026
