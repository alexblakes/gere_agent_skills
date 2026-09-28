---
title: 'somAgg code book genotype queries - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/somAgg_code_book_genotype/
scraped_at: 2026-05-04T06:33:58Z
---

# somAgg code book genotype queries

You can query the somAgg VCFs for participant genotypes. This document gives you example code for getting genotypes from all participants for a single variant, getting allele frequencies for single variant and multiallelic sites, filter by PASS or high quality variants.

The example queries below work with the genotype data VCFs from somAgg, present in:

`/gel_data_resources/main_programme/aggregation/aggregated_somatic_strelka/somAgg/v0.2/genomic_data`

> **bcftools version:**
>
> Please use bcftools versionÂ 1.10.2 via:Â `module loadÂ **bio/BCFtools/1.11.2-GCC-8.3.0**`

### Extracting genotypes for a single variant

**Question:** I want to see the variant allele frequency of all samples in somAgg for a particular variant I know. For example the chr7:Â 48866984 - G/A SNP

**Script:** Use bcftools query. Enter the region (chromosome and position) using `-r`. The `-f` option formats the output with the attributes included. Importantly, use **-i = 'GT="0/1"'** to select only participant that are carriers of the variant of interest. The `>` character writes the output to a tab-delimited file.Â

```
#!/bin/bash

module load bio/BCFtools/1.11.2-GCC-8.3.0

bcftools query -r chr7:48866984 \
-f '[%SAMPLE\t%CHROM\t%POS\t%REF\t%ALT\t%INFO/FILTER\t%FILTER\t%VAF\n]' \
-i 'GT="0/1"' \
somAgg_dr12_chr7_48864936_51531027.vcf.gz > chr7_48866984_g_a_vaf.tsv
```

**Output:Â**The output is a tab-delimited file in *long-format* - where each sample is on a separate line for the same variant. The columns are in the same order as stated in the `-f` command above.Â

```
...
LP3001239-DNA_E11   chr7    48866984    G   A   .   LowQscore   0.728324
LP3001559-DNA_C02   chr7    48866984    G   A   .   LowQscore   0.242424
LP3001654-DNA_F08   chr7    48866984    G   A   .   LowQscore   0.956522
...
```

You can also extract additional per-sample FORMAT tags by wrapping the tags in the `-f` '[ ]'Â brackets of the bcftools query command. For example if you want to see the depth (DP), and allelic depths (AU, CU, GU, and TU) for the variant above per sample, you could expand the `-f` command to:Â

`-f [%SAMPLE\t%CHROM\t%POS\t%REF\t%ALT\t%INFO/FILTER\t%FILTER\t%GT\t%DP\t%VAF\t%AU\t%CU\t%GU\t%TU\n]`

**Output:**

```
...
LP3001239-DNA_E11   chr7    48866984    G   A   .   LowQscore   0/1 175 0.728324    126,128 0,0 47,47   0,0
LP3001559-DNA_C02   chr7    48866984    G   A   .   LowQscore   0/1 100 0.242424    24,25   0,0 75,78   0,0
LP3001654-DNA_F08   chr7    48866984    G   A   .   LowQscore   0/1 73  0.956522    66,71   0,0 3,3 0,0
...
```

> **List of regions:**
>
> A list of regions can also be queried. You must use the `-R` flag and point to a tabÂ delimited file of CHROM, POS, END.

### Extracting VAFs - for single sample and for multiallelic sites

**Question:** I want to see the variant allele frequency (VAF) of a particular sample in somAgg for a region of interest. For example all variants for sample LP3000379-DNA\_B02Â inÂ chr6:28514047-310013577

**Script:** Use bcftools query. Enter the sample using `-s` and the region (chromosome and position) using `-r`. The `-f` option formats the output with the attributes included. Importantly, use **-i = 'GT="0/1"'** to select only variants that are carried by the participant.Â The `>` character writes the output to a tab-delimited file.Â

```
#!/bin/bash

module load bio/BCFtools/1.11.2-GCC-8.3.0

bcftools query -s LP3000379-DNA_B02 \
-r chr6:28514047-310013577 \
-f '[%SAMPLE\t%CHROM\t%POS\t%REF\t%ALT\t%INFO/FILTER\t%FILTER\t%VAF\n]' \
-i 'GT="0/1"' \
somAgg_dr12_chr6_28514047_31001357.vcf.gz > chr6_28514047_31001357_LP3000379-DNA_B02_vaf.tsv
```

**Output:** The output is a tab-delimited file in *long-format* - where each sample is on a separate line for the same variant. The columns are in the same order as stated in the `-f` command above.Â

