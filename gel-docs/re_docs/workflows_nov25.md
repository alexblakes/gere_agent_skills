---
title: 'What tools and workflows should I use to fulfil an overall goal?, November 2025 - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/workflows_nov25/
scraped_at: 2026-05-04T06:34:19Z
---

> **Archive training session:**
>
> Past training sessions may include information that is no longer true, in either the presentation or the Q&A. Please double check against the relevant documentation pages.

# What tools and workflows should I use to fulfil an overall goal?, November 2025

It can be hard to get started with a research project in the RE, with an abundance of data and tools available. In this training session we will look at some of the major use-cases in research and the steps involved in carrying these out, both at a large and small scale. Instead of going into deep detail on these paths, we will point you to tutorials and documentation to get you going with the different steps of the process.

The use cases weâll be looking at are:

- I'm interested in a phenotype and I want to know what variants are related
- I'm interested in a gene and I want to know what phenotypes are related
- I want to find a diagnosis for patients who didn't get one through primary clinical interpretation

For many of these use-cases, we will point you towards resources to carry out these projects at a large scale, using programmatic and command-line resources, and at a small scale using point-and-click tools. Bear in mind that is not always feasible to do this kind of research at both scales.

## Timetable

13.30 Introduction and admin  
13.35 Identifying variants associated with a phenotype  
13.50 Identifying phenotypes associated with a gene   
14.20 Finding diagnoses for patients who didnât get one through primary clinical interpretation  
14.35 Getting help and questions

## Learning objectives

After this training you will know:

- The main steps involved in common use-cases in the RE
- How to access training materials and navigate the documentation

## Target audience

This training is aimed at researchers:

- working with the Genomics England Research Environment
- who are looking for a start point for their research project goals
- Either programmers or non-programmers

## Date

11th November 2025

## Materials

You can access the redacted slides and video below. All sensitive data has been censored. You can access and copy code from the Jupyter and R notebooks used in the training at:

`/gel_data_resources/example_scripts/workshop_scripts/workflows_2025`

### Slides

[Download the slides](../workflows_2025.pdf)

### Video

[Give us feedback on this tutorial](https://surveys.genomicsengland.co.uk/s/3ZZGKI/)

### Q&A

Q&A

Hi, I just wanted to confirm: in participant explorer, when searching for HPO terms, results will be individuals where that HPO term is present, not just assessed, correct?

live answered

---

Does the AVT workflow work by interrogating single VCFs or AggV2?

hello! it interrogates AGGv2!

---

Are there participants with confirmed disease-causing CNVs within the 100K GenomeProject or NHS data (germline) ?

If yes, where can we find them on Labkey / with Labkey API ?

hi! in the 100kGP, there is a table entitled âsubmitted\_diagnostic\_discoveryâ, which contains disease-causing CNVs (along with other variants). This contains variants (including CNVs) that have been uncovered by researchers and are being sent to clinicians, for them to confirm results.

this will be available for NHS-GMS at a later point

please see this page for futher information: https://re-docs.genomicsengland.co.uk/exit\_questionnaire/

---

I may have missed it, but if Im interested in looking at response to targeted treatment for the cancer cohort, would it be best to look through lab key or Participant explorer?

We donât have a clear - cut treatment outcome field /table in the research environment. The easy way is evaluating overall survival.

The difficult way is combining the SACT tables, aggregating the individual treatments towards lines of therapy and evaluating whether a line of therapy changed before the expected end, a second diagnosis or progression death occured within a set-timeframe (usually 6 months post first treatment).

Tables to combine evaluate:
SACT -> individual drug administrations
av\_treatment -> more global mentions of treatment but also events such as radiotherapy
HES tables -> occurance of mets or recurrence through ICD10 codes.

---

What are the eligibility criteria for including a participant in a benchmarking dataset ? I saw a "is\_consenting" field within tables. Is there anything more to check ?

live answered

November 12, 2025
