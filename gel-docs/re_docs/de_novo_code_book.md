---
title: 'De novo data code book - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/de_novo_code_book/
scraped_at: 2026-05-04T06:32:00Z
---

# De novo data code book

This code book is to help you interrogate the 100kGP DNV dataset. It includes querying the multisample VCFs and querying the relevant LabKey tables.

> **Note:**
>
> Submit all scripts to the [High-Performance Compute](../hpc/) cluster, either to the short or interactive queue.

## Querying the annotated multi-sample VCFs

The below code snippets assume that you are working in the HPC environment. Use the LabKey tableÂ `denovo_cohort_information`Â to fetch the file paths to the annotated multi-sample VCFs for your cohort of interest. Examples of how to do this are in the LabKey section below.Â

> **Working directory:**
>
> Remember that you will need to change certain file paths to the inputs and outputs depending on your working location on the HPC.

### Location of the annotated multi-sample VCFs

The annotated multi-sample VCFs are found in the directory below under *flagged\_vcf* and split by the GRCh37 and GRCh38 cohorts. In the cohort folders, are the full file paths to all annotated multi-sample VCFs per cohort.Â

```
/gel_data_resources/main_programme/denovo_variant_dataset
|
âââ GRCh37
âÂ Â  âââ 20200326
âÂ Â      âââ cohort
âÂ Â      âââ flagged_vcf
âââ GRCh38
    âââ 20200326
        âââ cohort
        âââ flagged_vcf
```

### Basic filtering of the annotated multi-sample VCFs

You can query the multi-sample VCFs using bcftools to include (`-i`) or exclude (`-e`) variants based on flags in the `FORMAT` column, labelled `DE_NOVO_FLAG`.

**Example 1:**Â Include only `stringent_filter` pass DNVs in a single family, write results as compressed VCF:Â

```
#!/bin/bash

module load bcftools/1.16

bcftools view -i 'DE_NOVO_FLAG="DENOVO"' 00004-RTD_10001.denovo.reheader.vcf.gz -O z -o 00004-RTD_10001_only_denovo.vcf.gz
```

**Example 2:**Â Include only `stringent_filter` pass DNVs in a single family,Â write results as a tab-delimited text file of variants, sample IDs, and genotypes:

```
#!/bin/bash

module load bcftools/1.16

bcftools query -f '[%CHROM\t%POS\t%REF\t%ALT\t%SAMPLE\t%GT\n]' -i 'DE_NOVO_FLAG="DENOVO"' 00004-RTD_10001.denovo.reheader.vcf.gz > 00004-RTD_10001_only_denovo_sample_genotypes.tsv
```

**Output:**

```
1       76390973       A       T       LP2000950-DNA_D07       1/0
1       11623896       G       A       LP2000950-DNA_D07       1/0
1       18103688       C       T       LP2000950-DNA_D07       0/1
1       23653370       A       G       LP2000950-DNA_D07       0/1
2       15659761       T       C       LP2000950-DNA_D07       1/0
2       20627434       C       T       LP2000950-DNA_D07       0/1
...
```

*\* data have been randomised*

**Example 3:**Â Include only `base_filter` pass DNVs in a single family that fail a single `stringent_filter` (eg `simplerepeat`),Â write results as compressed VCF:Â

```
#!/bin/bash

module load bcftools/1.16

bcftools view -i 'DE_NOVO_FLAG="simplerepeat"' 00004-RTD_10001.denovo.reheader.vcf.gz -O z -o 00004-RTD_10001_simplerepeat_fail.vcf.gz
```

**Example 4:** Include only `base_filter` pass DNVs in a single family that fail more than one `stringent_filter` (eg `simplerepeat` and `abratio`),Â write results as compressed VCF:Â

```
#!/bin/bash

module load bcftools/1.16

bcftools view -i 'DE_NOVO_FLAG="simplerepeat" | DE_NOVO_FLAG="abratio"' 00004-RTD_10001.denovo.reheader.vcf.gz -O z -o 00004-RTD_10001_simplerepeat_abratio_fail.vcf.gz
  ```

