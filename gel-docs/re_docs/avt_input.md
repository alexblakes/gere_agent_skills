---
title: 'AVT detailed input file overview - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/avt_input/
scraped_at: 2026-05-04T06:31:20Z
---

# AVT detailed input file overview

The input file is broken down into seven sections. Each section details a related set of inputs, e.g. saige-gene settings.

## Section 1 - Setup

These settings define who you areÂ (for HPC usage), the name and genome build of the cohort, and a set of reference files that point to the genomic and functional annotation data for the cohort.

| Setting name | Description | Example value | Mandatory? |
| --- | --- | --- | --- |
| lsf\_project\_code | The project code needed to run jobs on the HPC. Full list is located at [LSF Project Codes](../lsf_codes/). Only relevant when running in the RE, not CloudRE | `re_gecip_cardiovascular` | Mandatory |
| cohort\_name | Name for your cohort that is described by the variable 'cohort\_file\_lists'. | `"aggV2"` | Mandatory |
| cohort\_genome\_build | The genome build that your cohort is aligned to. This is used later to fetch the correct gene positions. | `"GRCh38"` | Mandatory |
| cohort\_file\_lists | This setting defines a cohort, with three associated file options. Each cohort described here must have a unique name.  'cohort\_functional\_annotation\_file\_list' is mandatory.  *cohort\_bgen\_file\_list is a filepath to a 3-column tsv, where the columns are file.bgen, file.sample, file.bgen.bgi*  cohort\_pgen\_file\_list is a filepath to a 3-column tsv, where the columns are file.pgen, file.psam, file.pvar \* cohort\_functional\_annotation\_file\_list is a filepath to a 2-column tsv, where the columns are file.vcf, file.vcf.{tbi,csi} One of either 'cohort\_bgen\_file\_list' or 'cohort\_pgen\_file\_list' must be supplied, and the other must be left as "". | See example input settings for section 1. |  |
| run\_saige | Controls whether to run SAIGE-GENE for burden testing. Independent of Regenie i.e. both can be set to true. | `true` | Not Mandatory |
| run\_regenie | Controls whether to runÂ Regenie for burden testing. Independent ofÂ SAIGE-GENE i.e. both can be set to true. | `false` | Not Mandatory |

> **Note:**
>
> If both 'run\_saige' and 'run\_regenie' are set to false, then the workflow will not run any association analyses, and just output the results of the first step, i.e. a list of variants that pass functional filtering.

Example input settings for section 1

```
"master_aggregate_variant_testing.lsf_project_code": "bio",
"master_aggregate_variant_testing.cohort_name": "aggV2",
"master_aggregate_variant_testing.cohort_genome_build": "GRCh38",

"master_aggregate_variant_testing.cohort_file_lists": {
    "aggV2": {
        "cohort_bgen_file_list": "",
        "cohort_pgen_file_list": "aggV2_pgen_file_list.txt",
        "cohort_functional_annotation_file_list": "aggV2_functional_annotation_list.txt"
    },
    "custom_cohort": {
        "cohort_bgen_file_list": "custom_cohort_bgen_list.txt",
        "cohort_pgen_file_list": "",
        "cohort_functional_annotation_file_list": "custom_cophort_functional_annotation_list.txt"
    }
},

"master_aggregate_variant_testing.run_saige": true,
"master_aggregate_variant_testing.run_regenie": false,
```

## Section 2 - Input and output definition

This section defines all the input and output files that you need to change or be aware of for running the workflow.

