---
title: 'Aggregate Variant Testing "input variables" file - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/avt_input2/
scraped_at: 2026-05-04T06:31:22Z
---

# Aggregate Variant Testing "input variables" file

The "input variables" file (or simply inputs file), linked in the main AVT workflow directory as "inputs.json", is a large file with many options that can be varied by you. An example of an "input variables" file is shown below, along with a breakdown by section, and an explanation for each input. Where appropriate, the documentation will refer to an external source (i.e. SAIGE-GENE options).

> **Important note:**
>
> The "input variables" file is a JSON file, and therefore [it does not support the use of comments](https://en.wikipedia.org/wiki/JSON#Data_types_and_syntax). All comments in section 'Components of the "input variables" file', introduced by an arrow "<-", are added only for explanatory purposes. Please make sure you don't include the comments in your actual inputs file.

## Example "input variables" file

Example input file

```
{
    "master_aggregate_variant_testing.lsf_project_code": "bio",

    "master_aggregate_variant_testing.genome_build": "GRCh38",
    "master_aggregate_variant_testing.input_variants_dataset": "aggV2_PASS_UTRplus_proteincodinggenes",

    "master_aggregate_variant_testing.phenotype_input_file": "/gel_data_resources/workflows/input_material/BRS_tools_aggregateVariantTestingWorkflow/input_user_data/phenotype_day0_covid_aggV2.phen",
    "master_aggregate_variant_testing.phenotype_column_delimiter": " ",
    "master_aggregate_variant_testing.phenotype_sample_column": "IID",
    "master_aggregate_variant_testing.phenotype_case_or_control_column": "phen_ANA_C1_v1",
    "master_aggregate_variant_testing.phenotype_control_value": "0",
    "master_aggregate_variant_testing.phenotype_case_value": "1",

    "master_aggregate_variant_testing.chrX_female_only_cohort": false,
    "master_aggregate_variant_testing.chrX_male_only_cohort": false,

    "master_aggregate_variant_testing.min_info_af": 0,
    "master_aggregate_variant_testing.max_info_af": 1,

    "master_aggregate_variant_testing.use_precomputed_plink_files_for_grm": true,
    "master_aggregate_variant_testing.precomputed_plink_files_for_grm": [
        "/gel_data_resources/workflows/input_material/BRS_tools_aggregateVariantTestingWorkflow/input_user_data/phenotype_day0_covid_aggV2.plink_set_for_tests_all_samples.bed",
        "/gel_data_resources/workflows/input_material/BRS_tools_aggregateVariantTestingWorkflow/input_user_data/phenotype_day0_covid_aggV2.plink_set_for_tests_all_samples.bim",
        "/gel_data_resources/workflows/input_material/BRS_tools_aggregateVariantTestingWorkflow/input_user_data/phenotype_day0_covid_aggV2.plink_set_for_tests_all_samples.fam"
    ],

    "master_aggregate_variant_testing.part_1_inputs.chromosomes_input_file": "input_user_data/chromosomes.txt",
    "master_aggregate_variant_testing.part_1_inputs.genes_input_file": null,
    "master_aggregate_variant_testing.part_1_inputs.coordinates_input_file": null,
    "master_aggregate_variant_testing.part_1_inputs.groups_input_file": null,

    "master_aggregate_variant_testing.part_1_inputs.upstream_downstream_length": 0,

    "master_aggregate_variant_testing.part_1_inputs.platekeys_input_file": null,

    "master_aggregate_variant_testing.part_2_filtering.use_main_filtering": true,
    "master_aggregate_variant_testing.part_2_filtering.use_vep_filtering": true,
    "master_aggregate_variant_testing.part_2_filtering.use_masking": true,

    "master_aggregate_variant_testing.part_2_filtering.filter_values_to_include": ["PASS"],
    "master_aggregate_variant_testing.part_2_filtering.info_bcftools_expressions_to_include": [
        "INFO/OLD_MULTIALLELIC='.'",
        "INFO/OLD_CLUMPED='.'",
        "TYPE='snp'",
        "(INFO/AC<=20 || INFO/AC>=INFO/AN-20)",
        "INFO/medianDepthNonMiss>20",
        "INFO/medianGQ>=30"
    ],
    "master_aggregate_variant_testing.part_2_filtering.vep_severity_to_include": "missense+",
    "master_aggregate_variant_testing.part_2_filtering.vep_severity_scale": "resources/VEP_severity_scale_2020_bcftools_splitvep.txt",
    "master_aggregate_variant_testing.part_2_filtering.functional_annotation_filters": [
        {"score": "gnomADg_AF", "condition": "<0.001", "include_missing": "yes"},
        {"score": "CADD_PHRED", "condition": ">=10", "include_missing": "no"}
    ],

    "master_aggregate_variant_testing.part_2_filtering.min_fmt_dp": 10,
    "master_aggregate_variant_testing.part_2_filtering.min_fmt_gq": 20,
    "master_aggregate_variant_testing.part_2_filtering.pvalue_fmt_abratio": 0.001,

    "master_aggregate_variant_testing.part_2_filtering.keep_half_missing_as_ref": false,
    "master_aggregate_variant_testing.differential_missingness_pvalue": "10e-5",
    "master_aggregate_variant_testing.part_2_filtering.max_allowed_missingness": 0.05,
    "master_aggregate_variant_testing.part_2_filtering.final_max_info_ac_to_exclude": 0,

    "master_aggregate_variant_testing.part_3_GRM_creation.grm_sites_filter": [
        "INFO/OLD_MULTIALLELIC='.'",
        "INFO/OLD_CLUMPED='.'",
        "TYPE='snp'"
    ],
    "master_aggregate_variant_testing.part_3_GRM_creation.MAC_categories": [
        [1,2],
        [2,3],
        [3,4],
        [4,5],
        [5,6],
        [6,11],
        [11,21]
    ],
    "master_aggregate_variant_testing.part_3_GRM_creation.sparse_plink_files": [
        "/gel_data_resources/workflows/input_material/BRS_tools_aggregateVariantTestingWorkflow/resources/aggV2_HQ_SNPs_sparse_plink_files.bed",
        "/gel_data_resources/workflows/input_material/BRS_tools_aggregateVariantTestingWorkflow/resources/aggV2_HQ_SNPs_sparse_plink_files.bim",
        "/gel_data_resources/workflows/input_material/BRS_tools_aggregateVariantTestingWorkflow/resources/aggV2_HQ_SNPs_sparse_plink_files.fam"
    ],
    "master_aggregate_variant_testing.part_3_GRM_creation.percent_chunks_to_keep": 20,
    "master_aggregate_variant_testing.part_3_GRM_creation.variants_to_include": 10,

    "master_aggregate_variant_testing.part_4_testing.saige_singularity": "/gel_data_resources/workflows/input_material/BRS_tools_aggregateVariantTestingWorkflow/resources/saige_0.42.1.sif",
    "master_aggregate_variant_testing.part_4_testing.saige_threads_to_create_GRM_and_fit_nullGLMM": 8,
    "master_aggregate_variant_testing.part_4_testing.relatedness_cutoff_for_sparseGRM": 0.125,
    "master_aggregate_variant_testing.part_4_testing.num_random_marker_for_sparse_kin": 2000,

    "master_aggregate_variant_testing.part_4_testing.IsSparseKin": "TRUE",
    "master_aggregate_variant_testing.part_4_testing.traitType": "binary",
    "master_aggregate_variant_testing.part_4_testing.invNormalize": "false",
    "master_aggregate_variant_testing.part_4_testing.phenotype_covariate_column_names": "ancestry,age,sex,age2,age.sex,PC1,PC2,PC3,PC4,PC5,PC6,PC7,PC8,PC9,PC10,PC11,PC12,PC13,PC14,PC15,PC16,PC17,PC18,PC19,PC20",
    "master_aggregate_variant_testing.part_4_testing.tol": 0.02,
    "master_aggregate_variant_testing.part_4_testing.maxiter": 20,
    "master_aggregate_variant_testing.part_4_testing.tolPCG": 1e-5,
    "master_aggregate_variant_testing.part_4_testing.maxiterPCG": 500,
    "master_aggregate_variant_testing.part_4_testing.SPAcutoff": 2,
    "master_aggregate_variant_testing.part_4_testing.numRandomMarkerforVarianceRatio": 30,
    "master_aggregate_variant_testing.part_4_testing.skipModelFitting": "FALSE",
    "master_aggregate_variant_testing.part_4_testing.tauInit": "0,0",
    "master_aggregate_variant_testing.part_4_testing.LOCO": "FALSE",
    "master_aggregate_variant_testing.part_4_testing.traceCVcutoff": 0.0025,
    "master_aggregate_variant_testing.part_4_testing.ratioCVcutoff": 0.001,
    "master_aggregate_variant_testing.part_4_testing.isCateVarianceRatio": "TRUE",
    "master_aggregate_variant_testing.part_4_testing.cateVarRatioMinMACVecExclude": "0.5,1.5,2.5,3.5,4.5,5.5,10.5,20.5",
    "master_aggregate_variant_testing.part_4_testing.cateVarRatioMaxMACVecInclude": "1.5,2.5,3.5,4.5,5.5,10.5,20.5",
    "master_aggregate_variant_testing.part_4_testing.isCovariateTransform": "TRUE",
    "master_aggregate_variant_testing.part_4_testing.useSparseSigmaforInitTau": "FALSE",
    "master_aggregate_variant_testing.part_4_testing.minMAFforGRM": 0.01,
    "master_aggregate_variant_testing.part_4_testing.minCovariateCount": -1,
    "master_aggregate_variant_testing.part_4_testing.includeNonautoMarkersforVarRatio": "FALSE",
    "master_aggregate_variant_testing.part_4_testing.FemaleOnly": "FALSE",
    "master_aggregate_variant_testing.part_4_testing.MaleOnly": "FALSE",
    "master_aggregate_variant_testing.part_4_testing.sexCol": "",
    "master_aggregate_variant_testing.part_4_testing.FemaleCode": "1",
    "master_aggregate_variant_testing.part_4_testing.MaleCode": "0",
    "master_aggregate_variant_testing.part_4_testing.noEstFixedEff": "FALSE",

    "master_aggregate_variant_testing.part_4_testing.IsDropMissingDosages": "TRUE",
    "master_aggregate_variant_testing.part_4_testing.vcfField": "GT",
    "master_aggregate_variant_testing.part_4_testing.minMAF": 0,
    "master_aggregate_variant_testing.part_4_testing.maxMAFforGroupTest": 0.5,
    "master_aggregate_variant_testing.part_4_testing.minMAC": 0,
    "master_aggregate_variant_testing.part_4_testing.numLinesOutput": 10000,
    "master_aggregate_variant_testing.part_4_testing.is_sparse": "TRUE",
    "master_aggregate_variant_testing.part_4_testing.IsOutputAFinCaseCtrl": "TRUE",
    "master_aggregate_variant_testing.part_4_testing.IsOutputNinCaseCtrl": "TRUE",
    "master_aggregate_variant_testing.part_4_testing.IsOutputHetHomCountsinCaseCtrl": "TRUE",
    "master_aggregate_variant_testing.part_4_testing.condition": "",
    "master_aggregate_variant_testing.part_4_testing.IsSingleVarinGroupTest": "FALSE",
    "master_aggregate_variant_testing.part_4_testing.kernel": "linear.weighted",
    "master_aggregate_variant_testing.part_4_testing.method": "optimal.adj",
    "master_aggregate_variant_testing.part_4_testing.weights_beta_rare": "1,25",
    "master_aggregate_variant_testing.part_4_testing.weights_beta_common": "1,25",
    "master_aggregate_variant_testing.part_4_testing.weightMAFcutoff": 0.01,
    "master_aggregate_variant_testing.part_4_testing.r_corr": "0",
    "master_aggregate_variant_testing.part_4_testing.dosageZerodCutoff": 0.2,
    "master_aggregate_variant_testing.part_4_testing.IsOutputPvalueNAinGroupTestforBinary": "TRUE",
    "master_aggregate_variant_testing.part_4_testing.IsAccountforCasecontrolImbalanceinGroupTest": "TRUE",
    "master_aggregate_variant_testing.part_4_testing.weightsIncludeinGroupFile": "FALSE",
    "master_aggregate_variant_testing.part_4_testing.weights_for_G2_cond": "",
    "master_aggregate_variant_testing.part_4_testing.IsOutputBETASEinBurdenTest": "TRUE",
    "master_aggregate_variant_testing.part_4_testing.sampleFile_male": "",
    "master_aggregate_variant_testing.part_4_testing.is_rewrite_XnonPAR_forMales": "FALSE",

    "master_aggregate_variant_testing.part_4_testing.saige_output_file_name": "saige_output.txt",

    "master_aggregate_variant_testing.load_bcftools": "module load bio/BCFtools/1.10.2-GCC-8.3.0",
    "master_aggregate_variant_testing.load_bedtools": "module load bio/BEDTools/2.27.1-foss-2018b",
    "master_aggregate_variant_testing.load_python": ". /resources/conda/miniconda3/etc/profile.d/conda.sh && conda activate py3pypi",
    "master_aggregate_variant_testing.load_plink": "module load bio/PLINK/1.9b_4.1-x86_64",
    "master_aggregate_variant_testing.load_plink2": "module load bio/PLINK/2.00-devel-20200409-x86_64",
    "master_aggregate_variant_testing.load_singularity": "module load singularity/3.2.1",

    "master_aggregate_variant_testing.genome_build_to_ensembl_coordinates_files": {
        "GRCh37": "resources/Ensembl_87_genes_coordinates_GRCh37.tsv",
        "GRCh38": "resources/Ensembl_98_genes_coordinates_GRCh38.tsv"
    },

    "master_aggregate_variant_testing.genome_build_to_aggregate_genomic_data": {
        "aggV2": {
            "GRCh37": {
                "directory": "",
                "suffix_and_extension": "",
                "index_extra_extension": ""
            },
            "GRCh38": {
                "directory": "/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/genomic_data",
                "suffix_and_extension": ".vcf.gz",
                "index_extra_extension": ".csi"
            }
        },
        "aggV2_PASS_UTRplus_proteincodinggenes": {
            "GRCh37": {
                "directory": "",
                "suffix_and_extension": "",
                "index_extra_extension": ""
            },
            "GRCh38": {
                "directory": "/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/genomic_data_subset/PASS_UTRplus_proteincodinggenes",
                "suffix_and_extension": "_PASS_UTRplus_proteincodinggenes.vcf.gz",
                "index_extra_extension": ".csi"
            }
        }
    },
    "master_aggregate_variant_testing.genome_build_to_aggregate_functional_annotations": {
        "aggV2": {
            "GRCh37": {
                "directory": "",
                "suffix_and_extension": "",
                "index_extra_extension": ""
            },
            "GRCh38": {
                "directory": "/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/functional_annotation/VEP_99",
                "suffix_and_extension": "_VEPannot.vcf.gz",
                "index_extra_extension": ".csi"
            }
        },
        "aggV2_PASS_UTRplus_proteincodinggenes": {
            "GRCh37": {
                "directory": "",
                "suffix_and_extension": "",
                "index_extra_extension": ""
            },
            "GRCh38": {
                "directory": "/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/functional_annotation/VEP_99",
                "suffix_and_extension": "_VEPannot.vcf.gz",
                "index_extra_extension": ".csi"
            }
        }
    },

    "master_aggregate_variant_testing.pheno_plink_helper_python_script": "resources/pheno_helper_script.py",

    "master_aggregate_variant_testing.part_2_filtering.extraction_filtering_python_script": "resources/extraction_filtering_script.py",
    "master_aggregate_variant_testing.part_2_filtering.vep_severity_scale_ensembl_translation": "resources/VEP_severity_scale_translation_2020_Ensembl_to_bcftools_splitvep.tsv",
    "master_aggregate_variant_testing.part_2_filtering.vep_filtering_python_script": "resources/VEP_filtering_script.py",
    "master_aggregate_variant_testing.part_2_filtering.regions_file_python_script": "resources/regions_file_script.py",

    "master_aggregate_variant_testing.part_4_testing.singularity_mount_options": [
        "/pgen_int_work:/pgen_int_work",
        "/nas/weka.gel.zone/pgen_int_work:/nas/weka.gel.zone/pgen_int_work",
        "/gel_data_resources:/gel_data_resources",
        "/re_scratch:/re_scratch",
        "/nas/weka.gel.zone/re_scratch:/nas/weka.gel.zone/re_scratch",
        "/genomes:/genomes",
        "/nas/weka.gel.zone/pgen_genomes:/nas/weka.gel.zone/pgen_genomes",
        "/re_gecip:/re_gecip",
        "/nas/weka.gel.zone/re_gecip:/nas/weka.gel.zone/re_gecip",
        "/discovery_forum:/discovery_forum",
        "/nas/weka.gel.zone/discovery_forum:/nas/weka.gel.zone/discovery_forum",
        "/nas/weka.gel.zone/pgen_analysis:/nas/weka.gel.zone/pgen_analysis",
        "/genomes-bertha-prod:/genomes-bertha-prod",
        "/genomes/bertha-prod:/genomes/bertha-prod"
    ]
}
```

## Components of the "input variables" file

Blank lines help separate different sections of the inputs file.

The example inputs file shown above, which is the default for v2.0 of the workflow, is composed of two main parts, separated by 5 consecutive blank lines.

The top part contains variables that you are likely to modify to customise your workflow run (although many of those can be left with default values, see details below). This part is separated into five further sections, using three consecutive blank lines - these sections contain input variables for different parts of the workflow, and variables in each section are prefixed in the following manner:

- master\_aggregate\_variant\_testing
- master\_aggregate\_variant\_testing.part\_1\_inputs
- master\_aggregate\_variant\_testing.part\_2\_filtering
- master\_aggregate\_variant\_testing.part\_3\_GRM\_creation
- master\_aggregate\_variant\_testing.part\_4\_testing

The bottom part of the inputs file contains variables that you are unlikely to modify, although these variables too can be customised if needed.

### Top section - Main workflow file inputs

This section contains the following input variables with explanations:

Example main workflow file inputs

```
"lsf_project_code": "bio"   <- Change this to your LSF project code

"genome_build": "GRCh38"   <- Genome build for the analysis - only GRCh38 is available for now
"input_variants_dataset": "aggV2_PASS_UTRplus_proteincodinggenes"   <- String to identify variants dataset to use, usually "aggV2" or "aggV2_PASS_UTRplus_proteincodinggenes" (which is a subset of aggV2 containting only PASS variants from Ensembl protein coding genes with consequence 5_prime_UTR_variant or more severe)

"phenotype_input_file": "/gel_data_resources/workflows/input_material/BRS_tools_aggregateVariantTestingWorkflow/input_user_data/phenotype_day0_covid_aggV2.phen"   <- Change this to the full path to your phenotype file
"phenotype_column_delimiter": " "   <- The delimeter used in your phenotype file, can likely keep the same
"phenotype_sample_column": "IID"   <- Change this to the column name that identifies your sample IDs (IID in the example phenotype file)
"phenotype_case_or_control_column": "phen_ANA_C1_v1"   <- Change this to the column name that identifies your phenotype
"phenotype_control_value": "0"   <- Do not change (please code controls as 0 in your phenotype file)
"phenotype_case_value": "1"   <- Do not change (please code cases as 1 in your phenotype file)

"chrX_female_only_cohort": false   <- Change to true if you are running the workflow on chrX on a female-only cohort
"chrX_male_only_cohort": false   <- Change to true if you are running the workflow on chrX on a male-only cohort

"min_info_af": 0   <- Change to the minimum allele frequency to include (variants with a frequency less than this will be filtered out)
"max_info_af": 1   <- Change to the maximum allele frequency to include (variants with a frequency greater than this will be filtered out)

"use_precomputed_plink_files_for_grm": true,   <- Set to true if you want to compute plink files for GRM creation from scratch, otherwise to false
"precomputed_plink_files_for_grm": [   <- Array of 3 paths to precomputed plink files for GRM creation, as output by the workflow itself
    "/gel_data_resources/workflows/input_material/BRS_tools_aggregateVariantTestingWorkflow/input_user_data/phenotype_day0_covid_aggV2.plink_set_for_tests_all_samples.bed",
    "/gel_data_resources/workflows/input_material/BRS_tools_aggregateVariantTestingWorkflow/input_user_data/phenotype_day0_covid_aggV2.plink_set_for_tests_all_samples.bim",
    "/gel_data_resources/workflows/input_material/BRS_tools_aggregateVariantTestingWorkflow/input_user_data/phenotype_day0_covid_aggV2.plink_set_for_tests_all_samples.fam"
]
```

### Top section - Workflow part 1 inputs (translating inputs to chromosomal regions)

This section contains the following input variables with explanations:

Part 1 inputs

```
"chromosomes_input_file": "input_user_data/chromosomes.txt"   <- Change this to a file with the chromosome (only one for v2.0) that you want to test, in GRCh38 naming (e.g. chr1, chr2, ..., chrX). Set to null if you don't want to use this as an input file.
"genes_input_file": null   <- Change this to a file with a list of genes that you want to test, one per line (e.g. BRCA1, FMO3). Set to null if you don't want to use this as an input file.
"coordinates_input_file": null   <- Change this to a BED file of regions that you want to test, one per line (e.g. chr17    43044295    43170245). Set to null if you don't want to use this as an input file.
"groups_input_file": null   <- Change this to a SAIGE-GENE-like input file with tab-separated groups of variants, one per line (e.g. MYGROUP1   chr17:43045694_G/C  chr17:43051089_T/C). Set to null if you don't want to use this as an input file.

"upstream_downstream_length": 0   <- Integer length of region (in bp) to add to each gene upstream and downstream of Ensembl gene edges (no more than 100kbp; negative values no larger than -10kbp will be taken away inside gene edges).

"platekeys_input_file": null   <- Change this to a file with Genomics England platekey IDs of interest, one per line, to subset your phenotype file. Set to null if you don't want to subset your phenotype file.
```

> **Note:**
>
> Only one of "`genes_input_file`", "`coordinates_input_file`", and "`groups_input_file`" needs to be specified. If a "`chromosomes_input_file`" is specified together with one of those other files, it will be used to subset the other file's content; if it is specified on its own (as in the default example), it will be translated into the corresponding list of Ensembl genes. For the file paths, both relative and absolute paths are accepted.

### Top section - Workflow part 2 inputs (filtering)

This section contains the following input variables with explanations:

Part 2 Inputs

```
"use_main_filtering": true   <- Whether to use site wide filtering (defined below).
"use_vep_filtering": true   <- Whether to use VEP functional annotation filtering. This is skipped in case the input is specified as "groups_input_file".
"use_masking": true   <- Whether to apply a final masking of sites that have more than the allowed level of missingness (defined below).

"filter_values_to_include": ["PASS"]   <- Change to the list of filters that you are OK with including (here PASS sites only)
"info_bcftools_expressions_to_include": [   <- Change to the list of site wide criteria to keep a site. Here we have SNPs only, max allele count of 20, a median sitewide depth in non-missing samples of 20, and a median GQ of 30
    "INFO/OLD_MULTIALLELIC='.'",
    "INFO/OLD_CLUMPED='.'",
    "TYPE='snp'",
    "(INFO/AC<=20 || INFO/AC>=INFO/AN-20)",
    "INFO/medianDepthNonMiss>20",
    "INFO/medianGQ>=30"
]
"vep_severity_to_include": "missense+"   <- Change to the minimum VEP severity to include the site. Set to "" to include all sites (i.e. do not consider VEP severity). VEP severity scale can be found here: https://m.ensembl.org/info/genome/variation/prediction/predicted_data.html
"vep_severity_scale": "resources/VEP_severity_scale_2020_bcftools_splitvep.txt"   <- A helper file containing the VEP severity scale - if needed, you can rearrange this as you would with a bcftools +split-vep severity scale.
"functional_annotation_filters": [   <- Change to the specific functional annotations that you want to filter for. Note that there is an important difference between numbers and strings, which will be explained in the warning box below.
    {"score": "gnomADg_AF", "condition": "<0.001", "include_missing": "yes"},
    {"score": "CADD_PHRED", "condition": ">=10", "include_missing": "no"}
]

"min_fmt_dp": 10   <- Change to the minimum depth PER SAMPLE to include a sample at each site.
"min_fmt_gq": 20   <- Change to the mimimum GQ PER SAMPLE to include a sample at each site.
"pvalue_fmt_abratio": 0.001   <- Change to the desired p-value when testing AB ratio PER SAMPLE to include the sample at each site.

"keep_half_missing_as_ref": false   <- Whether to set half missing calls to reference (true / false; false means set half missing as fully missing).
"differential_missingness_pvalue": "10e-5"   <- Change to the desired p-value when testing cases VS controls for differential missingness.
"max_allowed_missingness": 0.05   <- Change to the maximum allowed missingness at a site, after all filters have been applied.
"final_max_info_ac_to_exclude": 0   <- Change to filter out any sites that have an allele count of this or fewer (sites may become monomorphic or drop to very few variant calls after all the filtering).
```

> **Note:**
>
> The workflow uses a python script to filter VEP functional annotation. This has consequences in how you specify filtering based on numbers vs strings.
>
> Numbers are straightforward. The syntax is as follows: {"score": "gnomADg\_AF", "condition": "<0.001"}. You can specify any valid comparison operator (==, !=, >=, <=) and filter numbers based on them.
>
> Strings behave a little differently. The syntax is as in the following example: `{"score": "LoF", "condition": "==\"HC\"", "include_missing": "no"}`. Note the escaped double-quotes (`\"`) around the string that you want to match. This is required due to the nature of the underlying python script. If they are omitted, you will get an error like the following: `"Error: object 'HC' not found"`

### Top section - Workflow part 3 inputs (preparing files for GRM creation)

This section contains the following input variables with explanations:

Part 3 inputs

```
"grm_sites_filter": [   <- Filters for GRM creation.
    "INFO/OLD_MULTIALLELIC='.'",
    "INFO/OLD_CLUMPED='.'",
    "TYPE='snp'"
]
"MAC_categories": [   <- Minor allele categories for GRM creation. These ranges are defined by the developer of SAIGE. Do not change.
    [1,2],
    [2,3],
    [3,4],
    [4,5],
    [5,6],
    [6,11],
    [11,21]
]
"sparse_plink_files": [   <- Path to the location of the PLINK files containing high quality common SNPs that are alos in 1,000 genomes. Do not change.
    "/gel_data_resources/workflows/input_material/BRS_tools_aggregateVariantTestingWorkflow/resources/aggV2_HQ_SNPs_sparse_plink_files.bed",
    "/gel_data_resources/workflows/input_material/BRS_tools_aggregateVariantTestingWorkflow/resources/aggV2_HQ_SNPs_sparse_plink_files.bim",
    "/gel_data_resources/workflows/input_material/BRS_tools_aggregateVariantTestingWorkflow/resources/aggV2_HQ_SNPs_sparse_plink_files.fam"
]
"sites_file_path": null   <- Change to a path containing a list of sites to use for GRM creation, one per aggregate chunk. Does not need to be specified.
"use_sites_file": false   <- Whether to use a list of sites for GRM creation, or extract sites from the aggregate files directly. Can be left false in most, if not all, cases.
"percent_chunks_to_keep": 20   <- To speed creation of the GRM, only X percent of chunks are used to extract sites. Change this value to sue more or fewer chunks (note that using 100% of chunks will take a long time).
"variants_to_include": 10   <- Change to set the number of variants per MAC category per chunk of the variant dataset. The SAIGE developers recommend at least 2,000 variants overall for each category.
```

### Top section - Workflow part 4 inputs (Aggregate Variant Tests with SAIGE-GENE)

This section contains the following input variables with explanations:

Part 4 inputs

```
"saige_singularity": "/gel_data_resources/workflows/input_material/BRS_tools_aggregateVariantTestingWorkflow/resources/saige_0.42.1.sif"   <- Path to the singularity container containing SAIGE. Change if a new container is available.
"saige_threads_to_create_GRM_and_fit_nullGLMM": 8   <- The number of threads used in those two steps of SAIGE-GENE computation - does not need to be changed.
"relatedness_cutoff_for_sparseGRM": 0.125   <- The pairwise relationship cutoff for generating the sparse GRM. Values below this will be set to 0\. The default recommended by SAIGE.
"num_random_marker_for_sparse_kin": 2000   <- The number of random markers used to generate the sparse GRM. The default recommended by SAIGE.

"IsSparseKin": "TRUE"   <- Required to perform aggregate variant testing. Do not change.
"traitType": "binary"   <- Binary or quantitative trait. Currently the workflow only works for binary traits. Do not change.
"invNormalize": "false"   <- Do not change, only relevant for quantitative traits.
"phenotype_covariate_column_names": "ancestry,age,sex,age2,age.sex,PC1,PC2,PC3,PC4,PC5,PC6,PC7,PC8,PC9,PC10,PC11,PC12,PC13,PC14,PC15,PC16,PC17,PC18,PC19,PC20"   <- Change to match the covariate columns in your phenotype file.
"tol": 0.02   <- The default recommended by SAIGE. Only change if you know what you are doing.
"maxiter": 20   <- The default recommended by SAIGE. Only change if you know what you are doing.
"tolPCG": 1e-5   <- The default recommended by SAIGE. Only change if you know what you are doing.
"maxiterPCG": 500   <- The default recommended by SAIGE. Only change if you know what you are doing.
"SPAcutoff": 2   <- The default recommended by SAIGE. Only change if you know what you are doing.
"numRandomMarkerforVarianceRatio": 30   <- The default recommended by SAIGE. Only change if you know what you are doing.
"skipModelFitting": "FALSE"   <- The default recommended by SAIGE. Only change if you know what you are doing.
"tauInit": "0,0"   <- The default recommended by SAIGE. Only change if you know what you are doing.
"LOCO": "FALSE"   <- Leave one chromosome out.
"traceCVcutoff": 0.0025   <- The default recommended by SAIGE. Only change if you know what you are doing.
"ratioCVcutoff": 0.001   <- The default recommended by SAIGE. Only change if you know what you are doing.
"isCateVarianceRatio": "TRUE"   <- The default recommended by SAIGE. Only change if you know what you are doing.
"cateVarRatioMinMACVecExclude": "0.5,1.5,2.5,3.5,4.5,5.5,10.5,20.5"   <- The default recommended by SAIGE. Only change if you know what you are doing.
"cateVarRatioMaxMACVecInclude": "1.5,2.5,3.5,4.5,5.5,10.5,20.5"   <- The default recommended by SAIGE. Only change if you know what you are doing.
"isCovariateTransform": "TRUE"   <- The default recommended by SAIGE. Only change if you know what you are doing.
"useSparseSigmaforInitTau": "FALSE"   <- The default recommended by SAIGE. Only change if you know what you are doing.
"minMAFforGRM": 0.01   <- The default recommended by SAIGE. Only change if you know what you are doing.
"minCovariateCount": -1   <- The default recommended by SAIGE. Only change if you know what you are doing.
"includeNonautoMarkersforVarRatio": "FALSE"   <- The default recommended by SAIGE. Only change if you know what you are doing.
"FemaleOnly": "FALSE"   <- The default recommended by SAIGE. Only change if you know what you are doing.
"MaleOnly": "FALSE"   <- The default recommended by SAIGE. Only change if you know what you are doing.
"sexCol": ""   <- The default recommended by SAIGE. Only change if you know what you are doing.
"FemaleCode": "1"   <- The default recommended by SAIGE. Only change if you know what you are doing.
"MaleCode": "0"   <- The default recommended by SAIGE. Only change if you know what you are doing.
"noEstFixedEff": "FALSE"   <- The default recommended by SAIGE. Only change if you know what you are doing.

"IsDropMissingDosages": "TRUE"   <- Whether to drop samples with missing genotypes in a group, or mean impute them. Set to TRUE due to the filtering applied earlier, that would be wasted if we imputed the values (also we know the truth of the sites, so we don't need to impute them).
"vcfField": "GT"   <- Which field contains the genotype information in the VCF. Do not change.
"minMAF": 0   <- Minimum minor allele frequency to include for testing.
"maxMAFforGroupTest": 0.5   <- Maximum minor allele frequency to include for testing.
"minMAC": 0   <- Mimimum minor allele count to include for testing.
"numLinesOutput": 10000   <- The maximum number of lines to output.
"is_sparse": "TRUE"   <- Do not change.
"IsOutputAFinCaseCtrl": "TRUE"   <- Output case and control allele frequency.
"IsOutputNinCaseCtrl": "TRUE"   <- Output the number of samples for cases and controls.
"IsOutputHetHomCountsinCaseCtrl": "TRUE"   <- Output counts for the number of hets and homs in the cases and controls.
"condition": ""   <- Advanced usage.
"IsSingleVarinGroupTest": "FALSE"   <- Also output single variant tests for each group. There is a bug in the current version of SAIGE-GENE that causes this to crash with smaller sample numbers.
"kernel": "linear.weighted"   <- The default recommended by SAIGE. Only change if you know what you are doing.
"method": "optimal.adj"   <- The default recommended by SAIGE. Only change if you know what you are doing.
"weights_beta_rare": "1,25"   <- The default recommended by SAIGE. Only change if you know what you are doing.
"weights_beta_common": "1,25"   <- The default recommended by SAIGE. Only change if you know what you are doing.
"weightMAFcutoff": 0.01   <- The default recommended by SAIGE. Only change if you know what you are doing.
"r_corr": "0"   <- The default recommended by SAIGE. Only change if you know what you are doing.
"dosageZerodCutoff": 0.2   <- The default recommended by SAIGE. Only change if you know what you are doing.
"IsOutputPvalueNAinGroupTestforBinary": "TRUE"   <- Do not change
"IsAccountforCasecontrolImbalanceinGroupTest": "TRUE"   <- whether to account for case control imbalance in your cohort. Do not change.
"weightsIncludeinGroupFile": "FALSE"   <- Should variants be valued differently, according to values specified in the group file. Not currently supported in the workflow.
"weights_for_G2_cond": ""   <- The default recommended by SAIGE. Only change if you know what you are doing.
"IsOutputBETASEinBurdenTest": "TRUE"   <- Do not change
"sampleFile_male": ""   <- If analysing chrX, change to the path of a file containing a list of all male sample IDs, one per line.
"is_rewrite_XnonPAR_forMales": "FALSE"   <- If analysing chrX, change to TRUE if you want SAIGE-GENE to automatically duplicate alleles in non-PAR regions of chrX for male samples.

"saige_output_file_name': "saige_output.txt"   <- Change to the name of your output file.
```

### Bottom section

This section contains the following input variables with explanations:

Bottom section

```
"load_bcftools": "module load bio/BCFtools/1.10.2-GCC-8.3.0"   <- Instructions to load the bcftools module.
"load_bedtools": "module load bio/BEDTools/2.27.1-foss-2018b"   <- Instructions to load the bedtools module.
"load_python": ". /resources/conda/miniconda3/etc/profile.d/conda.sh && conda activate py3pypi"   <- Instructions to load Python.
"load_plink": "module load bio/PLINK/1.9b_4.1-x86_64"   <- Instructions to load the plink module.
"load_plink2": "module load bio/PLINK/2.00-devel-20200409-x86_64"   <- Instructions to load the plink2 module.
"load_singularity": "module load singularity/3.2.1"   <- Instructions to load Singularity.

"genome_build_to_ensembl_coordinates_files": {   <- Paths to files containing Ensembl genes with coordinates and other information.
    "GRCh37": "resources/Ensembl_87_genes_coordinates_GRCh37.tsv",
    "GRCh38": "resources/Ensembl_98_genes_coordinates_GRCh38.tsv"
}

"genome_build_to_aggregate_genomic_data": {   <- Variables relating to the genomic dataset.
    "aggV2": {
        "GRCh37": {
            "directory": "",
            "suffix_and_extension": "",
            "index_extra_extension": ""
        },
        "GRCh38": {
            "directory": "/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/genomic_data",
            "suffix_and_extension": ".vcf.gz",
            "index_extra_extension": ".csi"
        }
    },
    "aggV2_PASS_UTRplus_proteincodinggenes": {
        "GRCh37": {
            "directory": "",
            "suffix_and_extension": "",
            "index_extra_extension": ""
        },
        "GRCh38": {
            "directory": "/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/genomic_data_subset/PASS_UTRplus_proteincodinggenes",
            "suffix_and_extension": "_PASS_UTRplus_proteincodinggenes.vcf.gz",
            "index_extra_extension": ".csi"
        }
    }
}
"genome_build_to_aggregate_functional_annotations": {   <- Variables relating to the functional annotation files for the genomic dataset.
    "aggV2": {
        "GRCh37": {
            "directory": "",
            "suffix_and_extension": "",
            "index_extra_extension": ""
        },
        "GRCh38": {
            "directory": "/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/functional_annotation/VEP_99",
            "suffix_and_extension": "_VEPannot.vcf.gz",
            "index_extra_extension": ".csi"
        }
    },
    "aggV2_PASS_UTRplus_proteincodinggenes": {
        "GRCh37": {
            "directory": "",
            "suffix_and_extension": "",
            "index_extra_extension": ""
        },
        "GRCh38": {
            "directory": "/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/functional_annotation/VEP_99",
            "suffix_and_extension": "_VEPannot.vcf.gz",
            "index_extra_extension": ".csi"
        }
    }
}

"pheno_plink_helper_python_script": "resources/pheno_helper_script.py"   <- Helper scripts.

"extraction_filtering_python_script": "resources/extraction_filtering_script.py"   <- Helper scripts.
"vep_severity_scale_ensembl_translation": "resources/VEP_severity_scale_translation_2020_Ensembl_to_bcftools_splitvep.tsv"   <- Helper file translating Ensembl Consequence annotations to bcftools +split-vep strings.
"vep_filtering_python_script": "resources/VEP_filtering_script.py"   <- Helper scripts.
"regions_file_python_script": "resources/regions_file_script.py"   <- Helper scripts.

"singularity_mount_options": [   <- Mount options for the Singularity containers. Do not change.
    "/pgen_int_work:/pgen_int_work",
    "/nas/weka.gel.zone/pgen_int_work:/nas/weka.gel.zone/pgen_int_work",
    "/gel_data_resources:/gel_data_resources",
    "/re_scratch:/re_scratch",
    "/nas/weka.gel.zone/re_scratch:/nas/weka.gel.zone/re_scratch",
    "/genomes:/genomes",
    "/nas/weka.gel.zone/pgen_genomes:/nas/weka.gel.zone/pgen_genomes",
    "/re_gecip:/re_gecip",
    "/nas/weka.gel.zone/re_gecip:/nas/weka.gel.zone/re_gecip",
    "/discovery_forum:/discovery_forum",
    "/nas/weka.gel.zone/discovery_forum:/nas/weka.gel.zone/discovery_forum",
    "/nas/weka.gel.zone/pgen_analysis:/nas/weka.gel.zone/pgen_analysis",
    "/genomes-bertha-prod:/genomes-bertha-prod",
    "/genomes/bertha-prod:/genomes/bertha-prod"
]
```

## Help and support

Please reach out via the [Genomics England Service Desk](../help/) for any issues related to running this script, including "AVT\_workflow" in the title/description of your inquiry.

February 13, 2025