```
...
LP3000379-DNA_B02   chr6    28519740    C   G   .           PASS        0.0569106
LP3000379-DNA_B02   chr6    28531537    C   T   .           LowQscore   0.0480769
LP3000379-DNA_B02   chr6    28555793    G   T   RepetitiveRegion    LowQscore   0.135135
LP3000379-DNA_B02   chr6    28568183    C   A   RepetitiveRegion    LowQscore   0.0833333
LP3000379-DNA_B02   chr6    28597929    C   G   .           PASS        0.0725806
LP3000379-DNA_B02   chr6    28650337    C   A   RepetitiveRegion    LowQscore   0.117647
LP3000379-DNA_B02   chr6    28669784    A   C   SimpleRepeat        LowQscore   0.123596
LP3000379-DNA_B02   chr6    28676027    G   A   CommonGermlineVariant,CommonGnomADVariant   LowQscore   0.107143
LP3000379-DNA_B02   chr6    28685038    C   T   .           LowQscore   0.037037
...
```

*\* data have been randomised and subset*

> **Note:**
>
> For SNVs, VAF has been calculated asÂ VAF = dALT / (dALT + dREF), where dALT and dREF are readÂ depth for tier 1 for ALT and REF respectively, i.e. the tier 1 counts for AU, CU, GU, or TU. The calculation was done in this way to reduce the effect of noise.Â However, for MULTI-ALLELIC this may not represent wellÂ the composition of possible ALTs. As an alternative you may query AU, CU, GU, TU and compute VAF = dALT/(AU + CU + GU + TU) â we recommend using only tier 1 counts for that.

> **List of samples:**
>
> A list of samples can also be queried. You must use the `-S`Â flag and point to a single column text file of sample IDs.Â

**Question:** I want to see allele depths in order to compute variant allele frequency (VAF) in a different way. I am only interested in multialleleic samples.

**Script:** Use bcftools query. Enter the the region (chromosome and position) using `-r`. The `-f` option formats the output with the attributes included. Importantly, use **-i = 'GT="0/1"'** to select only variants that are carried by the participant. Also, the SAMPLE\_MULTIALLELIC != "." will assure only samples for which the site was multiallelic to be selected. The `>` character writes the output to a tab-delimited file. Sort -k1 will sort by sample instead of position. (We have included VAF in the query to highlight the issue with the current calculation when addressing MULTIALLELIC sites/samples).

```
#!/bin/bash

module load bio/BCFtools/1.11.2-GCC-8.3.0

bcftools query -r chr6:30999722  \
-f '[%SAMPLE\t%REF\t%ALT\t%AU\t%CU\t%GU\t%TU\t%DP\t%VAF\t%SAMPLE_MULTIALLELIC\n]'  \
-i 'GT="0/1" & SAMPLE_MULTIALLELIC != "."'  \
somAgg_dr12_chr6_28514047_31001357.vcf.gz  \
| sort -k1
```

**Output:Â**The output is a tab-delimited file in *long-format* - where each sample is on a separate line for the same variant. The columns are in the same order as stated in the `-f` command above.Â

```
...
LP3000850-DNA_G03       C       A       65,70   50,50   13,13   0,0     133     0.565217        chr6-30999722-C/A/G
LP3000850-DNA_G03       C       G       65,70   50,50   13,13   0,0     133     0.206349        chr6-30999722-C/A/G
LP3001100-DNA_B02       C       G       0,0     0,0     86,98   15,16   113     1       chr6-30999722-C/G/T
LP3001100-DNA_B02       C       T       0,0     0,0     86,98   15,16   113     1       chr6-30999722-C/G/T
...
```

### Filtering for PASS only (internal and Strelka)

**Question:** I only want to use PASS variants in my analysis.Â

**Script:** The PASS given in the FMT/FILTER means that the site for that sample has passed all Strelka and Internal filters.Â

Use bcftools query. Enter the the region (chromosome and position) using `-r`. The `-f` option formats the output with the attributes included. Use the *-i*Â option to set the FORMAT/FILTER to only include PASS variants (sample level). Also, the SAMPLE\_MULTIALLELIC will show samples for which the site is multiallelic. The `>` character writes the output to a tab-delimited file.Â

```
#!/bin/bash

module load bio/BCFtools/1.11.2-GCC-8.3.0

bcftools query  -r chr7:48866084-48866984  \
-f '[%SAMPLE\t%CHROM\t%POS\t%REF\t%ALT\t%INFO/FILTER\t%FILTER\t%INFO/OLD_MULTIALLELIC\t%VAF\n]'  \
-i 'FMT/FILTER="PASS"'  \
somAgg_dr12_chr7_48864936_51531027.vcf.gz \
> chr7_48866984_48866984_PASS.tsv
```

