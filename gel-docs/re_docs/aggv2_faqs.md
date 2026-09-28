---
title: 'AggV2 FAQs - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/aggv2_faqs/
scraped_at: 2026-05-04T06:30:59Z
summary: "Answers to common aggV2 questions: mapping platekey sample IDs to participant IDs, locating genomic chunks, sample QC thresholds, and sex columns in `aggregate_gvcf_sample_stats`."
---

# AggV2 FAQs

Welcome to the aggV2 Frequently Asked Questions (FAQ) page! This page will be regularly updated with your feedback.Â

> **Help with AggV2:**
>
> Please reach out via the [Genomics England Service Desk](https://www.genomicsengland.co.uk/service-desk) for any issues related to the aggV2 aggregation or companion datasets, including "aggV2" in the title/description of your inquiry.

## General

### MappingÂ participant ID to sample ID

The samples in aggV2 are referenced by sample ID in the VCFs. How do I link this to participant ID so that I can use the phenotype data?

Â All samples in aggV2 genotype VCFs are referenced by sample ID - which is the platekey ID - of the sequenced genome. This is normally an 'LP' number such asÂ LP3000204-DNA\_B11; although there are some samples in aggV2 which do not being with LP. In order to map the sample ID to the participant ID, one can use the `aggregate_gvcf_sample_stats`Â LabKey table. This table includes all samples within aggV2 and has one participant ID per row. It contains the participant ID to sample ID map. This way you can join any phenotype data to aggV2 using the participant ID. Have a look here:Â [aggV2 Code Book::Phenotype Queries](../aggv2_phenotype_queries/)Â for an example of how to do this.Â

### Identifying the correct chunk to use

aggV2 is split into 1,371 chunks across the genome. Is there an easy way I can find the chunk that has my gene and variants of interest in?Â 

Â Yes. All chunks are named in the following format:Â gel\_mainProgramme\_aggV2\_**chromosome\_start\_stop**.vcf.gz, for example gel\_mainProgramme\_aggV2\_**chr1\_146620016\_147701894**.vcf.gz. We have written an easy-to-use script to help you identify the correct chunk to use for your variants(s), gene(s), regions(s) of interest. Please see here:Â [aggV2 Code Book::General Information](../aggv2_general_information/).Â

### Quality control status of the samples in aggV2

Do I need to exclude any samples in aggV2 based on overall sample quality - such as coverage, contamination, and mapping rate?Â 

Â All 78,195 samples in aggV2 pass our internal sample QC thresholds which you can read more about here:Â [Sample QC](../sample_qc/). You can see sample-level quality metrics for all samples in aggV2 using theÂ `aggregate_gvcf_sample_stats`Â LabKey table. Please be aware that there areÂ 706 (<1%) samples that are derived from saliva in aggV2. All these samples pass our QC thresholds but we do observe decreased quality (percent aligned reads and AT dropout) of these samples compared to blood samples.

### Participant sex

I see that there are three columns I can potentially use for sample sex in theÂ `aggregate_gvcf_sample_stats` LabKey table - which should I use?

Â Yes in theÂ `aggregate_gvcf_sample_stats`Â LabKey table there are three columns: `participant_phenotypic_sex`, `karyotype`, `illumina_ploidy`Â that describe the sex of the participant.

- `participant_phenotypic_sex`: The participant's stated sex by the clinician at the GMC (Male, Female, Indeterminate)
- `karyotype`: The participant's estimated sex chromosome ploidy by the Genomics England Interpretation Pipeline using inference by WGS coverage (note that only participants who have run through the Rare Disease or Cancer interpretation pipelines have data. Those who have not are missing for this field (NA)).Â
- `illumina_ploidy`: The participant's estimated sex chromosome ploidy byÂ the Illumina NSV4 Pipeline using inference by WGS coverage (note that only XX and XY estimates are outputted - other karyotypes are to available from the Illumina pipeline and set to NA).

It is down to the analysis in hand in how to treat missing/discordant sex values.

### Genotypes with 'missing' calls

I have come across many samples that have genotypes such as ./1 - what do these represent and how should I incorporate them into my analysis?Â 

Â Multi-allelic variants in aggV2 were decomposed to their bi-allelic representations using vt. This process generates 'partial genotypes'. It is crucial that you understand how these are generated and how they can be included. We have written extensive documentation on this. Please see theÂ [Variant Normalisation](../variant_normalisation/)Â page.Â

### Chromosome Y and M

Are variants included for chromosome Y and M included in aggV2?

Â Yes they are but we do not include site QC and FILTER annotations for these chromosomes. Suggestions are welcome on site QC for chromosomes Y and M!Â

### Sample ancestry

How do I know the ancestry of the samples within aggV2?

Â We have calculated genetically inferred ancestry of all samples within aggV2. Please see our methods here:Â [Ancestry inference](../ancestry_inference/). You can access the ancestry membership probability by 1000 Genomes super-population from theÂ `aggregate_gvcf_sample_stats`Â LabKey table.

### Blacklisted variants

Does aggV2 include blacklisted variants (i.e. variants that are routinely filtered out in downstream processes)?

Our internal pipelines indeed work with a list of blacklisted variants for cancer germline data specifically. We have observed variants which are unlikely correct within cancer germline VCFs. These were PASS variants and called as part of the NSv4 pipeline developed by Illumina, however the corresponding BAM files will show that this is unlikely correct. We have identified a short list of known variants, and have provided the list on our system. Within aggV2, however, due to the general nature of the aggregation and additional QC that has been performed, many of these variants will not actually have the PASS filter. So for projects working with PASS-only variants, this should not result in an issue.

March 13, 2025
