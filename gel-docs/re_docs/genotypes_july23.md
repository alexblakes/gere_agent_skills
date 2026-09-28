---
title: 'Finding participants based on genotypes, July 2023 - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/genotypes_july23/
scraped_at: 2026-05-04T06:32:14Z
---

> **Archive training session:**
>
> Past training sessions may include information that is no longer true, in either the presentation or the Q&A. Please double check against the relevant documentation pages.

# Finding participants based on genotypes, July 2023

For many analyses, you may be starting with a (list of) gene(s) and you want to find all participants with variants in that/those gene(s). Or maybe you have variant loci and you want to get all participants with homo- or heterozygous alternative alleles at these loci.

In this training session, we will look at both no code tools for finding variants and command line tools on the high-performance cluster (HPC), including using GEL-provided workflows.

We will have a look at the Labkey tiering tables that provide all variants that are considered to be plausibly pathogenic, and learn how to filter these by genes or loci. We will use the Integrated Variant Analysis tool (IVA) to search for variants by genes or loci, plus other parameters such as proband and parental genotypes, consequences and population frequencies. For each of these variants, we can pull out the participants with these variants. The training will also cover how you can use APIs to fetch the same data programmatically.

We will also use the Small Variant workflow and SV/CNV workflow that allow us to identify all variants (short and structural, respectively) in a list of genes, pulling out the platekeys of participants with these variants. To find individuals with variants at particular loci, we will use bcftools with the aggregated VCF files on the HPC.

## Timetable

13.30 Introduction and admin  
13.35 LabKey tables of variant genotypes  
13.45 Finding genotypes with IVA  
14.00 The Small Variant and SV/CNV workflows  
14.15 Aggregated variant files  
14.30 Using bcftools on the HPC  
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

18th July 2023

## Materials

You can access the redacted slides and video below. All sensitive data has been censored.

### Slides

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

will the slides be emailed directly to us or will they be availabe online? i would also like to access slides from a course i attended i think 3 weeks ago. thank you.

https://re-docs.genomicsengland.co.uk/tutorials/

---

Will it me helpful to be logged into the RE or not interactive to that extent?

live answered

---

Are the variants updated per participant as the panelapp green genes are updated?

live answered

---

related to this, is it possible to request from the clincial side, to analyse patients inside 100kGP using another panel app?

---

In the case of patients with multiple whole genome sequencing files, how should I choose the best one?

Typically we suggest selecting the genome with the most recent delivery date

What is equivelant to Panelapp for cancer?

live answered

---

Is the first check (rare, protein altering, relevant mode, segregate appropriately) an AND condition or an OR condition?

live answered

---

"Do GEL bam files contain unmapped reads?"

Yes they do contain unmapped reads

---

I still donât really understand whatâs the difference between the Data Viewer and the Lists panels within LabKeys. What tables are included in each? Also, how to know what of the tons of tables to look at when trying to locate a specific phenotype/measurement?

You can find a description of the tables at the following link https://re-docs.genomicsengland.co.uk/clinical\_data/. We have sections on cancer data, rare diseases data, and general clinical data.

Thank you. Iâve read the documentation but it doesnât really help much. For instance, if I want to see if a specific variable (letâs say the participants birth weight) is available and where, how do I search for it? And, again, what is the difference between the Data Viewer and the Lists?

---

Is there a way in the cancer tier and domain table to know which panelapp panels were applied as there is for rare disease?

panels\_applied table

Thank you. This table doesn't seem to contain any of the cancer participant ID when I search for them

---

for rare disease exomiser table, what is the difference between genotype and mode of inheritance? eg how can it monoallelic and biallelicvariants both be heterozygous?

live answered

so compoud heterozygous?

---

Is this HGVS a combination of dbsnp HGVSg & HGVSp?

live answered

---

Do they output the MANE transcript too, or is there a way to filter by just that transcript for each gene? Thanks!

live answered

---

How to call for patient fate ( alive - dead ) in the cancer\_analysis table

participant\_summary

It gives only 20 patients, is there a way to search for more at one go

---

is it possible to apply different PanelApps to the same participant? for example, if no variant has been identified using a specific gene panel.

IVA Case Interpreter

---

can we look for NHS patients fro different regions - example north London? or a particular hospital?

Some Labkey tables do have information on the Hospital where the participantâs samples were taken, e.g. table âclinic sampleâ

---

can the patients be sorted according to the age? Thank you

The âparticipantâ table in Labkey does have the year of birth for each participant

---

Does the protein altering include splice variants? If so, what tool/threshold would have been used to call as a splice variant, eg. spliceAI?

https://www.ensembl.org/info/genome/variation/prediction/predicted\_data.html

Is that for somatic or germline splice variants?

IVA has splice variants called with cellbase

Alternative mentioned below is to use Small Variant workflow which incluse VEP spliceAI query

---

