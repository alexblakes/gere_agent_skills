---
title: 'Using the GEL Research Environment for clinical genetic diagnosis, February 2023 - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/clinical_feb23/
scraped_at: 2026-05-04T06:31:47Z
---

> **Archive training session:**
>
> Past training sessions may include information that is no longer true, in either the presentation or the Q&A. Please double check against the relevant documentation pages.

# Using the GEL Research Environment for clinical genetic diagnosis, February 2023

## Description

The rich phenotypic and medical history data, coupled with whole genome sequences available in the GEL Research Environment provides a unique opportunity for diagnostic discovery. In this training session we will take you through the data available in the GEL RE, including results of our own bioinformatic diagnostic analysis, and how you can access these, as well as tools available to filter the data, carry out your own analyses and validate your results. As part of the training, we will show you how to submit your genetic diagnoses to the clinical Genomic Medicine Service or contact clinicians, leading to direct clinical application of your work.

This training is aimed at clinical geneticists and does not require any coding skills. You will have chance to ask questions of our clinical team who assess submitted diagnoses, and see what happens to your submissions.

You are only allowed to attend this session if you are eligible for data access. This means that you are a Research Network member that has met the necessary verification checks and passed our Information Governance training course. If you do not meet this criteria by 20th February 2023, you will be unregistered for this session.

## Timetable

14.00 Welcome and introduction  
14.05 GEL ingestion of rare disease participants  
14.15 Identifying participants who need a diagnosis  
14.25 Finding results of GEL analysis  
14.35 Exploring variants in IVA  
14.45 Validate your diagnosis  
14.55 Find and compare other participants with the same variant  
15.05 Submit your diagnosis and/or contact clinicians  
15.15 Questions

## Learning objectives

After this training you will know:

- How GEL analyses new rare disease genomes and where to find the results of these analyses
- How to filter, analyse and validate variants in a participant of interest
- How to submit diagnoses to the GMS

## Target audience

This training is aimed at researchers:

- working with the Genomics England Research Environment
- working in a clinical setting
- looking for genetic diagnosis for rare disease

## Date

21st February 2023

## Materials

You can access the redacted slides and video below. All sensitive data has been censored.

### Slides

### Video

