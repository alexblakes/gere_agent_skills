---
title: '100kGP data release change summary - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/100k_change_summary/
scraped_at: 2026-05-04T06:30:52Z
summary: "100kGP v19 added synoptic pathology reports, rare disease ONT long-reads, expanded RNA-Seq, and structural variant data."
---

# 100kGP data release change summary

## main-programme\_v19\_2024-10-31

### Updated 10/02/2026 - Synoptic pathology reports for cancer

We have added [synoptic pathology reports](../synoptic/) for a wide variety of cancer types. These are available in a new LabKey table, `synoptic_path_reports`.

### Updated 01/12/2025 - Additional rare disease ONT data

We have added [long-read sequencing data](../lrs/) for an additional 73 rare disease participants from 100kGP included in the Scottish Genomes Partnership project (see [the relevant page](../rd_sgp_ont/)), consisting of data from whole-genome long-read sequencing using Oxford Nanopore Technologies platforms and SV analysis. The new `rare_disease_ont_sgp` table has been added to describe these new data.

### Updated 11/09/2025 - Additional RNA-Seq data

We have added [RNA-Seq data](../rna_seq/) for an additional 2283 rare disease participants from 100kGP, bringing our total RNA-Seq samples to 7840 from 7829 participants. The `rnaseq_qc_metrics` and `transcriptome_file_paths_and_types` tables have been updated to include these new data.

### Updated 20/03/2025 - New rare disease ONT table

A new table called `rare_disease_ont_cohorts` has been added to the 'Long Read Sequencing' section in LabKey. The new table contains alignment and structural variant call data for 315 rare disease participants from four difference cohorts. Refer to the [ONT rare disease pilot project](../rd_ont/) page for full information about this data set.

### Bug Fixes

A few tables have been updated to fix data issues:

- `sequencing_report` and `genome_file_paths_and_types`: Around 21k genomes had inaccurate delivery date values that could cause issues when trying to select the latest delivery for a sample. Now all delivery dates are within 7 days of the date that appears in the file paths.
- `rare_disease_interpreted`: Around 1,500 participants had innaccessible paths in the 'Alignment File Path' column and they have now been updated. The date of birth of a participant has also been updated to match that in the `participant` table.
- `transcriptome_file_paths_and_types`: `*SJ.out.tab` files obtained with the DRAGEN 3.8.4 pipeline have been removed from the table because they contain incorrect information in the intron motif column. `*SJ.out.tab` files obtained with the DRAGEN 4.2.7 pipeline are included as this issue has been corrected in that version of DRAGEN.

### Data updates

Two tables have had a data refresh:

- NHSE Hospital Episode Statistics: There is now HES data available until January 2024.
- `cancer_ont_cohorts`: A new column `lr_merged_germline_methylation_path` has been added with the paths of germline BAM files with methylation tags. This release also includes new tumour methylation BAMs for a total of 83 tumour and 73 germline methylation BAMs. In addition, the column `methylation_guppy_version` has been removed since it's always the same as `guppy_version`.

## main-programme\_v18\_2023-12-21

### cancer\_ont\_cohorts

The table now includes information about BAM files that contain methylation tags for 9 participants. Six new columns have been added to record the versions of the tools used to call methylation sites plus a column with the file paths:

- `methylation_guppy_version`: Guppy toolkit version used for methylation BAMs.
- `methylation_basecall_version`: Guppy basecalling version used for methylation BAMs.
- `methylation_basecall_model`: Model used for guppy basecalling for methylation BAMs.
- `methylation_basecall_filter_threshold`: Basecalling filter threshold value used for methylation BAMs.
- `methylation_minimap2_version`: Minimap2 version used for read alignment for methylation BAMs.
- `lr_merged_tumour_methylation_path`: Path of the long read alignment data with methylation tags for the tumour sample.

### submitted\_diagnostic\_discovery

The table now includes two new columns:

- `group`: Combination of the participant id and the gene name used to group compound heterozygous variants together.
- `Zygosity`: Whether the variant is homoygous, heterozygous, compound heterozygous, heterozygous or mosaic.

In addition, the `gene_build` column has been renamed to `genome_build`, which is the nomenclature we use in other tables such as `sequencing_report` and `genome_file_paths_and_types`.

### domain\_assignment

Table has been decommissioned.

## main-programme\_v17\_2023-03-30

### NCRAS

A large number of the NCRAS tables have been refreshed. In particular SACT has five years of extra data, now covering a period of 10 years from 2012 to 2022.

There are also a number of schema changes to be aware of in the new NCRAS datasets:

- The columns `tumour_pseudo_id` and `event_pseudo_id` have been replaced by `anon_tumour_id` and `anon_event_id`. These new columns contain different sets of pseudonymised ids to those present in releases prior to v17.
- A number of columns in `av_tumour` have been deprecated. In addition, the following columns have been renamed
  - `date_first_event` replaced by `first_hosp_date`
  - `diagnosisprovider_code` replaced by `diag_hosp`
  - `diagnosisprovider_name` replaced by `diag_hosp_name`
  - `diagnosistrust_code` replaced by `diag_trust`
  - `diagnosistrust_name` replaced by `diag_trust_name`
