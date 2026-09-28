---
title: 'Detailed examples on how to query the aggregated dataset - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/avt_example2/
scraped_at: 2026-05-04T06:31:19Z
---

# Detailed examples on how to query the aggregated dataset

Here are some example use cases for this version of the Aggregate Variant Testing (AVT) workflow - for each case, we show what needs to be modified in the workflow files, in particular in the "input variables" file.

The example are not necessarily mutually exclusive, so we recommend taking a look at the simplest ones (top ones) anyway.

## Example 1 - I want to run AVT for all protein-coding genes in chr20, only missense variants or worse, low allele frequency in gnomAD

This is a basic use case. All protein coding genes in chr20 will be processed.

The **input variables file** needs to be modified in a few places - for example, this file would work (please see details below):

input variables file for Example 1

```
{
    "master_aggregate_variant_testing.lsf_project_code": "<your_HPC_project_code>",

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

    "master_aggregate_variant_testing.precomputed_plink_files_for_grm": [
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
        {"score": "gnomADg_AF", "condition": "<0.001", "include_missing": "yes"}
    ],

    "master_aggregate_variant_testing.part_2_filtering.min_fmt_dp": 10,
    "master_aggregate_variant_testing.part_2_filtering.min_fmt_gq": 20,
    "master_aggregate_variant_testing.part_2_filtering.pvalue_fmt_abratio": 0.001,

    "master_aggregate_variant_testing.part_2_filtering.keep_half_missing_as_ref": false,
    "master_aggregate_variant_testing.part_2_filtering.differential_missingness_pvalue": "10e-5",
    "master_aggregate_variant_testing.part_2_filtering.max_allowed_missingness": 0.05,
    "master_aggregate_variant_testing.part_2_filtering.final_max_info_ac_to_exclude": 0,

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
                "directory": "/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/functional_annotation/VEP",
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
                "directory": "/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/functional_annotation/VEP",
                "suffix_and_extension": "_VEPannot.vcf.gz",
                "index_extra_extension": ".csi"
            }
        }
    },

    "master_aggregate_variant_testing.part_2_filtering.extraction_filtering_python_script": "resources/extraction_filtering_script.py",
    "master_aggregate_variant_testing.part_2_filtering.vep_severity_scale_ensembl_translation": "resources/VEP_severity_scale_translation_2020_Ensembl_to_bcftools_splitvep.tsv",
    "master_aggregate_variant_testing.part_2_filtering.vep_filtering_python_script": "resources/VEP_filtering_script.py",
    "master_aggregate_variant_testing.part_2_filtering.pheno_plink_helper_python_script": "resources/pheno_helper_script.py",
    "master_aggregate_variant_testing.part_2_filtering.regions_file_python_script": "resources/regions_file_script.py"
}
```

Please note that this is very similar to the default content for this file. The most important variables to consider are:

- `lsf_project_code` : change this to your HPC project code, as usual
- `input_variants_dataset` : this was set to the name of the dataset containing Genomics England variants for protein coding genes only
- `phenotype_input_file` : this was set to the path of an example phenotype file you can use - if you change this to your own cohort's phenotype file, remember to amend the following few variables as appropriate
- `precomputed_plink_files_for_grm` : this was set to an empty array, meaning that the GRM will be computed from scratch in this case
- `part_1_inputs.chromosomes_input_file` : this was set to the path of the file containing the chromosome name
- `part_2_filtering.info_bcftools_expressions_to_include` : we are including here further filters, for example processing only SNPs, which can be removed or altered if needed
- `part_2_filtering.vep_severity_to_include` : this was set to accept only variants that are annotated by VEP to have a Consequence of missense or worse
- `part_2_filtering.functional_annotation_filters` : this was set to include only one condition, gnomAD frequency < 0.001, and to include variants that are missing from gnomAD altogether
- `part_4_testing.saige_output_file_name` : this was set to the name of the output file, to be created in the folder specified in the "options.json" file

Moreover, you need to make sure that the file referred to by variable "`part_1_inputs.chromosomes_input_file`", i.e. **the file found at "input\_user\_data/chromosomes.txt"**, contains only one line, equal to "chr20".

Finally, you need to specify your HPC project code in **the file called "submit\_workflow.sh"**, too.

## Example 2 - I want to run AVT for my regions with my own set of variants in protein coding genes