Sorry to re-ask. I think my reply might have got lost in the list. The panels\_applied table doesn't seem to include any of the cancer programme participant IDs. Is there an alternative table for which panels were applied to the cancer participants? Thank you!

The cancer program follows a different tiering strategy, as we do not have maternal/paternal genomes of the probands. The table âcancer\_tier\_and\_domain\_variantsâ has all the somatic and germline variants reported back to clinicians per sample

There are different panelapp cancer panels though (eg sarcoma, paediatric adult). The cancer\_tier\_and domain\_variants table doesn't say which panel was used for each participant. I think that table also isn't the ones that went back to the clinician (I think those are retiered onto updated panels)

---

Can you filter directly by genotype? For example, genomic location = 1:10000-20000 AND genotype = 0/1

live answered

---

What would be the best method to find all participants with all variant types in a gene?

live answered

---

so I have a list of variants in my favourite gene and therefore a list of participant IDs....to understand if the patients that have those variants do have the disease, would I then need to go into each participants clinical info and look on a case by case basis?

live answered

---

Same as Catherine, my follow up seems to have been ignored (and three people thumbed it up, so I assume it is a relatively common query). Iâve read the documentation about the tables but it doesnât really help much. For instance, if I want to see if a specific variable (letâs say the participants birth weight) is available and where, how do I search for it? And, again, what is the difference between the Data Viewer and the Lists?

https://re-docs.genomicsengland.co.uk/current\_release/

---

There seems to be info in the Lists that does not appear on the Data Views. But thanks for the link to the data dictionary.

Would it be possible to generate an online browser similar to (and sorry for mention this) the UK Biobank Showcase?"

---

Is it hg38 or hg37 for the cancer tier and domain table?

38

---

This might be a service desk question: In IVA case interpretation. It works wonderfully for the 'Cancer Program GRCh38 Germline' data, but I can't seem to get the 'Cancer Program GRCh38 Somatic' to load properly such that I can filter by gene It just spins and never loads

live answered

---

Further to Kimberley's question: I have a list of say 100 genes that are not on a panelapp panel and a list of 400 participant IDs, are you about to show us a programatic way I can see if any of my 400 patients have a variant in any of these genes (trying manually via IVA is too painful)? This would be incredibly helpful!!!

10 at a time , yes

---

Are there tutorials for using the HPC?

Yes check out this tutorial - https://re-docs.genomicsengland.co.uk/hpc\_nov22/

---

i have aboyt 140 genes i would like to check in a specific participant. What would be the best way to do this please? IVA or in R? thanks

yes, bcftools query directly on individual sampel VCF?

---

How can we reference the small variant workflow. Is there a paper or specific documentation that we can use to reference?

live answered

---

I have already used the Small Variant workflow and it was really helpful. However, the maximum number of genes I could query was 10. Has it change recently?

Thank you No, unfortunately the limit is still 10

Thank you Thank you! If I understood correctly, it will be possible if run in chunks, right?

---

Is it possible to do exactly what youâve done Emily but with just a subset of patients if we know their IDs ect

yes, you can construct your own sample file. But Emilyâs suggestion is better (if your samples are germline - default labkey sample)

---

When utilizing the SAIGE analysis workflow, I need to use files generated by PLINK. Could you show me how to generate PLINK files in HPC?

Do you mean the GWAS workflow or the AVT workflow?

Itâs Aggregrate variant testing workflow. Thank you very much

I will try to get an answer for you (I thought the conversion happened within the WF)

From the author:

AVT uses plink2 format input files for genomic data, VCF format for annotation data, and plink1 format for GRM

auto-conversion is too heavy to be done as a part of the workflow (it was in version 2, but then got removed due to the runtime issues)

All of these files exist in the aggV2 directory, and are specified as defaults in the workflow"

---

What's the best way to add additional arguments to your bsub script? It seems that its not as simple as bsub   ?

edit script.sh for your additional arguements

be sure to copy the script to your own project folder and edit your own copy

Small Variant (Nextflow) copy just the submit.sh

SV/CNV (WDL/Cromwell) copy the entire workflow directory

---

Does the previous workflow you showed not give you the genotype details/like read depth ect, unlike the aggregate files which do?

Neither of the previous WFs will include that information. Small variant will include VEP annotations and aggregated VCF; SV/CNV gives you canvas called CNVs and manta called SVs

---

The main programme is currently on v17, but the samples list for aggv2 seems to run up to v16. Can we continue to use that, or do we need to create one specifically for v17?

If your work commenced after the latest realease, then you should always filter for the most up-to-date consent status. In this case, you should create a sample list for v17.

---

This is incredibly helpful!! Thank you. Which programme would you recommend for opening the relevant Jupyter notebook within the research environment?

Browser (Firefox) or VS Code

https://re-docs.genomicsengland.co.uk/hpc\_jupyter/

October 7, 2025