- In `av_imd` the seperate quintile values have been replaced by a single `imd` column.
- The column `diagnosis_date_best` is no longer present in `av_treatment`. This column can still be found in `av_tumour`
- In `sact` the columns `gender_current_clean` and `morphology_clean` have been renamed to `gender_current` and `morphology`. Additionally the following columns are no longer present
  - `perf_stat_start_of_reg_adult`
  - `perf_stat_start_of_reg_child`
  - `perf_stat_start_of_cycle_adult`
  - `perf_stat_start_of_cycle_adult`

### cancer\_pathology\_reports

- The `report_id` column has been updated with a new, more stable ID format that supersedes the IDs present in previous releases.
- Approximately 2,000 new Pathology reports have been added to the dataset in this release.
- The old pathology report datasets `testes_path_reports` and `aml_path_reports` have now been deprecated.

### participant\_summary

- The `key_columns` table has been renamed `participant_summary`.
- A new field `affection_status` has been added to the table.
- There have been some changes to the origin tables and construction of this table. For more details please see [here](../general_clinical/).

### rare\_diseases\_participant\_phenotype

- A new field `notes` has been added to the table, which contains additional information on a participant phenotype. This includes Orphanet codes, where relevant HPO terms are not available.

### Long Read Sequencing

A separate section has been made in LabKey called 'Long Read Sequencing' to accomodate previous and new data tables relating to long read sequencing. The `lrs_sequencing_data` and `lrs_laboratory_sample` tables that were previously found in the 'Bioinformatics' sections have been placed under this, as well as two new tables `rare_disease_pacbio_pilot` and `cancer_ont_cohorts`

### rare\_disease\_pacbio\_pilot

This is a dataset of 91 rare disease samples from the 100kGP genome project re-sequenced with Pacific Biosciences (PacBio) as an example dataset to to demonstrate the utility of their HiFi technology.

### cancer\_ont\_cohorts

This table lists participant ids, sample data, file paths and sequencing statistics for Oxford Nanopore cancer cohorts available in the Research Environment, along with corresponding matched germline and Illumina short reads files where available.

### cancer\_registry

This table has been renamed in LabKey from `cancer_register_nhsd` to `cancer_registry`.

## main-programme\_v16\_2022-10-13

### Data quality work

The tables `participant` and `rare_disease_participant_disease` have been updated to fix incorrect values for year of birth and specific disease respectively. This is part of an ongoing effort to improve the quality of data provided in the Research Environment.

### Pathology reports table

A new longitudinal cancer pilot dataset, consisting of records of pathology laboratory reports for 100kGP Genomes Project participants (raw text, up to April 2020). `pathology_reports` contains filepaths pointing to the .txt document. The original format of the text is preserved. Identifiable information is redacted as per IG guidelines.

### submitted\_diagnostic\_discovery

The new table `submitted_diagnostic_discovery` has been added under the Bioinformatics section. This table contains a summary of variants that have been reported back to the GMCs as potentially causal as a result of analyses that have taken place after the initial standard 100,000 Genomes Project analysis by Genomics England. It combines both findings sourced internally within GEL, and from the research community. The motivation behind curating this table from data GEL uses to report to the Genomic Laboratory Hubs (GLHs) is to avoid duplicated effort within our research community (by which a variant that has been reviewed and submitted to a GLH is investigated again by a different member of the research community).

### Key Columns

A new aggregated, Quick View table has been added. This table is an aggregation of Rare Diseases, Cancer and Bioinformatics tables, in order to provide a single, high level table containing commonly used fields. The Key Column table is composed of demographic information from table participant, ancestry information from `aggregate_gvcf_sample_stats`, death details from tables `death_details`, `mortality` and `rare_diseases_pedigree_member`, study information from `cancer_analysis`, disease and phenotype information from tables `rare_diseases_participant_disease` and `rare_diseases_participant_phenotype` (filtered for phenotypes where `hpo_present = 'yes'`) and cancer information from tables `cancer_staging_consolidated` and `cancer_participant_disease`.

### `cancer_tier_and_domain_variants`

The `csv_version` column has been removed after updating all samples to a more recent version (v2.2) of Domain and Tiered variants. Furthermore variant allele frequency (VAF) has been added for each variant. Please see the updated [`cancer_tier_and_domain`](../cancer_tiering/) page.

### `cancer_100K_genomes_realigned_on_pipeline_2`

This table now has Somatic Small Variants Annotation VCF added for all samples included in the table (previously it was limited to haematological cases only).

### `cancer_analysis`

Updated tiering results (columns Small Variants Tiering Path, SV Tiering Path and CNV Tiering Path) have been generated for all samples using a single tiering code version (linked to pipeline version 1.35.0) and gene list (v2.2). This may result in slightly different tiering results per sample compared to previous releases (though the results should very much overlap). This update was also extended to the Analysis CSV Filepath files, which should match the tiering results. Please note that the Analysis HTML Filepath files were not updated, so these remain based upon the original analysis versions (as indicated in the filepath).

## main-programme\_v15\_2022-05-26

### PROMS

The dataset PROMS is no longer included in the main programme release due to restrictions from NHSE on this dataset. This dataset has been retroactively removed from all previous releases.

### Bridge files

The linkage files for the secondary datasets DID and Mental Health are no longer provided. Participant Id is already included in all datasets making these linkage files redundant.

### genome\_file\_paths\_and\_types and sequencing\_report

