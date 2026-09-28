---
title: 'Gene centric SNV report for cancer participants - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/gene-centric-snv-report/
scraped_at: 2026-05-04T06:32:09Z
---

# Gene centric SNV report for cancer participants

> **Deprecated:**
>
> The [`cancer_tier_and_domain_variants` table in Labkey](../cancer_tiering/) provides a a readily-accessible and up-to-date version of the data provided by this pipeline. We recommend querying the `cancer_tier_and_domain_variants` table directly, rather than using this script.

## Version control

| version | data release | clinVar |
| --- | --- | --- |
| v1.0-beta | DR11 | March, 2021 |

## Summary

This page describes how to generate a "gene report" for SNVs found in participants of the Genomics England **cancer cohort**.

The report contains counts of all participants with a small genic variant of **moderate or high impact**, as identified by a set of SO terms presented in the description section. It presents a breakdown of participant counts per disease type (censored when <5) and percentage by cancer type, as well as a break down of the variants split by somatic/germline and most common variants for that gene.

The R script to generate this report can be found in:

`~/gel_data_resources/example_scripts/gene-centric-snv-report/v1.0/scripts/01.functions.R`

## Description

The gene report is based on the counts of small genic variant of **moderate or high impact**, as identified by a set of SO terms below, for cancer patients.

| SO term | Consequence type |
| --- | --- |
| SO:0001893 | transcript ablation |
| SO:0001574 | splice\_acceptor\_variant |
| SO:0001575 | splice\_donor\_variant |
| SO:0001587 | stop\_gained |
| SO:0001589 | frameshift\_variant |
| SO:0001578 | stop\_lost |
| SO:0002012 | start\_lost |
| SO:0001889 | transcript\_amplification |
| SO:0001821 | inframe\_insertion |
| SO:0001822 | inframe\_deletion |
| SO:0001650 | inframe\_variant |
| SO:0001583 | missense\_variant |
| SO:0001630 | splice\_region\_variant |

The report defines deleterious variants those that

- causes loss-of-function, i.e.

  1. splice\_acceptor\_variant
  2. splice\_donor\_variant
  3. start\_lost
  4. stop\_lost
  5. stop\_gained
  6. frameshift\_variant
  7. inframe\_insertion
  8. inframe\_variant

  or are reported as
- pathogenic/ likely pathogenic in ClinVar (for version, see Version Control box above)

Finally, some participants will have more than one sample. Similarly, some will carry more than one mutation on the query gene. Nonetheless, the script counts each participant only once, except when it is clearly counting the different variants.

### Hypothetical example:

Say that for a given query gene, we have the following variants in our database:

| participant | sample | variant |
| --- | --- | --- |
| 1 | 1.1 | c.196del |
| 1 | 1.2 | - |
| 1 | 1.3 | c.180A>T |
| 1 | 1.3 | c.196del |
| 2 | 1.1 | c.196del |

The resulting counts will be as follows:

- two patients with mutations on the query gene.
- c.196del: 2, c.180A>T: 1

## Usage

The code was developed to work with R/4.0.2, so inside the RE, open a terminal and run:

```
$ module load R/4.0.2
$ rstudio
```

### Single queries

Then inside RStudio, source the script, load the SNVdb (only once), and query for your genes of interest, one at a time:

```
source("~/gel_data_resources/example_scripts/gene-centric-snv-report/v1.0/scripts/01.functions.R")

db <- loadSNVdb()
brca1 <- queryGene(gene_name = "BRCA1")
brca2 <- queryGene(gene_name = "BRCA2")
```

The output will be two files: one with summary counts (summary\_*gene\_name*.txt) and one with the full data to conduct further analysis as required (data\_*gene\_name*.tsv), where *gene\_name* is the queried gene.

### Multiple queries

Have a list of genes in a flat file, i.e. **gene\_list.txt**:

```
BRCA1
BRCA2
NTRK1
```

Then inside RStudio, source the script, load the SNVdb (only once), and load your **gene\_list.txt**:

```
# Source script, load SNVdb and your gene_list.txt
source("~/gel_data_resources/example_scripts/gene-centric-snv-report/v1.0/scripts/01.functions.R")
db <- loadSNVdb()
gene_list <- readLines("gene_list.txt")

## query all genes in the gene_list, concatenate and save results.
data <- lapply(gene_list, function(x){queryGene(x, saveData = F)}) %>% bind_rows()
write_tsv(data, 'my_data.tsv')
```

The output will be: one with summary counts (summary\_*gene\_name*.txt) per gene and one with the full data (concatenated for all genes) to conduct further analysis as required (my\_data.tsv).

## Input

loadSNVdb() does not require any input. Saving the output (as above) in a variable db will avoid referring to it again.

queryGene() will accept the following arguments:

