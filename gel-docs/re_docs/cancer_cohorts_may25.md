---
title: 'Building cancer cohorts, May 2025 - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/cancer_cohorts_may25/
scraped_at: 2026-05-04T06:31:32Z
---

> **Archive training session:**
>
> Past training sessions may include information that is no longer true, in either the presentation or the Q&A. Please double check against the relevant documentation pages.

# Building cancer cohorts, May 2025

Building a cohort is a vital first step in many kinds of genomics studies, such as GWAS, survival analysis and identifying cancer characteristics. The vast array of phenotypic data available in the Genomics England Research Environment, both recruited disease and electronic health records, is a great resource for cohort building and verification.

This training session will go over some of the ways you can build cohorts in the Genomics England Research Environment: Participant Explorer for no-code creation and the Labkey API for programmatic construction and verification. Using both methods, we will show how you can pull out the genomic file locations, or the participant identifiers to use with variant aggregation files.

You are only allowed to attend this session if you are eligible for data access. This means that you are a Research Network member that has met the necessary verification checks and passed our Information Governance training course. If you do not meet this criterion by 11th March 2024, you will be unregistered for this session.

## Timetable

13.30 Introduction and admin  
13.35 Parameters and considerations for building a cohort  
13.45 no code cohort building with participant explorer  
13.55 Labkey tables for cohort building in cancer  
14.05 Using the Labkey API in Python and R
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

`/gel_data_resources/example_scripts/workshop_scripts/cancer_cohort_2025`

### Slides

[Download the slides](../cancer_may_25.pdf)

### Video

[Give us feedback on this tutorial](https://surveys.genomicsengland.co.uk/s/B31PSZ/)

### Code

You can find the Jupyter notebook used inside the RE in:
`/gel_data_resources/example_scripts/workshop_scripts/cancer_cohorts_2025`

### Q&A

Q&A

are gms participantsincluded in 100k/vice versa

live answered

---

where can we find digital pathology slides and histopathology reports in these tables?

For pathology reports thereâs a âpathology\_reportsâ table that contains the paths of the reports in the file system

---

Can you paste the file path into the chat?

/gel\_data\_resources/example\_scripts/workshop\_scripts/cancer\_cohorts\_2025

---

Should JupyterLab already be available in my GEL Amazon WorkSpace?

Jupyter can be accessed from one of a number of conda environemnts. We would, however, recommend that you use the HPC for this type of work as the returned data can run the risk of maxing out the availabel VDI RAM.

For reference please review the information on this page: <https://re-docs.genomicsengland.co.uk/hpc_jupyter/>

---

hi i am running the r script whilst you are and have had this error: error in handleError(response, halt on error https request was unsuccessful status code = 500 with

cancer\_query <- labket\_to\_df(cancer\_type, version, 100000 and with the gms\_cancer\_query - is this a netrc issue?

Could you please raise a Service Desk ticket for this issue as it will be easier to support you in an individual manner.

You can mark the request for my attention.

Looking forward to hearing from you.

---

Is the recording going to be shared afterward? Unfortunately I lost the first part of the training session

Once the recording has been censored for Personally Identifyable Data it will be posted on the past trainings page:
<https://re-docs.genomicsengland.co.uk/upcoming/#past-training-sessions>

---

'@Matthieu. I wish there were a simpler way to use jupyter on the HPC. This is quite convoluted for us do every time we log on.

I can understand that the process is a little convoluted, it can be simplified by the use of BASH functions to automate certain parts of the process, however, it is necessary to launch your server on the HPC and âtunnelâ into it from the VDI. There is no way around this.

An example of this can be that you have one function that will activate the Conda Env and launch the Jupyter server on a selected port wihtin the HPCâs inter queue; and a second function that facilitates the connection to the server.

Here are a couple of examples that I use that you may find helpful.

Launch inter session:
function intersech(){
# Launch interactive cluster session
bsub -P $1 -Is -M $2 -q inter bash
}
$1 = your project code
$2 = memory requirement

Activate the conda env:
function conda2021(){
# short cut to the 2021\_base\_clone enviroment
source /resources/conda/miniconda3/bin/activate
conda activate 2021\_base\_clone
}

function jpt(){
# Launch a headless jupyter notebook session. Requires some port forwarding on the client side
jupyter-lab --no-browser --ip="\*" --port=$1
}

---

are there bigwig files?

Yes, there should be in the by\_date paths

I will add, however, that they may not be available for the older workflow runs. In any case, they should all have at least one with some bigwig files

---

Hi, thanks for the session. I have been trying to identify cancer subtypes (for haematological malignancies in particular) in the 100kGP, so far using ICDO codes in the cancer\_analysis table. Is this the correct way of doing so? Should I also be cross-checking with the hes tables or is it the same as checking the match\_rank value?

I cannot find ICD10 codes in cancer\_analysis in 100kGP or GMS, what columns are you using?

My bad, just saw the morphology and Topography ICS columns

I do not have an answer for this right now but what I can say is that the study abbreviation column is based on the ICD10 codes in hes\_apc

---

I have been using histology\_coded, which I saw in the documentation should be ICD-O-3 morphology codes (oncology version of ICD10 from what i understand?)

live answered

---

Are there information on other types of therapies other than chemotherapy? (like transplants for leukemia patients?)

live answered

October 7, 2025