A fix was applied which caused genome deliveries (<200) to be excluded from the final dataset. In some cases this could lead to confusing cases where only the somatic genome was listed and the germline genome was not for a given participant. This has now been fixed. This did not affect the **cancer\_analysis** table where both genomes were displayed correctly regardless.

### genomicsplc\_prs\_values

Polygenic Risk Score values have been made available for 12 complex traits, for ~40k participants from the aggV2 dataset. Detailed documentation can be found here: [Polygenic Risk Scores (Provided by Genomics PLC)](../prs/). This data was provided by Genomics PLC.

### cancer\_tier\_and\_domain\_variants

An aggregate table of clinically relevant variants reported in cancer samples has been added. This table contains Domain 1, 2 and 3 variants for samples passed through the cancer interpretation pipeline. For more information on this data please see link to [cancer\_tier\_and\_domain](../cancer_tiering/) page.

### Cancer pilot datasets

The following **Cancer pilot datasets** are no longer included in the main programme release; **Renal specific dataset, Colorectal specific dataset, Glioma specific dataset, Breast specific dataset.**

## main-programme\_v14\_2022-01-27

- **HES data changes**: The field `pseudo_hes_id` has been retired from the HES dataset and replaced by a new field `token_person_id` in the tables `op`, `apc` and `ae`. `pseudo_hes_id` has also been removed from the tables `mh_bridge` and `did_bridge` with no replacement. The field `susspellid` has been temporarily removed from `op`, this field should be returning in future releases.
- **mhsds**: A new mental health dataset from NHSE, mental health services dataset (mhsds), is made available this release, currently covering the period 2016-2019. This dataset is based on a different data model to previous MH data in the RE. For more details on this please see [Clinical and phenotype data](../clinical_data/) Secondary Data - NHSE (clinical data).
- Participants on expired child consent (turned 16 without reconsenting as adults) are no longer removed as ineligible participants, however only clinical data collected under valid consent (before they turned 16) will be included for these participants. As a result of this the number of participants included in Data Release V14 has increased from Data Release V13. For more information on this please see [Clinical and phenotype data](../clinical_data/) Secondary Data - Participant Consent.
- **covid\_test\_result** data has moved from the frequent release folder to the main release. For more information on this data please see [Clinical and phenotype data](../clinical_data/) Secondary Data - COVID.

## main-programme\_v13\_2021-09-30

- **rare\_disease\_participant\_phenotype** now contains updated HPO terms. Most terms remain the same with only a small number of changes.
- **denovo\_flagged\_variants**: An issue was detected whereby variants within the repetitive regions of the genome should have been detected and flagged. In reality however this was unfortunately not the case and all denovo variants (of both GRCh37 and GRCh38) were filtered using the GRCh37 coordinates of repeat regions. We have now corrected this issue, and updated the denovo\_flagged\_variants table for Data Release v13. Please note that this was only an issue for variants within repetitive regions. We want to thank the researchers that flagged the issue to us.
- **cancer\_analysis**: We have added additional histological data on cancer genomes and updated the classification of tumours registered within the 100,000 Genome Project.
- The **somAgg**: A dataset containing 16,341 somatic aggregated vcf files from the 100,000 Genomes Project which we made available as a multi-sample VCF dataset (somAgg). somAgg comprises over 573 million annotated single nucleotide variants and small indels (<=50bp) from quality controlled tumour whole genomes. For more information, please see [Somatic Aggregated Variant Call (somAgg v0.2)](../somAgg/). This is an early stage release and feedback is welcome.

## main-programme\_v12\_2021-05-06

