---
title: 'Building rare disease cohorts with matching control, May 2024 - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/rd_cohorts_may24/
scraped_at: 2026-05-04T06:33:31Z
---

> **Archive training session:**
>
> Past training sessions may include information that is no longer true, in either the presentation or the Q&A. Please double check against the relevant documentation pages.

# Building rare disease cohorts with matching control, May 2024

Building a cohort is a vital first step in many kinds of genomics studies, such as GWAS, survival analysis and identifying cancer characteristics. The vast array of phenotypic data available in the Genomics England Research Environment (GEL RE), both recruited disease and electronic health records, is a great resource for cohort building and verification.

This training session will go over some of the ways you can build cohorts in the GEL RE: Participant Explorer for no code creation and the Labkey API for programmatic construction and verification. Using both methods, we will show how you can pull out the genomic file locations, or the participant identifiers to use with variant aggregation files. During the session, we will discuss the tables in the database which contain phenotypic data, using ICD10 and HPO codes for diagnoses in the primary and secondary tables, plus continuous measurements in rare disease. We will look at how you can build matched cohorts of sex and ethnicity

## Timetable

13.30 Introduction and admin  
13.35 Parameters and considerations for building a cohort  
13.45 no code cohort building with Participant Explorer  
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

14th May 2024

## Materials

You can access the redacted slides and video below. All sensitive data has been censored. You can access and copy code from the Jupyter and R notebooks used in the training at:

`/gel_data_resources/example_scripts/workshop_scripts/rd_cohort_2024`

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

[Give us feedback on this tutorial](https://www.smartsurvey.co.uk/s/B6YTBE/)

Q&A

I have heard rumours/myths/dreamt of individuals recruited during the COVID pandemic for WGS sequencing for severe COVID symptoms as potential control is this true? Unsure where this thought comes from.

Hi Patrick! Here is a link to the documentation for CloudOS: https://re-docs.genomicsengland.co.uk/cloudos/

As well as a link to CloudOS data (with a specific COVID-19 data link): https://re-docs.genomicsengland.co.uk/cloudos\_data/

---

Are there any plans to update the alignments to T2T reference genome?

Hi Juliana! We are looking into this, but no plans just yet as far as I know.

---

Are these tables in LabKey pre-made and available for all, or are these ones you have created?

Hello! All LabKey tables that Emily is now going through are pre-made and available for you to access

---

Hi two questions relating to the linkage to medical records please: 1) have all patients in the 100K dataset had HES records uploaded 2) Is there any linkage to GP records / primary care diagnoses?

Hello Naomi! Thank you for the questions.

1. HES data is available for 100kGP participants with current consent, unless these have withdrawn from the dataset.
2. We only have data available from admission, outpatient appointments , critical care, and A&E attendance. You will be able to read more about this data here: https://re-docs.genomicsengland.co.uk/general\_clinical/#hospital-episodes-statistics-from-nhse

---

A lot of tables are named an acronym: 'ae' or 'apc' like the ones you just showed, where do I find the full name or an explanation of what that table is about?

Hi Suzana! Thank you for your question.

Yes, there is a data dictionary per each release, where further information is found:

100kGP (release 18): https://re-docs.genomicsengland.co.uk/release18/
NHS-GMS (release 3): https://re-docs.genomicsengland.co.uk/gms\_release3/

---

Iâm finding the semi-colons in the GMC\_exit questionairre frustrating to identify the exact gene of interest. Slightly off topic but does anyone have an effective work-around for this? I link to the tiering table but my approach is imperfect.

live answered

---

Is it possible to save filtered tables on LabKey?

live answered

---

I find it really difficult to install libraries from scratch into R in the research environment - where is this code/script that has all the dataframe packages that can be easily installed?

Hello Thiloka! All routine libraries and packages should be installed and you should be able to load these (e.g. tidyverse) once you open your R session. If you would like to install a package that is not used routinely, I believe you would have to submit a Service Desk ticket, as there are security measures put in place for any package installation.

I hope this answers your question - it would be good to know which package or library you have difficulty installing.

and a follow-up to this is - how to install additional R packages that arenât listed in your script ? I often have issues with connection to server that allows me to download from CRAN

Thanks Miruna, that is helpful. Packages are ontologyIndex, ontologySimilarity so I can manipulate the HPO data

octicons-check-16: Yes, I believe this has to do with security measures in the Research Environment. I would recommend submitting a Service Desk ticket so someone can help you with installing these packages.

---

can you post the location of the example code in the re folders kimdly

/gel\_data\_resources/example\_scripts/workshop\_scripts/rare\_disease\_cohort\_2024

---

Is there a possibility of discrepancy between participant explorer numbers and LabKey query numbers?

Hello Jayaram! There should not be any discrepancies between Participant Explorer and LabKey numbers, as long as they are both querying participants from the same release version.

---

Merging between tables often creates duplicate individuals in my experience (even when duplicates wouldnât obviously be in the initial table), is their a way to minimise this in the SQL query?

I still use the Rscript output option from the labkey options for the table then just merge across different lakkey tables on âparticipant\_idâ.

I have found previously that if I include a âDISTINCTâ keyword in my query (e.g. âSelect DISTINCT participant\_id, disease, hpo\_term., etc.â), it will select distinct records for each combination of variables.

As Emily mentioned, there isnât really a way to avoid this if you have variables that have multiple records for participants (e.g. multiple HPO terms per each participant will create multiple records for that one participant). However, the âDISTINCTâ flag will avoid downloading multiple records of the same HPO term per participant.

The âDISTINCTâ addition will make sure that you get the least amount of records available, while still keeping distinct records.

Hope this is helpful!

---

Can we concatenate all diagnoses listed in ICD-10 or hes\_ records, without specifying the exact diagnoses? Is there a dictionary we can refer to for these ICD-10 diagnoses and hes data so we can pull out the actual text version of these?

Hello! LabKey tables have ICD10 codes, which represent the codes that go alongside the diagnostic descriptions.

We have information on ICD10 code and code descriptions here (you will be able to link the codes to their description here):

/gel\_data\_resources/licenced\_resources/ICD10

October 7, 2025