| Setting name | Description | Example value | Mandatory? |
| --- | --- | --- | --- |
| output\_file\_name | The suffix for the output test statistics that are produced by saige-gene or regenie. The workflow will prefix this name with the phenotype, program and mask used. | `"output.txt"` | Mandatory |
| phenotype\_input\_file | Filepath that points to the phenotype file that you wish to use for the analysis. This should be a table using the column separators of your choice, and should contain a column of sample identifiers (e.g. platekey or IID), one or more phenotype columns, and all columns that you want to use as covariates.  *For binary traits, cases should be coded as 1 and controls should be coded as 0.*  This workflow might work for quantitative traits, but they have not been tested. | `"/path/to/pkd_cohort.txt"` | Mandatory |
| phenotype\_column\_delimiter | The delimiter used to separate columns in your phenotype file. Good choices for readability are spaces or tabs. | `"\t"` | Mandatory |
| phenotype\_sample\_column | The column in the phenotype file that lists the sample identifiers for each participant in the cohort. | `"plate_key"` | Mandatory |
| phenotype\_array\_for\_testing | An array that lists all the different phenotypes that you wish to test in your cohort. Can have one or more comma separated entries. Each phenotype is tested in parallel. Each phenotype in the array must correspond to a column in your phenotype file. | `"pkd"` | Mandatory |
| sex\_column | The name of the column that records the sex of each sample. These are coded values that typically encode male as 0 and female as 1 | `"sex"` | Mandatory |
| male\_coding | How males are coded in the sex column. | `0` | Mandatory |
| covarColList | A comma separated list of all covariates that you wish to include in the model for testing. Each covariate listed must be a column in the phenotype file. Not all covariate columns in the phenotype file need to be used as covariates in the test. | `"age,sex,pc1,pc2"` | Mandatory |
| chrX\_female\_only\_cohort | deprecate? | `false` | Mandatory |
| chrX\_male\_only\_cohort | deprecate? | false | Mandatory |
| chromosomes\_input\_file | A filepath that points to the chromosome input file. Please only provide ONE of chromosome, gene, region or variant input files. | `"/path/to/chromosomes.txt"` | Not Mandatory |
| genes\_input\_file | A filepath that points to the genes input file. Please only provide ONE of chromosome, gene, region or variant input files. | `"/path/to/genes.txt"` | Not Mandatory |
| coordinates\_input\_file | A filepath that points to the region input file. Please only provide ONE of chromosome, gene, region or variant input files. | `"/path/to/coordinates.bed"` | Not Mandatory |
| variant\_input\_file | A filepath that points to the variant input file. Please only provide ONE of chromosome, gene, region or variant input files. | `"/path/to/variants.tsv"` | Not Mandatory |
| gene\_exclusion\_file | A filepath that points to a gene exclusion file. | `"/path/to/exclude_genes.tsv"` | Not Mandatory |
| variant\_exclusion\_file | A filepath that points to a variant exclusion file. | `"/path/to/exclude_variants.tsv"` | Not Mandatory |
| precomputed\_plink\_files\_for\_grm | An array that lists the filepaths to the .bed, .bim and .fam files that contain the high quality common and rare variants that are needed by SAIGE-GENE for GRM creation and variance estimation, and by REGENIE for PRS estimation. Details on how these were created for aggV2 can be found [here](../aggv2/). | See the example input for section 2 | Mandatory |

> **Note:**
>
> Set all unneeded file inputs to null.

Example input settings for section 2

```
"master_aggregate_variant_testing.output_file_name": "output.txt",

"master_aggregate_variant_testing.phenotype_input_file": "/re_gecip/BRS/example.pheno",
"master_aggregate_variant_testing.phenotype_column_delimiter": "\t",
"master_aggregate_variant_testing.phenotype_sample_column": "plate_key",
"master_aggregate_variant_testing.phenotype_array_for_testing": ["pkd"],
"master_aggregate_variant_testing.sex_column": "sex",
"master_aggregate_variant_testing.male_coding": 0,
"master_aggregate_variant_testing.covarColList": "ancestry,age,sex,age2,age.sex,PC1,PC2,PC3,PC4,PC5,PC6,PC7,PC8,PC9,PC10,PC11,PC12,PC13,PC14,PC15,PC16,PC17,PC18,PC19,PC20",

"master_aggregate_variant_testing.chrX_female_only_cohort": false,
"master_aggregate_variant_testing.chrX_male_only_cohort": false,

"master_aggregate_variant_testing.part_1_variant_selection.chromosomes_input_file": "input_user_data/chromosomes.txt",
"master_aggregate_variant_testing.part_1_variant_selection.genes_input_file": null,
"master_aggregate_variant_testing.part_1_variant_selection.coordinates_input_file": null,
"master_aggregate_variant_testing.part_1_variant_selection.variant_input_file": null,
"master_aggregate_variant_testing.part_1_variant_selection.gene_exclusion_file": null,
"master_aggregate_variant_testing.part_1_variant_selection.variant_exclusion_file": null,

"master_aggregate_variant_testing.precomputed_plink_files_for_grm": [
    "/re_gecip/BRS/genomicc_data/WGS_analysis/aggregate_variant_tests/aggCOVID_V2/output/EUR/loftee_hc/snps_only/chr1/glob-7b047a45b923da427eab0cce842a1ad3/plink_set_for_tests_all_samples.bed",
    "/re_gecip/BRS/genomicc_data/WGS_analysis/aggregate_variant_tests/aggCOVID_V2/output/EUR/loftee_hc/snps_only/chr1/glob-7b047a45b923da427eab0cce842a1ad3/plink_set_for_tests_all_samples.bim",
    "/re_gecip/BRS/genomicc_data/WGS_analysis/aggregate_variant_tests/aggCOVID_V2/output/EUR/loftee_hc/snps_only/chr1/glob-7b047a45b923da427eab0cce842a1ad3/plink_set_for_tests_all_samples.fam"
],
```

## Section 3 - Functional filtering

This section is all about the various settings to filter variants based on their functional annotation attributes. Only variants that pass at least one of these filters will be included in downstream analysis.

