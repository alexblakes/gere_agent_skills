---
title: 'Importing tools and data to use in the Research Environment, February 2025 - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/import_feb25/
scraped_at: 2026-05-04T06:32:41Z
---

> **Archive training session:**
>
> Past training sessions may include information that is no longer true, in either the presentation or the Q&A. Please double check against the relevant documentation pages.

# Importing tools and data to use in the Research Environment, February 2025

Working with the extensive genomic data in the Genomics England Research Environment requires the use of specialised software tools, and comparison to other data. While a vast array of bioinformatics tools and public data are made available in the HPC, you may have further tools and datasets you are keen to use, including those you have written yourself, that you would like to use to analyse GEL data.

This training session will take you through the various methods available to you for self-installation of tools, including using conda environments, CRAN, containers and Airlock. You will also learn how to query the catalogue of previously installed tools, and how to make requests for installation.

## Timetable

13.30 Welcome and introduction  
13.35 What is already in the RE  
13.45 Personal conda environments  
13.50 Importing R packages with CRAN and Bioconductor  
14.00 Importing containers with Singularity  
14.10 Using Airlock to bring data/software in  
14.15 Making a software request
14.25 CloudOS â importing tools and pipelines on the Cloud
14.35 Software licensing requirements  
14.45 Questions

## Learning objectives

After this training you will know:

- How to find all the available software and data on the RE
- Methods for self-import and installation of data and tools
- How and when to request software installation of the RE

## Target audience

This training is aimed at researchers:

- working with the Genomics England Research Environment
- comfortable using the command line
- who can programme in python and/or R

## Date

12th February 2025

## Materials

You can access the redacted slides and video below. All sensitive data has been censored.

### Slides

[View the sides](../import_feb_25.pdf)

### Video

[Give us feedback on this tutorial](https://surveys.genomicsengland.co.uk/s/OUPMNY/)

### Q&A

Q&A

Iâm guessing everything in terms of containers runs through singularity, not docker, correct?

live answered

---

Can we link to EHR data for patients?

Hi Shikta! Could you elaborate on your question - do you mean linking to data from LabKey tables in the RE?

yes if I am interested in a particular cancer type - can I link it to EHR information? Or do you have a dataset which is already linked data.

I have linked documentation to accessing and linking clinical data via LabKey: [https://re-docs.genomicsengland.co.uk/clinical\_data/](../clinical_data/) . EHR information is available as part of our dataset, and you will have to carry out some data wrangling to link this data to your desired cohort (as all types of clinical/phenotypic data sit in different LabKey tables).

---

Do you offer mamba support?

I have checked the documentation and it is just conda

---

Hi Hamzah, can this be accessed with my RE access or does this require other access?

CloudOS requires extra access, which you can request

---

If I have my own software which exists as a private, password protected docker image, am i correct in reasoning that the correct way to import it would be airlock rather than singularity?

Yes, you can import containers as an image through Airlock if itâs not possible to make it public

October 7, 2025
