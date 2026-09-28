---
title: 'Building rare disease cohorts with matching control, June 2025 - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/rd_cohorts_june25/
scraped_at: 2026-05-04T06:33:31Z
---

> **Archive training session:**
>
> Past training sessions may include information that is no longer true, in either the presentation or the Q&A. Please double check against the relevant documentation pages.

# Building rare disease cohorts with matching control, June 2025

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

10th June 2025

## Materials

You can access the redacted slides and video below. All sensitive data has been censored. You can access and copy code from the Jupyter and R notebooks used in the training at:

`/gel_data_resources/example_scripts/workshop_scripts/rare_disease_cohorts_2025`

### Slides

[View the sides](../rare_disease_june_2025.pdf)

### Video

[Give us feedback on this tutorial](https://surveys.genomicsengland.co.uk/s/JGU3ST/)

Q&A

Does this system work for the cancer datasets as well?

Both Participant Explorer and LabKey will have information on Cancer Participants

---

can we subset participants using a list of identifiers? I have been looking into denovo variants and have selected some of them, but would like to have more information on the participants that have those mutations selected. How should I best proceed? Thanks!

There are multiple ways to generate a cohort, both from the phenotype and from the genetic makup, it may be possible to use both aproaches to refine your cohort of interest by intersecting the participant lists returned.

---

Is there a way to know what information is universal? So which type of phenotype information/measurements are available for all the participants?

As the information has been collated directly from the NHS we are dependent on the reporting/recruiting clinician for completness and accuracy of the data. We would not exclude a participant because some aspect of this data was missing.

---

Anyothere databases than GEL to find novel rare variant?

within LabKey, there are a number of tables that include information on variants (see tiering and exomiser tables for example).

Wew also have the Interactive Variant Analyser (IVA) that can help filter participants based on the variants present.

---

Are there variants annotated by ensemble-VEP as a column filter?

The most effective way of accessing VEP annotations will be to query the aggV2 functional annotation data. for more information please see the following documentation page:

https://re-docs.genomicsengland.co.uk/aggv2\_functional\_annotation\_queries/

---

can we have access to these demo notebooks?

The notebooks will be made available afer the session in the following directory:

/gel\_data\_resources/example\_scripts/workshop\_scripts/rare\_disease\_cohorts\_2025

---

Is it normal that creating a simple conda (custom python jupyter lab version and pandas) environment takes around 40 minutes within the research environment? Thanks! (and thanks for the other replies! Very helpful!)

Conda environments work differently between the virtual desktop and the HPC. The VDI will have limited resources and we generaly do not recommend running any heavy computational tasks here.

The HPC will need to ensure that sufficient resources are available for your task which can slow the process down. If you are seeing consistent slowness please raise a Service Desk ticket so that the specifics of the issue can be investigated.

---

sorry have a silly question ð. If I wasn't able to find a novel variant on VEP on Ensemble is it possible to find it in genomic England?

Novel variants have been reported, if there is possible causative effect Genomics England has a process for allowing this information to be passed back to the participantâs clinicians.

---

Any other way of communicating a novel variant than via GEL?

No, Genomics England will facilitate the communicatin of these variants to ensure that participants are not re-indentified.

It is important to note that any attempts to re-identify a participant will considdered to be a breach of information governance and could be grounds for having access to the Research Environment and the NGRL suspended.

I meant if in an animal study we find a variant and we confirm that in human via GEL, apart from participant, is there another database or NHS community to disscuss this variant?

To be able to use findings outside of the Research Environment you will need to export these via the Airlock (I am not sure if this will be touched on in this session) the Airlock policies are detailed here:
https://re-docs.genomicsengland.co.uk/airlock/

I would encourage you to read the section in its entirety to maximise the likelihood that your export request is accepted.

---

is there also a file containing common variants for each patient? for instande hapmap variants or something similar?

I canât remember if we have HapMap data specifically in the Research Environment we do have dbSNP and GnomAD data. Additional public reference data can be requested via a Service Desk ticket, my colleagues will review the licenses governing these data and will import it for you if the licenses are permissive

---

common variants that are normally used for GWAS/PRS types of analyses

Please see previous response

---

Are you aware of a sort of society variants using for PLINK GLM?

I am affraid that this question is not completely clear to me. Please raise a service desk ticket so that we can gather more inforamtion and provide you with more targeted support.

---

What is the best way to build a cohort of patients based on genetic variants for a specific gene? For example, I have identified a patient with specific phenotype that has a candidate pathogenic variant in the gene ABC123. I have extracted all the individuals with potentially pathogenic variants in my gene ABC123 and now want to pull out their phenotypic information to see if any of them overlap with my patient's specific phenotype. Finally, once I have this information is there a way to look at the phenotypes to see if they are enriched for a particular term?

I would be looking at performing some of the steps Emily took as part of this training, intersecting the resulting list of participants/samples with the list you have generated and then proceeding to review the filtered phenoptypes.

I will of couse recommend that you raise a Service Desk ticket as we will be able to look into the specifics of your question in a bit more detail.

---

will the bcf commands be in the notebooks? Very useful!

https://re-docs.genomicsengland.co.uk/aggv2\_code\_book/

---

Are those in submitted\_diagnostic\_discovery in LabKey and Participant Explorer linked? I see listed in LabKey but not reported in Participant Explorer.

Not all LabKey tables have been pulled into Participant Explorer

---

where will be able to see the recording of this session?

https://re-docs.genomicsengland.co.uk/upcoming/#past-training-sessions

October 7, 2025
