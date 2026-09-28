---
title: 'Building cancer cohorts and survival analysis, March 2024 - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/cancer_cohorts_mar24/
scraped_at: 2026-05-04T06:31:30Z
---

> **Archive training session:**
>
> Past training sessions may include information that is no longer true, in either the presentation or the Q&A. Please double check against the relevant documentation pages.

# Building cancer cohorts and survival analysis, March 2024

Building a cohort is a vital first step in many kinds of genomics studies, such as GWAS, survival analysis and identifying cancer characteristics. The vast array of phenotypic data available in the Genomics England Research Environment, both recruited disease and electronic health records, is a great resource for cohort building and verification.

This training session will go over some of the ways you can build cohorts in the Genomics England Research Environment: Participant Explorer for no-code creation and the Labkey API for programmatic construction and verification. Using both methods, we will show how you can pull out the genomic file locations, or the participant identifiers to use with variant aggregation files. We will also look at how to pull out the relevant data for survival analysis, and run this on cohorts.

You are only allowed to attend this session if you are eligible for data access. This means that you are a Research Network member that has met the necessary verification checks and passed our Information Governance training course. If you do not meet this criterion by 11th March 2024, you will be unregistered for this session.

## Timetable

13.30 Introduction and admin  
13.35 Parameters and considerations for building a cohort  
13.45 no code cohort building with participant explorer  
13.55 Labkey tables for cohort building in cancer  
14.05 Using the Labkey API in Python and R  
14.15 Survival analysis for cancer cohorts  
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

12th March 2024

## Materials

You can access the redacted slides and video below. All sensitive data has been censored. You can access and copy code from the Jupyter and R notebooks used in the training at:

`/gel_data_resources/example_scripts/workshop_scripts/cancer_cohort_2024`

### Slides

### Video

### Optional exercises

These practice exercises will allow you to try out what you've learned. Feel free to have a go in your own time.

Coding

These exercises are also written into the Jupyter and R notebooks, along with sample code that is a possible answer.

1. Build a cohort of all participants recruited to Genomics England with Colorectal cancer, and verify this diagnosis by checking the secondary NHS England data for the relevant ICD10 code, C18.
2. Pull out the Duke's stage for the participants in your cohort.
3. Identify participants in this cohort who have been treated with Bevacizumab.
4. Find the age at which the participants were diagnosed and segregate the group into those diagnosed at 69 and under, or 70 and over.
5. (Python only) Carry out survival analysis, comparing the two groups diagnosed at different ages.
6. Get the filepaths of the germline BAM files from the original analysis and CRAM files from the DRAGEN realignment for all participants.

No code

1. Using Participant Explorer, build a cohort of participants recruited to Genomics England with Colorectal cancer, who also have the relevant ICD10 code, C18, in their medical records.
2. View the medical history of some of the participants in the cohort and note their Duke's stage and any chemotherapy drugs they've been treated with.
3. Export a table of the cohort including the participants' year of birth, platekey and genome file paths.

[Give us feedback on this tutorial](https://www.smartsurvey.co.uk/s/QRAD2V/)

### Q&A

Q&A

Hello could you please remind me of the file path for the cohort building training folder? Thanks

Hi Mairena, the file path is /gel\_data\_resources/example\_scripts/workshop\_scripts/cancer\_cohorts\_2024/ .

Hi Mairena, you can also find recordings of past training sessions on this link: https://re-docs.genomicsengland.co.uk/upcoming/#past-training-sessions

---

is there a data dictionary to explain all these fields ?

https://re-docs.genomicsengland.co.uk/current\_release/

---

Hello, is it possible to include genes here? Like people with cancer due to a mutation on a certain gene?

Hi Mairena, you can find more information on workflows by accessing this link: https://re-docs.genomicsengland.co.uk/small\_variant/

You can also follow another training session on how to select participants based on genotypes here: https://re-docs.genomicsengland.co.uk/genotypes/

The cancer\_tier\_and\_domain\_variants also gives you a quick shortcut for tiered genes (those with known association to cancer). This table does not contain all germline/somatic variants but only for a selection of genes.

Structural variants are queried via this workflow: https://re-docs.genomicsengland.co.uk/structural\_variant/

---

How can I link the small variant pipeline with the pipeline we talk right now?

Hi Mairena, youâll use the platekey to link the clinical information to the participant genotype.

---

The platekey from the small variant pipeline?

Hi Mairena, the output from running the small variant workflow will include the platekeys of samples containing variants in the gene of interest. This list of IDs can be incorporated into an SQL query for linking clinical information such as those shown by Emily.

Each participant\_id will have one or more platekeys. If you use the cancer\_analysis table, youâll see their pairings.

---

Will this available in R as well?

Thereâs a version of the R survival analysis in R as well. It may differ a little from the python package. You can find more information here: https://re-docs.genomicsengland.co.uk/survival/

---

is it possible to examine progression free survival using GEL or only Overall survival?

The most direct analysis is with overall survival as the end point. However, progression free survival could be inferred from data, such as change in therapy would imply progression, but this is not readily available.

January 29, 2026
