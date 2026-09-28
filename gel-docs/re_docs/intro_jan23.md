---
title: 'Introduction to the Research Environment, January 2023 - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/intro_jan23/
scraped_at: 2026-05-04T06:32:45Z
---

> **Archive training session:**
>
> Past training sessions may include information that is no longer true, in either the presentation or the Q&A. Please double check against the relevant documentation pages.

# Introduction to the Research Environment, January 2023

The Genomics England Research Environment provides access to Genomics England data, including genomes, variants and phenotypic data from rare disease and cancer patients from the 100,000 Genomes project and NHS Genomic Medicine Service. Due to the sensitive nature of the data, all analyses on these data must be carried out within the Research Environment and only non-identifiable aggregate data can be exported. To enable this, a variety of tools are available within the Research Environment to segment and analyse the data.

You are only allowed to attend this session if you are eligible for data access. This means that you are a Research Network member that has met the necessary verification checks and passed our Information Governance training course. If you do not meet this criterion by 16th January 2023, you will be unregistered for this session.

This training session is aimed at newcomers to the Genomics England Research Environment and will introduce what is in the Research Environment, both in terms of data and tools. The basic functionality of the tools will be covered, along with how you can export data and the restrictions on doing this.

## Timetable

14.00 Welcome and introduction  
14.05 Sources and type of data in the Research Environment  
14.20 Tools in the Research Environment  
14.40 Programmatic access to Genomics England data  
14.50 Running command line tools and pipelines using our HPC cluster  
15.00 The Airlock, restricted import and export of data  
15.10 Getting help  
15.15 Questions

## Learning objectives

After this training you will know:  
 *what data can be accessed in the Genomics England Research Environment* the functions of the Participant Explorer, LabKey, IVA and IGV  
 *what APIs are available for exploring the data* the kinds of jobs you can run on the HPC cluster and when you might use it  
 *how to import and export data from the Genomics England Research Environment using Airlock* how to use the documentation to learn more

## Target audience

This training is aimed at researchers:

- new to the Genomics England Research Environment

## Date

17th January 2023

## Materials

You can access the redacted slides and video below. All sensitive data has been censored.

### Slides

### Video