[Give us feedback on this tutorial](https://www.smartsurvey.co.uk/s/18NAW8/)

Q&A

Is it possible to enable live transcript please, if it is not already.

I donât think this is avaialble Iâm afraid - although the session is being recorded.

Thank you. I looked at past recordings and can see those seem to have close captions generated. So I will use the recording for this training session with the subtitles when it becomes available.

---

is tiering following ACMG criteria ?

Tiering is not intended to follow ACMG criteria. Tiering is designed to help prioritise variants for review according to ACMG/ACGS criteria, based on biological and clinical criteria, e.g. allele frequency, consequence type and gene-phenotype association.

---

Does GEL have Phecode mapping from the icd10 codes?

Not directly - but it is relatively straight forward to do. Firstly mine all participants ICD-10 diagnoses via electronic health records - and then use mappings from https://phewascatalog.org/phecodes\_icd10 - implemented in the PhewasR package https://github.com/PheWAS/PheWAS. Weâre developing a PheWAS pipeline in house currently.

---

With 100kGP as a clinician researcher we could research our own patients. But as I understand it, we can't research individuals with the NHS GMS data. How can a clinician researcher reserach their own patients?

Hi - I think weâll have to get back to you on this question as we want to make sure we give the correct answer in in this very important case.

Currently, WGS data for only a small number of GMS patients have been released in the research environment. Re-identification of research participants in the research environment is not permitted. We are working on pathways to enable research analysis of specific patients such that it can be performed safely following ethics and information governance guidelines.

Thanks. Could I be notified when this pathway has been established. I believe Prof Andrew Wilkie was having a meeting with Prof Matt Brown regarding this.

Yes, we will be communicating when we have agreed pathways in place.

---

Regarding tiering, the filtering includes variants in green genes as determined by panel app. Are these green genes for any green genes in any panel, or are they only for panels relevant to the probands phenotype eg HPO terms?

Hi Chris - these are for green genes in the specifc panels applied to the family - and these panels applied to the family are phenotye specific. You can check out the PanelApp here https://panelapp.genomicsengland.co.uk/ - and search by gene or phenotype

Tier 3 includes variants in genes that were not included in the panels applied for analysis.

---

What are the differences between the "rare\_disease\_analysis" & "rare\_disease\_interpreted" tables?

Hi - thereâs some overlapping information across both tables - but the 'interpreted' table contains the specific information used at Genomics England in the Rare Disease Interpretation Pipeline. So you can see the affection status, phenotypic terms, and the exact paths to their genomic information that was used for tiering and exomier.

---

Are there any variants present in the tiering table but not exomiser?

Yes indeed - they are two different variant prioritisation algorithms. Tiering is âqualitiativeâ based on a set of criteria - and if a variant does not meet these criteria then it is not tiered. Exomiser is âquantitativeâ and scores variants based on their likely association to the disease.

---

When looking for potentially pathogenic variants, should I just be looking in the tiering and exomiser tables or are there other tables with potentially pathogenic variants?

Good question. Tiering + Exomier + GMC Exit questionnare are the three key data resources yes. But of course you have the full genomic data so can make your own assessment about variant links to disease.

---

can we please get a copy of the code please as a reference ?

live answered

---

Do these participant paths contain both variant-only VCFs & GVCFs?

Yes VCFs and gVCFs for all participants - can see those here https://re-docs.genomicsengland.co.uk/genomic\_data/. Weâve also aggregated almost all germline genomes into a single VCF called aggV2: https://re-docs.genomicsengland.co.uk/aggv2/

---

This question is a bit off topic, but if eventually exporting the result of an analysis (exporting participant details completely off the RE), can Participant Explorer data be exported among with LabKey variant data ? E.g. phenotype details, health history, records etc. viewed now.

Hi - individiaul level results are not allowed to be exported from the environment. This means any data that might enable the reidentification of a participant outside of the research environemnt. This includes row-level data such as: participant 1234 is 34 years old and is diagnosed with disease X and has genotype Y. This would not be allowed to be exported. You can export summary level / aggregated data as shown here https://re-docs.genomicsengland.co.uk/airlock\_rules/

---

One stupid question about the panel version; If I realise the panels\_applied table has a different version than what I find on PanelApp for the phenotype/disease, it means the version at the moment the participant data was added in GEL is mapped according to the old version â and some participant/variant data might outdated ? How should I take this into consideration in my analysis?

Great question. Yes over time, a panel changes version where genes are added/removed, change status from red/amber/green. This is normal as information changes substatianlly over time. You can find the exact version of the panel used for a specific family in the panels\_applied table. You can then use the panelapp website/api to find the genes and their status for that specifc version and compare with the other families on other versions https://panelapp.genomicsengland.co.uk/.

Variants in genes that were not included on the version of the panel applied in the analysis are likely to be found in tier 3 if they pass segregation filters applied in tiering. These variants may also be prioritised by Exomsier.

Perfect. Thank you both, Chris and Suzi!

I will have to try it once myself I think; follow what Emily didâ¦ I got the PanelApp part, but there were quite a few clicks and filters used for that task on IVA. Luckily this training is recorded! :)"
Itâs probably a good idea to start with reviewing tier 3 and exomiser variants before extending to IVA.

---

So for tiering and exomiser, I can search my favourite gene and itll pick up all tier 1, 2 and 3 variants, or equivalent for exomiser, that have occured in probands and sequenced family members?

Hi Kimberly - yes thatâs right.

Music to my ears! I've been using gene variant workflow and its gives me too much to go through! Thank you!

---

Is it common that pathogenic variants are not found in exomiser or tiering

For many participants, new diagnoses can be identified using variants found in tier 3 or prioritised by exomiser. There are also lots of reason that variants my not be prioritised by tiering, e.g. non-coding variants, structural variants, variants that not pass the expected segregation filters etc.

---