- **cancer\_analysis** quick view table now contains two additional columns with mean tumour autosomal coverage and mean germline autosomal coverage.
- **cancer\_100K\_genomes\_realigned\_on\_pipeline\_2** has had an additional ~1500 realigned genomes added.
- The new table **rare\_disease\_interpreted** has been added under the quick view tab. This table contains general information on interpreted genomes and file paths to the raw platypus vcfs for 32,826 families. For a small number of families, platypus vcfs have not been made available due to consent withdrawals. We have however made available the .bam file paths that were used for the interpretation. Platypus vcfs are provided unannotated at first, and we will provide annotation in a later Data Release to streamline the release of this table.
- The **tiering\_data** table has been completely refreshed. An issue was reported for 420 interpretations where the genome assembly was incorrectly assigned to GRCh38 but in actuality should have been GRCh37. To fix this issue we had to refresh the entire table. This resulted in a loss of 389 interpretations from 378 families (including withdrawals). However, for 288 out of these 378 familyâs alternate interpretations remain present that are likely updated or newer interpretations. If you find any additional issues, please reach out to us via the Genomics England Service Desk.
- Cancer Specific GEL curated datasets - Pilot - continued extension of series of cancer specific pilot datasets, aiming to incorporate additional clinical data provided by Public Health England cancer registry (NCRAS). The initial datasets were focused on colorectal, renal and gliomal cancers, this release also includes a breast dataset and full text pathology reports for testicular tumours and AML. These datasets concatenate all the participants in the 100,000 Genomes project registered with these cancers, with the initial focus being on providing a broad pathological understanding. This will aim to incorporate data points such as molecular mutations and resection margins in pathology reports. In addition, we are also including the date that each participant was last seen alive and dates and causes of death to aid with outcomes. It must be stressed that this work is a development process, and we are working in unison with NCRAS to develop this progression. The gold standard remains the NCRAS curated tables. However, for these datasets to improve and move forward, Genomics England are keen for feedback and for you to highlight areas for improvement. This is ultimately data that you use, thus we are keen to engage with you to aide this process. You will note subtle differences to the structure of the table compared to the curated NCRAS tables and thus additional data dictionaries have been provided. Genomics England hopes to continue developing this uncurated live dataset with your feedback and look forward to hearing your thoughts. Please reach out via the [Genomics England Service Desk](https://www.genomicsengland.co.uk/service-desk), including "cancer\_specific\_datasets\_pilot" in your enquiry.

## main-programme\_v11\_2020-12-17

- *Cancer Specific GEL Curated datasets - Pilot* - series of cancer specific pilot datasets, aiming to incorporate additional clinical data provided by Public Health England cancer registry (NCRAS). The initial datasets are focused on colorectal, renal and gliomal cancers. These datasets concatenate all the participants in the 100,000 Genomes project registered with these cancers, with the initial focus being on providing a broad pathological understanding. This will aim to incorporate data points such as molecular mutations and resection margins in pathology reports. In addition, we are also including date all participants were last seen alive (data provided up to June 2020) and dates and causes of death to aide with outcomes. It must be stressed that this work is a development process, and we are working in unison with NCRAS to develop this progression. The gold standard remains the NCRAS curated tables. However, for these datasets to improve and move forward, Genomics England are keen for feedback and for you to highlight areas for improvement. This is ultimately data that you use, thus we are keen to engage with you to aide this process. You will note subtle differences to the structure of the table compared to the curated NCRAS tables and thus additional data dictionaries have been provided. Genomics England hopes to continue developing this uncurated live dataset with your feedback and look forward to hearing your thoughts. Please reach out via the [Genomics England Service Desk](https://www.genomicsengland.co.uk/service-desk), including "cancer\_specific\_datasets\_pilot" in your enquiry.
- A new table, **cancer\_100K\_genomes\_realigned\_on\_pipeline\_2**, has been created for cancer genomes re-processed through Pipeline 2.0. This includes the initial ~2000 cases released in main\_programme\_v10\_2020-09-03, with an additional ~1500 additional genomes. Pipeline 2.0 uses DRAGEN v3.2.22 for alignment and germline variant calling + Strelka 2.9.9 for somatic small variants + Canvas 1.39 for somatic CNV + Manta 1.5 for somatic SVs. Please be aware that somatic\_small\_variants\_annotation\_vcf files with additional in-house false positive filtering for Strelka outputs are provided only for haematological samples. The table also includes additional column tinc\_result which contains results of Tumour in Normal Contamination (TINC) test (again, provided only for haematological samples). The TINC value has been generated using the [TINC R package](https://github.com/caravagnalab/TINC), and is expressed as the fraction of tumour reads in the normal sample in the genomic regions of the most prevalent tumour karyotype.
- New tables **mortalilty** and **cancer\_registry** replace **ons** and **cen** respectively.

## main-programme\_v10\_2020-09-03

- Two new tables, **lrs\_laboratory\_sample** and **lrs\_sequencing\_data**, have been added to the Common and Bioinformatics table, respectively. These tables accompany the release of [long-read whole genome sequencing data](../lrs/) for a subset of 47 participants in the 100,000 Genomes Project. File paths to raw and BAM files are provided.
- Data for [orthogonal standard-of-care tests](../soc/) which were collected from GMCs for a subset of cancer patients.
- DRAGEN realigned cancer genomes: First ~2000 cancer genomes re-processed through Pipeline 2.0. That includes DRAGEN v3.2.22 for alignment and germline variant calling + Strelka 2.9.9 for somatic small variants + Canvas 1.39 for somatic CNV + Manta 1.5 for somatic SVs. Please be aware that false positives have not been filtered from Strelka calls in this release. Further details of this test data are available here.
  These realigned files can be found in the genome\_file\_paths\_and\_types and sequencing\_report tables in LabKey. A new variable in the delivery\_version column called DRAGEN\_Pipeline2.0 will provide you the ability to easily subset their data to realigned genomes only. The delivery\_version column in genome\_file\_paths\_and\_types is new, and directly corresponds to the one found in sequencing\_report.
- The **aggregate\_gvcf\_sample\_stats** table has been refreshed for the aggV2 dataset - which can be found here: `/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2`. There are now changes to the table which reflect the changes in sample QC from aggV1 to aggV2. Please see the Data Dictionary for full descriptions of all columns.
  Added Columns:
  `karyotype, illumina_ploidy, sample_source, sample_preparation_method, sample_library_type, samtools_insert_size_standard_deviation, samtools_insert_size_average, samtools_error_rate, samtools_average_quality, samtools_raw_total_sequences, samtools_reads_mapped, samtools_reads_mapped_and_paired, samtools_reads_properly_paired, samtools_reads_unmapped, samtools_reads_duplicated, samtools_pairs_on_different_chromosomes, illumina_mean_coverage, illumina_autosome_mean_coverage, illumina_coverage_at_15x, illumina_percent_aligned_reads, illumina_percent_read_pairs_aligned_to_different_chromosomes, illumina_fragment_length_median, illumina_array_concordance, illumina_snvs_all, illumina_snvs, illumina_indels_all, illumina_deletions_all, illumina_insertions_all, illumina_snv_het_hom_ratio, illumina_snv_ts_tv_ratio, illumina_indel_het_hom_ratio, illumina_deletion_het_hom_ratio, illumina_insertion_het_hom_ratio, illumina_percent_gc_dropout, illumina_percent_at_dropout`
  Removed Columns:
  `paternal_platekey, maternal_platekey, samtools_reads_mapped_percent, samtools_pairs_on_different_chromosomes_percent, gc_drop, at_drop, coverage_localrmsd, coverage_med, coverage_avg, coverage_pct75, coverage_pct25, coverage_sdcoverage_gte15x, illmn_snv_ts_tv_ratio, illmn_autosome_mean_coverage, illmn_percent_aligned_reads, illmn_het_hom_ratio_del, illmn_het_hom_ratio_indel, illmn_het_hom_ratio_snv, illmn_het_hom_ratio_ins, illmn_snvs_all, illmn_indels_all, illmn_insertions_all, illmn_deletions_all`
- **sact\_uncurated** table is the raw feed from PHE\_NCRAS which feeds into their curation process producing the **sact** table (both under PHE/NCRAS section). This table extracts chemotherapy (SACT) information for cancer participants in the 100,000 genomes project from unlinked and unprocessed PHE/NCRAS chemotherapy data from 2008 until June 2020. This is a first trial attempt by a small group within Genomics England to curate chemotherapy data. Whilst we do not possess the extensive experience and resource of Public Health England, we are providing a nearly live dataset. As such, it is likely to contain some errors, however it contains clinical therapy data that is not yet available in the curated NCRAS registries, such as SNOMED CT diagnosis codes alongside ICD10. The gold standard remains the NCRAS curated SACT table. However, for this dataset to improve and move forward, Genomics England are keen for your feedback and for you to highlight areas for improvement. You will note subtle differences to the structure of the table compared to the curated SACT table and thus an additional data dictionary has been provided. A major point to raise is that this SACT curation does not provide tumour IDs, thus you must match this dataset to other NCRAS registries by adjusting for date. Genomics England hopes to continue developing this uncurated live dataset with your feedback and look forward to hearing your thoughts. Please reach out via the Genomics England Service Desk, including "sact\_uncurated" in your enquiry.

## main-programme\_v9\_2020-04-02

- Two new columns, `normalised_hpo_id` and `normalised_hpo_term`, have been added to the `rare_diseases_participant_phenotype` table. These columns provide a standardised description, and HPO ID (where the ID provided by the GMCs is an alternate ID in the ontology) for each row of data. The source data was downloaded from [Jackson labs](https://hpo.jax.org/app/download/ontology) in December 2019.
- A new table, `laboratory_sample_omics_availability`, has been added to the Common tables. This provides a view of the samples collected from 100,000 Genomes Project participants for the purpose of omics research. Proposals for the use of these samples can be submitted to the Scientific Advisory Committee and Access Review Committee, via the GECIP team.
- De novo variant dataset:
  - [Documentation](../de_novo_data/)
  - *denovo\_cohort\_information*: LabKey Table with cohort information for all participants included in the de novo variant dataset. Attributes within this table include: participant ID, sex, affection status, family ID, pedigree ID, and the path to each family's multi-sample VCF with flagged DNVs.
  - *denovo\_flagged\_variants*: LabKey Table of all base\_filter pass variants for all trios within the DNV dataset. This table includes all flags from the DNV annotation pipeline for each variant.
  - *annotated\_multi-sample\_VCFs*: All multi-sample VCFs per family with DNVs flagged within the FILTER field. These VCFs are functionally annotated with VEP and accessible within the filesystem. File paths per participant are included in the denovo\_cohort\_information LabKey table. The data can be found in directory: `/gel_data_resources/main_programme/denovo_variant_dataset`
- Mental Health and Learning Disabilities Dataset has been added to the secondary datasets extending the coverage period of activity related to mental health to 30/11/2015 and expanding the scope (from September 2014) to include people in contact with learning disability services for the first time. The tables are of the same format as the previously available MHMDS dataset.
  - `mhldds_event`
  - `mhldds_episode`
  - `mhldds_record`

## main-programme\_v8\_2019-11-28

- The `tiering_data` table has been updated to reflect an updated model for the Genomics England Tiering algorithm for rare disease (now on model version 6). Now, all variants include genomic annotation. Further changes are as such:
  - `db_snp_id` column has been removed as this is no longer included in the raw data from the Clinical Interpretation Pipeline
  - The allele frequency columns have been removed from the `tiering_data` table and are now all included in the `tiered_variants_frequency` table
  - The `event_justification` column has been renamed to `segregation_pattern`
- The `phenotype` variable in the `tiering_data` table has now been normalised so that all disease names match the official terms. It is therefore equivalent to the variable `normalised_specific_disease` rather than `specific_disease` in the table `rare_diseases_participant_disease`.
- The `panel_identifier` column has been added to the `panels_applied` table. This is a unique hash of the panel name and the panel version. The Data Dictionary has been updated to reflect this change.
- The `lab_sample_id` column has been added to the `genome_file_paths_and_types` table to make it easier to identify which genome deliveries are associated with a particular laboratory sample. The Data Dictionary has been updated to reflect this change.
- The gmc\_exit\_questionnaire has had the column `gene_name` added which is the name of the gene where the variant resides post annotation by Ensembl VEP v98. All genes are included (semi-colon delimited). The Data Dictionary has been updated to reflect this change.
- The gmc\_exit\_questionnaire has had the column `phenotypes_explained` removed. This is because of an ongoing issue at the GMC level whereby incorrect HPO terms were being entered in the Reporting Outcomes Questionnaire. Specifically, all negative HPO terms in "explainsPhenotype" checkbox were potentially being selected and included in the final report, which renders the utility of this attribute meaningless in the exit questionnaire. We recommend to use the `rare_disease_participant_phenotype` table to identify the HPO terms for the participant and link it back to the gmc\_exit\_questionnaire table. This is a temporary and partial solution to the issue whilst we try and fix it for the next release. We felt it better to remove potentially misleading information than to preserve it. The Data Dictionary has been updated to reflect this change.
- The columns: dbsnpid, genomicfeature\_hgnc, genomicfeature\_ensemblid, and consequencetype have been removed from the `tiered_variants_frequency` table. The data still remain in the `tiering_data` table. The Data Dictionary has been updated to reflect this change.
- laboratory\_sample\_id added to plated\_sample table;
- rare\_diseases\_participant\_disease.normalised\_age\_of\_onset created by changing values of rare\_diseases\_participant\_disease.age\_of\_onset â1 or >150 to null.
- cancer\_staging\_consolidated table that consolidates all the staging data in one place and aim to link more than only participant IDs, but also at the sample/tumour level.
- In the `domain_assignment` table, the names of six GECIP domains have been changed to the official domain names and to match those on the Genomics England website:
  - `Inherited cancer` is now `Inherited cancer predisposition`
  - `Immunology` is now `Immune disorders`
  - `Haematology` is now `Non-malignant haematological and haemostasis disorders`
  - `Response to sepsis` is now `Paediatric sepsis`
  - `Childhood cancers` is now `Childhood solid cancers`
  - `Head and neck` is now `Head and neck cancer`

## main-programme\_v7\_2019-07-25

- 196 platekeys have now been remapped to different participant IDs following the in-house QC checks. **These mappings have been rectified for Version 7** and the following tables have been corrected (`sequencing_report, genome_file_types_and_paths, rare_disease_analysis, aggregate_gvcf_sample_stats`). No other tables were affected.
- The affected platekeys â participant ID mappings are provided in the research environment under the folder: `/gel_data_resources/main_programme/sample_remappings` in the file: corrected\_sample\_remapping.tsv. Researchers working with earlier data releases should amend accordingly.
- In addition, the following four platekey IDs were blacklisted following in house QC checks and have been removed from release 7: LP3001094-DNA\_E08, LP3001053-DNA\_C03, LP3001268-DNA\_F06, LP3001327-DNA\_G09. Researchers using earlier releases should remove these from their analyses.
- The aggregate\_gVCF \_sample\_stats table now includes the first 10 principal components; a set of unrelated individuals and predicted probabilities of ancestry membership
- Exomiser data now included for all interpreted cases in the LabKey table: âexomiserâ.
- The **panels\_applied** table now contains the columns: `interpretation_cohort_id, interpretation_request_id, sample_id` and `phenotype`. See the data dictionary for the definitions of these fields.
- The **tiering\_data** table now contains the columns: `interpretation_cohort_id` and `interpretation_request_id`. See the data dictionary for the definitions of these fields.
- The **sex\_karyotype\_pass** column has been removed from the rare\_disease\_analysis table as this is made redundant by the `reported_karyotypic_sex` and `inferred_sex_karyotype` columns. The platekey column has been renamed to `plate_key`.
- The **rare\_disease** analysis table now only includes the latest genome delivery per participant per genome build. This ensures that deprecated genomes are not used in analysis.
- The **rare\_disease\_analysis** table now only reports the WGS genetic\_vs\_reported results for GRCh38 genomes as GRCh37 genomes were not subject to this test.
- The **gmc\_exit\_questionnaire** table now contains the columns: `interpretation_cohort_id` and `interpretation_request_id`. See the data dictionary for the definitions of these fields. The `variant_details` column has been separated into four fields: `chromosome, position, reference, alternate`.
- In the `delivery_version` column of the **sequencing\_table**, unknown delivery versions have been recorded with the âunknownâ flag.
- **rare\_diseases\_invest\_genetic**.`sample_source_id` removed from the dataset as it contains data of little use, some of which contains clinician contact details
- A spelling error in one of the enumerations for **rare\_diseases\_participant\_disease**.`normalised_specific_disease` corrected - 'Anophthalmia or microphthamia' corrected to 'Anophthalmia or microphthalmia'
- The cancer\_analysis table now contains the following four new columns: 1. interpretation\_request\_id: interpretation request and version of analysis that was released to the Interpretation Portal and returned to the Genomic Medicine Centre; 2. tumour\_purity: tumour purity (cancer cell fraction) calculated by [Ccube](https://rdrr.io/github/keyuan/ccube/); 3. analysis\_csv\_filepath: contains path to a machine-readable csv file with a summary of germline and somatic small variants that are presented in the results of Whole Genome Analysis. See Technical Information document for details of this analysis; 4. analysis\_html\_filepath: contains path to HTML file with results of Whole Genome Analysis. It includes annotation and prioritisation of somatic small variants and structural variants/copy number variants, COSMIC signatures, tumour mutation burden, tiered germline variants for cancer susceptibility genes. For FFPE samples, only analysis of small variants is included. See Technical Information document for the details of this analysis.
- In the **cancer\_analysis** table the `somatic_coding_variants_per_mb` is calculated as total number of small somatic non-synonymous coding variants per Mb of coding sequence (32.61 Mb). This metric was re-calculated using somatic\_small\_variants\_annotation\_vcf as input and all non-PASS variants were removed from the calculation;
- In the **cancer\_analysis** table, signature\_1 to signature\_30: COSMIC signatures (v2) were re-calculated using somatic\_small\_variants\_annotation\_vcf as input. Only signatures with contribution above 5% are shown
- In the **cancer\_analysis** table, the somatic\_small\_variants\_annotation\_vcf file has been updated: this VCF file contains Genomics England flags for potential false positive variants as well as additional annotations (see VCF header for details). Swift and PolyPhen scores as well as new PONnoise50SNV flag were added. See following description of all current flags: i. Variants with a population germline allele frequency above 1% in a Genomics England dataset (CommonGermlineVariant), ii. Variants with a population germline allele frequency above 1% in gnomAD dataset (CommonGnomADVariant), iii. Recurrent somatic variants with frequency above 5% in a Genomics England dataset (RecurrentSomaticVariant), iv. Variants overlapping simple repeats as defined by Tandem Repeats Finder (SimpleRepeat), v. Small indels in regions with high levels of sequencing noise where at least 10% of the basecalls in a window extending 50 bases to either side of the indelâs call have been filtered out by Strelka due to the poor quality (BCNoiseIndel), vi. SNVs resulting from systematic mapping and calling artefacts. The following methodology was used: the ratio of tumour allele depths at each somatic SNV site was tested to see if it is significantly different to the ratio of allele depths at this site in a panel of normals (PoN) using Fisherâs exact test. The PoN was composed of a cohort of 7000 non-tumour genomes from the Genomics England dataset, and at each genomic site only individuals not carrying the relevant alternate allele were included in the count of allele depths. The mpileup function in bcftools v1.9 was used to count allele depths in the PoN, and to replicate Strelka filters duplicate reads were removed and quality thresholds set at mapping quality â¥ 5 and base quality â¥ 5. All somatic SNVs with a Fisherâs exact test phred score < 50 were filtered, this threshold minimised the loss of true positive variants while still gaining significant improvement in specificity of SNV calling as calculated from a TRACERx truth set (PONnoise50SNV)
- In the **cancer\_analysis** table, the somatic\_small\_variants\_annotation\_json column has been removed, as the somatic\_small\_variants\_annotation\_vcf file should contain the equivalent information

## main-programme\_v6\_2019-02-28

- Date fields have been added to the following, tables:
  - cancer\_surgery
  - rare\_diseases\_invest\_blood\_laboratory\_test\_report
  - rare\_diseases\_invest\_genetic
  - cancer\_participant\_tumour
  - cancer\_risk\_factor\_general
  - cancer\_invest\_imaging
  - rare\_diseases\_participant\_phenotype
- In rare\_diseases\_pedigree, pedigree\_family\_id was renamed rare\_diseases\_family\_id, and in rare\_diseases\_pedigree\_member both member\_participant\_id and member\_participant\_sk were renamed participant\_id and participant\_sk accordingly
- In participant table, duplicated\_participant\_id was added to highlight instances where a single person has been recruited under multiple participant\_ids
- A new table, death\_details, was added. It contains death data received from GMCs only
- In the participant table both mother\_affected and father\_affected have been changed to Yes/No/Unknown values
- A new table, plated\_sample, has been created to accommodate plated sample-level data from the laboratory sample table, specifically:
  - platekey
  - well\_id
  - plate\_id
  - biorepository\_dispatch\_datetime
  - illumina\_qc\_datetime
  - dna\_amount (renamed illumine\_dna\_amount)
  - illumina\_delta\_cq
  - illumina\_qc\_status
  - illumina\_sample\_concentration
  - illumina\_sequence\_gender
  - matched\_dna\_germline\_laboratory\_sample\_sk (which is now accommodated in matched\_sample\_type and matched\_sample\_ids)
- Column mydob has been removed from apc, op, ae tables
- Column cdsuniqueid has been removed from ae table
- SACT table with 38 fields covering details of chemotherapy regimens recorded by PHE for cancer patients has been added.
- The sequencing\_report table now contains the column `lab_sample_id`
- The sequencing\_report table has the following columns removed: `No, BAM date, BAM size, Status`

## main-programme\_v5.1\_2018-11-20

- cancer\_analysis â 8 new columns
- hes\_ae â 55 new columns, 2 columns removed: lsoa01, oacode6
- hes\_apc - 64 new columns, 1 column removed: oacode6
- hes\_op - 52 new columns, 2 columns removed: lsoa01, pctorig02

## main-programme\_v5\_2018-10-31

- This release provides clinical data for 85,070 participants, and 71,860 genomes from 62,487 of these participants. Of these genomes, 54,456 are rare disease genomes (from 54,138 participants) and 17,404 are cancer genomes (from 8,349 participants)
- 15,545 families with Tier 1, 2 and 3 variants from the interpretation pipeline; 2,470 families with GMC exit questionnaires
- The LabKey table domain\_assignment has been updated to include Moratorium end dates for genomes associated with participants in this table
- File paths to tiering and structural variants from cancer genomes added to cancer quick view
- New clinical LabKey tables with information on progression and medical history: `cancer_surgery; cancer_risk_factor_cancer_specific; cancer_specific_pathology; cancer_systemic_anti_cancer_therapy; cancer_care_plan; cancer_invest_circulating_tumour_marker; as well as rare_diseases_imaging; rare_diseases_gen_measurement and rare_diseases_early_childhood_observation.`
- A new table tiered\_variants\_frequency was added between Main Programme Data Release V4 and this one (V5.1)
- Multiple data fields were added, removed and renamed in cancer\_invest\_sample\_pathology:
- The following were added: `tumour_id; sample_pathology_id; topography_icd_code; topography_snomed_ct_code; topography_snomed_rt_code; topography_snomed; topography_snomed_version; sample_receipt_date; sample_taken_date; vascular_or_lymphatic_invasion_cancer; event_date`
- The following were removed: `topography_id; sample_details_id; vascular_or_lymphatic_invasion_cancer_id`
- The following were renamed: `preoperative_therapy_id renamed to preoperative_therapy; vascular_or_lymphatic_invasion_cancer_id renamed to vascular_or_lymphatic_invasion_cancer`
- cancer\_invest\_imaging now includes free imaging report texts (report\_text) and multiple other data fields were added to this table: `cancer_invest_imaging; tumour_id; imaging_modality; cns_imaging_radiological_number_of_lesions; cns_imaging_radiological_lesion_size; cns_imaging_radiological_lesion_location; cns_imaging_radiological_largest_lesion_features; cns_imaging_principal_diagnostic_imaging_type; breast_imaging_mammogram_result`
- All new genomic data added in the current data release (since July 2018) are aligned against the reference genome version GRCh38, using alignment pipelines V4
- The following normalised diseases were renamed to match the official terms: Cytopaenia and pancytopaenia was renamed Cytopenia and pancytopenia; Early onset dementia (encompassing fronto-temporal dementia and prion disease) was shortened to Early onset dementia
- The rare\_disease\_analysis quick view table now provides WGS family selection quality checks for rare disease families with genomes on build GRCh38, reporting abnormalities of the sex chromosomes, family relatedness and Mendelian inconsistencies, as well as reported vs genetic sex summary status (this contains an overall status â only sex checks are unpacked into individual data fields)
- New outputs from the Genomics England Bioinformatics pipeline: The cancer\_analysis quick view table now contains gold standard cancer genomes that have been through Genomics England Bioinformatics interpretation and passed quality checks

## main-programme\_v4\_2018-07-31

- This release provides clinical data for 71,331 participants, and 55,681 genomes from 49,303 of these participants. Of these genomes, 43,997 are rare disease genomes (from 43,570 participants) and 11,684 are cancer genomes (from 5,715 participants).
- New LabKey tables: panels\_applied, rare\_diseases\_invest\_genetic, rare\_diseases\_invest\_genetic\_test\_result, rare\_diseases\_invest\_blood\_laboratory\_test\_report, panels\_applied, cancer\_invest\_sample\_pathology, cancer\_invest\_imaging, cancer\_risk\_factor\_general, cancer\_PCA\_QC\_stats, tumour\_MB\_signatures
- LabKey tables removed: family\_members
- âRelationship to probandâ field moved from family\_members to rare\_disease\_analysis
- Multiple data fields from cancer\_participant\_tumour and laboratory\_sample added to cancer\_analysis
- âDiseaseâ field changed to âdisease or panelâ in domain\_assignment; an âoriginâ field has been added to domain\_assignment to indicate whether the GECIP domain applied to each participant is based on the disease they were recruited for or the panel applied to their genome
- âPanel nameâ and âpanel versionâ fields moved from tiering to panels applied

## main-programme\_v3\_2018-04-30

- The dataset now includes 44,067 genomes.
- Clinical data are also provided for participants with and without a sequenced genome, for a total of 61,554
- New LabKey tables are: family\_members, genome\_file\_paths\_and\_types, rare\_disease\_analysis, tiering\_data.
- LabKey tables removed: rare\_diseases\_pedigree\_member\_disease, rare\_diseases\_pedigree\_member\_hpo\_term.
- Changes to LabKey tables including the new fields in the clinic\_sample\_level data and participant\_level\_data tables.
- A new field genome\_build was added to the sequencing\_report table. This specifies 37 when the Delivery Version is V2 or before, and 38 when it is V4.
- Removal of some ID fields where a human readable description of the value is available.
- A new column named normalised\_consent\_form has been created in the participant table, assigning the free text values in consent\_form to sensible categories
- Pedigree diagnosis and phenotype data were removed from the research dataset

## main-programme\_v2\_2018-01-30

- The dataset includes 31,384 genomes â an increase of 11,519 genomes from the first release.
- Clinical data are also provided for participants with and without a sequenced genome, for a total of 53,190 participants.
- A far broader set of clinical data are provided for participants, comprising 16 tables in LabKey.
- In addition to Hospital Episode Statistics (HES), the secondary datasets Diagnostic Imaging Dataset (DID), Patient Reported Outcome Measures (PROMs) and Mental Health Services Data Set (MHSDS) are included in the release.
- There have been significant changes to the data structure of the LabKey tables. Refer to the Data Dictionary that accompanies this release for further details.

## main-programme\_v1\_2017-10-11

- This data release represents the baseline for subsequent releases.

February 25, 2026
