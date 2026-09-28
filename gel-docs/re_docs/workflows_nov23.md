---
title: 'What tools and workflows should I use to fulfil an overall goal?, November 2023 - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/workflows_nov23/
scraped_at: 2026-05-04T06:34:18Z
---

> **Archive training session:**
>
> Past training sessions may include information that is no longer true, in either the presentation or the Q&A. Please double check against the relevant documentation pages.

# What tools and workflows should I use to fulfil an overall goal?, November 2023

It can be hard to get started with a research project in the RE, with an abundance of data and tools available. In this training session we will look at some of the major use-cases in research and the steps involved in carrying these out, both at a large and small scale. Instead of going into deep detail on these paths, we will point you to tutorials and documentation to get you going with the different steps of the process.

The use cases weâll be looking at are:

- I'm interested in a phenotype and I want to know what variants are related
- I'm interested in a gene and I want to know what phenotypes are related
- I want to know more about pathogenicity of different variant types on a large scale
- I want to find a diagnosis for patients who didn't get one through primary clinical interpretation

For many of these use-cases, we will point you towards resources to carry out these projects at a large scale, using programmatic and command-line resources, and at a small scale using point-and-click tools. Bear in mind that is not always feasible to do this kind of research at both scales.

You are only allowed to attend this session if you are eligible for data access. This means that you are a Research Network member that has met the necessary verification checks and passed our Information Governance training course. If you do not meet this criterion by 13th November 2023, you will be unregistered for this session.

## Timetable

13.30 Introduction and admin  
13.35 Identifying variants associated with a phenotype  
13.50 Identifying phenotypes associated with a gene  
14.05 Studying pathogenicity of variant types at scale  
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

14th November 2023

## Materials

You can access the redacted slides and video below. All sensitive data has been censored.

### Slides

### Video

[Give us feedback on this tutorial](https://www.smartsurvey.co.uk/s/160FY4/)

### Q&A

Q&A

How does one access data under the Diverse Data initiative?

Hi Niran, thanks for the question! To my knowledge, we have not formally released any data under the Diverse Data initiative. You may however be interested in: https://re-docs.genomicsengland.co.uk/gen\_sim/

---

Are the Rare Diseases still on the GRCh37 genome build or has this now changed to GRCh38?

live answered

So if you use the small variant workflow, will this only return variants from participants under hg38? Thanks! Amy

Will add that this actually a current ongoing process where we are realigning genomes with DRAGEN. However, we indeed do not have a timeline on its completion and when we will release that data. Re-interpretation of these cases is not on the planning however.

small variant workflow will generate results for both GRCh37 and GRCh38, Amy. Essentially, it will query every genome available. Hope this helps!
Amazing! Thank you :)

---

Very basic question but trying patient explorer today, my login does not work for the programme. Is their a specific module to do? I have used labkey for cohort building.

As Emily mentioned, this is one for the service desk. You can raise a ticket through the portal here: https://jiraservicedesk.extge.co.uk/plugins/servlet/desk

---

How can I move the gene list into the GEL small variant workflow? Is there any other possibility apart from Airlock?

live answered

---

paste from outside? or from inside? The website with the gene list is blocked from inside

Sometimes right clicking and copying can also work (within RE to elsewhere within the RE). Bit iffy admittedly.

---

How would I go from a cohort to get a list of file paths for BAM files (Normal)?

live answered

---

When dealing with a substantial number of cases exhibiting a specific genotype, the data accessibility might be confined to only 500 probands. How does the selection process operate among the thousands available?

Are these 500 probands the initial recruits, or is there a specific criterion guiding their selection, or is it purely a random selection?

Using IVA2

Hi Atieh, thank you for clarifying this is regarding to IVA. IVA can indeed be somewhat restricting in how much you can download into the RE, but was under the impression it is 1,000. I would perhaps want to recommend raising a ticket here: https://jiraservicedesk.extge.co.uk/plugins/servlet/desk so we can clarify the issue further.

To my knowledge this is not necessarily the first 500 recruited probands however. I would have to ask the team what the order/ranking is based on.

---