| Setting Name | Description | Example Value | Mandatory? |
| --- | --- | --- | --- |
| use\_snps\_only | A true/false flag to set if you want to analyse SNP variants only, or if you want to include INDEL variants as well | `true` | Mandatory |
| use\_vep\_filtering | A true/false flag to set if you want to perform functional annotation filtering. Generally set to true unless you already have a variant list that you do not wish to perform any additional filtering on. | `true` | Mandatory |
| use\_ensembl\_protein\_coding\_genes\_only | A true/false flag to set if you want to restrict your analysis to genes that have the biotype protein\_coding in Ensembl. Setting to false will include genes of all biotypes, e.g. lncRNA. | `true` | Mandatory |
| use\_genes\_only | A true/false flag to set if you are analysing Ensembl defined genes only, or you wish to include custom regions that lie outside / overlap genes. | `true` | Mandatory |
| functional\_annotation\_filter\_masks | This setting details the various 'masks' that are used to bin each variant. The format for each mask section is as follows: \* Mask name  \* AND filter settings - any variant will have to pass ALL filters in this section to be included  \* Zero or more specific filters  \* OR filter settings - any variant will have to pass ANY filter in this section to be included  \* Zero or more specific filters The rules that govern the functional filtering are:  \* Any annotation in the CSQ section of the functional annotation VCF can be used as an annotation to filter on. This is done by `bcftools +split-vep` internally.  \* The AND and OR filters are themselves combined with AND, therefore a variant must pass all filters in the AND block, AND one or more filters in the OR block.  \* If the annotation field annotation and the VEP severity field `vep_severity_to_include` are empty, the filter is skipped. Leaving filters empty does not impact the running of the workflow.  \* `vep_severity_to_include` operates in an identical manner to `bcftools +split-vep -s`. You can specify an exact consequence, e.g. `stop_gained`, and only variants with that consequence will be retained. Alternatively, you can specify a consequence or worse, e.g. `missense+`, to include all variants that are at least as severe as `missense`. If it is left blank, then all consequences will be considered.  \* `include_missing` can be set to `no` or `yes`. If set to `no` then only variants that pass the filter will be included. If set to `yes` then variants that pass the filter and variants that are annotated with missing entries by VEP i.e. '.', '-' or '' will be included. This can be useful for example when wanting to filter on CADD\_PHRED scores and also include INDELs, as many INDELs do not have a CADD\_PHRED score.  \* Comparators can be >, >=, ==, <=, < for float values, or == for string values. The workflow will exit with an error if the wrong comparator type is detected. Make sure to give each filter a unique name WITHIN the AND and OR blocks for each mask. Having the same name for multiple filters means that some filters will get skipped, and lead to confusing output. | See the example input in section 3 | Not mandatory |
| mask\_rank | This setting defines the order of the strictness for each mask, so that a variant is assigned to the correct mask in the case that is passes multiple. The lower the number, the more strict the mask is. | See the example input in section 3 | Not mandatory |
| regenie\_masks | This setting defines which masks can be grouped together when testing with REGENIE. | See the example input in section 3 | Not mandatory. |

Example input settings for section 3

```
"master_aggregate_variant_testing.part_1_variant_selection.use_snps_only": true,
"master_aggregate_variant_testing.part_1_variant_selection.use_vep_filtering": true,
"master_aggregate_variant_testing.part_1_variant_selection.use_ensembl_protein_coding_genes_only": true,
"master_aggregate_variant_testing.use_genes_only": true,

"master_aggregate_variant_testing.part_1_variant_selection.functional_annotation_filter_masks": {
    "LoF": {
        "and_mask": {
            "filter1": {"annotation": "LoF", "comparator": "==", "condition": "HC", "include_missing": "no", "vep_severity_to_include": ""}
        },
        "or_mask": {
            "filter1": {"annotation": "", "comparator": "", "condition": "","include_missing": "","vep_severity_to_include": ""}
        }
    },
    "missense": {
        "and_mask": {
            "filter1": {"annotation": "", "comparator": "", "condition": "","include_missing": "", "vep_severity_to_include": ""}
        },
        "or_mask": {
            "filter1": {"annotation": "CADD_PHRED",  "comparator": ">=", "condition": "10","include_missing": "no", "vep_severity_to_include": "missense+"},
            "filter2": {"annotation": "LoF",  "comparator": "==", "condition": "HC", "include_missing": "no", "vep_severity_to_include": ""}
        }
    },
    "synonymous": {
        "and_mask": {
            "filter1": {"annotation": "Consequence", "comparator": "==", "condition": "synonymous_variant", "include_missing": "no", "vep_severity_to_include": ""}
        },
        "or_mask": {
            "filter1": {"annotation": "", "comparator": "", "condition": "", "include_missing": "", "vep_severity_to_include": ""}
        }
    }
},

"master_aggregate_variant_testing.part_1_variant_selection.mask_rank": {
    "LoF": 1,
    "missense": 2,
    "synonymous": 3
},

"master_aggregate_variant_testing.part_2_regenie_testing.regenie_masks": {
    "strict_lof": "LoF",
    "mild_lof": "LoF,missense",
    "control": "synonymous"
},
```

## Section 4 - Site wide variant filtering

This section describes the filters used for site-wide filtering of variants.

