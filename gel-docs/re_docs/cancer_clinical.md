---
title: '100kGP Cancer-specific clinical data - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/cancer_clinical/
scraped_at: 2026-05-04T06:31:28Z
---

# 100kGP Cancer-specific clinical data

Some tables in LabKey contain data specific to cancer participants. All tables and their fields are described in our [data dictionary](../100k_data_dictionary/).

> **Primary and secondary data tables:**
>
> Primary clinical data were collected when participants were enrolled in the programme.
>
> Secondary clinical data were obtained from third parties such as NHSE.

Cancer data are presented at the participant level or sample level. All tumour samples have a matched germline sample. One participant might have more than one tumour sample, which, in such a case, could be related to temporal samples, two different tumours or, rarely, biological replicates. The latter is often part of the TracerX which is not available to commercial users.

## Central tables

| LabKey table | Description | Primary or secondary | CloudOS tsv filename |
| --- | --- | --- | --- |
| `cancer_analysis` | provides a list of cancer samples that have been sequenced and had variants called by the Illumina pipeline. Genomics England passes the samples through its Interpretation Pipeline, which will apply further QC and annotate on the called variants and perform analyses, such as estimating tumour mutation burden and compute mutational signatures. This information is then made available in the cancer analysis table, where each entry corresponds to one tumour sample that has been sequenced and interpreted. Samples are categorised by their registration disease and disease subtype. Data for all cancer participants whose genomes have been through Genomics England bioinformatics interpretation and passed quality checks, including: sex, ethnicity, disease recruited for and diagnosis; tumour ID, build of latest genome, QC status of latest genome and path to latest genomes; as well file paths to the genomes. This table includes information derived from `laboratory_sample` and `cancer_participant_tumour`. Some key data included in the table are elucidated below: **Global Tumour Mutation Burden:** This is the number of somatic non-synonymous small variants per megabase of coding sequences (32.61 Mb). This metric was calculated using `somatic_small_variants_annotation_vcf` as input (see below for description) and all non-PASS variants were removed from the calculation. **Tumour purity:** This is the tumour purity (cancer cell fraction) as calculated by [Ccube](https://rdrr.io/github/keyuan/ccube/) **Mutational Signatures:** The table includes the relative proportions of the different mutational signatures demonstrated by the tumour. Analysis of large sequencing datasets (10,952 exomes and 1,048 whole-genomes from 40 distinct tumour types) has allowed patterns of relative contextual frequencies of different SNVs to be grouped into specific mutational signatures. Using mathematical methods (decomposition by non-negative least squares) the contribution of each of these signatures to the overall mutation burden observed in a tumour can be derived. Further details of the 30 different mutational signatures used for this analysis, their prevalence in different tumour types and proposed aetiology can be found at the [Sanger Institute Website](http://cancer.sanger.ac.uk/census). **Cancer PCA QC Statistics:** The cancer analysis pipeline employs a sequencing quality control check which selects several important statistics associated with the sequencing returned by the sequencing provider, and uses them to check whether or not the sample in question is an outlier with respect to previous samples that have been run through the pipeline. It is, in effect, a safety net that can spot issues that have occurred at the tissue collection stage (i.e. at the Genomic Laboratory Hub (GLH)) or at the library preparation step (i.e. at the sequencing provider), both of which may impact upon the final genomic analysis returned to the clinician. **Somatic small variants annotation vcf filepaths:** The `somatic_small_variants_annotation_vcf` column contains file paths pointing to VCFs containing Genomics England flags for potential false positive variants as well as additional annotations (see VCF header for details). SIFT and PolyPhen scores as well as new PONnoise50SNV flag were added. The flags used for annotation are: i. `CommonGermlineVariant`: variants with a population germline allele frequency above 1% in an early subset of the Genomics England dataset. ii. `CommonGnomADVariant`: variants with a population germline allele frequency above 1% in gnomAD dataset iii. `RecurrentSomaticVariant`: recurrent somatic variants with frequency above 5% in an early subset of the Genomics England dataset iv. `SimpleRepeat`: variants overlapping simple repeats as defined by Tandem Repeats Finder v. `BCNoiseIndel`: small indels in regions with high levels of sequencing noise where at least 10% of the basecalls in a window extending 50 bases to either side of the indelâs call have been filtered out by Strelka due to the poor quality vi. `PONnoise50SNV`: SNVs resulting from systematic mapping and calling artefacts The following methodology was used for the PONnoise50SNV flag: the ratio of tumour allele depths at each somatic SNV site was tested to see if it is significantly different to the ratio of allele depths at this site in a panel of normals (PoN) using Fisherâs exact test. The PoN was composed of a cohort of 7000 non-tumour genomes from the Genomics England dataset, and at each genomic site only individuals not carrying the relevant alternate allele were included in the count of allele depths. The mpileup function in bcftools v1.9 was used to count allele depths in the PoN, and to replicate Strelka filters duplicate reads were removed and quality thresholds set at mapping quality â¥ 5 and base quality â¥ 5. All somatic SNVs with a Fisherâs exact test phred score < 50 were filtered, this threshold minimised the loss of true positive variants while still gaining significant improvement in specificity of SNV calling as calculated from a TRACERx truth set. A presentation entitled PONnoise50SNV: SNVs resulting from systematic mapping and calling artefacts, which further outlines the methodology, can be found in the Publications and other useful links table located on our Further reading and documentation page. **Alignment BAM files generated by Isaac Genome Alignment Software:** We have a [paper written by Research Network members](https://europepmc.org/article/MED/32437525) discussing the issue of reference bias in the computation of variant allele frequencies (VAFs) by the Illumina Isaac pipeline (caused by preferential soft clipping of reads supporting alternate alleles). |  | `gel_cancer_analysis_100k.tsv` |

## Cancer participants

| LabKey table | Description | Primary or secondary | CloudOS tsv filename |
| --- | --- | --- | --- |
| `cancer_participant_disease` | data about participants' cancer disease type and subtype. |  | `gel_cancer_disease_100k.tsv` |
| `cancer_participant_tumour` | data that characterises the tumour, e.g. staging and grading; morphology and location; recurrence at time of enrolment; and the basis of diagnosis. |  | `gel_cancer_tumour_100k.tsv` |
| `cancer_care_plan` | information from participants' NHS cancer care plan on their treatment and care intent, in particular outcomes of MDT meetings and coded connected data (e.g. diagnoses from scans). |  | `gel_cancer_care_plan_100k.tsv` |
| `cancer_invest_imaging` | coded data on imaging investigations characterising the scan, its modality, anatomical site and outcome; as well as the outcome of the imaging report in free text form. |  | `gel_cancer_imaging_100k.tsv` |
| `cancer_participant_tumour_metastatic_site` | the site of any metastatic disease in the body at diagnosis (if applicable). |  | `gel_cancer_tumour_metastases_100k.tsv` |
| `cancer_risk_factor_cancer_specific` | data on specific risk factors related to particular cancer types. This table was compiled with input from Research Network members. |  | `gel_cancer_risk_factor_100k.tsv` |
| `cancer_risk_factor_general` | data on general cancer risk factors, namely smoking status, height, weight and alcohol consumption. This table was compiled with input from Research Network members. |  | `gel_cancer_risk_factor_general_100k.tsv` |
| `cancer_surgery` | details of what surgical procedures were had, as well as the specific location of the intervention. |  | `gel_cancer_surgery_100k.tsv` |

## Tumour samples

| LabKey table | Description | Primary or secondary | CloudOS tsv filename |
| --- | --- | --- | --- |
| `cancer_invest_circulating_tumour_marker` | biomarker measurements specific to particular cancer types (ovarian or prostate). |  | `gel_circulating_tumour_marker_100k.tsv` |
| `cancer_invest_sample_pathology` | full pathology reports and other related data on and from their tumour samples around diagnosis and characterisation of the cancer. Much of this information is also found in the `clinic_sample` and `cancer_participant_tumour` tables. |  | `gel_cancer_pathology_100k.tsv` |
| `cancer_specific_pathology` | pathology data specific to participants' cancer type. This may provide additional data to the `cancer_invest_sample_pathology` and `cancer_participant_tumour` tables. |  | `gel_cancer_specific_pathology_100k.tsv` |
| `cancer_systemic_anti_cancer_therapy` | details the regimen and intent of the participants' chemotherapy. |  |  |

## Consolidated data

| LabKey table | Description | Primary or secondary | CloudOS tsv filename |
| --- | --- | --- | --- |
| [`cancer_staging_consolidated`](../cancer_staging/) | combines staging information from our primary clinical data (`cancer_participant_tumour`) and secondary clinical data from PHE/NCRAS (`sact` and `av_tumour`) to give a stage for each sample we have sequenced and fully interpreted on our database (`cancer_analysis`). The staging information may be in form of TNM combined, each component or other standards such as ajcc, or dukes, for example. The genomic data are rematched to the clinical data using a disease type (genomic data) and icd code (clinical data) correspondence dictionary created and validated internally. Also, the clinical stage information must not be further away than one year from the date the sample has been collected. The column names have been preserved as found in the original datasets they were extracted from, except for `tumour_pseudo_id` found both in `sact` and `av_tumour`, where a prefix with the dataset names was added to. Also, for each staging dataset used, when more than one entry for the same patient was available the closest one to the clinical data collection has been kept. |  | `phe_gel_cancer_tumour_linkage_100k.tsv` |

TNM

The [TNM Classification of Malignant Tumours | TNM)](https://en.wikipedia.org/wiki/TNM_staging_system) is a cancer staging notation system that describes the stage of a cancer that originates from a solid tumour with alphanumeric codes.

- `T` describes the size of the original (primary) tumour and whether it has invaded nearby tissues.
- `N` describes nearby (regional) lymph nodes that are involved.
- `M` describes distant metastasis.

The code for a particular cancer is made up of these three parts along with other parameters and modifiers.

## Bioinformatics analysis

| LabKey table | Description | Primary or secondary | CloudOS tsv filename |
| --- | --- | --- | --- |
| `cancer_100K_genomes_realigned_on_pipeline_2` | Cancer genomes re-processed through Pipeline 2.0 (which uses DRAGEN v3.2.22 for alignment and germline variant calling + Strelka 2.9.9 for somatic small variants + Canvas 1.39 for somatic CNV + Manta 1.5 for somatic SVs). Also contains `somatic_small_variants_annotation_vcf` files and tumour in normal contamination (TINC) results for a subset of ~800 haematological samples. |  | `gel_dragen_realigned_100k_genomes_100k.tsv` |

## NHSE-NCRAS cancer clinical data

Data from the third party NHSE, including data from the [National Cancer Registration and Analysis Service | NCRAS)](https://www.gov.uk/guidance/national-cancer-registration-and-analysis-service-ncras), describing cancer patients' medical history. The NCRAS is responsible for cancer registration in England to support cancer epidemiology, public health, service monitoring and research.

Cancer Registration (AV) is the systematic collection of data about cancer and tumour diseases. In England, this data collection is managed by NCRAS. Every year, NCRAS collects information on over 300,000 cases of cancer, including patient details (including their name, address, age, sex, and date of birth), as well as detailed data about the type of cancer, how advanced it is and the treatment the patient receives. At Genomics England the data are stripped out of identifiable information and associated to a the patient's `participant_id` so that these data can be linked to other clinical and also the genomic data.

This dataset brings together data from more than 500 local and regional datasets to build a picture of an individual's treatment from diagnosis.

> **Note:**
>
> `tumour_ids` in AV tables are assigned to participants by NCRAS and do not link to the `tumour_ids` assigned by Genomics England for sequencing and clinical data. Whilst this may refer to the same cancer, you should be cautious when linking these together.

> **Bug inrtdstable in releases 17 and 18:**
>
> - There is a bug in the NCRAS radiotherapy table, `rtds` for 100kGP releases 17 and 18. Approximately 8% of all records in this table are missing dates. This is due to a bug translating `Sep` in three-letter months to numbered dates.
> - This has been fixed in release 19.

| LabKey table | Description | Primary or secondary | CloudOS tsv filename |
| --- | --- | --- | --- |
| `av_patient` | demographics from the Cancer Registration and information about death, when applicable by the last day of data collection for the AV tables. |  | `ncras_cancer_patient_100k.tsv` |
| `av_tumour` | medical information about the tumour, including hormonal status (PR, ER and HER2), date of diagnosis, site, morphological and behaviour ICD10 codes as well as histology and grade. Table's `anon_tumour_id` is used to link treatment tables also available in NCRAS. One row per tumour (`av*` table specific `anon_tumour_id`), per participant at the point of registration of that cancer/tumour with NCRAS. |  | `ncras_cancer_tumour_100k.tsv` |
| `av_treatment` | treatment received for each participant. One participant receives more than one treatment, which includes surgery, chemo, immuno and radiotherapy. |  | `ncras_cancer_treatment_100k.tsv` |
| `av_rtd` | routes to diagnosis; these routes have been determined [using a model](https://europepmc.org/article/MED/22996611) that combines AV data with HES data, Cancer Waiting Times (CWT) data and data from the cancer screening programmes. Using these datasets cancers registered in England which were diagnosed in 2006 to 2018 are categorised into one of eight Routes to Diagnosis. |  | `ncras_cancer_route_to_diagnosis_100k.tsv` |
| `av_imd` | income deprivation domain; measures the proportion of the population experiencing deprivation relating to low income. The definition of low income used includes both those people that are out-of-work and those that are in work but who have low earnings. |  | `ncras_cancer_index_of_multiple_deprivation_100k.tsv` |
| `cwt` | the National Cancer Waiting Times Monitoring Data Set supports the continued management and monitoring of waiting times. |  | `ncras_cancer_waiting_times_100k.tsv` |
| `ncras_did` | diagnostic imaging dataset; a central collection of detailed information about diagnostic imaging tests carried out on NHS patients, extracted from local radiology information systems. The DID captures information about referral source, details of the test (type of test and body site), demographic information such as GP registered practice, patient postcode, ethnicity, gender and date of birth, plus data items about different events (date of imaging request, date of imaging, date of reporting, which allows calculation of time intervals. |  | `ncras_diagnostic_imaging_metadata_100k.tsv` |
| `rtds` | [radiotherapy dataset](https://digital.nhs.uk/ndrs/data/data-sets/rtds); is an existing standard (SCCI0111) that has required all NHS Acute Trust providers of radiotherapy services in England to collect and submit standardised data monthly against a nationally defined data set since 2009. The purpose of the standard is to collect consistent and comparable data across all NHS Acute Trust providers of radiotherapy services in England in order to provide intelligence for service planning, commissioning, clinical practice and research and the operational provision of radiotherapy services across England. Data are available from 01/04/2009. |  | `ncras_radiotherapy_100k.tsv` |
| `sact` | [systemic anti-cancer therapy](https://digital.nhs.uk/ndrs/data/data-sets/sact); contains clinical management on patients receiving cancer chemotherapy, and newer agents that have anti-cancer effects, in or funded by the NHS in England. It covers chemotherapy treatment for all solid tumour and haematological malignancies and those in clinical trials. It relates to all cancer patients, both adult and paediatric, in acute inpatient, day case, outpatient settings and delivery in the community. Data available for regimens between between July 2014 and December 2021. |  | `ncras_systemic_anti_cancer_therapy_curated_100k.tsv` |

### LUCADA

The National Lung Cancer Audit (LUCADA) looks at the care delivered during referral, diagnosis, treatment and outcomes for people diagnosed with lung cancer and mesothelioma. The data items in the LUCADA dataset have been compiled to meet the requirements of audit, and are not to be confused with the data items identified as Lung Cancer in the National Cancer dataset. The audit focuses on measuring the care given to lung cancer patients from diagnosis to the primary treatment package, assessing against standards and bringing about necessary improvements. The project supports the Calman Hine recommendations, the National Cancer Plan and other national guidance (e.g. NICE guidance) as it emerges.

The audit follows patients diagnosed between: 01/01/2005 - 31/12/2013 the vital status of each patient can be followed up with linkage to Cancer Registration data).

| LabKey table | Description | Primary or secondary | CloudOS tsv filename |
| --- | --- | --- | --- |
| `lucada_2013` | contains, for 56 participants, data on the national lung cancer audit 2013. |  | `ncras_lung_cancer_dataset_2013_100k.tsv` |
| `lucada_2014` | contains, for 18 participants, data on the national lung cancer audit 2014. |  | `ncras_lung_cancer_dataset_2014_100k.tsv` |

## Cancer-specific Genomics England curated datasets - pilot

All tables under âCancer Specific Curated Datasets â Pilotâ have been derived from the National Disease Registration Service (NDRS) raw data feed and subsequently processed by Genomics England staff. While every effort has been made to ensure utility, these datasets may contain errors or inconsistencies and should be used with appropriate caution.

These pilot tables contain valuable clinical therapy information which may not have yet been processed into the fully curated NCRAS datasets. Please use the curated NCRAS datasets where appropriate, in particular for information on cancer diagnoses.

There are known structural differences between the pilot tables and the fully curated NCRAS datasets. Where available please use the provided data dictionaries to support your use of these resources. Researchers should match to other datasets using the standard Genomics England participant ID.

Genomics England welcomes researcher feedback to improve the datasets we provide. Please share observations, report anomalies, or suggest improvements via the [Genomics England Service Desk](https://www.genomicsengland.co.uk/service-desk). When doing so, please specify the datasets your feedback refers to.

| LabKey table | Description | Primary or secondary | CloudOS tsv filename |
| --- | --- | --- | --- |
| `sact_uncurated` | table is the raw feed from NCRAS which feeds into their curation process producing the sact table (both under NCRAS section). This table extracts chemotherapy (SACT) information for cancer participants in the 100,000 genomes project from unlinked and unprocessed NCRAS chemotherapy data from 2008 until March 2021. It is likely to contain some errors, however it contains clinical therapy data that is not yet available in the curated NCRAS registries, such as SNOMED CT diagnosis codes alongside ICD10. A major point to raise is that this SACT curation does not provide tumour IDs, thus you must match this dataset to other NCRAS registries by adjusting for date. Please refer to background and use caveats in the quality notes section of this release note. |  | `phe_systemic_anti_cancer_therapy_un_curated_100k.tsv` |
| `pathology_reports` | Full text pathology reports pertaining to participants from 100k Genomes Project across all cancer types. Multiple reports per participants are provided where available prior, around and post WGS sample. |  |  |

February 5, 2026
