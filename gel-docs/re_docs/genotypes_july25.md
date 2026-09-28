---
title: 'Finding participants based on genotypes, June 2024 - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/genotypes_july25/
scraped_at: 2026-05-04T06:32:15Z
---

> **Archive training session:**
>
> Past training sessions may include information that is no longer true, in either the presentation or the Q&A. Please double check against the relevant documentation pages.

# Finding participants based on genotypes, July 2025

For many analyses, you may be starting with a (list of) gene(s) and you want to find all participants with variants in that/those gene(s). Or maybe you have variant loci and you want to get all participants with homo- or heterozygous alternative alleles at these loci.

In this training session, we will look at both no code tools for finding variants and command line tools on the high-performance cluster (HPC), including using GEL-provided workflows.

We will have a look at the Labkey tiering tables that provide all variants that are considered to be plausibly pathogenic, and learn how to filter these by genes or loci. We will use the Integrated Variant Analysis tool (IVA) to search for variants by genes or loci, plus other parameters such as proband and parental genotypes, consequences and population frequencies. For each of these variants, we can pull out the participants with these variants. The training will also cover how you can use APIs to fetch the same data programmatically.

We will also use the Small Variant workflow and Structural Variant workflow that allow us to identify all variants (short and structural, respectively) in a list of genes, pulling out the platekeys of participants with these variants. To find individuals with variants at particular loci, we will use bcftools with the aggregated VCF files on the HPC.

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

8th July 2025

## Materials

You can access the redacted slides and video below. All sensitive data has been censored. You can access and copy code from the Jupyter and R notebooks used in the training at:

`/gel_data_resources/example_scripts/workshop_scripts/genotypes_2025`

### Slides

[Download the slides](../genotypes_2025.pdf)

### Video

[Give us feedback on this tutorial](https://surveys.genomicsengland.co.uk/s/FRXL7X/)

### Q&A

Q&A

Tangential question: did Emily just say the 100,000 genomes project began in 2012? I thought I read somewhere that participant recruitment started in 2015? Just wondering in terms of describing the cohort in methods sectionsâ¦.

thatâs correct, the first genomes from the 100k project were delivered in December 2015 (basing on the sequencing\_report table in labkey)

---

the AggVariant files only contain 38 and not 37, is this right?

AggV2 has genomes aligned to hg38 only

---

but Tiering data lacks annotations hgvs nomeclature, how to overcome this if you have large list of filtered variants? Also how to filter for MANE Select transcript as variants are called in all transcripts if you are filtering for several genes?

Re hgvs nomenclature, can you please clarify what youâd like to overcome? You can for example pull the positions and join the variants on those.

Re MANE, we do not have the transcript information available for the tiering data

In another way, how to do variant annotations of the tiering data? do I need to use VEP for that or is there simpler way to do so?

and yes, using VEP will be an appropriate way of doing this. Unless you already have the exact coordinates, then you should be able to bind them

if I may ask how?

Apologies, I potentially misunderstood your question. If you have a list of variants you found in the tiering table, you can use VEP to get the annotations.

---

Is there any limitaion in exporting data as TSV (in IVA) among users?

Can you clarify what you mean by limitation? In terms of data size, or getting it out of the research environment?

I assume you mean getting it out through the airlock system https://re-docs.genomicsengland.co.uk/airlock/. I am not aware of any specific limits. If youâd like more clarification please feel free to send a service desk ticket and someone from the team will reply with a detailed answer.

Oh yes, data size and also if everybody has the possibility to export in TSV format within the environment (not out of)?

Yes, everyone can export the data within the environment. I am not sure about the size limitations Iâm afraid.

---

Apart from Genomics England, is there another source to look up a novel variant?

live answered

Actually I got a question and I hope to find the answer by today training session: The way to identify patients with a potential pathogenic variant in a novel gene identified from animal studies.

If you have the coordinates of the human version of the gene, you can use those to look up the variants.

---

am I right in thinking the bed coordinates are always one bp less than the vcf coordinates? Do we have to minus 1 from the coordinates we enter in the .bed file? (p.s. Sorry if you covered this already!)

Yes, bed coordinates are 0-based and vcf coordinates are 1-based. Navigating between the two formats will require extra care. Iâd suggest reading the documentation for each file format to understand exactly how the regions are represented, so you can avoid excluding/including positions by mistake.

---

From these four methods by which one we can find a novel variant? Found from an animal study

live answered

---

Tiering and exomiser because of filtering have any hope to have a novel variant?

live answered

---

To make sure we looked at all the variants in a gene in IVA, do we need to look in both GRCh 37 and 38, or they contain the same variants?

live answered

---

workflow is only for 100k GP and not GMS? is that right? we only access GMS data through labkey?

live answered

October 7, 2025
