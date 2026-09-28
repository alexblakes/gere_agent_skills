---
title: 'AggV2 Code Book - Functional annotation queries - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/aggv2_functional_annotation_queries/
scraped_at: 2026-05-04T06:31:00Z
summary: "Query and filter AggV2 VEP 109 functional annotations (consequence, allele frequency, gene) using bcftools split-vep on GEL aggregate VCFs."
---

# AggV2 Code Book - Functional annotation queries

## Disclaimer

We can use [split-vep](https://samtools.github.io/bcftools/howtos/plugin.split-vep.html) (available with bcftools version 1.10.2-foss-2018b) to query and parse the functional annotation from VEP.

> **bcftools version:**
>
> Please use bcftools version 1.16 via: `module load bcftools/1.16`

> **Snippets:**
>
> Within each snippet shown below, most lines end with the '\' character. This is not part of the command but a shorthand notation meaning "keep reading the next line as part of a single command." We do this to split each snippet over multiple lines so it is easier to read.

The queries below work with the functional annotation data files present in:

`/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/functional_annotation/VEP_109`

You can view all of the available VEP annotations using the command below - all annotations can be extracted and/or filtered for.

```
#!/bin/bash

module load bcftools/1.16

bcftools +split-vep -l /gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/functional_annotation/VEP_109/gel_mainProgramme_aggV2_chr7_48864936_51531027_VEPannot.vcf.gz
```

**Output:**

```
...
1   Consequence
2   IMPACT
3   SYMBOL
4   Gene
5   Feature_type
6   Feature
7   BIOTYPE
8   EXON
9   INTRON
10  HGVSc
...
```

## Extract variants above threshold for aggV2 derived allele frequencies

**Question:** "I want to find common variants in genetically inferred European samples".

**Script:** Use bcftools query with the *-i* flag to specify the allele frequency cut-off, and the *-f* flag to determine the output attributes and format.

**Note:** Use the functional annotation data in the VEP\_99 directory to access [aggV2 allele frequencies](../aggv2_allele/).

```
module load bcftools/1.16

bcftools query /gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/functional_annotation/VEP_109/gel_mainProgramme_aggV2_chr1_1_506426_VEPannot.vcf.gz \
-i "AF_eur > 0.05" \
-f '%CHROM\t%POS\t%REF\t%ALT\t%AF_eur\n' | head -5
```

**Output:** The first five lines are printed to screen.

```
...
chr1    10108   C   T   0.073
chr1    10109   A   T   0.083
chr1    10147   C   A   0.063
chr1    10150   C   T   0.067
chr1    10177   A   C   0.132
...
```

## Extract variants for a gene of interest

**Question:** "I want to extract all variants in the gene *IKZF1* and view some basic annotation".

**Script:** Use bcftools split-vep. This example will output variants annotated against all transcripts for the gene of interest - *IKZF1* - using the -*i* flag. There will be one annotation per line (for each transcript - using the *-d* flag). The *-f* option formats the output with the attributes included. The *>* character writes the output to a tab-delimited file.

```
#!/bin/bash

module load bcftools/1.16

bcftools +split-vep /gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/functional_annotation/VEP_109/gel_mainProgramme_aggV2_chr7_48864936_51531027_VEPannot.vcf.gz \
-i 'SYMBOL="IKZF1"' -d \
-f '%CHROM\t%POS\t%REF\t%ALT\t%SYMBOL\t%Feature\t%Consequence\t%Existing_variation\n' > IKZF1_variants.tsv
```

**Output:** The output is a tab-delimited file in *long-format* - where each annotation is on a separate line across all variants. The columns are in the same order as stated in the *-f* command above.

```
...
chr7    50319076        G       A       IKZF1   ENST00000641948 non_coding_transcript_exon_variant      rs374267123
chr7    50319076        G       A       IKZF1   ENST00000642219 synonymous_variant      rs374267123
chr7    50319076        G       A       IKZF1   ENST00000645066 synonymous_variant      rs374267123
chr7    50319076        G       A       IKZF1   ENST00000646110 synonymous_variant      rs374267123
chr7    50319076        G       C       IKZF1   ENST00000331340 missense_variant        rs374267123
chr7    50319076        G       C       IKZF1   ENST00000343574 missense_variant        rs374267123
...
```

*\* data have been randomised and subset*

## Extract variants for a gene of interest with a damaging prediction

**Question:** "I want to view the variants that that are missense or worse and rare in gnomAD in the gene *IKZF1*".

**Script:** Use bcftools split-vep. This example will output variants annotated against all transcripts for the gene of interest - *IKZF1* - that are missense or worse (*-s* and -S flag) and rare in Europeans (use the *-c* flag for numeric conversion). There will be one annotation per line (for each transcript - using the *-d* flag). The *-f* option formats the output with the attributes included. The *>* character writes the output to a tab-delimited file.

```
#!/bin/bash

module load bcftools/1.16

bcftools +split-vep /gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/functional_annotation/VEP_109/gel_mainProgramme_aggV2_chr7_48864936_51531027_VEPannot.vcf.gz \
-i 'SYMBOL="IKZF1" & EUR_AF<0.05' -d \
-f '%CHROM\t%POS\t%REF\t%ALT\t%SYMBOL\t%Feature\t%Consequence\t%Existing_variation\t%EUR_AF\n' \
-c SYMBOL,Feature,Consequence,EUR_AF:Float,Existing_variation \
-s worst:missense+ -S ../../additional_data/vep_severity_scale/VEP_severity_scale_2020.txt > IKZF1_rare_missense.tsv
```

**Output:** The output is a tab-delimited file in *long-format* - where each annotation is on a separate line across all variants. The columns are in the same order as stated in the *-f* command above.

```
...
chr7    50368156        C       T       IKZF1   ENST00000413698 missense_variant        rs558055360     0
chr7    50368201        A       G       IKZF1   ENST00000413698 missense_variant        rs117111762     0.002
chr7    50368251        A       G       IKZF1   ENST00000413698 missense_variant        rs573829014     0
chr7    50368281        G       A       IKZF1   ENST00000413698 missense_variant        rs562525663     0
chr7    50368296        G       A       IKZF1   ENST00000413698 missense_variant        rs544990441     0
chr7    50376578        G       A       IKZF1   ENST00000331340 missense_variant        rs144637662&COSM6972304 0.001
chr7    50376689        G       A       IKZF1   ENST00000331340 missense_variant        rs549930725     0.001
chr7    50400076        G       A       IKZF1   ENST00000331340 missense_variant        rs148169768     0
chr7    50400355        G       C       IKZF1   ENST00000331340 missense_variant        rs529231990     0
...
```

*\* data have been randomised and subset*

**Please note** that when specifying severity constraints using the -s flag, you should currently specify the severity scale explicitly using the -S flag. This is due to a known bug in bcftools 1.10.x (outdated default severity scale), which will be resolved in bcftools 1.11. The severity scale can be found in the location below:

`/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/additional_data/vep_severity_scale/VEP_severity_scale_2020.txt`

## Additional annotation queries

Below are some additional queries using split-vep that extract useful annotation.

```
module load bcftools/1.16

#Example infile
infile='gel_mainProgramme_aggV2_chr10_10064150_12359131_VEPannot.vcf.gz'

#View all the types of VEP data annotated to file
bcftools +split-vep ${infile} -l

#If we want to view just all gnomAD annotations we can pipe to grep
bcftools +split-vep ${infile} -l | grep -i gnomADg

#Check CADD scores
bcftools +split-vep ${infile} -f '%CHROM:%POS-%REF/%ALT %CADD_RAW %CADD_PHRED\n' -d

#Check LOFTEE
bcftools +split-vep ${infile} -f '%CHROM:%POS-%REF/%ALT %LoF %LoF_filter \n' -d

#Check gnomAD custom annotations
bcftools +split-vep ${infile} -f '%CHROM:%POS-%REF/%ALT %gnomADg_AF %gnomADg_AF_eas %gnomADg_AF_sas\n' -d

#Check TOPMed custom annotations
bcftools +split-vep ${infile} -f '%CHROM:%POS-%REF/%ALT %topmedg %topmedg_AF topmedg_SVM \n' -d

#Check ClinVar custom annotations
bcftools +split-vep ${infile} -f '%CHROM:%POS-%REF/%ALT %ClinVar_CLNDN %ClinVar_CLNREVSTAT \n' -d
```

August 8, 2025