**Example 5:**Â Exclude `base_filter` fail DNVs and exclude DNVs that fail a stringent filter (eg `patch`) in a single family,Â write results as compressed VCF:Â 

``` bash linenums="1"
#!/bin/bash

module load bcftools/1.16

bcftools view -e 'DE_NOVO_FLAG="base_fail" | DE_NOVO_FLAG="patch"' 00004-RTD_10001.denovo.reheader.vcf.gz -O z -o 00004-RTD_10001_base_and_patch_fail.vcf.gz
```

**Example 6:** For families with nested trios (e.g. multiple offspring) and simple trios, you can print out the sample ID and also the de novo flag value for each sample. Note that the `DE_NOVO_FLAG` `FORMAT` attribute for the mother and father samples is always set to `.` missing. You can filter these missing samples out by including the flag as shown below (`-i 'DE_NOVO_FLAG!="."'`):Â

```
#!/bin/bash

module load bcftools/1.16

bcftools query -i 'DE_NOVO_FLAG!="."' -f '[%CHROM\t%POS\t%REF\t%ALT\t%SAMPLE\t%GT\t%DE_NOVO_FLAG\n]' 00058-RTD_10127.denovo.reheader.vcf.gz > 00058-RTD_10127_sample_genotypes.tsv
```

**Output:**

```
2       128586362       T       G       LP3000128-DNA_E05       1/0     DENOVO
2       128586362       T       G       LP3000135-DNA_E01       0/0     base_fail
2       130215368       C       A       LP3000128-DNA_E05       0/0     base_fail
2       130215368       C       A       LP3000135-DNA_E01       1/0     altreadparent;abratio
...
```

*\* data have been randomised*

**Example 7:** Example 6 shows the output in long-format (where the variant is duplicated by the number of samples). It is also possible to show the same data in wide-format - with each column being maintaining the same sample id and order in the VCF. Now one variant per line is shown:

```
#!/bin/bash

module load bcftools/1.16

bcftools query -f '%CHROM\t%POS\t%REF\t%ALT\t[%GT\t%DE_NOVO_FLAG\t]\n' 00058-RTD_10127.denovo.reheader.vcf.gz > 00058-RTD_10127_sample_genotypes.tsv
```

**Output:**

```
2       2255217       A       G       0/1     DENOVO  0/1     base_fail       0/0     .       0/0     .       
2       2270459       AT      A       1/0     base_fail       1/0     base_fail       0/0     .       0/0     .          
2       2318407       C       T       0/1     altreadparent;abratio   0/1     altreadparent;abratio   0/0     .       0/0     .       
...
```

*\* data have been randomised*

### More advanced filtering of the annotated multi-sample VCFs

It is also possible to perform more advanced filtering by querying the attributes within the `INFO` field; such as the genomic annotation from VEP. Also, multiple filtering steps can be chained together in the same command to build complex queries.Â