[Give us feedback on this tutorial](https://www.smartsurvey.co.uk/s/MS3CSE/)

Q&A

How do we re-engage with our participants?

live answered

---

What happens if a participant loses capacity to consent?

live answered

---

The number of cancer participants mentioned on the graph, is to date? When the number keeps changing, are we updated about it? For example, I can see there are currently 692 prostate cancer patient, when more get added will we be notified?

I believe this question has been answered live, but to clarify, participants will only be added during a new Data Release. As the enrollment for the 100K project has ended, you'll find cohorts of participants with specific cancers or rare diseaes to expand within the NHS-GMS section of our dataset. The numbers for the 100K (main programme) will roughly remain the same.

---

Do you know the expected timeframe for gaining access to additional gms clinical data e.g. hospital episode statistics?

The data is being generated and processed by Genomics England, as the pipelines differ between the 100,000 Genomes and the NHS GMS we are still working through the release processes. There will be regular releases of NHS GMS data in a similar manner to that used for the 100,000 Genomes

---

Do the older versions still have people in them that have withdrawn? They're not removed from all versions?

A participant consents to be included in research that starts up to the point at which they withdraw. There will be some ongoing research projects that will have started during a previous release.

All new research needs to use the latest release.

This distinction will ensure that longterm projects can take place as well as respecting the consent status of participants"

---

How are the clinical concepts populated? I've come across some entries that mention a "referral" for a condition XYZ

Participant Explorer will draw most of its data from LabKey, the clinical concepts will therefore generally come from the Clinical Data passed onto Genomics England

---

Does participant explorer have the option to give it a list of participant IDs and get back all of their HPO terms (for example)?

live answered

---

When you download the data is that saved onto the Research Environment or downloaded locally onto your computer?

live answered

---

And is the data saved indefinitely or for a set amount of time?

This will depend on the place the data has been saved to. You will have a limited amount of space within the Research Environment virtual desktop, you will also have access to a filesystem that is mounted on both the Research Environment virtual desktop and the HPC, this filesystem will be backed up following these principles: https://re-docs.genomicsengland.co.uk/backup/

---

What happened if a variant is identified worldwide after we've picked it up? Does it get updated in the RE?

There are ongoing efforts to keep resources up to date, whether this is Gnomad, dbSNP, VEP data, etc â¦ we also look to provide up-to-date versions of the tools used.

---

Locally meaning when logged into research env.?

live answered

---

I have selected a group of variants from the tiering table using the LabKey API in Python. How can I programmatically look up annotations for these variants, such as rsIDs and ClinVar status?

Depending on the area that you are researching some of the information may be available from labkey, Iâm thinking about the analysis csv files mentioned in the cancer\_analysis table.

An API for IVA does exist but the documentation for this is a work in progress, if you are having difficulties please raise a support ticket and we will try to assist.

---

how to get the QR code to install the Okta Verify

if you are having issues accessing the Research Environment once you have passed the Information Governance training please contact the Service Desk who will guide you.

https://re-docs.genomicsengland.co.uk/help/"

---

Is there a support for Hail (for genomic data analysis)

At present we do not have support for Hail within the RE or the HPC, it may be possible to containerise the tool and use the process ddescribed here: https://re-docs.genomicsengland.co.uk/hpc\_containers/

to bring this in

---

Would it be possible to perform a burden (Fisherâs exact) test for comparing the burden of rare variants in cases and control? I know there is a run\_rvtest command that I can use via the IVA browser API but would you recommend using it for this?

we have an implementation of rv\_tests within the latest version of the Genomics England Aggregate Variant Testing workflow. This is an analysis that would be most appropriate to run on the HPC

---

How can I be added to my Professors agreed research project?

I believe that your Professor would be able to update their registered project to add you as a collaborator. The Service Desk will be able to route this type of query to the appropriate team, if in doubt please ensure that your Professor raises a ticket

---

Can you import scripts into the RE that you have developed externally?

live answered

---

the Airlock documentation say that the ârule of 5â does not apply to genotypic data, and specifically that variant counts in a gene are permissible for export. so, for example, could we export the datum that 3 patients had variants in a specific 200-base promoter, or a specific 7-base motif? also, the docs also say we cannot export sequence data: does this mean weâre not permitted to export specific variants in any way?

My understanding is that the Airlock will not permit the export of variant level data, or summary data that is based on the analysis of less than 6 individuals.

---

Question for the end, are we able to provide a video to future cohorts that would want to use the RE and don't necessarly have the expertise?

In such cases we generally reaching out to other researchers within a specific GeCIP as we highly encourage collaborations. Alternatively, these tutorials and training videos are available (with censored data) on our documentation page: https://re-docs.genomicsengland.co.uk/ under Tutorials. Hope this helps!

---

will our data saved on the local research environment still be accessible? or should I wait until this occurs to start my cohorting/analysis?

The file systems will not change, neither will HPC access, only the virtual desktop environment and some usability functions

---

How can I request access to the cloudRE?

CloudRE access requests would need to go via the Service Desk, though please be aware that the CloudRE currently lags behind the Research Environment in terms of the data that is availble.

---

Does GEL have any software or analytical pipeline that helps us to perform family based linkage analysis using WGS data? Is it possible to do this via the case portal of the IVA browser or any other tools?

We have a catalogue of tools that are available within the Research Environment and HPC on this page https://re-docs.genomicsengland.co.uk/hpc\_software/ or by searching for the releavant modules as Emily demonstrated. I can confirm that we have KING v2 which is one of the tools that was used in the generation of our own relatedness files,

---

just wanted to verify that registration date of a project (which starts the 3-month period before we can export through Airlock) is dated from the time we first enter the project into the system, rather than the date the project is approved.

or alternately, that the date given next to my project is the date when the three-month period started.

I believe itâs when it is approved, but if there is a deadline requiring an exception to this, please get in touch. If youâre hosting a Masters student or similar short-term project, we recommend registering your project before getting your student then just adding them to it.

---

Is there a tool that would allow us to identify genetically unrelated individuals in a specific disease domain (e.g. familial cerebral small vessel disease) and perform analyses on them?

We have produced general resources of this type but should you need to generate your own based on a cohort of your building, the tools we have used are present. Should you require a different set a software request can be raised via the Service Desk

October 7, 2025