tiering and exomiser is quite slow at loading, is that normal? any way around it?

They are quite large tables (>10M rows) so it can take some time to render on the broswer. For any querying of such large data, I would recommend using the LabKey API in R or Python to programmatically interface to the data https://re-docs.genomicsengland.co.uk/labkey\_api/. Other than that - Iâm afraid youâll have to wait for it to load!

---

We can see what panels have been applied to patients using 'panels\_analysed' column. Is there a way of seeing which variants have previously been analysed and what the ACMG classification, or any other information, was? This could save duplicating effort on potential variants which have previously been identified & analysed by GMC/other researchers.

Hi Chris - if I understand your question correctly - you should use the gmc\_exit\_questionnaire and the submitted\_diagnostic\_discovery table as described here https://re-docs.genomicsengland.co.uk/exit\_questionnaire/

Yes that's it, thanks

Previous classifications for vairants can be found in the gmc\_exit\_questionnaire but this may not include classificioants for all tier 1/tier 2 variants, even if they have been looked at. The submitted\_diagnostic\_discovery table contains research findings which have not formally been reviewed by NHS clinical scienists yet (unless also found in the exit questionnaire).

After they have been submitted into submitted\_diagnostic\_discovery and reviewed, are they then removed? (ie is it just diagnoses pending review in that table?)

Currently, variants are not removed from the table after review. We welcome feedback if you would like this to change in future.

---

Could you talk about how to open and use the vcf files? Thank you!

Hi Catherine - do you mean looking / analysing them on the command line? If so - we recommend using bcftools https://samtools.github.io/bcftools/bcftools.html which is installed in the research environemnt. You can view, slice, extract, and transform VCF files easily.

Is the only way to use them via the command line? Out of the research environment I've looked at them in excel etc. Although these might have been smaller vcfs. Sorry if this is a silly question

I am also interested in this. Havent come across bcftools and havent been able to look at them in excel either. But I would like to do both of these

---

I don't seem to have access to labkey or IVA. Do I need to separately register?

Hi Suzanne - could you contact the Genomics England Sevice Desk please https://re-docs.genomicsengland.co.uk/help/ they will be able to help you with access. Apologies about this.

---

does the variant browser cover samples outside aggv2?

Hi Ana - it does indeed such as older genomes aligned to GRCh37 - and also somatic calls from the cancer cohort. Almost all GRCh38 germline samples will be shared by the variant browser and aggV2.

---

what do you recommand our steps if we want to pull out the clinical features of all the people with certain genotype?

Hey - so yes so firstly you can identify participants with genotype of interest. You can do this in multiple ways, using: aggv2 (https://re-docs.genomicsengland.co.uk/aggv2/), or using the prioritised variants from tiering/exomiser. From this, you can get their participantâs IDs and use this to map back to phenotypic data in LabKey - such as the rare\_disease\_phenotype table.

---

How can I receive a projectID? Does one need to send a proposal which will be reviewed? If yes, how long would that take? Thank you.

live answered

---

Hi, just a quick ask do we already have the lists of HPO and ICD-10 codes (maybe in excel or txt format) in the research environment?
Thank you :)

`gel_data_resources/licensed_resources/ICD10`

---

May I have one more question, Iâm quite interest in the hes (hospital episode statistics) and I noticed there are hundreads of columns in ecds, hes\_cc and etc.
May I know where do I find a detailed explantion of these columns please?

At the top of this page https://re-docs.genomicsengland.co.uk/current\_release/ you can see the data dictionary (as Emily is talking about now). Hope this helps. It will show you all tables and column descriptions.

---

Just bringing the vcf question up the list please

live answered

---

how do we use bcftools?

https://samtools.github.io/bcftools/bcftools.html
https://re-docs.genomicsengland.co.uk/hpc\_using\_software/

---

To use VEP command line to annotate gnomAD genome AF, we need to download the variation\_genotype VCF file from the Ensembl FTP site, but the file is quite large. Is it possible to put these onto the public resources folder?

https://re-docs.genomicsengland.co.uk/vep/

October 7, 2025