| Setting name | Description | Example value | Mandatory? |
| --- | --- | --- | --- |
| differential\_missing\_pvalue | The p-value threshold for testing differential missingness between cases and controls. Sites that have a smaller p-value than this setting will be removed. | `10e-5` | Mandatory |
| upstream\_downstream\_length | A value in basepairs that allows for padding of input regions. For example, you may wish to pad genes by 10kb to potentially capture regulatory regions. Set to 0 by default. | `10000` | Mandatory |
| use\_max\_mac | A true/false setting on whether to use the minor allele count as the upper bound for rare variant filtering. Useful for capturing very rare variants in large cohorts. | `false` | Mandatory |
| final\_max\_mac\_to\_exclude | The maximum MAC for variants to include, if using the use\_max\_mac setting. Variants with a higher MAC than this value will be removed. | `20` | Mandatory |
| use\_max\_maf | A true/false setting on whether to use the minor allele frequency as the upper bound for rare variant filtering. Useful for capturing rare variants in small cohorts. | `true` | Mandatory |
| final\_max\_maf\_to\_include | The maximum MAF for variants to include if using the use\_max\_maf setting. Variants with a higher MAF than this value will be removed. | `0.005` | Mandatory |
| max\_missingness | The upper threshold for missing data for each site. Sites that have a higher percentage of missing values than this value will be excluded. | `0.05` | Mandatory |
|  |  |  |  |

> **Note:**
>
> Use only one of MAC of MAF for filtering.
>
> MAF filtering is generally better for small cohorts, where a MAC of 20 might actually correspond to a MAF of 1% or more.

Example input settings for section 4

```
"master_aggregate_variant_testing.differential_missingness_pvalue": "10e-5",
"master_aggregate_variant_testing.part_1_variant_selection.upstream_downstream_length": 0,
"master_aggregate_variant_testing.part_1_variant_selection.use_max_mac": false,
"master_aggregate_variant_testing.part_1_variant_selection.final_max_mac_to_exclude": 20,
"master_aggregate_variant_testing.part_1_variant_selection.use_max_maf": true,
"master_aggregate_variant_testing.part_1_variant_selection.final_max_maf_to_exclude": 0.005,
"master_aggregate_variant_testing.part_1_variant_selection.max_missingness": 0.05,
```

## Section 5 - SAIGE-GENE settings

