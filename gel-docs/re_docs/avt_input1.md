---
title: 'Aggregate Variant Testing inputs file - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/avt_input1/
scraped_at: 2026-05-04T06:31:21Z
---

# Aggregate Variant Testing inputs file

The inputs.json file is a large file with many options that can be edited by the user. An example of a valid input file is shown below ("Example Inputs File"). That is followed by a breakdown ("Components of the Input File") by section, and an explanation for each input. Where appropriate, the documentation will refer to an external source (i.e. SAIGE-GENE options).

> **IMPORTANT NOTE:**
>
> The inputs file is a JSON file, and therefore [it does not support the use of comments](https://en.wikipedia.org/wiki/JSON#Data_types_and_syntax). All comments in section "Components of the input file", introduced by an arrow "<-", are added only for explanatory purposes. Please make sure you don't include the comments in your actual input file.

## Example inputs file

Example input file

```
{
    "master_aggregate_variant_testing.hpc_system": "Helix",
    "master_aggregate_variant_testing.lsf_project_code": "bio",

    "master_aggregate_variant_testing.genome_version": "GRCh38",

    "master_aggregate_variant_testing.phenotype_input_file": "/gel_data_resources/workflows/input_material/BRS_tools_aggregateVariantTestingWorkflow/input_user_data/phenotype_day0_covid_aggV2.phen",
    "master_aggregate_variant_testing.phenotype_column_delimiter": " ",
    "master_aggregate_variant_testing.phenotype_sample_column": "IID",
    "master_aggregate_variant_testing.phenotype_case_or_control_column": "phen_ANA_C1_v1",
    "master_aggregate_variant_testing.phenotype_control_value": "0",
    "master_aggregate_variant_testing.phenotype_case_value": "1",

    "master_aggregate_variant_testing.min_info_af": 0,
    "master_aggregate_variant_testing.max_info_af": 1,

    "master_aggregate_variant_testing.part_1_inputs.chromosomes_input_file": null,
    "master_aggregate_variant_testing.part_1_inputs.genes_input_file": "input_user_data/genes.txt",
    "master_aggregate_variant_testing.part_1_inputs.coordinates_input_file": null,

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
    "master_aggregate_variant_testing.part_2_filtering.vep_severity_scale": "resources/VEP_severity_scale_2020.txt",
    "master_aggregate_variant_testing.part_2_filtering.vep_filtering_python_script": "resources/VEP_filtering_script.py",
    "master_aggregate_variant_testing.part_2_filtering.vep_functional_annotation_labels": "resources/VEP_functional_annotation_labels.txt",
    "master_aggregate_variant_testing.part_2_filtering.vep_rare_variant_databases_labels": ["AF", "AFR_AF", "AMR_AF", "EAS_AF", "EUR_AF", "SAS_AF", "AA_AF", "EA_AF", "MAX_AF", "MAX_AF_POPS", "gnomADg_AF", "gnomADg_AF_afr", "gnomADg_AF_amr", "gnomADg_AF_asj", "gnomADg_AF_eas", "gnomADg_AF_sas", "gnomADg_AF_fin", "gnomADg_AF_nfe", "gnomADg_AF_oth", "gnomADg_AF_ami", "gnomADg_AF_male", "gnomADg_AF_female", "topmedg_AF"],
    "master_aggregate_variant_testing.part_2_filtering.functional_annotation_filters": [
        {"score": "gnomADg_AF", "condition": "<0.001"},
        {"score": "LoF", "condition": "==\"HC\""}
    ],

    "master_aggregate_variant_testing.part_2_filtering.min_fmt_dp": 10,
    "master_aggregate_variant_testing.part_2_filtering.min_fmt_gq": 20,
    "master_aggregate_variant_testing.part_2_filtering.pvalue_fmt_abratio": 0.001,

    "master_aggregate_variant_testing.part_2_filtering.keep_half_missing_as_ref": false,
    "master_aggregate_variant_testing.part_2_filtering.max_allowed_missingness": 0.05,
    "master_aggregate_variant_testing.part_2_filtering.final_max_info_ac_to_exclude": 0,

    "master_aggregate_variant_testing.part_2_filtering.regions_file_python_script": "resources/regions_file_script.py",

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
    "master_aggregate_variant_testing.part_3_GRM_creation.sites_file_path": null,
    "master_aggregate_variant_testing.part_3_GRM_creation.use_sites_file": false,
    "master_aggregate_variant_testing.part_3_GRM_creation.percent_chunks_to_keep": 20,
    "master_aggregate_variant_testing.part_3_GRM_creation.variants_to_include": 10,

    "master_aggregate_variant_testing.part_4_testing.saige_singularity": "/gel_data_resources/workflows/input_material/BRS_tools_aggregateVariantTestingWorkflow/resources/saige_0.39.sif",
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
    "master_aggregate_variant_testing.part_4_testing.IsSingleVarinGroupTest": "TRUE",
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

    "master_aggregate_variant_testing.part_4_testing.saige_output_file_name": "output_file_name.txt"
}
```

## Components of the input file

There are five parts in the input file, that correspond to the five parts of the aggregate variant testing workflow. These are prefixed in the following manner:

- master\_aggregate\_variant\_testing
- master\_aggregate\_variant\_testing.part\_1
- master\_aggregate\_variant\_testing.part\_2
- master\_aggregate\_variant\_testing.part\_3
- master\_aggregate\_variant\_testing.part\_4

### Main workflow file

This section contains the following input variables with explanations:

Example main workflow file inputs

```
hpc_system": "Helix"   <- Do not change this
lsf_project_code": "bio"   <- Change this to your LSF project code
genome_version": "GRCh38"   <- Do not change this
phenotype_input_file": "/gel_data_resources/workflows/input_material/BRS_tools_aggregateVariantTestingWorkflow/input_user_data/phenotype_day0_covid_aggV2.phen"   <- Change this to the full path to your phenotype file
phenotype_column_delimiter": " "   <- The delimeter used in your phenotype file, can likely keep the same
phenotype_sample_column": "IID"   <- Change this to the column name that identifies your sample IDs (IID in the example phenotype file)
phenotype_case_or_control_column": "phen_ANA_C1_v1"   <- Change this to the column name that identifies your phenotype
phenotype_control_value": "0"   <- Do not change (code controls as 0 in your phenotype file)
phenotype_case_value": "1"   <- Do not change (code cases as 1 in your phenotype file)
min_info_af": 0   <- Change to the minimum allele frequency to include (variants with a frequency less than this will be filtered out)
max_info_af": 1   <- Change to the maximum allele frequency to include (variants with a frequency greater than this will be filtered out)
```

### Workflow part 1 inputs - Translating inputs to chromosomal regions

This section contains the following input variables with explanations:

Part 1 inputs

```
part_1_inputs.chromosomes_input_file": null   <- Change this to a file with the chromosomes that you want to test, one per line in GRCh38 naming (e.g. chr1, chr2). Set to null if you don't want to use this as an input file.
part_1_inputs.genes_input_file": "input_user_data/genes.txt"   <- Change this to a file with a list of genes that you want to test, one per line (e.g. BRCA1, FMO3). Set to null if you don't want to use this as an input file.
part_1_inputs.coordinates_input_file": null   <- Change this to a tab seperated file of regions that you want to test, one per line (e.g. chr17 43044295    43170245). Set to null if you don't want to use this as an input file.
part_1_inputs.platekeys_input_file": null   <- Do not change this (useful only if you do not specify a phenotype file and you do not actually run tests)
```

> **Note:**
>
> Only one of "`chromosomes_input_file`", "`genes_input_file`", and "`coordinates_input_file`" needs to be specified - for the file path, both relative and absolute paths are accepted.

### Workflow part 2 inputs - Filtering

This section contains the following input variables with explanations:

Part 2 inputs

```
part_2_filtering.use_main_filtering: true   <- Whether to use site wide filtering (defined below)
part_2_filtering.use_vep_filtering: true   <- Whether to use VEP functional annotation filtering
part_2_filtering.use_masking: true   <- Whether to apply a final masking of sites that have more than the allowed level of missingness (defined below)

part_2_filtering.filter_values_to_include: ["PASS"]   <- Change to the list of filters that you are OK with including (here PASS sites only)
part_2_filtering.info_bcftools_expressions_to_include: [   <- Change to the list of site wide criteria to keep a site. Here we have SNPs only, max allele count of 20, a median sitewide depth in non-missing samples of 20, and a median GQ of 30
        "INFO/OLD_MULTIALLELIC='.'",
        "INFO/OLD_CLUMPED='.'",
        "TYPE='snp'",
        "(INFO/AC<=20 || INFO/AC>=INFO/AN-20)",
        "INFO/medianDepthNonMiss>20",
        "INFO/medianGQ>=30"
    ]
part_2_filtering.vep_severity_to_include: "missense+"   <- Change to the minimum VEP severity to include the site. Set to "" to include all sites (i.e. do not consider VEP severity). VEP severity scale can be found here: https://m.ensembl.org/info/genome/variation/prediction/predicted_data.html
part_2_filtering.vep_severity_scale: "resources/VEP_severity_scale_2020.txt"   <- A helper file containing the VEP severity scale. Do not change.
part_2_filtering.vep_filtering_python_script: "resources/VEP_filtering_script.py"   <- A helper script for filtering functional annotations. Do not change.
part_2_filtering.vep_functional_annotation_labels: "resources/VEP_functional_annotation_labels.txt"   <- A helper file listing all teh VEP annotations in the aggregate. Do not change.
part_2_filtering.vep_rare_variant_databases_labels: ["AF", "AFR_AF", "AMR_AF", "EAS_AF", "EUR_AF", "SAS_AF", "AA_AF", "EA_AF", "MAX_AF", "MAX_AF_POPS", "gnomADg_AF", "gnomADg_AF_afr", "gnomADg_AF_amr", "gnomADg_AF_asj", "gnomADg_AF_eas", "gnomADg_AF_sas", "gnomADg_AF_fin", "gnomADg_AF_nfe", "gnomADg_AF_oth", "gnomADg_AF_ami", "gnomADg_AF_male", "gnomADg_AF_female", "topmedg_AF"]   <- A list of all the external allele frequency sources in the annotation files. Do not change.
part_2_filtering.functional_annotation_filters: [   <- Change to the specific functional annotations that you want to filter for. Note that there is an important difference between numbers and strings, which will be explained in the warning box below.
        {"score": "gnomADg_AF", "condition": "<0.001"},
        {"score": "LoF", "condition": "==\"HC\""}
    ]
part_2_filtering.min_fmt_dp: 10   <- Change to the minimum depth PER SAMPLE to include a sample at each site.
part_2_filtering.min_fmt_gq: 20   <- Change to the mimimum GQ PER SAMPLE to include a sample at each site.
part_2_filtering.pvalue_fmt_abratio: 0.001   <- Change to the minimum AB ratio PER SAMPLE to include a sample at each site.
part_2_filtering.keep_half_missing_as_ref: false   <- Whether to set half missing calls to reference. true / false.
part_2_filtering.max_allowed_missingness: 0.05   <- Change to the maximum allowed missingness at a site, after all filters have been applied.
part_2_filtering.final_max_info_ac_to_exclude: 0   <- Change to filter out any sites that have an allele count of this or fewer (sites may become monomorphic or drop to very few variant calls after all the filtering)
part_2_filtering.regions_file_python_script: "resources/regions_file_script.py"   <- A helper script for region filtering. Do not change.
```

> **Note:**
>
> The workflow uses a python script to filter VEP functional annotation. This has consequences in how you specify filtering based on numbers vs strings.
>
> Numbers are straightforward. The syntax is as follows: {"score": "gnomADg\_AF", "condition": "<0.001"}. You can specify any valid comparison operator (==, !=, >=, <=) and filter numbers based on them.
>
> Strings behave a little differently. The syntax is as follows: {"score": "LoF", "condition": "==\"HC\""}. Note the escaped quotes (\") around the string that you want to match. This is required due to the nature of the underlying python script. If they are omitted, you will get an error like the following: "Error: object 'HC' not found"

### Workflow part 3 inputs - GRM creation

This section contains the following input variables with explanations:

Part 3 inputs

```
part_3_GRM_creation.MAC_categories: [   <- Minor allele categories for GRM creation. These ranges are defined by the developer of SAIGE. Do not change.
        [1,2],
        [2,3],
        [3,4],
        [4,5],
        [5,6],
        [6,11],
        [11,21]
    ],
part_3_GRM_creation.sparse_plink_files: [   <- Path to the location of the PLINK files containing high quality common SNPs that are alos in 1,000 genomes. Do not change.
        "/gel_data_resources/workflows/input_material/BRS_tools_aggregateVariantTestingWorkflow/resources/aggV2_HQ_SNPs_sparse_plink_files.bed",
        "/gel_data_resources/workflows/input_material/BRS_tools_aggregateVariantTestingWorkflow/resources/aggV2_HQ_SNPs_sparse_plink_files.bim",
        "/gel_data_resources/workflows/input_material/BRS_tools_aggregateVariantTestingWorkflow/resources/aggV2_HQ_SNPs_sparse_plink_files.fam"
    ],
part_3_GRM_creation.sites_file_path: null   <- Change to a path containing a list of sites to use for GRM creation, one per aggregate chunk. Does not need to be specified.
part_3_GRM_creation.use_sites_file: false   <- Whether to use a list of sites for GRM creation, or extract sites from the aggregate files directly. Can be left false in most, if not all, cases.
part_3_GRM_creation.percent_chunks_to_keep: 20   <- To speed creation of the GRM, only X percent of chunks are used to extract sites. Change this value to sue more or fewer chunks (note that using 100% of chunks will take a long time).
part_3_GRM_creation.variants_to_include: 10   <- Change to set the number of variants per MAC category per chunk. The SAIGE developers recommend at least 2,000 variants per category.
```

### Workflow part 4 inputs - Aggregate Variant Tests with SAIGE-GENE

Part 4 inputs

```
part_4_testing.saige_singularity: "/gel_data_resources/workflows/input_material/BRS_tools_aggregateVariantTestingWorkflow/resources/saige_0.39.sif"   <- Path to the singularity container containing SAIGE. Change if a new container is available.
part_4_testing.relatedness_cutoff_for_sparseGRM: 0.125   <- The pairwise relationship cutoff for generating the sparse GRM. Values below this will be set to 0\. The default recommended by SAIGE.
part_4_testing.num_random_marker_for_sparse_kin: 2000   <- The number of random markers used to generate the sparse GRM. The default recommended by SAIGE.
part_4_testing.IsSparseKin: "TRUE"   <- Required to perform aggregate variant testing. Do not change.
part_4_testing.traitType: "binary"   <- Binary or quantitative trait. Currently the workflow only works for binary traits. Do not change.
part_4_testing.invNormalize: "false"   <- Do not change, only relevant for quantitative traits.
part_4_testing.phenotype_covariate_column_names: "ancestry,age,sex,age2,age.sex,PC1,PC2,PC3,PC4,PC5,PC6,PC7,PC8,PC9,PC10,PC11,PC12,PC13,PC14,PC15,PC16,PC17,PC18,PC19,PC20"   <- Change to match the covariate columns in your phenotype file.
part_4_testing.tol: 0.02   <- The default recommended by SAIGE. Only change if you know what you are doing.
part_4_testing.maxiter: 20   <- The default recommended by SAIGE. Only change if you know what you are doing.
part_4_testing.tolPCG: 1e-5   <- The default recommended by SAIGE. Only change if you know what you are doing.
part_4_testing.maxiterPCG: 500   <- The default recommended by SAIGE. Only change if you know what you are doing.
part_4_testing.SPAcutoff: 2   <- The default recommended by SAIGE. Only change if you know what you are doing.
part_4_testing.numRandomMarkerforVarianceRatio: 30   <- The default recommended by SAIGE. Only change if you know what you are doing.
part_4_testing.skipModelFitting: "FALSE"   <- The default recommended by SAIGE. Only change if you know what you are doing.
part_4_testing.tauInit: "0,0"   <- The default recommended by SAIGE. Only change if you know what you are doing.
part_4_testing.LOCO: "FALSE"   <- Leave one chromosome out.
part_4_testing.traceCVcutoff: 0.0025   <- The default recommended by SAIGE. Only change if you know what you are doing.
part_4_testing.ratioCVcutoff: 0.001   <- The default recommended by SAIGE. Only change if you know what you are doing.
part_4_testing.isCateVarianceRatio: "TRUE"   <- The default recommended by SAIGE. Only change if you know what you are doing.
part_4_testing.cateVarRatioMinMACVecExclude: "0.5,1.5,2.5,3.5,4.5,5.5,10.5,20.5"   <- The default recommended by SAIGE. Only change if you know what you are doing.
part_4_testing.cateVarRatioMaxMACVecInclude: "1.5,2.5,3.5,4.5,5.5,10.5,20.5"   <- The default recommended by SAIGE. Only change if you know what you are doing.
part_4_testing.isCovariateTransform: "TRUE"   <- The default recommended by SAIGE. Only change if you know what you are doing.
part_4_testing.useSparseSigmaforInitTau: "FALSE"   <- The default recommended by SAIGE. Only change if you know what you are doing.
part_4_testing.minMAFforGRM: 0.01   <- The default recommended by SAIGE. Only change if you know what you are doing.
part_4_testing.minCovariateCount: -1   <- The default recommended by SAIGE. Only change if you know what you are doing.
part_4_testing.includeNonautoMarkersforVarRatio: "FALSE"   <- The default recommended by SAIGE. Only change if you know what you are doing.

part_4_testing.IsDropMissingDosages: "TRUE"   <- Whether to drop samples with missing genotypes in a group, or mean impute them. Set to TRUE due to the filtering applied earlier, that would be wasted if we imputed the values (also we know the truth of the sites, so we don't need to impute them).
part_4_testing.vcfField: "GT"   <- Which field contains the genotype information in the VCF. Do not change.
part_4_testing.minMAF: 0   <- Minimum minor allele frequency to include for testing.
part_4_testing.maxMAFforGroupTest: 0.5   <- Maximum minor allele frequency to include for testing.
part_4_testing.minMAC: 0   <- Mimimum minor allele count to include for testing.
part_4_testing.numLinesOutput: 10000   <- The maximum number of lines to output.
part_4_testing.is_sparse: "TRUE"   <- Do not change.
part_4_testing.IsOutputAFinCaseCtrl: "TRUE"   <- Output case and control allele frequency.
part_4_testing.IsOutputNinCaseCtrl: "TRUE"   <- Output the number of samples for cases and controls.
part_4_testing.IsOutputHetHomCountsinCaseCtrl: "TRUE"   <- Output counts for the number of hets and homs in the cases and controls.
part_4_testing.condition: ""   <- Advanced usage.
part_4_testing.IsSingleVarinGroupTest: "FALSE"   <- Also output single variant tests for each group. There is a bug in the current version of SAIGE-GENE that causes this to crash with smaller sample numbers.
part_4_testing.kernel: "linear.weighted"   <- The default recommended by SAIGE. Only change if you know what you are doing.
part_4_testing.method: "optimal.adj"   <- The default recommended by SAIGE. Only change if you know what you are doing.
part_4_testing.weights_beta_rare: "1,25"   <- The default recommended by SAIGE. Only change if you know what you are doing.
part_4_testing.weights_beta_common: "1,25"   <- The default recommended by SAIGE. Only change if you know what you are doing.
part_4_testing.weightMAFcutoff: 0.01   <- The default recommended by SAIGE. Only change if you know what you are doing.
part_4_testing.r_corr: "0"   <- The default recommended by SAIGE. Only change if you know what you are doing.
part_4_testing.dosageZerodCutoff: 0.2   <- The default recommended by SAIGE. Only change if you know what you are doing.
part_4_testing.IsOutputPvalueNAinGroupTestforBinary": "TRUE"   <- Do not change
part_4_testing.IsAccountforCasecontrolImbalanceinGroupTest: "TRUE"   <- whether to account for case control imbalance in your cohort. Do not change.
part_4_testing.weightsIncludeinGroupFile: "FALSE"   <- Should variants be valued differently, according to values specified in the group file. Not currently supported in the workflow.
weights_for_G2_cond": ""   <- The default recommended by SAIGE. Only change if you know what you are doing.
part_4_testing.IsOutputBETASEinBurdenTest: "TRUE"   <- Do not change
part_4_testing.saige_output_file_name: "output_file_name.txt"   <- Change to the name of your output file.
```

## Help and support

Please reach out via the [Genomics England Service Desk](../help/) for any issues related to running this script, including "AVT\_workflow" in the title/description of your inquiry.

October 28, 2022
