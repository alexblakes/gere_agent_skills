---
title: 'AggV2 code book - genotype queries - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/aggv2_genotype_queries/
scraped_at: 2026-05-04T06:31:01Z
summary: "bcftools query examples for extracting AggV2 genotypes by variant, region, allele frequency, and PASS filter."
---

# AggV2 code book - genotype queries

You can query the AggV2 VCFs for participant genotypes. This document gives you example code for getting genotypes from all participants for a single variant, getting genotypes for a single participant across a genomic region, getting allele frequencies for all variants across a genomic region and filtering variants by PASS sites.

The example queries work with the genotype data VCFs from aggV2, present in:

`/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/genomic_data`

> **bcftools version:**
>
> Please use bcftools version 1.16 via: `module load bcftools/1.16`

## Extracting genotypes for a single variant

**Question:** "I want to see the genotypes of all samples in aggV2 for a particular variant I know. For example the chr7: 48866984 - G/A SNP

**Script:** Use bcftools query. Enter the region (chromosome and position) using `-r`. The `-f` option formats the output with the attributes included. The `>` character writes the output to a tab-delimited file.

```
!/bin/bash

module load bcftools/1.16

bcftools query -r chr7:48866984 \
-f '[%SAMPLE\t%CHROM\t%POS\t%REF\t%ALT\t%INFO/OLD_MULTIALLELIC\t%INFO/OLD_CLUMPED\t%FILTER\t%GT\n]' \
/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/genomic_data/gel_mainProgramme_aggV2_chr7_48864936_51531027.vcf.gz > chr7_48866984_g_a_genotypes.tsv
```

**Output:** The output is a tab-delimited file in *long-format* - where each sample is on a separate line for the same variant. The columns are in the same order as stated in the `-f` command above. If there are multiple variants at the same position (i.e. from a decomposed variant), all variants at the same position will be returned.

```
...
LP1234567-DNA_A01       chr7    48866984        G       A       .       .       PASS    0/0
LP2345678-DNA_B02       chr7    48866984        G       A       .       .       PASS    0/1
LP3456789-DNA_C03       chr7    48866984        G       A       .       .       PASS    1/1
LP4567890-DNA_D04       chr7    48866984        G       A       .       .       PASS    0/0
LP5678901-DNA_E05       chr7    48866984        G       A       .       .       PASS    0/1
LP6789012-DNA_F06       chr7    48866984        G       A       .       .       PASS    0/0
...
```

*Data have been randomised and subset.*

You can also extract additional per-sample FORMAT tags by wrapping the tags in the `-f '[ ]'` brackets of the bcftools query command. For example if you want to see the depth (DP), genotype quality (GQ), and allelic depths (AD) for the variant above per sample, you could expland the `-f` command to:

```
-f '[%SAMPLE\t%CHROM\t%POS\t%REF\t%ALT\t%INFO/OLD_MULTIALLELIC\t%INFO/OLD_CLUMPED\t%FILTER\t%GT\t%DP\t%GQ\t%AD\n]'
```

**Output:**

```
...
LP1234567-DNA_A01       chr7    48866984        G       A       .       .       PASS    0/0     21      59      21,0
LP2345678-DNA_B02       chr7    48866984        G       A       .       .       PASS    0/1     28      81      28,15
LP3456789-DNA_C03       chr7    48866984        G       A       .       .       PASS    1/1     17      43      0,15
LP4567890-DNA_D04       chr7    48866984        G       A       .       .       PASS    0/0     36      79      36,0
LP5678901-DNA_E05       chr7    48866984        G       A       .       .       PASS    0/1     36      92      36,36
LP6789012-DNA_F06       chr7    48866984        G       A       .       .       PASS    0/0     26      56      26,0
...
```

> **List of regions:**
>
> You can also query a list of regions. You must use the `-R` flag and point to a tab delimited file of CHROM, POS, END.

## Extracting genotypes for a single sample

**Question:** "I want to see the genotypes of a particular sample in aggV2 for a region of interest. For example all variants for sample LP8901234-DNA\_G07 in chr7: 48866084-48866984

**Script:** Use bcftools query. Enter the sample using `-s` and the region (chromosome and position) using *-r*. The `-f` option formats the output with the attributes included. The `>` character writes the output to a tab-delimited file.

```
#!/bin/bash

module load bcftools/1.16

bcftools query -s LP3000204-DNA_B10 \
-r chr7:48866084-48866984 \
-f '[%SAMPLE\t%CHROM\t%POS\t%REF\t%ALT\t%INFO/OLD_MULTIALLELIC\t%INFO/OLD_CLUMPED\t%FILTER\t%GT\n]' \
/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/genomic_data/gel_mainProgramme_aggV2_chr7_48864936_51531027.vcf.gz > chr7_48866984_48866984_LP8901234-DNA_G07_genotypes.tsv
```

**Output:** The output is a tab-delimited file in *long-format* - where each sample is on a separate line for the same variant. The columns are in the same order as stated in the `-f` command above.

