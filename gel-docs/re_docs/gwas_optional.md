---
title: 'The GWAS workflow - Optional arguments and defaults - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/gwas_optional/
scraped_at: 2026-05-04T06:32:25Z
---

# The GWAS workflow - Optional arguments and defaults

You can easily change any arguments in the GWAS workflow.

> **Disclaimer:**
>
> As there is active development of the pipeline for ongoing projects, the arguments stated here might become outdated for the latest versions. We will always strive to make this document up-to-date, but if in doubt, you can always verify the active arguments of a particular version that you are running by looking at the following .config files (while changing the version (v.1.2 e.t.c), for the version that you want to run:
>
> ```
> /pgen_int_data_resources/workflows/BRS_tools_GWAS_nf/v.1.2/nextflow.config
> /pgen_int_data_resources/workflows/BRS_tools_GWAS_nf/v.1.2/config_profiles/cluster.config
> /pgen_int_data_resources/workflows/BRS_tools_GWAS_nf/v.1.2/config_profiles/cloud.config
> ```
>
> nextflow.config specifies all major arguments for the pipeline and also additional arguments specific to the HPC cluster or the cloud environment are called with the cluster.config or cloud.config files.

## Changing arguments

To change an argument, add the string with double dash and the value in single quotes, e.g.,

`--traitType 'quantitative'`

To pass an environmental variable, use double quotes for the same effect:

```
#set variable trait in bash
trait=quantitative

#pass the variable as an argument by adding to the nextflow execution script:
--traitType "$trait"
```

## List of process arguments

### gwas\_maskingQC

This process sets genotypes that fail certain criteria to missing (./.), performs QC at the VCF level, and transforms the VCF files to bgen and pgen.

It is turned off by default, as it is usually done once per aggregate as it can be very computationally intensive given that it works on VCF files directly.

| Argument | default | Usage |
| --- | --- | --- |
| `--skip_maskingQC` | true | Set to true to skip masking. Its true (OFF) by default as its very computationally intensive |
| `--min_fmt_dp` | 10 | masking genotype depth for autosomes |
| `--min_fmt_gq` | 20 | masking genotype quality for autosomes |
| `--min_fmt_gq_females` | 20 | masking genotype depth for chrX females |
| `--min_fmt_dp_females` | 10 | masking genotype quality for chrX females |
| `--min_fmt_dp_males` | 5 | masking genotype depth for chrX males |
| `--pvalue_fmt_abratio` | 0.001 | masking AB ratio P-value threshold |
| vcfQC\_additional\_args | `-i \'INFO/OLD_MULTIALLELIC="."\'` | Additional QC parameters at the VCF level. Argument is passed directly toÂ [bcftools](https://samtools.github.io/bcftools/howtos/filtering.html)Â as: bcftools view -i ${params.vcfQC\_additional\_args} Default keeps bi-allelic variants only. |

### vcftopgen

vcftopgen process is activated when input is VCF, but masking is disabled, to create pgen files to pass downstream.

QC at the VCF level is also possible (without having to mask).

| Argument | default | Usage |
| --- | --- | --- |
| `--vcfQC_additional_args` | `-i \'INFO/OLD_MULTIALLELIC="."\'` | Additional QC parameters at the VCF level. Argument is passed directly toÂ [bcftools](https://samtools.github.io/bcftools/howtos/filtering.html)Â as: bcftools view -i ${params.vcfQC\_additional\_args} Default keeps bi-allelic variants only. |
| `--plink_set_missing_var_ids` | @:#*$r*$a | set variant ids when they are missing. Only matters if input is VCF. Corresponds to |
| --set-missing-var-idsÂ command of plink2. |  |  |
| `--plink_new_id_max_allele_len` | 1000 | minimum length of id. Only matters if input is VCF. Corresponds toÂ |
| --new-id-max-allele-lenÂ command of plink2. |  |  |
| `--plink_vcf_half_call` | m | how to deal with vcf half calls. Convert to missing by default. Only matters if input is VCF. Corresponds toÂ  --vcf-half-callÂ command of plink2. |
| `--plinkmem` | 2000 | memory argument for plink |

### gwas\_siteQC

gwas\_siteQC process performs filtering QC at the bgen/pgen/bed level (i.e, files with these formats are generated as necessary. It uses plink2 to make transformations between bgen/pgen/bed formats and plink1.9 to test for differential missingness and HWE.

The process first filters for maf > 0.5% and missingness < 2% by default (change with --siteQCplink\_add\_args).

In the case of binary traits, test for differential missingness is performed (P>1e-5 by default, option --thres\_m) then this is followed by an HWE test that is performed using only unrelated controls (P>1e-6 by default, option --thres\_HWE) and uses females only for testing HWE on chromosome X.

In the case of quantitative traits, the process does not perform a differential missingness test, it performs only an HWE test on unrelated individuals of the whole sample and uses females only for testing HWE on chromosome X.

| Argument | default | Usage |
| --- | --- | --- |
| `--skip_siteQC` | false | Set to true to skip siteQC. Its false by default. |
| `--siteQCplink_add_args` | --maf 0.005 --geno 0.02 | filtering arguments given to plink1.9 for site QC. By default maf>0.005 and missingness < 0.02 |
| `--thres_m` | 0.00001 | differential missingness filter P-value |
| `--thres_HWE` | 0.000001 | HWE on unrelated control filter P-value |
| `--plinkmem` | 2000 | memory argument for plink |

### SAIGE

Arguments for two processes corresponding to the 2-step SAIGE association analysis.

#### gwas\_SAIGE\_fit\_null\_glmm

| Argument | default | Usage |
| --- | --- | --- |
| `--traitType` | binary | Define trait type as binary or quantitative |
| `--saigeStep1ExtraFlags` |  | SAIGE extra flags for controlling step 1 |
| `--rdaFile` | FALSE | Use this argument to provide rdaFile directly if pre-generated. Combine with varianceRatioFile. If provided will skip gwas\_SAIGE\_fit\_null\_glmm. |
| `--varianceRatioFile` | FALSE | Use this argument to provideÂ varianceRatioFile directly if pre-generated. Combine with rdaFile. If provided will skip gwas\_SAIGE\_fit\_null\_glmm. |

#### gwas\_SAIGE\_spa\_tests\_bgen

| Argument | default | Usage |
| --- | --- | --- |
| `--saigeStep2ExtraFlags` |  | SAIGE extra flags for controlling step 2 |

### GCTA

Arguments for two processes corresponding to the 3-step GCTA association analysis.

#### sparseGRM

| Argument | default | Usage |
| --- | --- | --- |
| `--GRM_sparse_cutoff` | 0.05 | relatedness cut-off for creating sparse-grm |

#### gwas\_GCTA\_fit\_null\_glmm

| Argument | default | Usage |
| --- | --- | --- |
| `--sparseGRM` |  | Use this argument to provide precomputed GRM files. If provided, process sparseGRM will be skipped. Provide the files as string in the following way: prefix.{grm.id,grm.sp} |

### Plotting

| Argument | default | Usage |
| --- | --- | --- |
| `--manhattan_Pcutoff` | 1e-50 | collapse Pvalues above threshold |
| `--manhattan_Pylim` | 5e-8 | Â y-axis limit (P-value) |

## List of LSF cluster profile arguments

Arguments that control the cluster submission and error control of the pipeline.

Fitting the null fit for SAIGE and GCTA or inferring the GRM for GCTA sometimes need control of memory and queue and clusterOption arguments to be micromanaged. The arguments below allow this.

| Argument | default | Usage |
| --- | --- | --- |
| **Memory arguments** |  |  |
| `--memory` | 5 GB | default memory for all processes unless specified otherwise. |
| `--memory_nullfit` | 10 GB | Memory for processes: gwas\_SAIGE\_fit\_null\_glmm gwas\_GCTA\_fit\_null\_glmm |
| `--memory_grm` | 80 GB | Memory for processes: sparseGRM (GCTA) |
| `--memory_plotting` | 10 GB | Memory for plotting |
| **Queue arguments** |  |  |
| `--queue` | short | default queue for all processes unless specified otherwise |
| `--queue_nullfit` | short | Queue for processes: gwas\_SAIGE\_fit\_null\_glmm gwas\_GCTA\_fit\_null\_glmm |
| queueGRM | short | queue for processes gwas\_SAIGE\_fit\_null\_glmm gwas\_GCTA\_fit\_null\_glmm |
| `--queue_plotting` | short | Queue for plotting |
| **Cluster options arguments** |  |  |
| `--clusterOptions` | `-P Bio -R rusage[mem=5000] -M 5000` | default submission details for all processes unless specified otherwise |
| `--clusterOptions_nullfit` |  | submission details for processes: gwas\_SAIGE\_fit\_null\_glmm, gwas\_GCTA\_fit\_null\_glmm |
| `--clusterOptions_grm` | `-P Bio -R rusage[mem=80000] -M 80000` | submission for processes: sparseGRM (GCTA) |
| `--clusterOptions_plotting` | `-P Bio -R rusage[mem=10000] -M 10000` | submission for process plotting |
| **errorStrategy arguments** |  |  |
| `--errorStrategy` | 'finish' | default error strategy. Will terminate pipeline in case of error after retrying specified times |
| `--errorStrategy_GRM` | 'finish' | error strategy for processes: gwas\_SAIGE\_fit\_null\_glmm (SAIGE) sparseGRM (GCTA) gwas\_GCTA\_fit\_null\_glmm (GCTA) Will terminate pipeline in case of error after retrying specified times |
| `--errorStrategy_SAIGE_step2` | 'finish' | error strategy for processes: gwas\_SAIGE\_spa\_tests\_bgen (SAIGE) gwas\_GCTA\_spa\_tests\_pgen (GWAS) Will terminate pipeline in case of error after retrying specified times |
| `--errorStrategy_plotting` | 'finish' | error strategy for process plotting. Will terminate pipeline in case of error. |
| `--maxRetries` | 3 | Will terminate pipeline in case of error after retrying specified times |

July 9, 2025
