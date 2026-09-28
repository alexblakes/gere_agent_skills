---
title: 'Building rare disease cohorts with matching control, June 2023 - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/rare_disease_cohorts_june23/
scraped_at: 2026-05-04T06:33:28Z
---

> **Archive training session:**
>
> Past training sessions may include information that is no longer true, in either the presentation or the Q&A. Please double check against the relevant documentation pages.

# Building rare disease cohorts with matching control, June 2023

Building a cohort is a vital first step in many kinds of genomics studies, such as GWAS, survival analysis and identifying cancer characteristics. The vast array of phenotypic data available in the Genomics England Research Environment (GEL RE), both recruited disease and electronic health records, is a great resource for cohort building and verification.

This training session will go over some of the ways you can build cohorts in the Genomics England RE: Participant Explorer for no code creation and the Labkey API for programmatic construction and verification. Using both methods, we will show how you can pull out the genomic file locations, or the participant identifiers to use with variant aggregation files. During the session, we will discuss the tables in the database which contain phenotypic data, using ICD10 and HPO codes for diagnoses in the primary and secondary tables, plus continuous measurements in rare disease. We will look at how you can build matched cohorts of sex and ethnicity

You are only allowed to attend this session if you are eligible for data access. This means that you are a Research Network member that has met the necessary verification checks and passed our Information Governance training course. If you do not meet this criterion by 19th June 2023, you will be unregistered for this session.

## Timetable

13.30 Introduction and admin  
13.35 Parameters and considerations for building a cohort  
13.45 no code cohort building with participant explorer  
13.55 Labkey tables for cohort building in rare disease  
14.05 Using the Labkey API in Python and R  
14.15 Creating a matched cohort
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
- working in rare disease genomics
- who can programme in python and/or R (a small segment of the training is suitable for non-programmers)

## Date

20th June 2023

## Materials

You can access the redacted slides and video below. All sensitive data has been censored.

### Slides

### Video

### Optional exercises

These practice exercises will allow you to try out what you've learned. Feel free to have a go in your own time.

Coding

These exercises are also written into the Jupyter and R notebooks, along with sample code that is a possible answer.

1. Build a cohort of all participants in Genomics England with Motor Neurone Disease/Amyotrophic Lateral Sclerosis. You should search for all participants recruited to Genomics England for ALS, all participants with the HPO term HP:0007354 and all diagnoses of the ICD10 code G12.2 in their medical history.
2. Narrow down your search to include only those who do not yet have a genetic diagnosis. You should check for diagnoses that have been approved by the GLHs, and also those who have diagnoses submitted by researchers.
3. Create a control cohort of participants without ALS. You should expand the search criteria to exclude all participants with similar phenotypes:
4. Use the disease group to search for participants not recruited for diseases related to ALS.
5. Find the parent term of the HPO term HP:0007354 and any other child terms of that parent (https://hpo.jax.org/app/). Use these to exclude participants.
6. Find related terms to the ICD10 code G12.2 (look at https://phewascatalog.org/phecodes\_icd10 to find related codes) and search both medical history and causes of death to exclude participants.
7. Get the mean age and sex ratios of your case and control cohorts. Ensure that these are broadly similar. Filter both cohorts to only include participants of European ancestry.
8. Check that all of your cohort have genomes aligned to GRCh38, are in AggV2, have no sex chromosome aneuploidies and their phenotypic sex matches their sex chromosomes, had samples taken as blood, using EDTA extraction and with PCR-free sequencing and that you only have one of any pair of monozygotic twins, prioritising affected participants.
9. Get the filepaths of the BAM files for all participants in the case and control cohorts.

No code

1. Use Participant Explorer to build a cohort of all participants in Genomics England with Motor Neurone Disease/Amyotrophic Lateral Sclerosis. You should search for all participants recruited to Genomics England for ALS, all participants with the HPO term HP:0007354 and all diagnoses of the ICD10 code G12.2 in their medical history.
2. Narrow down your search to include only those who do not yet have a genetic diagnosis, are of European ancestry and have genomes aligned to GRCh38
3. Download a table of all your cohorts, including participant ID, details of their phenotype, platekey and the file location of their genome BAM files.
4. Use Participant Explorer to build a control cohort excluding all the parent terms of those you used to build your case cohort, matching on ancestry and genome build, and download details as with your control cohort.

[Give us feedback on this tutorial](https://www.smartsurvey.co.uk/s/JOVV3E/)

October 7, 2025