These settings allow you to tweak various aspects of SAIGE-GENE at runtime. Most settings have been left at the default value recommended by the developers. We recommend only changing these settings if you have used SAIGE-GENE in the past. For more information on these options please consult [the SAIGE-GENE documentation](https://github.com/weizhouUMICH/SAIGE/wiki/Genetic-association-tests-using-SAIGE).

> **Note:**
>
> Settings that are not present in the table below, but are present in the program are handled internally, such as input files and output files.

| Setting name | Description | Example value | Mandatory? |
| --- | --- | --- | --- |
| LOCO | A true/false setting for using leave-one-chromosome-out when testing with SAIGE-GENE | `"FALSE"` | Mandatory |
| saige\_setp0\_options | The settings used to build the sparse GRM that is used for SAIGE-GENE. This should be left as default. | See the example input in section 5 | Mandatory |
| saige\_step1\_options | The settings that are used to fit the null GLMM in SAIGE-GENE. Most of these can be left as default.  *To perform rare variant testing, `IsSparseKin` should be left as `TRUE`*  `MaleCode` and `FemaleCode` should be set to the same values as in your phenotype file (0,1 by default) `traitType` can be set to `quantitative` and `invNormalize` can be set to `true` to test for quantitative traits. Note that this setting has not been tested in this workflow, and may not work. | See the example input in section 5 | Mandatory |
| saige\_step2\_options | The settings that are used for running the rare variant tests in SAIGE-GENE. Most can be left as default. \* `method_to_CollapseUltraRare` implements SAIGE-GENE+ when set to `absence_or_presence`. To disable this, set to '' (an empty string). | See the example input in section 5. | Mandatory |

Example input settings for section 5

```
"master_aggregate_variant_testing.part_2_saige_testing.LOCO": "FALSE",

"master_aggregate_variant_testing.part_2_saige_testing.saige_step0_options": [
    "--relatednessCutoff=0.125",
    "--numRandomMarkerforSparseKin=2000"
],

"master_aggregate_variant_testing.part_2_saige_testing.saige_step1_options": [
    "--IsSparseKin='TRUE'",
    "--traitType='binary'",
    "--invNormalize='FALSE'",
    "--outputPrefix='null_glmm'",
    "--outputPrefix_varRatio='null_glmm_var_ratio'",
    "--minMAFforGRM=0.01",
    "--sexCol=''",
    "--FemaleCode='1'",
    "--FemaleOnly='FALSE'",
    "--MaleCode='0'",
    "--MaleOnly='FALSE'",
    "--noEstFixedEff='FALSE'",
    "--tol=0.02",
    "--maxiter=20",
    "--tolPCG=1e-5",
    "--maxiterPCG=500",
    "--SPAcutoff=2",
    "--numRandomMarkerforVarianceRatio=30",
    "--skipModelFitting='FALSE'",
    "--tauInit='0,0'",
    "--traceCVcutoff=0.0025",
    "--ratioCVcutoff=0.001",
    "--isCateVarianceRatio='TRUE'",
    "--isCovariateTransform='TRUE'",
    "--cateVarRatioMinMACVecExclude='0.5,1.5,2.5,3.5,4.5,5.5,10.5,20.5'",
    "--cateVarRatioMaxMACVecInclude='1.5,2.5,3.5,4.5,5.5,10.5,20.5'",
    "--useSparseSigmaforInitTau='FALSE'",
    "--minCovariateCount=-1",
    "--includeNonautoMarkersforVarRatio='FALSE'",
    "--memoryChunk=2"
],
"master_aggregate_variant_testing.part_2_saige_testing.saige_step2_options": [
    "--IsDropMissingDosages='FALSE'",
    "--IsSparse='TRUE'",
    "--IsOutputAFinCaseCtrl='TRUE'",
    "--IsOutputNinCaseCtrl='TRUE'",
    "--IsOutputHetHomCountsinCaseCtrl='TRUE'",
    "--IsSingleVarinGroupTest='TRUE'",
    "--IsOutputPvalueNAinGroupTestforBinary='TRUE'",
    "--IsAccountforCasecontrolImbalanceinGroupTest='TRUE'",
    "--IsOutputBETASEinBurdenTest='TRUE'",
    "--is_rewrite_XnonPAR_forMales='FALSE'",
    "--minMAF=0",
    "--maxMAFforGroupTest=0.5",
    "--minMAC=0",
    "--numLinesOutput=10000",
    "--condition=''",
    "--kernel='linear.weighted'",
    "--method='optimal.adj'",
    "--weights.beta.rare=1,25",
    "--weights.beta.common=1,25",
    "--weightMAFcutoff=0.01",
    "--r.corr=0",
    "--dosageZerodCutoff=0.2",
    "--weightsIncludeinGroupFile='FALSE'",
    "--weights_for_G2_cond=''",
    "--SPAcutoff=2",
    "--chrom=chr1",
    "--method_to_CollapseUltraRare='absence_or_presence'",
    "--MACCutoff_to_CollapseUltraRare=10",
    "--DosageCutoff_for_UltraRarePresence=0.5"
],
```

## Section 6 - Regenie settings

These settings allow you to tweak various aspects of Regenie at runtime. Most settings have been left as defaults. Check https://rgcgithub.github.io/regenie/options/#burden-testing for a full list of options.

| Setting name | Description | Example value | Mandatory? |
| --- | --- | --- | --- |
| regenie\_step1\_options | Options for step 1 of REGENIE. | See the example inputs in section 6 | Mandatory |
| regenie\_step2\_options | Options for step 2 of REGENIE. | See the example inputs in section 6 | Mandatory |

Example input settings for section 6

```
"master_aggregate_variant_testing.part_2_regenie_testing.regenie_step1_options": [
    "--step 1",
    "--bt",
    "--lowmem",
    "--lowmem-prefix .",
    "--bsize 1000",
    "--ref-first",
    "--loocv"
],
"master_aggregate_variant_testing.part_2_regenie_testing.regenie_step2_options": [
    "--step 2",
    "--minMAC 1",
    "--aaf-bins 0.005",
    "--build-mask 'max'",
    "--bt",
    "--firth --approx",
    "--firth-se",
    "--bsize 1000",
    "--ref-first",
    "--singleton-carrier"
],
```

## Section 7 - Workflow resources

This section details workflow resources. You should NOTÂ change these, with the possible exception of CPU and memory settings - if the workflow is crashing due to lack of resources.

> **Warning:**
>
> Changing any setting apart from CPU and memory settings will almost guarantee that the workflow will break. Lowering CPU and memory requirements too far will also break the workflow.

Example input settings for section 7

```
"master_aggregate_variant_testing.tools_container": "quay.io/alexander-stuckey/gwas_avt",
"master_aggregate_variant_testing.part_2_saige_testing.saige_container": "quay.io/alexander-stuckey/saige:0.44.6.5",
"master_aggregate_variant_testing.part_2_regenie_testing.regenie_container": "quay.io/alexander-stuckey/regenie",

"master_aggregate_variant_testing.genome_build_to_ensembl_coordinates_files": {
    "GRCh37": "resources/Ensembl_87_genes_coordinates_GRCh37.tsv",
    "GRCh38": "resources/Ensembl_98_genes_coordinates_GRCh38.tsv"
},
"master_aggregate_variant_testing.part_1_variant_selection.vep_severity_scale": "resources/vep_severity_scale_2020_bcftools_splitvep.txt",

"master_aggregate_variant_testing.pheno_plink_helper_python_script": "resources/pheno_helper_script.py",
"master_aggregate_variant_testing.part_1_variant_selection.python_input_filtering_script": "resources/input_filtering.py",
"master_aggregate_variant_testing.part_1_variant_selection.vep_severity_scale_ensembl_translation": "resources/vep_severity_scale_translation_2020_Ensembl_to_bcftools_splitvep.tsv",
"master_aggregate_variant_testing.part_1_variant_selection.vep_filtering_python_script": "resources/vep_filtering_script.py",
"master_aggregate_variant_testing.part_1_variant_selection.vep_severity_bcftools_translation_and_ranking": "resources/vep_severity_bcftools_translation_and_ranking.tsv",

"master_aggregate_variant_testing.part_1_variant_selection.variant_extraction_threads": 4,
"master_aggregate_variant_testing.part_1_variant_selection.variant_extraction_memory": 16000,

"master_aggregate_variant_testing.part_2_saige_testing.saige_step_0_threads": 8,
"master_aggregate_variant_testing.part_2_saige_testing.saige_step_0_memory": 16000,
"master_aggregate_variant_testing.part_2_saige_testing.saige_step_1_threads": 8,
"master_aggregate_variant_testing.part_2_saige_testing.saige_step_1_memory": 16000,
"master_aggregate_variant_testing.part_2_saige_testing.saige_filter_differential_missingness_cpus": 1,
"master_aggregate_variant_testing.part_2_saige_testing.saige_filter_differential_missingness_memory": 4000,
"master_aggregate_variant_testing.part_2_saige_testing.saige_create_GRM_threads": 4,
"master_aggregate_variant_testing.part_2_saige_testing.saige_create_GRM_memory": 20000,
"master_aggregate_variant_testing.part_2_saige_testing.saige_step_2_threads": 4,
"master_aggregate_variant_testing.part_2_saige_testing.saige_step_2_memory": 64000,

"master_aggregate_variant_testing.part_2_regenie_testing.regenie_filter_GRM_cpus": 1,
"master_aggregate_variant_testing.part_2_regenie_testing.regenie_filter_GRM_memory": 8000,
"master_aggregate_variant_testing.part_2_regenie_testing.regenie_step_1_cpus": 8,
"master_aggregate_variant_testing.part_2_regenie_testing.regenie_step_1_memory": 16000,
"master_aggregate_variant_testing.part_2_regenie_testing.regenie_create_set_filter_diff_missing_cpus": 2,
"master_aggregate_variant_testing.part_2_regenie_testing.regenie_create_set_filter_diff_missing_memory": 32000,
"master_aggregate_variant_testing.part_2_regenie_testing.regenie_step_2_cpus": 2,
"master_aggregate_variant_testing.part_2_regenie_testing.regenie_step_2_memory": 16000
```

## The full input file

The full input file

``` bash linenums="1"
{
"master\_aggregate\_variant\_testing.lsf\_project\_code": "bio",

```
"master_aggregate_variant_testing.cohort_name": "aggV2",
"master_aggregate_variant_testing.cohort_genome_build": "GRCh38",

"master_aggregate_variant_testing.cohort_file_lists": {
    "aggV2": {
        "cohort_bgen_file_list": "example_bgen_list.txt",
        "cohort_pgen_file_list": "",
        "cohort_functional_annotation_file_list": "example_functional_list.txt"
    }
},

"master_aggregate_variant_testing.run_saige": true,
"master_aggregate_variant_testing.run_regenie": false,

"master_aggregate_variant_testing.output_file_name": "output.txt",

"master_aggregate_variant_testing.phenotype_input_file": "/re_gecip/BRS/example.pheno",
"master_aggregate_variant_testing.phenotype_column_delimiter": "\t",
"master_aggregate_variant_testing.phenotype_sample_column": "plate_key",
"master_aggregate_variant_testing.phenotype_array_for_testing": ["covid"],
"master_aggregate_variant_testing.sex_column": "sex",
"master_aggregate_variant_testing.male_coding": 0,
"master_aggregate_variant_testing.covarColList": "ancestry,age,sex,age2,age.sex,PC1,PC2,PC3,PC4,PC5,PC6,PC7,PC8,PC9,PC10,PC11,PC12,PC13,PC14,PC15,PC16,PC17,PC18,PC19,PC20",

"master_aggregate_variant_testing.chrX_female_only_cohort": false,
"master_aggregate_variant_testing.chrX_male_only_cohort": false,

"master_aggregate_variant_testing.part_1_variant_selection.chromosomes_input_file": "input_user_data/chromosomes.txt",
"master_aggregate_variant_testing.part_1_variant_selection.genes_input_file": null,
"master_aggregate_variant_testing.part_1_variant_selection.coordinates_input_file": null,
"master_aggregate_variant_testing.part_1_variant_selection.variant_input_file": null,
"master_aggregate_variant_testing.part_1_variant_selection.gene_exclusion_file": null,
"master_aggregate_variant_testing.part_1_variant_selection.variant_exclusion_file": null,

"master_aggregate_variant_testing.part_1_variant_selection.use_snps_only": true,
"master_aggregate_variant_testing.part_1_variant_selection.use_vep_filtering": true,
"master_aggregate_variant_testing.part_1_variant_selection.use_ensembl_protein_coding_genes_only": true,
"master_aggregate_variant_testing.use_genes_only": true,

"master_aggregate_variant_testing.part_1_variant_selection.functional_annotation_filter_masks": {
    "LoF": {
        "and_mask": {
            "filter1": {"annotation": "LoF", "comparator": "==", "condition": "HC", "include_missing": "no", "vep_severity_to_include": ""}
        },
        "or_mask": {
            "filter1": {"annotation": "", "comparator": "", "condition": "","include_missing": "","vep_severity_to_include": ""}
        }
    },
    "missense": {
        "and_mask": {
            "filter1": {"annotation": "", "comparator": "", "condition": "","include_missing": "", "vep_severity_to_include": ""}
        },
        "or_mask": {
            "filter1": {"annotation": "CADD_PHRED",  "comparator": ">=", "condition": "10","include_missing": "no", "vep_severity_to_include": "missense+"},
            "filter2": {"annotation": "LoF",  "comparator": "==", "condition": "HC", "include_missing": "no", "vep_severity_to_include": ""}
        }
    },
    "synonymous": {
        "and_mask": {
            "filter1": {"annotation": "Consequence", "comparator": "==", "condition": "synonymous_variant", "include_missing": "no", "vep_severity_to_include": ""}
        },
        "or_mask": {
            "filter1": {"annotation": "", "comparator": "", "condition": "", "include_missing": "", "vep_severity_to_include": ""}
        }
    }
},
```

| "master\_aggregate\_variant\_testing.part\_1\_variant\_selection.mask\_rank": {
"LoF": 1,
"missense": 2,
"synonymous": 3
},

```
"master_aggregate_variant_testing.part_2_regenie_testing.regenie_masks": {
    "strict_lof": "LoF",
    "mild_lof": "LoF,missense",
    "control": "synonymous"
},

"master_aggregate_variant_testing.differential_missingness_pvalue": "10e-5",
"master_aggregate_variant_testing.part_1_variant_selection.upstream_downstream_length": 0,
"master_aggregate_variant_testing.part_1_variant_selection.use_max_mac": false,
"master_aggregate_variant_testing.part_1_variant_selection.final_max_mac_to_exclude": 20,
"master_aggregate_variant_testing.part_1_variant_selection.use_max_maf": true,
"master_aggregate_variant_testing.part_1_variant_selection.final_max_maf_to_exclude": 0.005,
"master_aggregate_variant_testing.part_1_variant_selection.max_missingness": 0.05,

"master_aggregate_variant_testing.precomputed_plink_files_for_grm": [
    "/re_gecip/BRS/genomicc_data/WGS_analysis/aggregate_variant_tests/aggCOVID_V2/output/EUR/loftee_hc/snps_only/chr1/glob-7b047a45b923da427eab0cce842a1ad3/plink_set_for_tests_all_samples.bed",
    "/re_gecip/BRS/genomicc_data/WGS_analysis/aggregate_variant_tests/aggCOVID_V2/output/EUR/loftee_hc/snps_only/chr1/glob-7b047a45b923da427eab0cce842a1ad3/plink_set_for_tests_all_samples.bim",
    "/re_gecip/BRS/genomicc_data/WGS_analysis/aggregate_variant_tests/aggCOVID_V2/output/EUR/loftee_hc/snps_only/chr1/glob-7b047a45b923da427eab0cce842a1ad3/plink_set_for_tests_all_samples.fam"
],

"master_aggregate_variant_testing.part_2_saige_testing.LOCO": "FALSE",

"master_aggregate_variant_testing.part_2_saige_testing.saige_step0_options": [
    "--relatednessCutoff=0.125",
    "--numRandomMarkerforSparseKin=2000"
],

"master_aggregate_variant_testing.part_2_saige_testing.saige_step1_options": [
    "--IsSparseKin='TRUE'",
    "--traitType='binary'",
    "--invNormalize='false'",
    "--outputPrefix='null_glmm'",
    "--outputPrefix_varRatio='null_glmm_var_ratio'",
    "--minMAFforGRM=0.01",
    "--sexCol=''",
    "--FemaleCode='1'",
    "--FemaleOnly='FALSE'",
    "--MaleCode='0'",
    "--MaleOnly='FALSE'",
    "--noEstFixedEff='FALSE'",
    "--tol=0.02",
    "--maxiter=20",
    "--tolPCG=1e-5",
    "--maxiterPCG=500",
    "--SPAcutoff=2",
    "--numRandomMarkerforVarianceRatio=30",
    "--skipModelFitting='FALSE'",
    "--tauInit='0,0'",
    "--traceCVcutoff=0.0025",
    "--ratioCVcutoff=0.001",
    "--isCateVarianceRatio='TRUE'",
    "--isCovariateTransform='TRUE'",
    "--cateVarRatioMinMACVecExclude='0.5,1.5,2.5,3.5,4.5,5.5,10.5,20.5'",
    "--cateVarRatioMaxMACVecInclude='1.5,2.5,3.5,4.5,5.5,10.5,20.5'",
    "--useSparseSigmaforInitTau='FALSE'",
    "--minCovariateCount=-1",
    "--includeNonautoMarkersforVarRatio='FALSE'",
    "--memoryChunk=2"
],
"master_aggregate_variant_testing.part_2_saige_testing.saige_step2_options": [
    "--IsDropMissingDosages='FALSE'",
    "--IsSparse='TRUE'",
    "--IsOutputAFinCaseCtrl='TRUE'",
    "--IsOutputNinCaseCtrl='TRUE'",
    "--IsOutputHetHomCountsinCaseCtrl='TRUE'",
    "--IsSingleVarinGroupTest='TRUE'",
    "--IsOutputPvalueNAinGroupTestforBinary='TRUE'",
    "--IsAccountforCasecontrolImbalanceinGroupTest='TRUE'",
    "--IsOutputBETASEinBurdenTest='TRUE'",
    "--is_rewrite_XnonPAR_forMales='FALSE'",
    "--minMAF=0",
    "--maxMAFforGroupTest=0.5",
    "--minMAC=0",
    "--numLinesOutput=10000",
    "--condition=''",
    "--kernel='linear.weighted'",
    "--method='optimal.adj'",
    "--weights.beta.rare=1,25",
    "--weights.beta.common=1,25",
    "--weightMAFcutoff=0.01",
    "--r.corr=0",
    "--dosageZerodCutoff=0.2",
    "--weightsIncludeinGroupFile='FALSE'",
    "--weights_for_G2_cond=''",
    "--SPAcutoff=2",
    "--chrom=chr1",
    "--method_to_CollapseUltraRare='absence_or_presence'",
    "--MACCutoff_to_CollapseUltraRare=10",
    "--DosageCutoff_for_UltraRarePresence=0.5"
],

"master_aggregate_variant_testing.part_2_regenie_testing.regenie_step1_options": [
    "--step 1",
    "--bt",
    "--lowmem",
    "--lowmem-prefix .",
    "--bsize 1000",
    "--ref-first",
    "--loocv"
],
"master_aggregate_variant_testing.part_2_regenie_testing.regenie_step2_options": [
    "--step 2",
    "--minMAC 1",
    "--aaf-bins 0.005",
    "--build-mask 'max'",
    "--bt",
    "--firth --approx",
    "--firth-se",
    "--bsize 1000",
    "--ref-first",
    "--singleton-carrier"
],

"master_aggregate_variant_testing.tools_container": "quay.io/alexander-stuckey/gwas_avt",
"master_aggregate_variant_testing.part_2_saige_testing.saige_container": "quay.io/alexander-stuckey/saige:0.44.6.5",
"master_aggregate_variant_testing.part_2_regenie_testing.regenie_container": "quay.io/alexander-stuckey/regenie",

"master_aggregate_variant_testing.genome_build_to_ensembl_coordinates_files": {
    "GRCh37": "resources/Ensembl_87_genes_coordinates_GRCh37.tsv",
    "GRCh38": "resources/Ensembl_98_genes_coordinates_GRCh38.tsv"
},
"master_aggregate_variant_testing.part_1_variant_selection.vep_severity_scale": "resources/vep_severity_scale_2020_bcftools_splitvep.txt",

"master_aggregate_variant_testing.pheno_plink_helper_python_script": "resources/pheno_helper_script.py",
"master_aggregate_variant_testing.part_1_variant_selection.python_input_filtering_script": "resources/input_filtering.py",
"master_aggregate_variant_testing.part_1_variant_selection.vep_severity_scale_ensembl_translation": "resources/vep_severity_scale_translation_2020_Ensembl_to_bcftools_splitvep.tsv",
"master_aggregate_variant_testing.part_1_variant_selection.vep_filtering_python_script": "resources/vep_filtering_script.py",
"master_aggregate_variant_testing.part_1_variant_selection.vep_severity_bcftools_translation_and_ranking": "resources/vep_severity_bcftools_translation_and_ranking.tsv",

"master_aggregate_variant_testing.part_1_variant_selection.variant_extraction_threads": 4,
"master_aggregate_variant_testing.part_1_variant_selection.variant_extraction_memory": 16000,

"master_aggregate_variant_testing.part_2_saige_testing.saige_step_0_threads": 8,
"master_aggregate_variant_testing.part_2_saige_testing.saige_step_0_memory": 16000,
"master_aggregate_variant_testing.part_2_saige_testing.saige_step_1_threads": 8,
"master_aggregate_variant_testing.part_2_saige_testing.saige_step_1_memory": 16000,
"master_aggregate_variant_testing.part_2_saige_testing.saige_filter_differential_missingness_cpus": 1,
"master_aggregate_variant_testing.part_2_saige_testing.saige_filter_differential_missingness_memory": 4000,
"master_aggregate_variant_testing.part_2_saige_testing.saige_create_GRM_threads": 4,
"master_aggregate_variant_testing.part_2_saige_testing.saige_create_GRM_memory": 20000,
"master_aggregate_variant_testing.part_2_saige_testing.saige_step_2_threads": 4,
"master_aggregate_variant_testing.part_2_saige_testing.saige_step_2_memory": 64000,

"master_aggregate_variant_testing.part_2_regenie_testing.regenie_filter_GRM_cpus": 1,
"master_aggregate_variant_testing.part_2_regenie_testing.regenie_filter_GRM_memory": 8000,
"master_aggregate_variant_testing.part_2_regenie_testing.regenie_step_1_cpus": 8,
"master_aggregate_variant_testing.part_2_regenie_testing.regenie_step_1_memory": 16000,
"master_aggregate_variant_testing.part_2_regenie_testing.regenie_create_set_filter_diff_missing_cpus": 2,
"master_aggregate_variant_testing.part_2_regenie_testing.regenie_create_set_filter_diff_missing_memory": 32000,
"master_aggregate_variant_testing.part_2_regenie_testing.regenie_step_2_cpus": 2,
"master_aggregate_variant_testing.part_2_regenie_testing.regenie_step_2_memory": 16000
```

}

```

May 7, 2024
