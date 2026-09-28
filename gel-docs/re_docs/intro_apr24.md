---
title: 'Introduction to the Research Environment, April 2024 - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/intro_apr24/
scraped_at: 2026-05-04T06:32:44Z
---

> **Archive training session:**
>
> Past training sessions may include information that is no longer true, in either the presentation or the Q&A. Please double check against the relevant documentation pages.

# Introduction to the Research Environment, April 2024

The Genomics England Research Environment provides access to Genomics England data, including genomes, variants and phenotypic data from rare disease and cancer patients from the 100,000 Genomes project and NHS Genomic Medicine Service. Due to the sensitive nature of the data, all analyses on these data must be carried out within the Research Environment and only non-identifiable aggregate data can be exported. To enable this, a variety of tools are available within the Research Environment to segment and analyse the data.

This training session is aimed at newcomers to the Genomics England Research Environment and will introduce what is in the Research Environment, both in terms of data and tools. The basic functionality of the tools will be covered, along with how you can export data and the restrictions on doing this.

## Timetable

13.30 Welcome and introduction  
13.35 Sources and type of data in the Research Environment  
13.50 Tools in the Research Environment  
14.10 Programmatic access to Genomics England data  
14.20 Running command line tools and pipelines using our HPC cluster  
14.30 The Airlock, restricted import and export of data  
14.45 Getting help and questions

## Learning objectives

After this training you will know:

- what data can be accessed in the Genomics England Research Environment
- the functions of the Participant Explorer, LabKey, IVA and IGV
- what APIs are available for exploring the data
- the kinds of jobs you can run on the HPC cluster and when you might use it
- how to import and export data from the Genomics England Research Environment using Airlock
- how to use the documentation to learn more

## Target audience

This training is aimed at researchers:

- new to the Genomics England Research Environment

## Date

9th April 2024

## Materials

You can access the redacted slides and video below. All sensitive data has been censored.

### Slides

### Video

[Give us feedback on this tutorial](https://www.smartsurvey.co.uk/s/OF2X7N/)

Q&A

Excited to be here! Iâm sure my question will be addressed as we proceed. Iâm interested in ONT Data and as part of my analysis pipeline I need to use EPI2ME. Iâm not sure I could see EPI2ME on RE. How do i access the ONT once i have identified participants on Labkey?

Hi Peter, at the momento we have only release ONT data for some ~100 cancer participants. You can find them in the âcancer\_ont\_cohortsâ LabKey table

Hi Peter, at the momento we have only release ONT data for some ~100 cancer participants. You can find them in the âcancer\_ont\_cohortsâ LabKey table

We are expecting to increase the number of participants that we have ONT data for in future releases

As per EPI2ME, Iâm not sure if itâs available but if not, you can request it by opening a service desk ticked and the team will look into it

Hereâs the service desk website if you need it: https://jiraservicedesk.extge.co.uk/plugins/servlet/desk

---

For the pediatric tumors- is there more detailed data?

Hi Stefan, what type of data do you have in mind? I donât think we have pediatric tumour-specific tables but we may have what you need in some generic table.

---

Is secondary data available for all rare disease patients? Or only a subset?

live answered

---

How do we map the ICD-10 codes in the LabKey table to actual medical terms? is there a script in the RE?

I donât think there is an script for that, unfortunately. There are some tables that have the mapping done already, e.g. cancer analysis table and there are some tutorials in the documentation that explain how ICD codes can be used:

- https://re-docs.genomicsengland.co.uk/cancer\_analysis\_histology/#map-the-icd10-codes-and-icdo3-codes-from-av\_tumour-to-tcga-codes
- https://re-docs.genomicsengland.co.uk/rd\_cohorts/#icd10-codes"

Again, if this is very important to you and you cannot find what you need just open a ticket with service desk via https://jiraservicedesk.extge.co.uk/plugins/servlet/desk and someone from the team will look into it

---

Are the tools 'nf-core/rnafusion' and 'Arriba' included in the nf-core RNA sequencing pipelines?

Sorry, what RNA sequecing pipelines are you talking about? Or RNA data has been processed using the DRAGEN RNA pipeline.

More info here: https://re-docs.genomicsengland.co.uk/rna\_seq/

---

Are copy number variations (microdeletions etc) also found in IVA please?

Yes, you can filter variants in IVA by type. Note however, that if you are interested in CNVs, the VCFs loaded to IVA were called using standard variant caller. We also have CNV VCFs called with tools such as Canvas but I donât think those were loaded to IVA

---

Asier, I saw that when you showed number of participants per tumor type some were simply labeled pediatric cancer. Is there a way to understand the actual cancer type for these?

Sorry, Iâm not an expert in cancer or clinical data but I imagine that those numbers were base on filtering on one column. My suggestion would be to find those samples/participants and explore the data available for them in the different tables

---

Can I ask about the cloudOS?

Once you have access are you suppsoe to downlaod the data to the local workspace?

live answered

---

How does HPC resource get charged?

live answered

October 7, 2025
