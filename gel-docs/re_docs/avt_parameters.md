---
title: 'AVT parameters - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/avt_parameters/
scraped_at: 2026-05-04T06:31:24Z
---

# AVT parameters

These values are over-written by command line arguments passed to `nextflow run` in the submission script `submit.sh`.

For a complete list of workflow parameters (configurable parameters have a `params.` prefix), you can run:

```
nextflow config -flat -profile <profile_name> main.nf | grep ^params
```

All parameters have a default value, which is listed here. To change the parameter, add it to your submission script.

| Category | Parameter | Notes | Default |
| --- | --- | --- | --- |
| General parameters | `--outdir` | The location of the output files | `.` |
|  | `--publish_all` | [whether to publish the intermediate files](../avt_output_files/) | `false` |
|  |  |  |  |
| Input | `--region_input_file` | [file that specifies the region of the genome that needs to be processed](../avt_input_files/#region-input-region_input_file) | `"${projectDir}/input/chromosomes_subset.txt"` |
|  | `--exclusion_data_file` | [a text file containing genomic regions to be excluded](../avt_input_files/#exclusion-data-file-exclusion_data_file) | `false` |
|  |  |  |  |
|  | `--input_cohort_file` | [case/control cohort](../avt_input_files/#input-cohort-file-input_cohort_file) | `"/gel_data_resources/workflows/input_material/RDP_tools_aggregateVariantTestingWorkflow/auxiliary_files/input/cohort.txt"` |
|  | `--cohort_sample_column` | [The column in your cohort file that specifies the platekey](../avt_input_files/#input-cohort-file-input_cohort_file) | `"Platekey"` |
|  | `--cohort_sex_column` | [The column in your cohort file that specifies the sex](../avt_input_files/#input-cohort-file-input_cohort_file) | `"sex"` |
|  | `--control_coding` | [How controls are coded in your input file](../avt_input_files/#input-cohort-file-input_cohort_file) | `0` |
|  | `--phenotype_array` | [List of columns in your input file that contain phenotype data](../avt_input_files/#input-cohort-file-input_cohort_file) | `"status"` |
|  | `--phenotype_type_array` | [List of phenotype types that correspond to the list of phenotype columns - these can be `b` binary or `q` quantitative](../avt_input_files/#input-cohort-file-input_cohort_file) | `"b"` |
|  | `--covariates` | [List of columns of covariates in your input file (for SAIGE-GENE and REGENIE branches)](../avt_input_files/#input-cohort-file-input_cohort_file) - please use `false` if no covariates are needed for SAIGE-GENE and REGENIE. This parameter does not affect the Fisher's test branch at all | `"age,sex,age.age,age.sex,PC1,PC2,PC3,PC4,PC5,PC6,PC7,PC8,PC9,PC10,PC11,PC12,PC13,PC14,PC15,PC16,PC17,PC18,PC19,PC20"` |
|  | `--categorical_covariates` | [List of columns of discrete covariates in your input file (for SAIGE-GENE and REGENIE branches)](../avt_input_files/#input-cohort-file-input_cohort_file) - please use `false` if no categorical covariates are needed for SAIGE-GENE and REGENIE. This parameter does not affect the Fisher's test branch at all | `"sex"` |
|  |  |  |  |
|  | `--variant_type_filter` | `true` to use SNPs only, `false` otherwise | `false` |
|  | `--variant_freq_filter` | this is an integer or floating point value. If the value is a float, then it is assumed to be minor allele *frequency*, while if it is an integer it is assumed to be minor allele *count*. | `0.01` |
|  | `--variant_missingness` |  | `0.05` |
|  | `--protein_coding_genes_only` | if you want to filter by protein coding genes | `true` |
|  | `--diff_missingness_pvalue` |  | `0.05` |
|  |  |  |  |
|  | `--functional_annotation_filter_masks` | [The location of a json file containing functional annotation labels](../avt_input_files/#functional-annotation-filter-masks-file-functional_annotation_filter_masks) | `"${projectDir}/input/functional_annotation_filter_masks.json"` |
|  | `--mask_rank` | [The location of a json file ranking variant consequences](../avt_input_files/#mask-ranks-file-mask_rank) | `"${projectDir}/input/mask_rank.json"` |
|  |  |  |  |
|  | `--run_saige_gene` | [Choose to run SAIGE-GENE](../avt_output_files/#saige-gene) | `true` |
|  | `--saige_masks` |  | `"LoF,LoF;missense"` |
|  |  |  |  |
|  | `--run_regenie` | [Choose to run regenie](../avt_output_files/#regenie) | `true` |
|  | `--regenie_masks` |  | `"${projectDir}/input/regenie_masks.json"` |
|  |  |  |  |
|  | `--run_fishers_test` | [Choose to run Rvtests/Fisher's test](../avt_output_files/#rvtestsfishers-test) | `true` |
|  | `--rvtests_recessive_mode` |  | `false` |
|  | `--rvtests_options` | String containing any further options to pass to RVtests | `"--siteMACMin 8 --single dominantExact"` |
|  | `--output_file_name_suffix` | This currently applies to output files in the Fisher's test branch only | `"example_output"` |
|  |  |  |  |
| Advanced inputs (unlikely to be changed) | `--tracedir` |  | `"${params.outdir}"` |
|  |  |  |  |
|  | `--genomic_data` |  | `"${projectDir}/input/aggV2_pgen_list_by_chromosomes_all_variants_biallelic_and_multiallelic.tsv"` |
|  | `--vcf_files` |  | `"${projectDir}/input/aggV2_functional_annotations_list_by_chunks_VEP105.tsv"` |
|  | `--precomputed_plink_files_for_grm_bed` |  | `"/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/additional_data/HQ_SNPs/GELautosomes_LD_pruned_1kgp3Intersect_common_and_rare_for_AVT_mpv10.bed"` |
|  | `--precomputed_plink_files_for_grm_bim` |  | `"/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/additional_data/HQ_SNPs/GELautosomes_LD_pruned_1kgp3Intersect_common_and_rare_for_AVT_mpv10.bim"` |
|  | `--precomputed_plink_files_for_grm_fam` |  | `"/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/additional_data/HQ_SNPs/GELautosomes_LD_pruned_1kgp3Intersect_common_and_rare_for_AVT_mpv10.fam"` |
|  |  |  |  |
|  | `--consequence_severity_ranking_file` |  | `"${projectDir}/resources/VEP_severity_bcftools_translation_and_ranking.tsv"` |
|  | `--ensembl_gene_list` |  | `"${projectDir}/resources/Ensembl_105_genes_coordinates_GRCh38.tsv"` |
|  | `--ensembl_gene_list_protein_coding` |  | `"${projectDir}/resources/Ensembl_105_genes_coordinates_GRCh38_protein_coding.tsv"` |
|  |  |  |  |
| Cluster settings (no real need to modify these) | `--executor` |  | `'lsf'` |
|  | `--cache` |  | `'lenient'` |
|  | `--queue` |  | `{ task.attempt < 2 ? 'short' : 'medium' }` |
|  | `--cpus` |  | `{ 1 + (task.attempt - 1) }` |
|  | `--memory` |  | `{ 2.GB + (1.GB * (task.attempt - 1)) }` |
|  | `--project_code` |  | `null` |
|  | `--cluster_options` |  | `'-P null'` |
|  | `--error_strategy` |  | `'retry'` |
|  | `--max_retries` |  | `3` |
|  | `--queue_size` |  | `5000` |
|  | `--poll_interval` |  | `'30 sec'` |
|  | `--exit_read_timeout` |  | `'30 sec'` |
|  |  |  |  |
| Containers in the module\_params scope (no need to modify these) | `--bcftools_container` |  | `'docker-gel-research-containers.artifactory.aws.gel.ac/bcftools:v1.20'` |
|  | `--bgenix_container` |  | `'docker-gel-research-containers.artifactory.aws.gel.ac/bgenix:v1.1.4.1'` |
|  | `--plink2_container` |  | `'docker-gel-research-containers.artifactory.aws.gel.ac/plink:v1.90b7.6-v2.00-a516LM'` |
|  | `--python_container` |  | `'docker-gel-research-containers.artifactory.aws.gel.ac/python:v3.12.6.1'` |
|  | `--regenie_container` |  | `'docker-gel-research-containers.artifactory.aws.gel.ac/regenie:v3.4.1.1'` |
|  | `--rvtests_container` |  | `'docker-gel-research-containers.artifactory.aws.gel.ac/rvtests:v2.1.0.2'` |
|  | `--saige_container` |  | `'docker-gel-research-containers.artifactory.aws.gel.ac/saige:v1.3.6.1'` |

March 11, 2025
