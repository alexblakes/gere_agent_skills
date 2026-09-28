---
title: 'Using the Research Environment for clinical diagnostic discovery, January 2026 - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/clin_jan26/
scraped_at: 2026-05-04T06:31:47Z
---

> **Archive training session:**
>
> Past training sessions may include information that is no longer true, in either the presentation or the Q&A. Please double check against the relevant documentation pages.

# Using the Research Environment for clinical diagnostic discovery, January 2026

The rich phenotypic and medical history data, coupled with whole genome sequences available in the GEL Research Environment provides a unique opportunity for diagnostic discovery. In this training session we will take you through the data available in the GEL RE, including results of our own bioinformatic diagnostic analysis, and how you can access these, as well as tools available to filter the data, carry out your own analyses and validate your results. As part of the training, we will show you how to submit your genetic diagnoses to the clinical Genomic Medicine Service or contact clinicians, leading to direct clinical application of your work.

This training is aimed at clinical geneticists and does not require any coding skills. You will have chance to ask questions of our clinical team, who assess submitted diagnoses, and see what happens to your submissions.

## Timetable

13.30 Welcome and introduction  
13.35 GEL ingestion of rare disease participants  
13.45 Identifying participants who need a diagnosis  
13.55 Finding output of GEL analysis  
14.05 Exploring variants in IVA  
14.15 QC your diagnosis  
14.25 Find and compare other participants with the same variant  
14.35 Submit your diagnosis and/or contact clinicians  
14.45 Getting help and questions

## Learning objectives

After this training you will know:

- How GEL analyses new rare disease genomes and where to find the results of these analyses
- How to filter, analyse and validate variants in a participant of interest
- How to submit diagnoses to the GMS

## Target audience

This training is aimed at researchers:

- Are working in the Genomics England TRE
- Are clinical geneticists trying to do diagnostic discovery
- Do not necessarily have any coding skills

## Date

13th January 2026

## Materials

You can access the redacted slides and video below. All sensitive data has been censored.

### Slides

[View the sides](../clinical_jan_26.pdf)

### Video

[Give us feedback on this tutorial](https://surveys.genomicsengland.co.uk/s/TQBETY/)

### Q&A

Q&A

Since IVA is not available for the NHS-GMS data, are you able to see pedigree of families in the NHS-GMS cohort? If so, how?

pedegree information will be discernable from within LabKey, the specific methods and tables that you would need to query can be looked at within a support ticket.

---

What does Unknown for diagnosis mean? Does it mean a potential diagnosis is being worked on?

The participant would remain undiagnosed, if a diagnosis is found, either internally or via a researcher partnership, the table would be updated.

---

In participant explorer if a participant has a birth year of 2019 and is listed as being in the 100K, would it be correct to assume that that is the upper cap that the birth year of a participant could be for the 100k?

Participant Explorer takes its information from the same source as LabKey, I do not have the information on the Date of Birth ranges from recruited participants to hand but this information may not be 100% accurate

Thank you. A somewhat related question, are participants "duplicated" from the 100k to the GMS. So for example if a participant took part in the the 100K, and later on are analysed by the GMS. Would they have two entries within the environment? And would they have two sets of ID's?

It is possible, however, due to the nature of the anonymisation that we are required to perform there are no concordance tables between the two projects that I am aware of.

Thank you. If 100kGP + NHS-GMS are pooled together there is a risk of double analysing the same individual/family if they appear in both datasets. We may not immediately know if the two records across 100kGP and NHS-GMS are, or are not, the same person/family. How would you suggest to detect/remove that potential overlap?

the risk would be at the individual level, as there is no guarantee that the whole family would have been recruited for the GMS project. I would be looking at secondary data that may match between the two projects closely prior to proceeding with the analysis.

On a personal level, as the pipelines used in the GMS project are more up to date I would retain the GMS data over the 100K data should a concordance suggest a ducplication.

---

In participant explorer, can you filter by medical history within a phenotype when collecting data?

I am not sure I fully understand the question, are you requesting to understand if the phenotype at recruitement is available? If so I would recommend using LabKey and cross referncing the recruitment date the HES data to find the ICD or HPO terms that were recorded at the time.

when exporting data, after filtering by a phenotype, can you then filter further by medical history or does this have to be performed manually on participant explorer?

Once data is exported from a tool you would need to use this filter as the basis of a new search, it wonât be possible to âre-importâ the data into the tool to continue filtering.

There will of course be the possiblity to use additional tools to perform the filtering of the exported data, most of these however will not be graphical in nature and will require the use of some command line funcitons

---

Is there any tool or software to draw the pedigree?

have not come across one specifically, however there are many R and Python packages that are already present, and we have the ability to help you access these types of tools within the Research Environment.

---

Do we have software to analyse a trio? (for example recessive conditions)

Genomics England has performed a large amount of pre-processing of data, including functional annotation of variants, these are accessible both within tools such as IVA and within specialised VCF files. I am thinking mostly about the Aggregation data. These can be analysed using tools such as BCFtools, BiomaRt (within R) or python-based tools.

---

What column provides genetic ancestry information of the participant?

Given that the participant explorer data is the same as the LabKey data I will be using LabKey as the basis of this answer.

The participant table will have ethnicity codes and an ethnicity description recoded

Could you tell me please the column name of ethnicity codes and an ethnicity description recoded. I found only scores, PCs and self-reported ancestry using dictionary and LAbKey

I would recommend raising a service desk ticket for this question as this will provide us with the ability to provide more accurate replies.

---

Did I understand correctly: for 100k project we have whole genome sequencing data (build 37 and/or 38) and for NHS we have files which include only panels/specific genes?

This is incorrect, all participants have Whole Genome Sequencing (WGS) data, GRCh37 & GRCh38 for the 100K, solely GRCh38 for GMS.

The panels are virtual pannels that are used to analyse the WGS data

---

Will the NHS GMS cases be uploaded onto IVA at some point? If not, is there any other GUI way to interrogate their unfiltered VCF files?

The list of tools that are present in the Research Enviroment is under constant review. We balance both the functionality that is offered with the support requirements for each tool.

I am not aware of plans to include GMS data within IVA, then again I am not aware of plans *not* to include this data. I would recommend raising a service desk ticket as this will give us more time to review the question and provide you with a more detailed answser.

January 14, 2026