**Output:Â**a tab-delimited file of PASS variants per sample only for the region of interest.Â

```
...
LP3001647-DNA_B03       chr6    28514047        C       T       .       PASS    .       0.184
LP3001600-DNA_F01       chr6    28514048        T       A       .       PASS    .       0.102564
LP3001169-DNA_D01       chr6    28514053        G       A       .       PASS    .       0.0740741
LP3001370-DNA_A01       chr6    28514062        C       T       .       PASS    .       0.309278
LP3001652-DNA_H03       chr6    28514062        C       T       .       PASS    .       0.353846
...
```

You can also include (using *-i*) or exclude (using *-e*)Â variants based on the other values in the FILTER field.

The query above will return only samples that have **passed** both Strelka and internal filters. Internal filters can be found on INFO, when referring to the site, or in FORMAT, when referring to the call in the sample:

| VCF field | Filter flag | Description |
| --- | --- | --- |
| INFO | CommonGermlineVariant | Variants with a population germline allele frequency above 1% in a Genomics England sub-cohort |
| INFO | RecurrentSomaticVariant | Recurrent somatic variants with frequency above 5% in a Genomics England cohort |
| INFO | SimpleRepeat | Variants overlapping simple repeats as defined by [Tandem Repeats Finder](http://hgdownload.cse.ucsc.edu/goldenPath/hg38/database/simpleRepeat.txt.gz) |
| INFO | CommonGnomADVariant | Variants with a population germline allele frequency above 1% in gnomAD dataset |
| FORMAT | BCNoise10Indel | Flags if average fraction of filtered basecalls within 50 bases of the indel exceeds 0.1, FDP50/DP50 > 0.1 |
| FORMAT | PONnoise50SNV | Flags if SomaticFisherPhred is below 50, indicating somatic SNV is systematic mapping/sequencing error (applies only to SNVs that pass Strelka filters) |

If you are interested in retrieving variants that have PASS on Illumina (but may have failed internal filter flags), expand the -i argument in the above so you have. Note that the awk command is to make use only exact matches are kept.Â

```
#!/bin/bash

module load bio/BCFtools/1.11.2-GCC-8.3.0

bcftools query  -r chr7:48866084-48866984  \
-f '[%SAMPLE\t%CHROM\t%POS\t%REF\t%ALT\t%INFO/FILTER\t%FILTER\t%SAMPLE_MULTIALLELIC\t%VAF\n]' \
-i 'FMT/FILTER="PASS" | (GT = "0/1" & FMT/FILTER = ".") | FMT/FILTER == "BCNoise10Indel" | FMT/FILTER = "PONnoise50SNV"'   \
somAgg_dr12_chr7_48864936_51531027.vcf.gz  \
| awk ' $6 !~ "RepetitiveRegion" && ($7 !~ "LowQscore" && $7 !~ "BCNoiseIndel" && $7 !~ "HighDepth" && $7 !~ "LowQuality" && $7 !~ "QSI_ref")  {print}' \
> chr7_48866984_48866984_illumina_PASS.tsv
```

### Filtering high quality variants for discovery

Imagine that you have a discovery projects, where you want to control for FP, but still be permissive so that your get potential novel hits. To this end, we suggest the query below. Notice that theÂ RecurrentSomaticVariant flag has been implemented after a rigorous study to deal with the problems introduced with FFPE. Today, however, the number of FFPE is quite small (<10%) onÂ the Cancer Programme, so the filter becomes less relevant.

The query below will remove allÂ HomopolimerIndel, and keep only variants that are either PASS (FMT/FILTER) orÂ RecurrentSomaticVariant (INFO/FILTER)

```
#!/bin/bash

module load bio/BCFtools/1.11.2-GCC-8.3.0

bcftools view \
-e 'INFO/HomopolimerIndel!=0 | (INFO/FILTER!="RecurrentSomaticVariant" & INFO/FILTER != ".")' \
-S ./input/samples.txt somAgg_dr12_chr7_48864936_51531027.vcf.gz | \
bcftools query \
-f '[%CHROM\t%POS\t%REF\t%ALT\t%VAF\n]' \
-i 'FMT/FILTER="PASS" | (GT = "0/1" & FMT/FILTER = ".")' \
>  chr7_48866984_48866984_PASS_RSV_noHPI.tsv
```

January 19, 2026