```
...
LP8901234-DNA_G07       chr7    48866319        G       T       .       .       ABratio 0/1
LP8901234-DNA_G07       chr7    48866343        G       A       .       .       PASS    0/1
LP8901234-DNA_G07       chr7    48866346        A       G       .       .       PASS    1/1
LP8901234-DNA_G07       chr7    48866347        G       A       .       .       PASS    1/1
LP8901234-DNA_G07       chr7    48866357        A       C       .       .       PASS    0/0
LP8901234-DNA_G07       chr7    48866370        C       A       chr7:48866370:C/A/T     .       PASS    0/1
...
```

*Data have been randomised and subset.*

> **List of samples:**
>
> You can also query a list of samples. You must use the `-S` flag and point to a single column text file of sample IDs.

## Extracting allele frequencies and site QC metics for a range of variants

**Question:** "I want to see the allele frequencies of all variants in a region of interest. For example all variants in chr7: 48866084-48866984

**Script:** Use bcftools query. Enter the region (chromosome and position) using `-r`. The `-f` option formats the output with the attributes included. The `>` character writes the output to a tab-delimited file.

```
#!/bin/bash

module load bcftools/1.16

bcftools query -r chr7:48866084-48866984 \
-f '%CHROM\t%POS\t%REF\t%ALT\t%INFO/OLD_MULTIALLELIC\t%INFO/OLD_CLUMPED\t%FILTER\t%INFO/AN\t%INFO/AC\t%INFO/AC_Hom\t%INFO/AC_Het\t%INFO/AC_Hemi\n' \
/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/genomic_data/gel_mainProgramme_aggV2_chr7_48864936_51531027.vcf.gz > chr7_48866984_48866984_LP9012345-DNA_H08_genotypes.tsv
```

**Output:** The output is a tab-delimited file in *wide-format* - where each variant is on a separate line across all samples. The columns are in the same order as stated in the `-f` command above.

```
...
chr7    48866111        G       C       .       .       PASS    156390  222     1       222     0
chr7    48866116        A       C       .       .       PASS    156390  8       4       4       0
chr7    48866117        A       T       .       .       PASS    156390  12       2       2       0
chr7    48866118        T       C       .       .       PASS    156390  24       2       4       0
chr7    48866123        C       T       .       .       PASS    156390  110      4       10      0
chr7    48866128        G       A       .       .       PASS    156390  18       4       8       0
...
```

*Data have been randomised and subset.* Allele frequency data for aggV2 are housed in the INFO field of the genotype VCFs as shown below:

```
##INFO= <id=an,number=1,type=integer,description="total number="" of="" alleles="" in="" called="" genotypes"="">
##INFO= <id=ac,number=a,type=integer,description="allele count="" in="" genotypes"="">##INFO= <id=ac_hom,number=a,type=integer,description="allele counts="" in="" homozygous="" genotypes"="">
##INFO= <id=ac_het,number=a,type=integer,description="allele counts="" in="" heterozygous="" genotypes"="">
##INFO=<id=ac_hemi,number=a,type=integer,description="allele counts="" in="" hemizygous="" genotypes"=""></id=ac_hemi,number=a,type=integer,description="allele></id=ac_het,number=a,type=integer,description="allele></id=ac_hom,number=a,type=integer,description="allele></id=ac,number=a,type=integer,description="allele></id=an,number=1,type=integer,description="total>
```

You can also extract per-variant summary statistics and site QC metics using bcftools query and including the INFO tag in the query. For example if you wanted to extract the per-variant median depth, median GQ, ABRatio, and HWE p-value in Europeans, the `-f` command could be expanded to:

```
-f '%CHROM\t%POS\t%REF\t%ALT\t%INFO/OLD_MULTIALLELIC\t%INFO/OLD_CLUMPED\t%FILTER\t%INFO/medianDepthAll\t%INFO/medianGQ\t%INFO/ABratio\t%INFO/phwe_eur\n'
```

**Output:**

```
...
chr7    48866111        G       C       .       .       PASS    19      48      0.942   0.533
chr7    48866116        A       C       .       .       PASS    19      48      1       0.5
chr7    48866117        A       T       .       .       PASS    19      48      1       0.5
chr7    48866118        T       C       .       .       PASS    19      48      1       0.5
chr7    48866123        C       T       .       .       PASS    19      48      1       0.5
chr7    48866128        G       A       .       .       PASS    19      48      1       0.5
...
```

## Filtering for PASS sites only

**Question:** "I only want to use PASS sites in my analysis".

**Script:** Use bcftools view. Use the `-i` option to set the FILTER to only include PASS sites. The `-Oz` option writes the output to a gzipped VCF and the `-o` option specifies the output VCF file name.

```
#!/bin/bash

module load bcftools/1.16

bcftools view -i 'FILTER="PASS"' \
-r chr7:48866084-48866984 \
/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/genomic_data/gel_mainProgramme_aggV2_chr7_48864936_51531027.vcf.gz \
-Oz -o chr7_48866984_48866984_PASS_sites.vcf.gz
```

**Output:** Gzipped VCF of PASS sites only for the region of interest. You can also include (using `-i`) or exclude (using `-e`) variants based on the other values in the FILTER field. For example, if you want to extract variants that PASS but also include variants that do not fail HWE for Europeans, you could use:

`-i 'FILTER="PASS" | FILTER="phwe_eur"'`

You could also exclude any sites that fail GQ but PASS all other site QC metrics by using `-e` as shown:

`-e 'FILTER~"GQ"'`

August 8, 2025