We will use [split-vep](https://samtools.github.io/bcftools/howtos/plugin.split-vep.html) to query and parse the genomic annotation from VEP (available for recent versions of bcftools).

**Example 1:**Â Include only variants in a single family for a gene of interest (eg *ACTL6B*),Â write results as a tab-delimited text file of variants with specified genomic annotation.Â This example will output variants annotated against all transcripts for gene of interest,Â there will be one annotation per line (for each transcript - using the `-d` flag).Â The annotation columns to be printed out can be manually selected (gnomAD\_NFE, Consequence etc). It is also possible to query many genes at a time (such as: `-i 'SYMBOL="ACTL6B" | SYMBOL="IL9R"'`),Â or by applying a filter and using grep on the output:

```
#!/bin/bash

module load bcftools/1.16

bcftools +split-vep 00004-RTD_10001.denovo.reheader.vcf.gz -d -f '%CHROM\t%POS\t%REF\t%ALT\t%SYMBOL\t%Feature\t%Consequence\t%gnomAD_NFE_AF\t%Existing_variation\n' -i 'SYMBOL="ACTL6B"' > 00004-RTD_10001_gene_only.tsv
```

**Output:**

```
7   100244267   C   T   ACTL6B  ENST00000160382 missense_variant    .   rs1131695228
7   100244267   C   T   ACTL6B  ENST00000461605 downstream_gene_variant .   rs1131695228
7   100244267   C   T   ACTL6B  ENST00000485601 downstream_gene_variant .   rs1131695228
7   100244267   C   T   ACTL6B  ENST00000487125 non_coding_transcript_exon_variant  .   rs1131695228
7   100244267   C   T   ACTL6B  ENST00000487225 downstream_gene_variant .   rs1131695228
7   100244267   C   T   ACTL6B  ENST00000489904 downstream_gene_variant .   rs1131695228
```

*\* data have been randomised*

**Example 2:**Â It is possible to firstly extract `stringent_filter` pass variants and pipe this into `+split-vep` then write results as a tab-delimited text file of variants with specified genomic annotation:

```
#!/bin/bash

module load bcftools/1.16

bcftools view -i 'DE_NOVO_FLAG="DENOVO"' 00004-RTD_10001.denovo.reheader.vcf.gz |\
bcftools +split-vep -d -f '%CHROM\t%POS\t%REF\t%ALT\t%SYMBOL\t%Feature\t%Consequence\t%gnomAD_NFE_AF\t%Existing_variation\n' -i 'SYMBOL="ACTL6B"' > 00004-RTD_10001_denovo_gene_only.tsv
```

**Example 3:**Â You can also perform more complex filtering such as scanning for all `stringent_filter` pass variants,Â that are missense or worse (`-s` and `-S` flags) and rare in gnomAD (use the `-c` flag for numeric conversion). Write results as a tab-delimited text file of variants with specified genomic annotation. The sample ID is also printed here so that it can be joined to other tables:Â

```
#!/bin/bash

module load bcftools/1.16

bcftools view -i 'DE_NOVO_FLAG="DENOVO"' 00004-RTD_10001.denovo.reheader.vcf.gz |\
bcftools +split-vep -d -f '[%SAMPLE\t%CHROM\t%POS\t%REF\t%ALT\t%DE_NOVO_FLAG\t%SYMBOL\t%Feature\t%Consequence\t%gnomAD_NFE_AF\t%Existing_variation\n]' \
-c SYMBOL,Feature,Consequence,gnomAD_NFE_AF:Float,Existing_variation -i 'gnomAD_NFE_AF<0.001' -s worst:missense+ -S VEP_severity_scale_2020.txt > 00004-RTD_10001_denovo_rare_missense.tsv
```

When specifying severity constraints using the `-s` flag, you should specify the severity scale explicitly using the `-S` flag. This is due to a known bug in bcftools 1.10.x (outdated default severity scale), which will be resolved in bcftools 1.11 - "VEP\_severity\_scale\_2020.txt" is an example file for the current severity scale, which will be used in the relevant examples on this page:

VEP\_severity\_scale\_2020.txt

```
# Default consequence substrings ordered in ascending order by severity.
## Consequences with the same severity can be put on the same line in arbitrary order.
## See also https://www.ensembl.org/info/genome/variation/prediction/predicted_data.html
intergenic
feature_truncation feature_elongation
regulatory
TF_binding_site TFBS
downstream upstream
non_coding_transcript
intron NMD_transcript
non_coding_transcript_exon
5_prime_utr 3_prime_utr
coding_sequence mature_miRNA
stop_retained start_retained synonymous
incomplete_terminal_codon
splice_region
missense inframe protein_altering
transcript_amplification
exon_loss
disruptive
start_lost stop_lost stop_gained frameshift
splice_acceptor splice_donor
transcript_ablation
```

**Example 4:**Â The Bayes Factor for each variant from theÂ [PlatypusÂ bayesiandenovofilter.py](https://github.com/andyrimmer/Platypus/blob/master/extensions/DeNovo/bayesianDeNovoFilter.py) script can also be easily extracted from the INFO field if required, write results as a tab-delimited text file of variants:

```
#!/bin/bash

module load bcftools/1.16

bcftools query -f '%CHROM\t%POS\t%REF\t%ALT\t%FILTER\t%INFO/bayesFactor\n' 00004-RTD_10001.denovo.reheader.vcf.gz > 00004-RTD_10001_bayes_factor.tsv
```

**Example 5:** Likewise the `multidenovo_filter` can also be extracted from the INFO fieldÂ

```
#!/bin/bash

module load bcftools/1.16

bcftools query -f '%CHROM\t%POS\t%REF\t%ALT\t%FILTER\t%INFO/multidenovo_filter\n' 00004-RTD_10001.denovo.reheader.vcf.gz > 00004-RTD_10001_multidenovo_filter.tsv
```

### Iterating through the cohort of annotated multi-sample VCFs

There are a few ways to perform queries across the entire cohort to extract DNVs of interest using in a single command. This can be done using an array job; however due to the small size of the annotated multi-sample VCFs, it is also feasible to run a query in a single *while* loop.

We have deposited a text file for each cohort (GRCh37 and GRCh38) under the folders:Â

- `/gel_data_resources/main_programme/denovo_variant_dataset/GRCh37/20200326/cohort/grch37_cohort_1762.tsv`
- `/gel_data_resources/main_programme/denovo_variant_dataset/GRCh38/20200326/cohort/grch38_cohort_10847.tsv`

These file contains the full file paths to every family's annotated multi-sample VCF in the cohort. They can be used to iterate through allÂ annotated multi-sample VCF and extract variants of interest. If you want to do this for only a subset of the cohort, then you can use theÂ `vcf_path_flagged_denovo`Â column in theÂ `denovo_cohort_information` LabKey table to fetch the file paths for your custom cohort.Â

Example:Â In this example, all annotated multi-sample VCFs from the GRCh37 cohort will be interrogated.Â For each VCF in the list, `cohorts_grch37_vcfs.tsv`,Â it will first filter for `stringent_filter` pass DNVs only (`-i 'DE_NOVO_FLAG="DENOVO"'`),Â it will then print out specified genomic annotation that match the criteria:Â DNV is missense or worse and is in gene *IL6*.Â The sample id will also be printed out to join back onto other tables:

```
#!/bin/bash

module load bcftools/1.16

while read -r vcf ; do bcftools view -i 'DE_NOVO_FLAG="DENOVO"' $vcf |\
bcftools +split-vep -d -f '[%SAMPLE\t%GT\t%CHROM\t%POS\t%REF\t%ALT\t%SYMBOL\t%Feature\t%Consequence\t%gnomAD_NFE_AF\t%Existing_variation\n]' \
-i 'SYMBOL="IL6"' -s worst:missense+ -S VEP_severity_scale_2020.txt ; done < /gel_data_resources/main_programme/denovo_variant_dataset/GRCh37/20200326/cohort/grch37_cohort_1762.tsv >> output.tsv
  ```

### Performing custom filtering

You may want to perform DNV flagging based on custom filters, starting with all Mendelian inconsistencies for all families. This is possible by extracting the necessary fields from the VCF such as coverage, number of reads supporting the variant, and genotype. The below example shows how to extract these values from the VCF for each sample which can then be later processed in R/Python etc to develop the custom filters. The LabKey tableÂ `denovo_cohort_information` can then be used to associate the VCF with the correct trio. Please see the VCF header for a description of each attribute within the VCFs.Â 

``` bash linenums="1"
#!/bin/bash

module load bcftools/1.16

bcftools query -f '%CHROM\t%POS\t%REF\t%ALT\t[%GT\t%NR\t%NV\t]\n' 00058-RTD_10127.denovo.reheader.vcf.gz > 00058-RTD_10127_attributes.tsv
```

## Querying the LabKey tables

The two LabKey tablesÂ `denovo_cohort_information`Â andÂ `denovo_flagged_variants`Â can be queried though either the [LabKey desktop application](../labkey/) or through the [LabKey APIs](../labkey_api/).

For all queries we will use the labkey helper function `labkey_to_df` which uses an SQL query, a database to access and the maximum number of rows in your output, which is defined in the [LabKey documentation](../labkey_api/#helper-function-for-using-the-api-for-sql-queries)

### Fetching entire tables

These examples show how to fetch an entire table and save as an object in your R session. Tables can then be post-filtered in R. Both tables are fetched in this example.

RPython

```
version <- "/main-programme/main-programme_v19_2024-10-31"

denovo_cohort_information_sql <- "SELECT * FROM denovo_cohort_information"
denovo_cohort_information_query <- labkey_to_df(denovo_cohort_information_sql, version, 1000000000)

denovo_flagged_variants_sql <- "SELECT * FROM denovo_flagged_variants"
denovo_flagged_variants_query <- labkey_to_df(denovo_flagged_variants_sql, version, 1000000000)
```

```
version = "/main-programme/main-programme_v19_2024-10-31"

denovo_cohort_information_sql = "SELECT * FROM denovo_cohort_information"
denovo_cohort_information_query = labkey_to_df(denovo_cohort_information_sql, version, 1000000000)

denovo_flagged_variants_sql = "SELECT * FROM denovo_flagged_variants"
denovo_flagged_variants_query = labkey_to_df(denovo_flagged_variants_sql, version, 1000000000)
```

### Filtering tables and selecting columns

Tables can be filtered for certain attributes and specified columns selected in Rlabkey using SQL.

**Example 1:** In this example, we can filter theÂ `denovo_flagged_variants` tableÂ for variants that pass theÂ `stringent_filter` in a particular family. We then filter for a certain variant of interest, by chromosome and position. TheÂ `trio_id`,Â `chrom`,Â `position`,Â `reference`,Â `alternate`Â columns are then returned.Â

RPython

```
version <- "/main-programme/main-programme_v19_2024-10-31"

denovo_cohort_sql <- "SELECT trio_id, chrom, position, reference, alternate
  FROM denovo_flagged_variants
  WHERE trio_id = '00004-RTD_10001.1'
  AND stringent_filter = '1'
  AND chrom = '1'
  AND position = '101888210'"

de_novo_cohort_query <- labkey_to_df(denovo_cohort_sql)
```

```
version = "/main-programme/main-programme_v19_2024-10-31"

denovo_cohort_sql = "SELECT trio_id, chrom, position, reference, alternate
  FROM denovo_flagged_variants
  WHERE trio_id = '00004-RTD_10001.1'
  AND stringent_filter = '1'
  AND chrom = '1'
  AND position = '101888210'"

de_novo_cohort_query = labkey_to_df(denovo_cohort_sql)
```

**Example 2:** You can also perform a query across the entire cohort to find DNVs in a particular gene of interest. In this example, theÂ `denovo_flagged_variants` table if firstly filtered for the GRCh38 cohort and for a chromosomal range representing the coordinates of the gene. The variants are filtered forÂ `stringent_filter`Â `pass` and the `trio_id`,Â `chrom`,Â `position`,Â `reference`,Â `alternate`Â columns are returned.

RPython

```
version <- "/main-programme/main-programme_v19_2024-10-31"

denovo_cohort_sql <-  "SELECT trio_id, chrom, position, reference, alternate
  FROM denovo_flagged_variants
  WHERE assembly = 'GRCh38'
  AND stringent_filter = '1'
  AND chrom = '7'
  AND position >= '50303465'
  AND position <= '50405101'"

de_novo_cohort_query <- labkey_to_df(denovo_cohort_sql)
```

```
version = "/main-programme/main-programme_v19_2024-10-31"

denovo_cohort_sql = "SELECT trio_id, chrom, position, reference, alternate
  FROM denovo_flagged_variants
  WHERE assembly = 'GRCh38'
  AND stringent_filter = '1'
  AND chrom = '7'
  AND position >= '50303465'
  AND position <= '50405101'"

de_novo_cohort_query = labkey_to_df(denovo_cohort_sql)
```

### Joining multiple LabKey tables together

The usefulness of the APIs comes when joining multiple tables together.

**Example 1:** In this example, we perform the query above to findÂ `stringent_filter`Â `pass` DNVs in a gene of interest from theÂ `denovo_flagged_variants`Â table. We then bind these results together with useful columns of theÂ `denovo_cohort_information`Â table to fetch the offspring'sÂ `sex`,Â `affection_status`, and `file path to the annotated multi-sample VCF`.Â

RPython

```
version <- "/main-programme/main-programme_v19_2024-10-31"

denovo_cohort_sql <-  "SELECT ci.participant_id, ci.trio_id, ci.family_id, ci.sex, ci.affection_status, ci.vcf_path_flagged_denovo,
  fv.chrom, fv.position, fv.reference, fv.alternate
  FROM denovo_flagged_variants
  AS fv
  LEFT JOIN denovo_cohort_information
  AS ci
  ON fv.trio_id = ci.trio_id
  WHERE fv.assembly = 'GRCh38'
  AND fv.stringent_filter = '1'
  AND fv.chrom = '7'
  AND fv.position >= '50303465'
  AND fv.position <= '50405101'
  AND ci.member = 'Offspring'"

de_novo_cohort_query <- labkey_to_df(denovo_cohort_sql)
```

```
version = "/main-programme/main-programme_v19_2024-10-31"

denovo_cohort_sql = "SELECT ci.participant_id, ci.trio_id, ci.family_id, ci.sex, ci.affection_status, ci.vcf_path_flagged_denovo,
  fv.chrom, fv.position, fv.reference, fv.alternate
  FROM denovo_flagged_variants
  AS fv
  LEFT JOIN denovo_cohort_information
  AS ci
  ON fv.trio_id = ci.trio_id
  WHERE fv.assembly = 'GRCh38'
  AND fv.stringent_filter = '1'
  AND fv.chrom = '7'
  AND fv.position >= '50303465'
  AND fv.position <= '50405101'
  AND ci.member = 'Offspring'"

de_novo_cohort_query = labkey_to_df(denovo_cohort_sql)
```

**Example 2:** The remaining phenotype tables can then be joined onto the filtered DNV dataset created above. We now bind the participant's recruited disease using theÂ `normalised_specific_disease`Â column from theÂ `rare_diseases_participant_disease`Â table.Â

RPython

```
version <- "/main-programme/main-programme_v19_2024-10-31"

denovo_cohort_sql <-  "SELECT ci.participant_id, ci.trio_id, ci.family_id, ci.sex, ci.affection_status, ci.vcf_path_flagged_denovo,
  rd.normalised_specific_disease,
  fv.chrom, fv.position, fv.reference, fv.alternate
  FROM denovo_flagged_variants AS fv
  LEFT JOIN denovo_cohort_information AS ci
  ON fv.trio_id = ci.trio_id
  LEFT JOIN rare_diseases_participant_disease AS rd
  ON ci.participant_id = rd.participant_id
  WHERE fv.assembly = 'GRCh38'
  AND fv.stringent_filter = '1'
  AND fv.chrom = '7'
  AND fv.position >= '50303465'
  AND fv.position <= '50405101'
  AND ci.member = 'Offspring'"

de_novo_cohort_query <- labkey_to_df(denovo_cohort_sql)
```

```
version = "/main-programme/main-programme_v19_2024-10-31"

denovo_cohort_sql = "SELECT ci.participant_id, ci.trio_id, ci.family_id, ci.sex, ci.affection_status, ci.vcf_path_flagged_denovo,
  rd.normalised_specific_disease,
  fv.chrom, fv.position, fv.reference, fv.alternate
  FROM denovo_flagged_variants AS fv
  LEFT JOIN denovo_cohort_information AS ci
  ON fv.trio_id = ci.trio_id
  LEFT JOIN rare_diseases_participant_disease AS rd
  ON ci.participant_id = rd.participant_id
  WHERE fv.assembly = 'GRCh38'
  AND fv.stringent_filter = '1'
  AND fv.chrom = '7'
  AND fv.position >= '50303465'
  AND fv.position <= '50405101'
  AND ci.member = 'Offspring'"

de_novo_cohort_query = labkey_to_df(denovo_cohort_sql)
```

October 24, 2024