Assuming all variants of interest have an [Ensembl Consequence](https://www.ensembl.org/info/genome/variation/prediction/predicted_data.html) of at least 3\_prime\_UTR\_variant or worse, we can use the "aggV2\_PASS\_UTRplus\_proteincodinggenes" dataset again.

The **input variables file** needs to be modified in a few places - for example, this file would work (please see details below):

input variables file for Example 2

```
{
    "master_aggregate_variant_testing.lsf_project_code": "<your_HPC_project_code>",

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

    "master_aggregate_variant_testing.precomputed_plink_files_for_grm": [
        "/gel_data_resources/workflows/input_material/BRS_tools_aggregateVariantTestingWorkflow/input_user_data/phenotype_day0_covid_aggV2.plink_set_for_tests_all_samples.bed",
        "/gel_data_resources/workflows/input_material/BRS_tools_aggregateVariantTestingWorkflow/input_user_data/phenotype_day0_covid_aggV2.plink_set_for_tests_all_samples.bim",
        "/gel_data_resources/workflows/input_material/BRS_tools_aggregateVariantTestingWorkflow/input_user_data/phenotype_day0_covid_aggV2.plink_set_for_tests_all_samples.fam"
    ],

    "master_aggregate_variant_testing.part_1_inputs.chromosomes_input_file": "input_user_data/chromosomes.txt",
    "master_aggregate_variant_testing.part_1_inputs.genes_input_file": null,
    "master_aggregate_variant_testing.part_1_inputs.coordinates_input_file": null,
    "master_aggregate_variant_testing.part_1_inputs.groups_input_file": "input_user_data/groups.tsv",

    "master_aggregate_variant_testing.part_1_inputs.upstream_downstream_length": 0,

    "master_aggregate_variant_testing.part_1_inputs.platekeys_input_file": null,

    "master_aggregate_variant_testing.part_2_filtering.use_main_filtering": true,
    "master_aggregate_variant_testing.part_2_filtering.use_vep_filtering": false,
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
    "master_aggregate_variant_testing.part_2_filtering.differential_missingness_pvalue": "10e-5",
    "master_aggregate_variant_testing.part_2_filtering.max_allowed_missingness": 0.05,
    "master_aggregate_variant_testing.part_2_filtering.final_max_info_ac_to_exclude": 0,

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
                "directory": "/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/functional_annotation/VEP",
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
                "directory": "/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/functional_annotation/VEP",
                "suffix_and_extension": "_VEPannot.vcf.gz",
                "index_extra_extension": ".csi"
            }
        }
    },

    "master_aggregate_variant_testing.part_2_filtering.extraction_filtering_python_script": "resources/extraction_filtering_script.py",
    "master_aggregate_variant_testing.part_2_filtering.vep_severity_scale_ensembl_translation": "resources/VEP_severity_scale_translation_2020_Ensembl_to_bcftools_splitvep.tsv",
    "master_aggregate_variant_testing.part_2_filtering.vep_filtering_python_script": "resources/VEP_filtering_script.py",
    "master_aggregate_variant_testing.part_2_filtering.pheno_plink_helper_python_script": "resources/pheno_helper_script.py",
    "master_aggregate_variant_testing.part_2_filtering.regions_file_python_script": "resources/regions_file_script.py"
}
```

Please note that this is very similar to the default content for this file. The most important variables to consider are:

- `lsf_project_code` : change this to your HPC project code, as usual
- `input_variants_dataset` : this was set to the name of the dataset containing Genomics England variants for protein coding genes only
- `phenotype_input_file` : this was set to the path of an example phenotype file you can use - if you change this to your own cohort's phenotype file, remember to amend the following few variables as appropriate
- `precomputed_plink_files_for_grm` : this time, this was set to an array of existing plink files corresponding to the same cohort as the phenotype file, meaning that the GRM will be re-used and the whole part\_3 of the workflow will be skipped
- `part_1_inputs.chromosomes_input_file` : this was set to the path of the file containing the chromosome name
- ``` part_1_inputs.``groups_input_file ``` : this was set to the path of the file containing the custom variants, split by custom region/group
- `part_2_filtering.use_vep_filtering` : this is set to false, as VEP annotation filtering cannot be used for custom variant groups (note that this will be set to false automatically by the workflow at runtime anyway, if the `groups_input_file` variable is provided)
- `part_2_filtering.info_bcftools_expressions_to_include` : we are including here further filters, for example processing only SNPs, which can be removed or altered if needed
- `part_2_filtering.vep_severity_to_include` : the value provided for this variable is irrelevant (here it is left as the default), as we are not going to use VEP annotation filtering
- `part_2_filtering.functional_annotation_filters` : the value provided for this variable is irrelevant (here it is left as the default), as we are not going to use VEP annotation filtering
- `part_4_testing.saige_output_file_name` : this was set to the name of the output file, to be created in the folder specified in the "options.json" file

Then, your own regions and variants need to be provided in the file referred to by variable "`part_1_inputs.groups_input_file`", i.e. **the file found at "input\_user\_data/groups.tsv"**. The file format is described in the main documentation page; briefly, each line represents a region (group of variants), so the first field in the line is an identifier for the group, followed by TAB and then a TAB-separated list of the variants in that group, formatted as `CHR:POS_REF/ALT` . Please note that the final list of variants processed may be smaller, because in this example we are still performing some filtering and masking on the custom variants, as shown by the fact taht variables "`part_2_filtering.use_main_filtering`" and "`part_2_filtering.use_masking`" are set to "true".

Moreover, you need to make sure that the file referred to by variable "`part_1_inputs.chromosomes_input_file`", i.e. **the file found at "input\_user\_data/chromosomes.txt"**, contains only one line, equal to the name of the chromosome you want to process. The "`groups_input_file`" file discussed just above will be subset to this chromosome, meaning that only variants on this chromosome will be processed in this run.

Finally, you need to specify your HPC project code in **the file called "submit\_workflow.sh"**, too.

## Example 3 - I want to run AVT on selected parts of the genome and I have the coordinates

Assuming that some of the location of interest may be outside protein-coding genes, we will use the full Genomics England dataset of variants for this example use case - please note that this causes in average much longer run times compared to the other dataset.

The **input variables file** needs to be modified in a few places - for example, this file would work (please see details below):

input variables file for Example 3

```
{
    "master_aggregate_variant_testing.lsf_project_code": "<your_HPC_project_code>",

    "master_aggregate_variant_testing.genome_build": "GRCh38",
    "master_aggregate_variant_testing.input_variants_dataset": "aggV2",

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

    "master_aggregate_variant_testing.precomputed_plink_files_for_grm": [
        "/gel_data_resources/workflows/input_material/BRS_tools_aggregateVariantTestingWorkflow/input_user_data/phenotype_day0_covid_aggV2.plink_set_for_tests_all_samples.bed",
        "/gel_data_resources/workflows/input_material/BRS_tools_aggregateVariantTestingWorkflow/input_user_data/phenotype_day0_covid_aggV2.plink_set_for_tests_all_samples.bim",
        "/gel_data_resources/workflows/input_material/BRS_tools_aggregateVariantTestingWorkflow/input_user_data/phenotype_day0_covid_aggV2.plink_set_for_tests_all_samples.fam"
    ],

    "master_aggregate_variant_testing.part_1_inputs.chromosomes_input_file": "input_user_data/chromosomes.txt",
    "master_aggregate_variant_testing.part_1_inputs.genes_input_file": null,
    "master_aggregate_variant_testing.part_1_inputs.coordinates_input_file": "input_user_data/coordinates.bed",
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
    "master_aggregate_variant_testing.part_2_filtering.vep_severity_to_include": "synonymous+",
    "master_aggregate_variant_testing.part_2_filtering.vep_severity_scale": "resources/VEP_severity_scale_2020_bcftools_splitvep.txt",
    "master_aggregate_variant_testing.part_2_filtering.functional_annotation_filters": [
        {"score": "gnomADg_AF", "condition": "<0.001", "include_missing": "yes"},
        {"score": "CADD_PHRED", "condition": ">=10", "include_missing": "no"}
    ],

    "master_aggregate_variant_testing.part_2_filtering.min_fmt_dp": 10,
    "master_aggregate_variant_testing.part_2_filtering.min_fmt_gq": 20,
    "master_aggregate_variant_testing.part_2_filtering.pvalue_fmt_abratio": 0.001,

    "master_aggregate_variant_testing.part_2_filtering.keep_half_missing_as_ref": false,
    "master_aggregate_variant_testing.part_2_filtering.differential_missingness_pvalue": "10e-5",
    "master_aggregate_variant_testing.part_2_filtering.max_allowed_missingness": 0.05,
    "master_aggregate_variant_testing.part_2_filtering.final_max_info_ac_to_exclude": 0,

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
                "directory": "/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/functional_annotation/VEP",
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
                "directory": "/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/functional_annotation/VEP",
                "suffix_and_extension": "_VEPannot.vcf.gz",
                "index_extra_extension": ".csi"
            }
        }
    },

    "master_aggregate_variant_testing.part_2_filtering.extraction_filtering_python_script": "resources/extraction_filtering_script.py",
    "master_aggregate_variant_testing.part_2_filtering.vep_severity_scale_ensembl_translation": "resources/VEP_severity_scale_translation_2020_Ensembl_to_bcftools_splitvep.tsv",
    "master_aggregate_variant_testing.part_2_filtering.vep_filtering_python_script": "resources/VEP_filtering_script.py",
    "master_aggregate_variant_testing.part_2_filtering.pheno_plink_helper_python_script": "resources/pheno_helper_script.py",
    "master_aggregate_variant_testing.part_2_filtering.regions_file_python_script": "resources/regions_file_script.py"
}
```

Please note that this is very similar to the default content for this file. The most important variables to consider are:

- `lsf_project_code` : change this to your HPC project code, as usual
- `input_variants_dataset` : this was set to the name of the dataset containing all of Genomics England variants
- `phenotype_input_file` : this was set to the path of an example phenotype file you can use - if you change this to your own cohort's phenotype file, remember to amend the following few variables as appropriate
- `precomputed_plink_files_for_grm` : this was set to an array of existing plink files corresponding to the same cohort as the phenotype file, meaning that the GRM will be re-used and the whole part\_3 of the workflow will be skipped, saving considerable time for this large variant dataset
- `part_1_inputs.chromosomes_input_file` : this was set to the path of the file containing the chromosome name
- ``` part_1_inputs.``coordinates_input_file ``` : this was set to the path of a BED file containing the locations of interest
- `part_2_filtering.use_vep_filtering` : this is set to true again, as VEP annotation filtering is available for this use case (note that all variants athis will be set to false automatically by the workflow at runtime anyway, if the `groups_input_file` variable is provided)
- `part_2_filtering.info_bcftools_expressions_to_include` : we are including here further filters, for example processing only SNPs, which can be removed or altered if needed
- `part_2_filtering.vep_severity_to_include` : this was set to a Consequence of synonymous or worse
- `part_2_filtering.functional_annotation_filters` : the same filter for gnomAD frequencies was used as in Example 1; also, a filter was added that selects variants annotated with CADD PHRED vale >=10, and excludes variants with no CADD PHRED annotations
- `part_4_testing.saige_output_file_name` : this was set to the name of the output file, to be created in the folder specified in the "options.json" file

Then, your own genome locations of interest need to be provided in a BED file, referred to by variable "`part_1_inputs.coordinates_input_file`", i.e. **the file found at "input\_user\_data/coordinates.bed"**. Each line of the BED file will be interpreted as a group of variants, meainng that all variants found at locations included in that line will be processed together for the actual Aggregate Variant Testing. Please note that in this use case, variants can be filtered and masked like in Example 1, including being filtered by VEP annotation values - for each individual locus, all variants will be processed together regardless of the gene they affect, because no gene information is present in the input (for instance, only the variant and transcript with worst Consequence will be processed for each locus, even if two genes span that locus). Also, in this use case the **longest stretch of genome** that is allowed for one line of the BED file is 3 Mbp.

Moreover, you need to make sure that the file referred to by variable "`part_1_inputs.chromosomes_input_file`", i.e. **the file found at "input\_user\_data/chromosomes.txt"**, contains only one line, equal to the name of the chromosome you want to process. The "`coordinates_input_file`" file discussed just above will be subset to this chromosome, meaning that only variants on this chromosome will be processed in this run.

Finally, you need to specify your HPC project code in **the file called "submit\_workflow.sh"**, too.

## Example 4 - I want to run AVT on chrX

Please note that the workflow has not been tested extensively for chrX analysis. The workflow must always be run separately for chrX, and currently **only on a single-sex cohort** (female samples only, or male samples only). **This example use case is for a male-only cohort**, so that we can highlight a couple of variables that can be used for non-PAR regions in the case of male samples - but the workflow can be run in a very similar way on female-only cohorts.

We want to run AVT on **all protein coding genes in chrX for our cohort** - therefore, this use case is similar to Example 1 from that perspective.

The **input variables file** needs to be modified in a few places - for example, this file would work (please see details below):

input variables file for Example 4

```
{
    "master_aggregate_variant_testing.lsf_project_code": "<your_HPC_project_code>",

    "master_aggregate_variant_testing.genome_build": "GRCh38",
    "master_aggregate_variant_testing.input_variants_dataset": "aggV2_PASS_UTRplus_proteincodinggenes",

    "master_aggregate_variant_testing.phenotype_input_file": "/gel_data_resources/workflows/input_material/BRS_tools_aggregateVariantTestingWorkflow/input_user_data/phenotype_day0_covid_aggV2_male_only.phen",
    "master_aggregate_variant_testing.phenotype_column_delimiter": " ",
    "master_aggregate_variant_testing.phenotype_sample_column": "IID",
    "master_aggregate_variant_testing.phenotype_case_or_control_column": "phen_ANA_C1_v1",
    "master_aggregate_variant_testing.phenotype_control_value": "0",
    "master_aggregate_variant_testing.phenotype_case_value": "1",

    "master_aggregate_variant_testing.chrX_female_only_cohort": false,
    "master_aggregate_variant_testing.chrX_male_only_cohort": true,

    "master_aggregate_variant_testing.min_info_af": 0,
    "master_aggregate_variant_testing.max_info_af": 1,

    "master_aggregate_variant_testing.precomputed_plink_files_for_grm": [
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
        {"score": "gnomADg_AF", "condition": "<0.001", "include_missing": "yes"}
    ],

    "master_aggregate_variant_testing.part_2_filtering.min_fmt_dp": 10,
    "master_aggregate_variant_testing.part_2_filtering.min_fmt_gq": 20,
    "master_aggregate_variant_testing.part_2_filtering.pvalue_fmt_abratio": 0.001,

    "master_aggregate_variant_testing.part_2_filtering.keep_half_missing_as_ref": false,
    "master_aggregate_variant_testing.part_2_filtering.differential_missingness_pvalue": "10e-5",
    "master_aggregate_variant_testing.part_2_filtering.max_allowed_missingness": 0.05,
    "master_aggregate_variant_testing.part_2_filtering.final_max_info_ac_to_exclude": 0,

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
    "master_aggregate_variant_testing.part_4_testing.sampleFile_male": "/gel_data_resources/workflows/input_material/BRS_tools_aggregateVariantTestingWorkflow/input_user_data/phenotype_day0_covid_aggV2.male_samples.txt",
    "master_aggregate_variant_testing.part_4_testing.is_rewrite_XnonPAR_forMales": "TRUE",

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
                "directory": "/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/functional_annotation/VEP",
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
                "directory": "/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/functional_annotation/VEP",
                "suffix_and_extension": "_VEPannot.vcf.gz",
                "index_extra_extension": ".csi"
            }
        }
    },

    "master_aggregate_variant_testing.part_2_filtering.extraction_filtering_python_script": "resources/extraction_filtering_script.py",
    "master_aggregate_variant_testing.part_2_filtering.vep_severity_scale_ensembl_translation": "resources/VEP_severity_scale_translation_2020_Ensembl_to_bcftools_splitvep.tsv",
    "master_aggregate_variant_testing.part_2_filtering.vep_filtering_python_script": "resources/VEP_filtering_script.py",
    "master_aggregate_variant_testing.part_2_filtering.pheno_plink_helper_python_script": "resources/pheno_helper_script.py",
    "master_aggregate_variant_testing.part_2_filtering.regions_file_python_script": "resources/regions_file_script.py"
}
```

Please note that this is very similar to the default content for this file. The most important variables to consider are:

- `lsf_project_code` : change this to your HPC project code, as usual
- `input_variants_dataset` : this was set to the name of the dataset containing Genomics England variants for protein coding genes only
- `phenotype_input_file` : this was set to the path of an example phenotype file you can use (male samples only) - if you change this to your own cohort's phenotype file, remember to amend the following few variables as appropriate
- `chrX_male_only_cohort` : this was set to true, as the cohort is consists of male samples only, and it is for chrX analysis
- `precomputed_plink_files_for_grm` : this was set to an empty array, meaning that the GRM will be computed from scratch in this case
- `part_1_inputs.chromosomes_input_file` : this was set to the path of the file containing the chromosome name
- `part_2_filtering.info_bcftools_expressions_to_include` : we are including here further filters, for example processing only SNPs, which can be removed or altered if needed
- `part_2_filtering.vep_severity_to_include` : this was set to accept only variants that are annotated by VEP to have a Consequence of missense or worse
- `part_2_filtering.functional_annotation_filters` : this was set to include only one condition, gnomAD frequency < 0.001, and to include variants that are missing from gnomAD altogether
- `part_4_testing.sampleFile_male` : this was set to the path to a text file containing a list of the IDs of all male samples in the phenotype file, one per line
- `part_4_testing.is_rewrite_XnonPAR_forMales` : this was set to "TRUE", because we would like SAIGE-GENE to duplicate alleles in non-PAR regions of chrX for male samples
- `part_4_testing.saige_output_file_name` : this was set to the name of the output file, to be created in the folder specified in the "options.json" file

Moreover, you need to make sure that the file referred to by variable "`part_1_inputs.chromosomes_input_file`", i.e. **the file found at "input\_user\_data/chromosomes.txt"**, contains only one line, equal to "chrX".

Finally, you need to specify your HPC project code in **the file called "submit\_workflow.sh"**, too.

October 3, 2023