How did you get the R notebook that you current use on the right handside? Could you send me a link?

I believe you will be send this information after the training session has concluded, but the notebooks Emily is showing are located here: `/gel_data_resources/example_scripts/workshop_scripts/workflows_20231114`

---

Any timelines for the DDI?

No problem - unfortunately I canât provide any timelines at the moment. If you have a specific question or request regarding the Data Diversity initiative then I would recommend you get in touch via the Service Desk so we can investigate for you

---

And how can I filter MAFs below 1% from the GEL Small variant workflow?

Hi Mairena. I think the answer depends on the allele frequencies you are interested inâ¦

I believe the output of the small variant workflow includes variants annotated with VEP, and these annotations include AFs from gnomAD which you could filter on directly.

If instead you would like AFs calculated from GEL participants, you should be able to obtain these by looking up your variants of interest against our AggV2 dataset: https://re-docs.genomicsengland.co.uk/aggv2\_allele/

---

How do you check BAM files ?

Hello, would you mind expanding on your question? Sorry I may have missed the context of your question while I was answering another

---

Is it possible to do the small variant workflow for hundreds of genes or would you need to do it in 10 gene lots? Thanks!

The latter indeed. We have rate limited so it remains efficient on our system as we would not recommend the workflow for 100's or 1,000's of genes.

If you aim to screen many genes, we actually recommend to use our aggregate AggV2, along with the pre-annotated data. This does limit the work only to participants with a genome aligned to GRCh38.
See: https://re-docs.genomicsengland.co.uk/aggv2/
Codebook: https://re-docs.genomicsengland.co.uk/aggv2\_code\_book/
Tutorial: https://re-docs.genomicsengland.co.uk/aggregate\_genotypes/"

---

Is GMC exit questionnaire data updated if a diagnosis is later found? And how often is submitted diagnostic discovery updated/is it automatically updated?

live answered

And how often is submitted diagnostic discovery updated/is it automatically updated?

Just to add on this. We generally update both these tables in full upon a new Data Release. However, the process from getting a variant detected through the diagnostic discovery pathway back into the GMC exit questionnaire is still not available. So we always recommend to check the diagnostic discovery table!

---

Hello, is there an aggregated version of PanelApp, where for each gene there is an associated syndrome, so it can be used for intersection/enrichment analysis in R/Python. Thanks!

I donât think we have this kind of resource, but thereâs a possibility we might be able to create a âlook-upâ table of some sort. Would you mind raising a ticket with the service desk for your request?
Hello, is there an aggregated version of PanelApp, where for each gene there is an associated syndrome, so it can be used for intersection/enrichment analysis in R/Python.

---

Are the 'solved' cases based on the panals and tiering analysis?

live answered

can you then re-run exomiser for a participant with updated hpo terms? and also apply another panel to what has already been done? but not using tiering data but rather raw data? thanks

Yes, adding onto Emily's comment/demo, we have a few versions of exomiser installed on our HPC. I cannot guarantee how well they work though - we have had a few system changes since we installed them. So if you have a containerised version of exomiser, you should be able to re-run it.

---

can i just clarify if when applying new gene panels, it is using raw (non analysed) data and not tiering data?

We provide the joint-called data, but you could technically recall these too, but that will become very computationally heavy if you want to do this for many cases.

We have single sample BAMs/CRAMs, VCFs, and gVCFs, as well as the joint-called VCFs available. All available for use.

Hope this clarifies things! :)

If you are doing this work through IVA, it will always use the joint-called VCF that was used for the downstream interpretation/tiering processes, by the way.
can i just clarify if when applying new gene panels, it is using raw (non analysed) data and not tiering data? sorry i meant in the app that eily was showing earlier, when you apply a different panel

---

If I use the AggV2 See: https://re-docs.genomicsengland.co.uk/aggv2/ how can I set the MAF to 1% across all ancestries?

As Emily is suggesting, this is something you can do using bcftools. For the AggV2 data there are allele frequencies in the INFO field which can be queried using the bcftools documentation: https://samtools.github.io/bcftools/bcftools.html

January 29, 2026