| argument | type | default | description |
| --- | --- | --- | --- |
| gene\_name | required | - | string argument, name of the (ONE) gene to be queried for. Use uppercase letters. E.g. "BRCA1" or "NTRK3". |
| variant | optional | NULL | character, it accepts one string or vector of string with the changes observed in the protein level. This is the description part of [HGVS simple](https://varnomen.hgvs.org/bg-material/simple/). E.g.: c("c.1961del", "c.3708T>G") |
| relevance\_type | optional | c("(likely)pathogenic", "other", "LoF", "path\_LoF") | character, it accepts one string or vector of strings with variant relevance. Select at least one of the default values. For any deleterious variant use: c("(likely)pathogenic", "LoF", "path\_LoF") Types are:  \* LoF: variants that cause a loss-of function, i.e. a variant with one of the following consequences according to CellBase: splice\_acceptor\_variant, splice\_donor\_variant, start\_lost, stop\_lost, stop\_gained, frameshift\_variant, inframe\_insertion, inframe\_variant.  \* (likely)pathogenic: pathogenic or likely pathogenic on ClinVar.  \* path\_LoF: LoF AND (likely)pathogenic.  \* other: nor LoF or (likely)pathogenic. |

## Output

**summary\_gene\_name.txt** presents summary information split into three parts:

1. Overview counts, including  
   **N**: total number of patients with any small genic variant of **moderate or high impact** mutations on the query gene  
   **D**: number of patients with any deleterious mutations on the query gene  
   **S**: total number of patients with any somatic deleterious mutations on the query gene  
   **G**: total number of patients with any germline deleterious mutations on the query gene
2. Break-down by variant, including  
   **n.deleterious**: total number of patients with any deleterious mutations on the query gene per disease type  
   **p.deleterious**: percent of patients with any deleterious mutations on the query gene per disease type  
   **n.total**: total number of patients with any non-synonymous, splice site and RNA gene variants mutations on the query gene per disease type  
   **p.total**: percent of patients with any non-synonymous, splice site and RNA gene variants mutations on the query gene per disease type
3. Most common variants across all disease type, including  
   change: as seen in the protein level  
   consequence: as predicted by CellBase  
   clinical\_relevance: pathogenic or likely pathogenic if listed in Clinvar as such. Empty otherwise.
   n: counts

Note that only counts > five are included in the report, across all of the above parts.

Example of summary file (the numbers shown below are synthetic):

```
Gene: BRCA1
Variant(s):
Relevance: (likely)pathogenic, other, LoF, path_LoF

N: Total participants with at least one mutation on the query gene
D: Number of participants with at least one mutation on the query gene that causes loss-of-function and/or is pathogenic/likely pathogenic in ClinVar (March 2021)
S: Number of participants with at least one (likely) pathogenic/LoF somatic mutation on the query gene
G: Number of participants with at least one (likely) pathogenic/LoF germline mutation on the query gene. (Only reported if gene is internally listed as relevant for solid/blood tumour(s).)
Deleterious: a variant that is at least one of the following: likely pathogenic/ pathogenic on ClinVar, or have a consequence that according to CellBase causes loss-of-function, i.e. splice_acceptor_variant, splice_donor_variant, stop_gained, frameshift_variant, start_lost, stop_lost, inframe_deletion, inframe_insertion.)

N = 500
PL = 300

S = 150
G = 75

###### Counts per indications (all with n > five)
disease_type    n.deleterious   p.deleterious   n.total p.total
OVARIAN                         33  10.1    67  12.5
ENDOMETRIAL_CARCINOMA           77  6.2     99  9.7
COLORECTAL                      55  2.5     132 7.8
...

###### Variants (all with n > five)
change  consequence clinical_significance   n
c.1961del       frameshift_variant  Pathogenic  33
c.3708T>G       missense_variant                12
c.68_69del      frameshift_variant               7
c.1846_1848del  inframe_deletion                 4
```

**data\_gene\_name.tsv** contains all queried variants (filtered accordingly if variants and relevance\_type arguments have been used, but multiple patient sample presented), in a table format where:

1. participant\_id: Genomics England unique participant identifier
2. tumour\_sample\_platekey: somatic sample identifier
3. disease\_type: cancer type
4. type: somatic/ germline
5. gene: gene\_name
6. change: protein level alteration
7. consequence: as predicted by CellBase
8. clinical\_significance: pathogenic or likely pathogenic if listed in ClinVar as such
9. relevance: a combination of 7 and 8 (see input for more details.)

#### Details on loadSNVdb

The SNVdb loaded by the function is a compilation of all non-synonymous, splice site and RNA gene SNV variants found per sample for the participants in the cancer programme. Somatic variants are listed for all genes, germline variants are listed only for genes with indication of cancer predisposition as listed by [Genomics England PanelApp](https://panelapp.genomicsengland.co.uk). These are listed per sample as a csv file and generated by our internal cancer analysis team. The paths for the individual .csv files are provided in the cancer\_analysis table in LabKey.

The data is complemented with a recent version (March, 2021) of ClinVar pathogenic and likely pathogenic variants.

## Exporting your gene centric SNV report

The gene centric SNV report has been designed so that it does not contain any identifiable data, for example by masking counts less than five. For this reason, you should be able to export your report; all exports **must** be via [Airlock](../airlock/), you **must not** copy the report by hand.

## Help and support

Please reach out via the [Genomics England Service Desk](../help/) for any issues related to running this script, including "gene-centric-cancer-SNV-report" in the title/description of your inquiry.

October 24, 2024
