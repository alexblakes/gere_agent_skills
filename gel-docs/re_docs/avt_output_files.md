---
title: 'AVT output files - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/avt_output_files/
scraped_at: 2026-05-04T06:31:24Z
---

# Output files

Output in the results folder (default `results/`) in the standard case when `publish_all = false`:

```
âââ dump_versions
âÂ Â  âââ software_versions.yml
âââ pipeline_info
âÂ Â  âââ execution_report_2024-07-11-11-54-27.html
âÂ Â  âââ execution_timeline_2024-07-11-11-54-27.html
âÂ Â  âââ execution_trace_2024-07-11-11-54-27.txt
âââ regenie_aggregate_summary_statistics
âÂ Â  âââ aggregated_regenie_results_STATUS.tsv
âââ run_fishers_test_using_rvtests
âÂ Â  âââ STATUS_mask_LoF_recessive_false_avt_output.DominantFisherExact.assoc
âÂ Â  âââ STATUS_mask_LoF_recessive_false_avt_output.log
âÂ Â  âââ STATUS_mask_missense_recessive_false_avt_output.DominantFisherExact.assoc
âÂ Â  âââ STATUS_mask_missense_recessive_false_avt_output.log
âÂ Â  âââ STATUS_mask_synonymous_recessive_false_avt_output.DominantFisherExact.assoc
âÂ Â  âââ STATUS_mask_synonymous_recessive_false_avt_output.log
âââ saige_aggregate_summary_statistics
âÂ Â  âââ aggregated_saige_set_results_STATUS.tsv
âÂ Â  âââ aggregated_saige_single_variant_results_STATUS.tsv
âââ validate_input_files
    âââ exclusion_data_type.txt
    âââ validated_annotation_data_list.tsv
    âââ validated_genomic_data_list.tsv
    âââ validated_user_exclusion_file.tsv
    âââ validated_user_region_file.tsv
    âââ validation_errors.txt
    âââ workflow_internal_initial_cohort_file.tsv
```

> **Note:**
>
> if `publish_all = true`, all intermediate files will be published in the results folder, organised in sub-folders in a way similar to what is shown above.

## Association output files

```
# Aggregated association output (all annotation labels in the same file)
aggregated_regenie_results_<phenotype>.tsv
aggregated_saige_set_results_<phenotype>.tsv
aggregated_saige_single_variant_results_<phenotype>.tsv

# Rvtests
<phenotype>_mask_<annotationLabel>_<testType>_<suffix>.DominantFisherExact.assoc
<phenotype>_mask_<annotationLabel>_<testType>_<suffix>.log
```

See individual association tool documentation for interpretation of association output:

### SAIGE-GENE

- documentation: <https://saigegit.github.io/SAIGE-doc/>
- source: <https://github.com/saigegit/SAIGE>

### regenie

- documentation: <https://rgcgithub.github.io/regenie/>
- source: <https://github.com/rgcgithub/regenie>

### Rvtests/Fisher's test

- documentation: <http://zhanxw.github.io/rvtests/>
- source: <https://github.com/zhanxw/rvtests>

### PLINK

- documentation:
  - 1.9: <https://www.cog-genomics.org/plink/1.9/>
  - 2.0: <https://www.cog-genomics.org/plink/2.0/>
- source: <https://github.com/chrchang/plink-ng>

October 2, 2024
