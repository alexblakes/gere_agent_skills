---
title: 'Importing tools and data to use in the Research Environment, March 2023 - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/import_mar23/
scraped_at: 2026-05-04T06:32:43Z
---

> **Archive training session:**
>
> Past training sessions may include information that is no longer true, in either the presentation or the Q&A. Please double check against the relevant documentation pages.

# Importing tools and data to use in the Research Environment, March 2023

Working with the extensive genomic data in the Genomics England Research Environment requires the use of specialised software tools, and comparison to other data. While a vast array of bioinformatics tools and public data are made available in the HPC, you may have further tools and datasets you are keen to use, including those you have written yourself, that you would like to use to analyse GEL data.

This training sessions will take you through the various methods available to you for self-installation of tools, including using conda environments, CRAN, containers and Airlock. You will also learn how to query the catalogue of previously installed tools, and how to make requests for installation.

You are only allowed to attend this session if you are eligible for data access. This means that you are a Research Network member that has met the necessary verification checks and passed our Information Governance training course. If you do not meet this criterion by 20th March 2023, you will be unregistered for this session.

## Timetable

14.00 Welcome and introduction  
14.05 What is already in the RE  
14.15 Personal conda environments  
14.25 Importing R packages with CRAN and Bioconductor  
14.35 Importing containers with Singularity  
14.45 Using Airlock to bring data/software in  
14.55 Making a software request  
15.05 Software licensing requirements  
15.15 Questions

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

21st March 2023

## Materials

You can access the redacted slides and video below. All sensitive data has been censored.

### Slides

### Video

Q&A

sorry if you already said it. Are you going to share the recorded webinar?

live answered

---

Are there any plans of having any R 4.x.x version available anytime soon?

We do actually have many R 4.X.X options available, they just werenât listed on the slide. We definitely have 4.0.2, 4.0.3, 4.1.0, and 4.2.1 for example.

thatâs great to know. thanks!

Youâre welcome :-)

---

Iâve just learnt how to use R, I want to access data from a neuro-oncology database, is there such data available? and if yes, for a complete beginner can you suggest the process of data manipulation? I understand this depends on the research question, which is intratumoral heterogeneity.

Due to our need to ensure protection of our participantâs data we donât normally permit access to external databases. we may be able to host the data internally. For this we would need to ask you to raise a request via the service desk, itâs best to raise this as a âsoftware requestâ as the information that we need is similar

---

Also for the R environment, certain R packages have Linux dependencies that need to be "apt install"ed, but we don't have the permissions to do so (for example, the tidyverse package). How would you recommend we handle this sort of thing in the RE?

Good question. In these situations I would recommend you raise a Service Desk ticket so that we can look into the issue for you (and perhaps install the package on your behalf if deemed necessary). One possible workaround might be to try a different R version in case the dependency is met on that version.

---

can I make a singularity file on sylabs website and pull that? when I tried it gave me a strange error to do with compatibilityâ¦

Sylabs support can be a little hit and miss at present depending on the type of manifest that is used. the Artifactory is not compatible with v1 manifests. We tend to find that converting a docker image is more reliable

---

Will Airlock requests work the same after the move to AWS?

live answered

---

Which form should we use for reference files, like .bed? It is neither a script/program nor biological/phenotypic data

live answered

---

whatâs the min/average time we should wait for airlock approvals? (assuming a simple request)

The Airlock Committee does meet at least once a week, more complex requests will take more time as it will require a more in-depth review. So approvals can be as quick as the same week or may need a few weeks to be fully reviewed

---

how long does it take (typically) to export pdf/png plot figures from RE (in order to write papers)? I may need to do this multiple times when writing a paper

Exporting figures should be a very quick process if you follow our airlock guidelines (see: https://re-docs.genomicsengland.co.uk/airlock\_rules/). You should read this ahead of time to make sure your request is accepted as quickly as possible, and get in touch with us if you have any questions.

As Matt said in the other question, the airlock team meets at least once a week so you should receive a response quite promptly.

---

hi all, sorry i joined lateâwill a recording/slides be made available?

live answered

October 7, 2025
