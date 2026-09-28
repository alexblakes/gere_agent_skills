---
title: 'Finding participants based on genotypes, June 2024 - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/genotypes_jun24/
scraped_at: 2026-05-04T06:32:15Z
---

> **Archive training session:**
>
> Past training sessions may include information that is no longer true, in either the presentation or the Q&A. Please double check against the relevant documentation pages.

# Finding participants based on genotypes, June 2024

For many analyses, you may be starting with a (list of) gene(s) and you want to find all participants with variants in that/those gene(s). Or maybe you have variant loci and you want to get all participants with homo- or heterozygous alternative alleles at these loci.

In this training session, we will look at both no code tools for finding variants and command line tools on the high-performance cluster (HPC), including using GEL-provided workflows.

We will have a look at the Labkey tiering tables that provide all variants that are considered to be plausibly pathogenic, and learn how to filter these by genes or loci. We will use the Integrated Variant Analysis tool (IVA) to search for variants by genes or loci, plus other parameters such as proband and parental genotypes, consequences and population frequencies. For each of these variants, we can pull out the participants with these variants. The training will also cover how you can use APIs to fetch the same data programmatically.

We will also use the Small Variant workflow and SV/CNV workflow that allow us to identify all variants (short and structural, respectively) in a list of genes, pulling out the platekeys of participants with these variants. To find individuals with variants at particular loci, we will use bcftools with the aggregated VCF files on the HPC.

## Timetable

13.30 Introduction and admin  
13.35 LabKey tables of variant genotypes  
13.45 Finding genotypes with IVA and Cohort Browser  
14.00 The Small Variant and Structural Variant workflows  
14.15 Aggregated variant files  
14.30 Using bcftools on the HPC and Cloud  
14.45 Getting help and questions

## Learning objectives

After this training you will be able to:

- Know which LabKey tables which contain tiered variant data
- Use the IVA Variant Browser to filter variants.
- Differentiate between the the Small Variant and SV/CNV workflows and know when to use them.
- Understand the contents of the aggregated variant files: AggV2 and SomAgg.
- Run pipelines and tools on the GEL HPC.

## Target audience

This training is aimed at researchers:

- working with the Genomics England Research environment
- working with genetic and genomic variation data
- who can work on the command line to run tools and scripts

## Date

11th June 2024

## Materials

You can access the redacted slides and video below. All sensitive data has been censored. You can access and copy code from the Jupyter and R notebooks used in the training at:

`/gel_data_resources/example_scripts/workshop_scripts/genotypes_2024`

### Slides

[Download the slides](../genotypes_2024.pdf)

### Video

### Optional exercises

These practice exercises will allow you to try out what you've learned. Feel free to have a go in your own time.

Coding/command line

These exercises are also written into the Jupyter and R notebooks, along with sample code that is a possible answer.

1. Use the LabKey API to look up participants with variants in the gene JPH3 that have been selected by rare disease tiering, cancer tiering or exomiser. Repeat your rare disease tiering query with NHS GMS data.
2. Run the Small Variant and SV/CNV workflows to find participants with all variants in JPH3.
3. Query the SomAgg aggregate VCF for all participants with an alternate allele at 16:87690170. Make sure you query the correct file chunk.

No code

1. Use Labkey to look up participants with variants in the gene JPH3 that have been selected by rare disease tiering, cancer tiering or exomiser. Repeat your rare disease tiering query with NHS GMS data.
2. Use IVA to find all participants with somatic variants in JPH3.

[Give us feedback on this tutorial](https://www.smartsurvey.co.uk/s/JEMYJC/)

### Q&A

Q&A

What about if you have a list of different loci? Do you have to do each one individually or can you pull multiple loci at once?

The queries are run from SQL, itâs based on PostgreSQL with some changes, but you should be able to save your loci as a list and pass this to the query

---

Does Tiering use the most up to date version of the panels it applies?

Tiering is part of the GEL bioinformatics pipeline so itâs based on the panel available at the time it was run. If the panel gets updated the analysis would need to be rerrun for it to be picked up.

The âpanels\_appliedâ table tells you which is the panel version used per participant per interpretation request

---

How do you filter in IVA to search within only the cancer somatic variants? for example to compare the number of vairants in a gene between somatic and germline, thank you

You will need to select the project that you want to search at the start, the options will be:

- Rare Disease GRCh37
- Rare Disease GRCh38
- Cancer Somatic GRCh38
- Cancer Germline GRCh38

If you wanted to compare between the somatic and germline cancer cohorts you would need to run the query twice and perform the comparison outside of IVA

---

What about if you have a list of participants with the gene/vairant of interest from labkey, can we pull corresponding clinical data as well for further analysis?

Labkey should allow you to join the information from these tables to extract the clinical data. For joining tables you can review the example queries that we have for the small variant and structural variant workflows as a guide. or you can look at the LabKey SQL reference documentation here:

https://www.labkey.org/Documentation/wiki-page.view?name=labkeysql

---

I have a couple of unrelated questions about the cancer data that I would be grateful for any help with please, although not directly related to this session - (just being opportunistic asking here - but please point me in the right direction if there is a better forum to ask these on!)

1. I have noticed that about 500 of the participants in the cancer\_analysis file do not seem to have NCRAS records (they aren't in the 'av\_tumour' or âav\_participantâ table) - any idea why this might be please?
2. There is an 'NHSE cancer\_registry' table and there is also the NCRAS data (av\_patient, av\_tumour etc)â¦what is the difference between these two datasources please?

Hi Naomi, thanks for your question! Please raise a ticket with the service desk (as Emily just mentioned). The team will get back to you as soon as possible. Iâd answer here but it would require a little investigation and I fear Iâm about to lose access to this chat!

Adding to that, I would check the NCRAS documentation if you havenât yet: https://re-docs.genomicsengland.co.uk/cancer\_clinical/#nhse-ncras-cancer-clinical-data

Itâs an external data source so itâs assumable missing participants in that registry

---

I would like to ask about Exomiser and absent data entries. For example this is a made up example. Gene ABC variant 1234, rank 1, but there is a lack of frequency data, how is the rank calculated?

live answered in session with a promise to follow this up:

October 7, 2025
