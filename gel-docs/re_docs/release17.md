---
title: 'Release v17 (30/03/2023) - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/release17/
scraped_at: 2026-05-04T06:33:40Z
---

# 100kGP Release v17 (30/03/2023)

[Data dictionary](../r17_data_dictionary.xlsx)

## Purpose

This document provides a description of the Main Programme Data Release v17 dated 30th March 2023.

Each progressive release incorporates new content, enhances existing content, and enables more effective use of the data.

This data are presented within the Genomics England Research Environment, accessed via the [AWS virtual desktop](https://re.extge.co.uk/ovd/) interface and subject to all Genomics England data protection and privacy principles.

Please see the [Research Environment User Guide](../) for detailed documentation on how to use and query the Genomics England dataset. This page also includes instructional videos which can not be viewed from within the Research Environment.

## Release overview

Data Release Version 17 provides clinical data for 90,189 participants, and 106,270 genomes (uniquely sequenced samples) from 88,498 of these participants. We hold germline genomes from 72,874 rare disease programme participants[1](#fn:1) and germline and somatic genomes from 15,624 cancer programme participants[2](#fn:2).

Table containing genome counts by sample, and delivery types.[3](#fn:3)

| Programme | Sample Type | Delivery Type | Genomes | Participants |
| --- | --- | --- | --- | --- |
| Cancer | Germline | V2 (GRCh37) | 265 | 265 |
|  | Somatic | V2 (GRCh37) | 294 | 265 |
| Cancer | Germline | V4 (GRCh38) | 15,773 | 15,423 |
|  | Somatic | V4 (GRCh38) | 17,198 | 15,616 |
| Cancer | Germline | D2 (GRCh38) | 15,757 | 15,500 |
|  | Somatic | D2 (GRCh38) | 16,049 | 15,001 |
| Cancer | Germline | Combined | 31,795 | 15,619 |
|  | Somatic | Combined | 33,541 | 15,618 |
| Cancer | Total | Combined | 65,336[4](#fn:4) | 15,624 |
| Rare Disease | Germline | V2 (GRCh37) | 10,336 | 10,249 |
|  | Germline | V4 (GRCh38) | 65,586 | 64,897 |
| Rare Disease | Total | Combined | 75,922 | 72,874 |
| Total | Combined | Combined | 141,258[5](#fn:5) | 88,498 |

The above table contains genomes that have been processed using different alignment methods and therefore can be counted multiple times. The table below provides the number of uniquely sequenced samples.

| Programme | Sample Type | Genomes count | Participant count |
| --- | --- | --- | --- |
| Cancer | Germline | 15,902 | 15,619 |
|  | Tumour | 17,003 | 15,618 |
| Cancer | Total | 32,753 | 15,624 |
| Rare Disease | Germline | 73,517 | 72,874 |
| Total |  | 106,270 | 88,498 |

## Accessing the data

The Research Environment will hold both genomic and clinical data which are located and displayed in various ways. Below we present a brief overview on how to access these data.

- The genomic data (BAMs, VCFs, and associated quality metrics) delivered to us by our sequencing provider (Illumina) are presented in file shares. These are accessed via the your home directory under the subfolder '/genomes/by\_date'.
- Clinical data and secondary health data (âmedical historyâ) are presented in [LabKey](../labkey/). Tabulated outputs from the Genomics England bioinformatics pipeline are also included in LabKey.
- Relevant genomic data produced by the Genomics England Bioinformatics pipeline (such as rare disease tiering, structural and copy-number variant reports for cancer genomes) are found in your home directory, under the folder 'gel\_data\_resources' and then `main_programme` ([Genomics England Data](../gel_data/)).

Approximately 10% of the genomic data are aligned against the reference genome version GRCh37 and the remaining majority (90%) against version GRCh38. The alignments were also made using different versions of Illuminaâs alignment pipelines V2 and V4, reflecting the versions that were applicable at the time of sequencing. The versions for each genome are identified in the Sequencing Report table. We intend to provide realigned and recalled versions of all our genomes in the future using the DRAGEN 2.0 pipeline. Currently, we have made 31,053 realigned genomes available from 15,001 participants in the Research Environment as part of this data release. These comprise only participants enrolled in the Cancer programme at present.

### Overview video

## Audience

The intended audience for this document is researchers that have access to the Genomics England Research Environment.

## Identifying this data release

The clinical data, secondary data, and tabulated bioinformatic data for this data release, and the paths to the applicable genome files, are found in the following LabKey folder:

`main_programme/main-programme_v17_2023-03-30`

Subsequent releases will be identified by an incremental increase in the version number and the date of data release.

## Frequency of release

Until V6 (Feb 2019), data releases were quarterly. As the data has increased in volume and depth, the time to process and create the data releases has extended. Since V7, there have been releases every 4 months. Now that all consented and eligible 100,000 Genomes Project participants' data are in the research environment, the release schedule is designed to maximise the efficiency with which we add exit questionnaire and new secondary data.

## Samples removed

In Data Release V8, a decision was made to review certain categories of participants and their inclusion in the Genomics Englandâs main programme data. The following scenarios were reviewed and participants discontinued from release V8 onwards:

- Discontinued samples (samples which were not determined to be complete enough for continued inclusion in data releases as per the scenarios below)
  - For both Cancer and Rare Disease
    - Cases with samples that have failed QC with no replacement
    - Adults (individuals >=18 at time of release) consented as children
  - Cancer only
    - Cases for which a âsample not sentâ notification has been received
  - Rare Disease only
    - Cases where the clinical data cannot be verified or resolved to a quality where it is appropriate to include them in the research environment, as determined by the Genomics England clinical team

> **Note:**
>
> Discontinued data and samples will remain in earlier Main Programme releases but will not be included in this or subsequent data releases. For new research, you must use the most recent data release and are not permitted to use previous data releases.

In addition to the above data withdrawals, on rare occasions, we may have to completely remove the genomes of individuals across all data releases to abide by regulatory rules.

## Scope

### In scope

Data that are in scope for this release:

- Cancer and rare disease data for the main programme participants with current consent. These data include:
  - Genomic data for participants when available
  - Whole genome sequencing (WGS) family-based quality control for rare disease, reporting sex checks and pedigree checks
  - Outputs of the Genomics England Bioinformatics Research Services
  - An aggregated Illumina gVCF for germline genomes (including genomes up to late 2019). Please see the documentation here: [Aggregated Variant Calls (aggV2)](../aggv2/)
    - Principal components for germline genomes
    - Inferred ancestry assigned to samples based on genomic data. (See also [aggV2](../aggv2/))
    - The list of samples for this aggregate can be found in the 'aggregate\_gvcf\_sample\_stats' table in Labkey, for the latest data release.
    - Phased data is now available for participants in our aggV2 dataset. The data contains over 342 million phased small variants (SNPs and short indels) across chromosomes 1-22 of aggV2. Detailed documentation can be found here: [Aggv2 Phased Data (Provided by University of Oxford)](../ox_aggv2/). This data was provided by Sinan Shi from the University of Oxford.
  - A somatic aggregate containing 16,341 somatic vcf files (including genomes up to early 2021) from the 100,000 Genomes Project which we made available as a multi-sample VCF dataset (somAgg). More information can be found here: [Somatic Aggregated Variant Call (somAgg v0.2 ALPHA version)](../somAgg/). This is an early stage release and feedback is very welcome.
    - Annotated single nucleotide variants and small indels (â¤50bp) from quality controlled tumour whole genomes.
  - Genome-wide *de novo* variant dataset for 13,925 trios from 12,583 families from the rare disease programme. This was built for main programme data release v9. Researchers are responsible for only using the participants who are consented for research in the latest data release. Please see the documentation here: [The *de novo* variant research dataset for the 100,000 Genomes Project](../de_novo_data/)
  - Polygenic Risk Score values have been made available for 12 complex traits, for ~40k participants from the aggV2 dataset. Detailed documentation can be found here: [Polygenic Risk Scores (Provided by Genomics PLC)](../prs/). This data was provided by Genomics PLC.
  - A collection of 18,990 cancer tier and domain variants reported through the bioinformatics cancer interpretation pipeline aggregated in the cancer\_tier\_and\_domain\_variants table.
  - Long read sequencing data provided by internal teams as part of collaborative pilot projects. These are now been placed under a separate section in LabKey called 'Long Read Sequencing'.
    - Oxford Nanopore Technologies (ONT)
      - `lrs_laboratory_sample` and `lrs_sequencing_data` (<100 Rare Disease programme participants)
      - `cancer_ont_cohorts` (<150 Cancer programme participants from various cancer disease types)
    - PacBio
      - `rare_disease_pacbio_pilot` (<100 Rare Disease programme participants)
  - Outputs of the Genomics England Bioinformatics rare diseases interpretation pipeline
    - Tiering data â rare disease
    - Exomiser results for interpreted genomes â rare disease
    - GMC outcome data ("exit questionnaire data") â rare disease - up until 24/01/2023.
    - Platypus vcfs used for the genomic interpretation of 33,973 families (3,430 GRCh37 and 30,545 GRCh38) are available via the rare\_disease\_interpreted table. Platypus vcfs are provided unannotated.
  - Outputs of the Genomics England Bioinformatics cancer interpretation pipeline
    - 'Gold standard' cancer genomes which have been through interpretation and passed quality checks
    - Tumour signature and mutational burden data
    - Annotation and tiering of small variants
      - Tiering, structural and copy number variant report
    - Cancer Principal Component Analysis (PCA). For more information on these metrics please see the following document: [Cancer Analysis Technical Information Document](../cancer_analysis/).
  - Submitted Diagnostic Discovery data provided by the Research Community. These are potential diagnoses that were not identified as causal in the initial analysis by GEL, but were identified by Research Environment users and submitted to GEL as part of a process called 'Diagnostic Discovery'. If you would like to be involved in this yourself please contact [service desk](../help/). These findings are in addition to the GMC exit questionnaire data, and may remain listed as "unsolved cases" therein.
  - Clinical data collected upon enrollment, including formal pedigree data on rare disease participants where it is available
  - Secondary datasets (medical history), these are available at varying levels of completeness and include:
    - Hospital Episode Statistics (HES), including HES Accident and Emergency, HES Admitted Patient Care, and HES Outpatient Care.
    - Emergency Care Data Set (ECDS).
    - Diagnostic Imaging Dataset (DID).
    - Mental Health Minimum Dataset (MHMDS).
    - Mental Health Learning Disabilities Dataset (MHLDDS).
    - Mental Health Services Dataset (MHSDS).
    - Office for National Statistics - Death details data, Cancer Registration (MORTALITY, CANCER\_REGISTRY).
    - Systemic Anti-Cancer Therapy Dataset (SACT).
    - Systemic Anti-Cancer Therapy Dataset - UNCURATED (SACT\_UNCURATED).
    - National Radiotherapy Dataset (RTDS).
    - Cancer Registration (AV) tables.
    - Cancer waiting times (CWT).
    - Lung Cancer Data Audit (LUCADA).
    - National Cancer Registration and Analysis Service Diagnostic Imaging Dataset (NCRAS\_DID).
    - COVID Test Results data (covid\_test\_results). This was previously included in the frequent release section.
  - Sample datasets describing:
    - Handling and quality control of DNA samples at the Genomic Medicine Centres, the biorepository and the sequencer.
    - Omics samples stored at the biorepository.
  - Orthogonal standard-of-care test data collected from GMCs for a subset of cancer patients

### Out of scope

Additional time is required to update the applications/tools that are available in the RE to the current data release, e.g. IVA, Participant Explorer. Please refer to the [Application Data Versions](../tool_versions/) page for the data release version used in the RE products and services.

Data out of scope for this release:

- Clinical and genomic data for participants that have withdrawn from the 100,000 Genomes Project or were otherwise ineligible.
- Participant data from the pilot phases of the project.
- Clinical data for participants on expired child consent collected after their 16th birthday (for more details see [Clinical and phenotype data : Secondary data - Participant Consent](../clinical_data/)).
- Data relating to the NHS Genomic Medicine Service (GMS) . Genomic and clinical data on NHS GMS participants is currently released separately to the main\_programme release. For more information on the NHS GMS data releases please see: [NHS GMS data release notes](../current_gms/)

### Quality notes

- BAM and VCF genomic data files are as they have been delivered to us by our sequencing provider (Illumina). These have all passed an initial QC check based on sequencing quality and coverage. They have, however, not all undergone our full in-house quality checks and they are therefore subject to potential discrepancies or inaccuracies. Such checks include, but are not limited to, discrepancies in genetic versus reported sex and in family relationships.
  - As participants undergo the in-house checks and pass through the Genomics England interpretation pipeline, any inaccuracies we identify will be rectified in subsequent releases.
  - Any samples that have been affected prior to this release (e.g. sample swaps or samples that have been retracted as part of the in-house QC process) are listed in Section 10 below.
  - You are encouraged to work on the subset of samples that have already passed our internal QC checks; these can be found below for rare disease and cancer genomes, respectively.
- For Rare Disease genomes, you should note that all tiered genomes have passed through Genomics England in-house QCs and that all tiered genomes come from the pool of genomes that have had family checks applied to them, as a first step towards Genomics England tiering. For rare disease interpretation including tiering, small variants are called using the Platypus variant caller. Please see the Rare Disease Results Guide on our [Further reading and documentation page](../further_reading/) for more information.
  - Different QC filtering has been applied to the Illumina VCF files and the Platypus VCFs that are used for tiering in the rare disease programme. There may therefore, be tiered variants that have been filtered out of the Illumina VCF files, and, conversely, variants present in the Illumina VCF file that have been filtered out of the platypus VCFs.
  - Some rare disease families lack a proband.
  - Human Phenotype Ontology (HPO) terms may be missing or incomplete for some participants.
  - Each participant's relationship to their family's proband is available in the `rare_diseases_pedigree_member` table and can be used to determine family relationships, especially for cases without formal pedigree data. Pedigree data are only available for a subset of rare disease participants.
  - WGS family selection quality checks are provided for rare disease genomes on GRCh38, reporting abnormalities of sex chromosomes and reported vs genetic sex summary checks (computed from family relatedness, Mendelian inconsistencies, and sex chromosome checks). Full details on why a family has failed a reported vs genetic sex check can be requested via the [Service Desk](https://www.genomicsengland.co.uk/service-desk).
- For Cancer genomes, you should note that all 'gold standard genomes' that have been through Genomics England interpretation and passed quality checks are found in the cancer quick view table cancer\_analysis. **We strongly recommend using the data from this table for *all* cancer analyses**.
- Clinical data and secondary data have been provided as submitted and have undergone limited validation and cleaning
- **sact\_uncurated** is the table with the raw feed from NCRAS which feeds into their curation process producing the SACT table (both under NCRAS section), which remains the gold standard. A major point to raise is that this SACT curation does not provide tumour IDs, thus you must match this dataset to other NCRAS registries by adjusting for date. A lot of familiar data fields remain in their raw non-standardised form (sex, treatmentintent, clinicaltrialindicator). Pending feedback, these fields can be normalised in subsequent updates.

### Terms of use for specific cohorts

> **Note:**
>
> Participants identified as TracerX in the field normalised\_consent\_form in the participant table in LabKey must not be used by commercial organisations. Commercial organisations do not have access to the genomic data of TracerX participants.
>
> Participants with a participant ID that commences with 125 or 226 were recruited through the Scottish Genomes Partnership Research Programme. These are under the governance of a separate but linked consent and protocol to the 100,000 genomes project. Only the removal of summary level statistics is permitted. Airlock approval will not be granted for the removal of record level data associated with these participants.

## Data release description

The Genomics England data are organised into data views (displayed within LabKey as tables) categorised into Quick View, Common, Bioinformatics, Rare Disease and Cancer. The Data Dictionary that describes the table structure and provides data definitions for this release can be found [here](../r17_data_dictionary.xlsx).

### Quick view

Data views that bring together data from several LabKey tables for convenient access:

| Name of table / data view | Description |
| --- | --- |
| rare\_disease\_analysis | Data for all rare disease participants including: sex, ethnicity, disease recruited for and relationship to proband; latest genome build, QC status of latest genome, path to latest genomes and whether tiering data are available; as well as family selection quality checks for rare disease genomes on GRCh38, reporting abnormalities of the sex chromosomes, family relatedness, Mendelian inconsistencies and reported vs genetic sex summary checks. Please note that only sex checks are unpacked into individual data fields; a final status is shown in the âgenetic vs reported resultsâ column. |
| rare\_disease\_interpreted | Data for all interpreted rare disease participants including: sex, recruited disease of the proband, delivery IDs and file paths of the BAMs used for each interpretation, file path to the raw platypus vcf used for each interpretation, and the status of each interpretation (please see the [Data Dictionary](../r17_data_dictionary.xlsx) for more details). This table includes entries from the gmc\_exit\_questionnaire such as: case\_solved\_family and gmc\_exit\_q\_event\_date (= event\_date in gmc\_exit\_questionnaire). Furthermore, the rare\_disease\_interpreted table contains interpretations that have not yet been fully evaluated by a GMC and thus will not appear in the gmc\_exit\_questionnaire. We therefore added an additional status in âcase\_solved\_familyâ called âreport\_not\_availableâ. Finally, this table provides a column called âlast\_statusâ. This refers to the last available status of an interpretation. For more details, please see the [Data Dictionary](../r17_data_dictionary.xlsx). Please note that for families and relatives for who have (partially) withdrawn consent, the platypus genomes have not been made available and thus NA may appear in the platypus\_vcf\_path field. |
| cancer\_analysis | The Cancer Analysis table provides a list of cancer samples that have been sequenced and had variants called by the Illumina pipeline. Genomics England passes the samples through its Interpretation Pipeline, which will apply further QC and annotate on the called variants and perform analyses, such as estimating tumour mutation burden and compute mutational signatures. This information is then made available in the Cancer Analysis table, where each entry corresponds to one tumour sample that has been sequenced and interpreted. Samples are categorised by their registration disease and disease subtype. Data for all cancer participants whose genomes have been through Genomics England bioinformatics interpretation and passed quality checks, including: sex, ethnicity, disease recruited for and diagnosis; tumour ID, build of latest genome, QC status of latest genome and path to latest genomes; as well file paths to the genomes. This table includes information derived from laboratory\_sample and cancer\_participant\_tumour. Some key data included in the table are elucidated below: *Global Tumour Mutation Burden* This is the number of somatic non-synonymous small variants per megabase of coding sequences (32.61 Mb). This metric was calculated using somatic\_small\_variants\_annotation\_vcf as input (see below for description) and all non-PASS variants were removed from the calculation. *Tumour purity* This is the tumour purity (cancer cell fraction) as calculated by [Ccube](https://rdrr.io/github/keyuan/ccube/) *Mutational Signatures* The table includes the relative proportions of the different mutational signatures demonstrated by the tumour. Analysis of large sequencing datasets (10,952 exomes and 1,048 whole-genomes from 40 distinct tumour types) has allowed patterns of relative contextual frequencies of different SNVs to be grouped into specific mutational signatures. Using mathematical methods (decomposition by non-negative least squares) the contribution of each of these signatures to the overall mutation burden observed in a tumour can be derived. Further details of the 30 different mutational signatures used for this analysis, their prevalence in different tumour types and proposed aetiology can be found at the [Sanger Institute Website](http://cancer.sanger.ac.uk/census). *Cancer PCA QC Statistics* The cancer analysis pipeline employs a sequencing quality control check which selects several important statistics associated with the sequencing returned by the sequencing provider, and uses them to check whether or not the sample in question is an outlier with respect to previous samples that have been run through the pipeline. It is, in effect, a safety net that can spot issues that have occurred at the tissue collection stage (i.e. at the GMC (Genomic Medicine Centre)) or at the library preparation step (i.e. at the sequencing provider), both of which may impact upon the final genomic analysis returned to the clinician. *Somatic small variants annotation vcf filepaths* The somatic\_small\_variants\_annotation\_vcf column contains file paths pointing to VCFs containing Genomics England flags for potential false positive variants as well as additional annotations (see VCF header for details). SIFT and PolyPhen scores as well as new PONnoise50SNV flag were added. The flags used for annotation are: i. CommonGermlineVariant: variants with a population germline allele frequency above 1% in an early subset of the Genomics England dataset. ii. CommonGnomADVariant: variants with a population germline allele frequency above 1% in gnomAD dataset iii. RecurrentSomaticVariant: recurrent somatic variants with frequency above 5% in an early subset of the Genomics England dataset iv. SimpleRepeat: variants overlapping simple repeats as defined by Tandem Repeats Finder v. BCNoiseIndel: small indels in regions with high levels of sequencing noise where at least 10% of the basecalls in a window extending 50 bases to either side of the indelâs call have been filtered out by Strelka due to the poor quality vi. PONnoise50SNV: SNVs resulting from systematic mapping and calling artefacts The following methodology was used for the PONnoise50SNV flag: the ratio of tumour allele depths at each somatic SNV site was tested to see if it is significantly different to the ratio of allele depths at this site in a panel of normals (PoN) using Fisherâs exact test. The PoN was composed of a cohort of 7000 non-tumour genomes from the Genomics England dataset, and at each genomic site only individuals not carrying the relevant alternate allele were included in the count of allele depths. The mpileup function in bcftools v1.9 was used to count allele depths in the PoN, and to replicate Strelka filters duplicate reads were removed and quality thresholds set at mapping quality >= 5 and base quality >= 5. All somatic SNVs with a Fisherâs exact test phred score < 50 were filtered, this threshold minimised the loss of true positive variants while still gaining significant improvement in specificity of SNV calling as calculated from a TRACERx truth set. A presentation entitled PONnoise50SNV: SNVs resulting from systematic mapping and calling artefacts, which further outlines the methodology, can be found in the Publications and other useful links table located on our Further reading and documentation page. *Alignment BAM files generated by Isaac Genome Alignment Software* A paper written by Research Network members discussing the issue of reference bias in the computation of variant allele frequencies (VAFs) by the Illumina Isaac pipeline (caused by preferential soft clipping of reads supporting alternate alleles) can be located [here](https://europepmc.org/article/MED/32437525) |
| participant\_summary | The Participant Summary table provides data for all rare disease and cancer participants. The table is an aggregation of data from several Rare Diseases, Cancer and Bioinformatics tables within LabKey which aims to provide commonly used fields across all these tables in a single space for all our participants. The Participant Summary table is composed of demographic information from table participant, ancestry information from aggregate\_gvcf\_sample\_stats, death details from tables death\_details, mortality and rare\_diseases\_pedigree\_member, study information from cancer\_analysis, disease and phenotype information from tables rare\_diseases\_participant\_disease, rare\_disease\_interpreted rare\_diseases\_participant\_phenotype (filtered for phenotypes where hpo\_present = 'yes') and cancer information from tables cancer\_staging\_consolidated and cancer\_participant\_disease. This table was previously named key\_columns in v16. For further details on the construction of this table please see [here](../general_clinical/). |

### Common

Data views that are common to both the rare disease and the cancer domains. This data pertains to sample handling, genome sequencing, and participant data.

Data Relating to Participants:

| Name of table / data view | Description |
| --- | --- |
| participant | Data on each individual participant in the 100,000 Genomes Project, e.g. personal information (such as relatives or self-reported ethnicity); points of contact with the Project (e.g. handling Genomic Medicine Centre or Trust); and a record of the status of their clinical review. |
| death\_details | Data on participant deaths submitted by GMCs, likely less complete than the data collected by ONS and NHSE. |

Data Relating to Samples:

| Name of table / data view | Description |
| --- | --- |
| clinic\_sample | Data describing the taking and handling of participant samples at the Genomic Medicine Centres, i.e. in the clinic, as well as the type of samples obtained. Because of the complexities of handling and managing tumour tissues samples in a clinical setting, there are many fields that are cancer-specific. |
| clinic\_sample\_quality\_check\_result | Data describing the quality control of obtaining and handling participant samples at the Genomic Medicine Centres, i.e. in the clinic. |
| laboratory\_sample | Data describing the handling of samples at the biorepository and in preparation for sequencing, as well as the type of sample. |
| plated\_sample | Data describing the handling and QC of samples at Illumina (the sequencing provider). |
| laboratory\_sample\_omics\_availability | Availability of samples collected from participants in the 100,000 Genomes Project for the purpose of omics research. Data includes: Participant ID, Sample Type (e.g. Serum, RNA Blood), the number of aliquots of that sample type for that participant, and the availability status - whether the sample has already been used for a research project. Research proposals for the use of these samples can be submitted, via the GECIP team, to the Scientific Advisory Committee and Access Review Committee. |

### Bioinformatics

Contains tables with data that are related to the genomic data and the outputs from the Genomics England interpretation pipeline data for participants from both cancer and rare disease programmes. These tables do not directly include primary and secondary sources of clinical data.

| Name of table / data view | Description |
| --- | --- |
| sequencing\_report | For each participant in the 100,000 Genomes Project, this table contains data describing the sequencing of their genome(s) and associated output, as well as the sample type that the sequence is from. |
| genome\_file\_paths\_and\_types | Data that specifies the genomic files and their folder locations for a given participant. Please be aware that the same genome can be released with multiple versions of mapping/variant calling pipeline. Since the Main Programme Data Release Version 10, we have added file paths to genomes that have been realigned with the DRAGEN pipeline. Please see the change summary for Main Programme Data Release v10 below on how to select for these. |
| aggregate\_gvcf\_sample\_stats | This table accompanies the aggregated Illumina gVCFs (/gel\_data\_resources/main\_programme/aggregation/aggregate\_gVCF\_strelka/aggV2). Individual sample QC data was retrieved from Genomics England OpenCGA database. Most sequencing metrics are BAM file statistics provided from Illumina or Genomics England WGS data processing pipeline. The table contains principal components, a set of unrelated individuals and probabilities of ancestry membership, and more. (These are crude categories to represent broad groups of ancestries. Please do not over-interpret these.) Please also refer to the documentation listed here: [Aggregated Variant Calls (aggV2)](../aggv2/). *This table was changed significantly from Main Programme Data Release Version 10 onwards. Please see the change summary of the respective Data Release below.* |
| tiering\_data | For each participant of the 100,000 Genomes Project who has been through the Genomics England interpretation pipeline, this table contains data describing the variants that are identified as plausibly pathogenic for a participant's phenotype. The tiering process is based on a number of features such as their segregation in the family, frequency in control populations, effect on protein coding, and mode of inheritance. and whether they are in a gene in the virtual gene panel(s) applied to the family. The applied panels can be found in the respective table 'panels\_applied'. |
| tiered\_variants\_frequency | This table contains the frequencies of each tiered variant for every Project participant for whom we provide tiered variants. |
| panels\_applied | For each participant of the 100,000 Genomes Project, this table contains the name and version of the panel(s) that was applied to his or her genome. |
| exomiser | This table contains the full results from the Exomiser rare disease SNV and Indel Prioritisation Process. All rare disease cases are now run through the Exomiser automated variant prioritisation framework as part of the interpretation pipeline. Given a multi-sample VCF file, family pedigree and proband phenotypes encoded by Human Phenotype Ontology (HPO) terms, Exomiser annotates the consequence of variants (based on Ensembl transcripts) and then filters and prioritises them for how likely they are to be causative of the probandâs disease based on: 1) the predicted pathogenicity and allele frequency of the variant in reference databases 2) how closely the patientâs phenotypes match the known phenotypes of diseases and model organisms associated with the gene. Exomiser was developed by members of the Monarch initiative: principally Dr. Damian Smedleyâs team at Queen Mary University London and Professor Peter Robinsonâs team at Jackson Laboratory, USA, with previous contributions from staff at CharitÃ© âUniversitÃ¤tsmedizin, Berlin and the Sanger Institute. Please see 1) [Publication](https://www.nature.com/articles/nprot.2015.124) [Website](https://github.com/exomiser/Exomiser) |
| gmc\_exit\_questionnaire | Data reporting back from the Genomic Medicine Centres, for variants reported to them by Genomics England, to what extent a familyâs presenting case can be explained by the combined variants reported to them (including any segregation testing performed); confidence in the identification and pathogenicity of each variant; and the clinical validity of each variant or variant pair in general and clinical utility in a specific case (only the most recent update will be shown and only one questionnaire per report). |
| domain\_assignment | For each participant in the 100,000 Genomes Project, this table contains: data describing the disease type to which they were recruited; the gene panel(s) applied to their genome(s); the GECIP domain to which their genome(s) have been assigned for the purposes of administering the GECIP publication moratorium; whether this participant is still under moratorium as of the date of release, and the end date of the GECIP moratorium associated with their genome(s). |
| cancer\_staging\_consolidated | This table combines staging information from our primary clinical data (cancer\_participant\_tumour) and secondary clinical data from PHE/NCRAS (sact and av\_tumour) to give a stage for each sample we have sequenced and fully interpreted on our database (cancer\_analysis). The staging information may be in form of TNM combined, each component or other standards such as AJCC, or Dukes', for example. The genomic data is matched to the clinical data using a disease type (genomic data) and ICD code (clinical data) correspondence dictionary created and validated internally. Also, the clinical stage information must not be further away than one year from the date the sample has been collected. Note that, the column names have been preserved as found in the original datasets they were extracted from, except for tumour\_pseudo\_id found both in sact and av\_tumour, where a prefix with the dataset names was added to. Also, for each staging dataset used, when more than one entry for the same patient was available the closest one to the clinical data collection has been kept. Further information on the staging table and its generation process can be found in the document: [Staging data (Cancer)](../cancer_staging/) |
| denovo\_cohort\_information | Table with cohort information for all participants included in the de novo variant dataset. Attributes within this table include: participant ID, sex, affection status, family ID, pedigree ID, and the path to each family's multi-sample VCF with flagged DNVs. See [De novo variant research dataset](../de_novo_data/) for more information. |
| denovo\_flagged\_variants | Table of all base\_filter pass variants for all trios within the DNV dataset. This table includes all flags from the DNV annotation pipeline for each variant. See De novo variant research dataset for more information. |
| cancer\_100K\_genomes\_realigned\_on\_pipeline\_2 | Cancer genomes re-processed through Pipeline 2.0 (which uses DRAGEN v3.2.22 for alignment and germline variant calling + Strelka 2.9.9 for somatic small variants + Canvas 1.39 for somatic CNV + Manta 1.5 for somatic SVs). Also contains somatic\_small\_variants\_annotation\_vcf files and tumour in normal contamination (TINC) results for a subset of ~800 haematological samples. |
| submitted\_diagnostic\_discovery | This table contains a summary of variants that have been reported back to the GMCs as potentially causal as a result of analyses that have taken place after the initial standard 100,000 Genomes Project analysis by Genomics England. It combines both findings sourced internally within GEL, and from the research community. The motivation behind curating this table from data GEL uses to report to the Genomic Laboratory Hubs (GLHs) is to avoid duplicated effort within our research community (by which a variant that has been reviewed and submitted to a GLH is investigated again by a different member of the research community). |

### Long Read Sequencing

Contains tables related to long-reads sequencing data for 100,000 Genomes Project participants.

| Name of table / data view | Description |
| --- | --- |
| lrs\_laboratory\_sample | Data describing the characteristics and processing methods (DNA to library preparation) of samples from participants in the 100,000 Genomes Project for which long-reads sequencing has been carried out. |
| lrs\_sequencing\_data | This table includes data describing long-read sequencing of a subset of 100,000 Genomes Project participants and associated output, including paths to raw and BAM files. |
| cancer\_ont\_cohorts | Table listing participant ids, sample data, file paths and sequencing statistics for Oxford Nanopore cancer cohorts available in the Research Environment, along with corresponding matched germline and Illumina short reads files where available |
| rare\_disease\_pacbio\_pilot | This is a dataset of 91 rare disease samples from the 100kGP genome project re-sequenced with Pacific Biosciences (PacBio) as an example dataset to to demonstrate the utility of their HiFi technology. |

### Rare diseases

Rare disease data are presented at the level of rare disease families (families of probands), rare disease pedigrees, and participants. Participants are individuals who have consented to be part of the project with the expectation that a sample of their DNA will be obtained and their genome sequenced. Pedigree members are extended members of the probandâs family, this includes participants as well a small amounts of deidentified data recorded to allow a full picture of the probandâs extended family. This additional information is extracted from the probandâs medical record.

All rare disease table names are prefixed with ârare\_diseases\_â.

Data at the Level of rare disease families:

| Name of table / data view | Description |
| --- | --- |
| rare\_diseases\_family | Data describing the families of rare disease probands participating in the 100,000 Genomes Project. It includes the family group type, the status of the familyâs pre-interpretation clinical review and the settings that were chosen for the interpretation pipeline at the clinical review. |
| rare\_diseases\_pedigree | Data describing the Rare Disease participants, linking pedigrees to probands and their family members. |
| rare\_diseases\_pedigree\_member | Data describing the Rare Disease pedigree members, similar to the data about each individual participant in the participant table (common data view). It may also include additional data, such as the age of onset of predominant clinical features; data on links to other family members; as well as phenotypic data. |

Data at the level of rare disease participants.

The data presented in these tables provides information on disease progression and pertinent medical history:

| Name of table / data view | Description |
| --- | --- |
| rare\_diseases\_participant\_disease | Data describing the rare disease participants' disease type/subtype assigned to them upon enrolment, and the date of diagnosis. |
| rare\_diseases\_participant\_phenotype | Data describing the Rare Disease participantsâ phenotypes. For each Rare Disease participant in the 100,000 Genomes Project, there are data about whether a phenotypic abnormality as defined by an HPO term is present and what the HPO term is, as well as the age of onset, the severity of manifestation, the spatial pattern in the body and whether it is progressive or not. Please note that these data are only available for a subset of the rare disease participants. |
| rare\_diseases\_gen\_measurement | For Rare Disease participants in the 100,000 Genomes Project, this table contains general measurements relevant to the disease, alongside the date that the measurements were taken on. Please note that these data are only available for a subset of the rare disease participants. |
| rare\_diseases\_early\_childhood\_observation | For Rare Disease participants in the 100,000 Genomes Project, this table contains measurements and milestones provided by the GMCs, related to childhood development. Please note that these data are only available for a subset of the rare disease participants. |
| rare\_diseases\_imaging | For Rare Disease participants in the 100,000 Genomes Project, this table contains various data and measurements from past scans, alongside the date of the scans. Please note that these data are only available for a subset of the rare disease participants. |
| rare\_diseases\_invest\_genetic | For Rare Disease participants in the 100,000 Genomes Project, this table contains information on any genetic tests carried out. Data characterising the genetic investigation is recorded alongside records of the sample tissue source and the type of testing laboratory. Please note that these data are only available for a subset of the rare disease participants. |
| rare\_diseases\_invest\_genetic\_test\_result | For Rare Disease participants in the 100,000 Genomes Project, this table contains the results of any genetic tests carried out. Following on from the rare\_diseases\_invest\_genetic table, a summary of the results is presented and contextualised by testing method and scope. Please note that these data are only available for a subset of the rare disease participants. |
| rare\_diseases\_invest\_blood\_laboratory\_test\_report | For Rare Disease participants in the 100,000 Genomes Project, this table contains the results of any blood tests carried out. Over 400 blood values are recorded alongside type and technique of testing and the status of the participating patient in the care pathway. Please note that these data are only available for a subset of the rare disease participants. |

### Cancer

Cancer data are presented for either the patient level cancer diagnosis/disease type or the tumour-specific sample details of participants in the cancer arm of the 100,000 Genomes Project.

All cancer table names are prefixed with âcancer\_"

Data relating to cancer participants:

| Name of table / data view | Description |
| --- | --- |
| cancer\_participant\_disease | For each cancer participant in the 100,000 Genomes Project, this table includes data about their cancer disease type and subtype. |
| cancer\_participant\_tumour | For each cancer participantâs tumour in the 100,000 Genomes Project, this table contains data that characterises the tumour, e.g. staging and grading; morphology and location; recurrence at time of enrolment; and the basis of diagnosis. |
| cancer\_participant\_tumour\_metastatic\_site | For each cancer participant in the 100,000 Genomes Project, this table contains the site of their metastatic disease in the body (if applicable) at diagnosis. |
| cancer\_care\_plan | For a proportion of cancer participants in the 100,000 Genomes Project, this table contains information from their NHS cancer care plan on their treatment and care intent, in particular outcomes of MDT meetings and coded connected data (e.g. diagnoses from scans). |
| cancer\_surgery | For a proportion of cancer participants in the 100,000 Genomes Project, this table contains details of what surgical procedures were had, as well as the specific location of the intervention. |
| cancer\_risk\_factor\_general | For a proportion of cancer participants in the 100,000 Genomes Project, this table contains data on general cancer risk factors, namely smoking status, height, weight and alcohol consumption. This table was compiled with input from Research Network members. |
| cancer\_risk\_factor\_cancer\_specific | For a proportion of cancer participants in the 100,000 Genomes Project, this table contains data on specific risk factors related to particular cancer types. This table was compiled with input from GECIP members. |
| cancer\_invest\_imaging | For a proportion of cancer participants in the 100,000 Genomes Project, this table contains: coded data on imaging investigations characterising the scan, its modality, anatomical site and outcome; as well as the outcome of the imaging report in free text form. |

Data derived from or relating to tumour samples:

| Name of table / data view | Description |
| --- | --- |
| cancer\_invest\_sample\_pathology | For a subset of cancer participants in the 100,000 Genomes Project, this table contains full pathology reports and other related data on and from their tumour samples around diagnosis and characterisation of the cancer. Please note that much of this information is also found in the clinic\_sample and cancer\_participant\_tumour tables. |
| cancer\_specific\_pathology | For a subset of tumours from cancer participants in the 100,000 Genomes Project, this table contains pathology data specific to that participantâs cancer type. This may provide additional data to the cancer\_invest\_sample\_pathology and cancer\_participant\_tumour tables. |
| cancer\_invest\_circulating\_tumour\_marker | For a subset of tumours from cancer participants in the 100,000 Genomes Project, this table contains biomarker measurements specific to particular cancer types. |

### Secondary data

Secondary data tables are the corpus of curated data we receive from national data warehouses for all eligible participants not belonging in a data restricting cohort and not registered in Northern Ireland, Wales or Scotland. They are mostly longitudinal in nature and agnostic to the recruited disease. Data at the point of release captures all activity contained in the period covered within each of the datasets up to the latest quarter published by NHSE and end of calendar year for PHE/NCRAS.

***Please Note: The linking files MH\_bridge and DID\_bridge will no longer be provided as part of the main programme release. Participant id is already been included in all tables making these files redundant.***

#### NHSE

- HES: Hospital Episode Statistics containing details of all commissioned activity during admissions, outpatient appointments and A&E attendances.
- DID: Metadata (demographics, modalities, ordering entity and dates) on diagnostic imaging tests collated from local radiology information systems.
- MORTALITY/CANCER\_REGISTRY: Office of National Statistics registry data for cancer registrations and deaths inside and outside hospitals. Issue of death certificates and cancer network registrations are a requirement for an entry to these manifests.
- COVID: Data on covid test results for 100K participants. Pre Data Release V14 this data was found in the frequent release folder. For more information please see [Clinical and phenotype data](../clinical_data/) Secondary Data - COVID.

| Name of table / data view | Description |
| --- | --- |
| hes\_apc | Historic records of admissions into secondary care of GEL main programme participants. |
| hes\_cc | Historic records of admissions into critical care of GEL main programme participants. |
| hes\_op | Historic records of outpatient attendances of GEL main programme participants. |
| hes\_ae | Historic records of A&E attendances of GEL main programme participants. |
| ecds | Main dataset of urgent and emergency care of GEL main programme participants. Expands hes\_ae and will replace it entirely in the future. |
| did | Historic diagnostic Imaging records of GEL main program participants. |
| mortality | Replaces **ons** table. Covers date of death, place of death, cause of death details (ICD10) only. |
| cancer\_registry | Replaces **cen** table. Covers cancer events only with date of cancer registration and basic cancer type characteristics such as site, morphology and behaviour. |
| covid\_test\_results | This describes extracts from the microbiology results database, known as SGSS, following linkage to external cohort studies. |

- MHMDS: Data on patients receiving care in NHS specialist mental health services. Reporting care period for this dataset is up to March '14.
- MHLDDS: Data on patients receiving care in NHS specialist mental health services. Reporting care period for this dataset is from March '14 to March '16.
- MHSDS: Data on patients receiving care in NHS specialist mental health services. Reporting care period for this dataset us from March '16 to March '19.

A large number of new tables were added in Release v14 as part of the mhsds dataset. For more information on this new dataset please see [Clinical and phenotype data](../clinical_data/) Secondary data - NHSE (clinical data)

| Name of table / data view | Description |
| --- | --- |
| mhmd\_v4\_record | Historic records of MH related admissions of GEL main programme participants. One record per spell per patient in a provider. |
| mhmd\_v4\_event | Historic records of MH related admissions of GEL main programme participants. Episode and event tables link to the records table via spell\_id. |
| mhmd\_v4\_episode | Historic records of MH related admissions of GEL main programme participants. Episode and event tables link to the records table via spell\_id. |
| mhldds\_record | Historic records of MH related admissions of GEL main programme participants. One record per spell per patient in a provider. |
| mhldds\_event | Historic records of MH related admissions of GEL main programme participants. Episode and event table link to the records table via mhm\_mhmds\_spell\_id. |
| mhldds\_episode | Historic records of MH related admissions of GEL main programme participants. Episode and event tables link to the records table via mhm\_mhmds\_spell\_id. |
| mhsds\_master\_patient\_index | Provides patient information, demographics and death details for participants present in the MHSDS dataset. One record per participant per recording period (2016/17, 2017/18, 2018/19) giving a maximum of 3 records per participant. |
| mhsds\_gp\_practice\_registration | Carries details of GP Practice registrations for participants present in the MHSDS dataset. One record per change of GP practice registration. |
| mhsds\_patient\_indicators | Carries details of specific indicators relating to the patient including psychosis. |
| mhsds\_ care\_coordinator | Carries details of the mental health care coordinator assigned to a patient. One record per assignment. |
| mhsds\_care\_plan\_type | Carries details of Care Plans created for a patient by their responsible organisation. One record per care plan created for the patient |
| mhsds\_crisis\_plan | The predecessor (pre 2018) to Care Plan Type. Carries detail of Crisis Plans created for a patient by their responsible organisation. One record per crisis plan created for the patient. Other care plan types are not included. |
| mhsds\_care\_plan\_agreement | Carries detail of any agreements to Care Plans by a patient, team or organization. One record per care plan agreement. |
| mhsds\_service\_or\_team\_referral | Carries details of the referral that a patient is subject to. This is an instance where a patient is referred to specialist care. One record for each referral. |
| mhsds\_service\_or\_team\_type\_referred\_to | Carries details of the service or team that a patient is referred to. One record for each service or team referred to. |
| mhsds\_other\_reason\_for\_referral | Carries additional details about why a patient has been referred to a specific service. One record per additional referral. |
| mhsds\_referral\_to\_treatment | Carries details about the referral to treatment details for the patients referral. One record for each Referral To Treatment period. |
| mhsds\_onward\_referral | Carries details about any onward referral of a patient. One record per onward referral. |
| mhsds\_discharge\_plan\_agreement | Carries details about any agreements to a Discharge Plan by a person, team or organisation. One record per agreement of a discharge plan. |
| mhsds\_care\_contact | Carries details about any contacts with a patient which have taken place as part of a referral. One record per care contact. |
| mhsds\_care\_activity | Carries details about any Care Activity undertaken at a Care Contact. One record per care activity. |
| mhsds\_other\_in\_attendance | Carries details about any other people in attendance at a Care Contact. One record per other person in attendance at a Care Contact. |
| mhsds\_indirect\_activity | Carries details of indirect activity which takes place as a result of the referral. One record for each instance of indirect activity taking place. |
| mhsds\_responsible\_clinician\_assignment | Carries details of the assignment of a Mental Health Responsible Clinician to the patient. One record per assigned Mental Health Responsible Clinician. |
| mhsds\_hospital\_provider\_spell | Carries details of each Hospital Provider Spell for a patient. One record per hospital provider spell. This is a continuous period of inpatient care under a single Hospital Provider starting with a hospital admission and ending with a discharge from hospital. |
| mhsds\_ward\_stay | Carries additional details of Ward Stays which occurred during a Hospital Provider Spell for the patient. One record per ward stay. |
| mhsds\_assigned\_care\_professional | Carries details of the Care Professional assigned responsibility for the care of the patient. One record per care professional admitted care episode. |
| mhsds\_delayed\_discharge | Carries details of the patient's Mental Health Delayed Discharge Periods which occurred during a Hospital Provider Spell. One record per instance of a patient being subject to a mental health delayed discharge period. |
| mhsds\_hospital\_provider\_spell\_commissioner | Carries details of each Commissioner Assignment Period during a Hospital Provider Spell. One record per commissioner assignment period. |
| mhsds\_medical\_history\_previous\_diagnosis | Carries details any previous diagnoses for a patient which are stated by the patient or recorded in medical notes. These do not necessarily have to have been diagnosed by the organisation submitting the data. One record per previous diagnosis. |
| mhsds\_provisional\_diagnosis | Carries details of a provisional diagnosis recorded for a patient. One record per provisional diagnosis. |
| mhsds\_primary\_diagnosis | Carries details of the primary diagnosis recorded for the patient. Only one record is permitted for the primary diagnosis per patient. |
| mhsds\_secondary\_diagnosis | Carries details of a secondary diagnosis recorded for a patient. One record for each secondary diagnosis. |
| mhsds\_coded\_scored\_assessment\_referral | Carries details of scored assessments that are issued and completed as part of a referral to a mental health service, but do not take place at a specific contact. One record per coded scored assessment question or dimension captured outside of a Care Contact. |
| mhsds\_coded\_scored\_assessment\_act | Carries details of scored assessments that are issued and completed as part of a specific Care Activity. One record per coded scored assessment question or dimension captured as part of a specific Care Activity. |
| mhsds\_coded\_scored\_assessment\_cont | Replaced by coded\_score\_assessment\_act in 2018. Carries details of scored assessments that are issued and completed as part of a specific Care Activity. One record per coded scored assessment question or dimension captured as part of a specific Care Activity. |
| mhsds\_care\_programme\_approach\_care\_episode | Carries details of the periods of time the patient spent on Care Programme Approach. One record per CPA Care Episode. |
| mhsds\_care\_programme\_approach\_review | Carries details of the Care Programme Approach (CPA) reviews undertaken for the patient. One record permitted for the most recent CPA Review that has taken place. |
| mhsds\_clustering\_tool\_assessment | Carries details of all clustering tool assessments for all patients. One record per Clustering Tool Assessment. |
| mhsds\_coded\_score\_assessment\_clustering\_tool | Carries details of scored assessments that are issued and completed as part of a Clustering Tool assessment. One record per coded scored assessment question or dimension captured as part of a Clustering Tool assessment. |
| mhsds\_care\_cluster | Carries details of the Care Cluster resulting from a clustering tool assessment. One record per period of time that a patient was allocated to a Care Cluster. |
| mhsds\_curated\_participant | Overview of general participant information; demographics, death details, GP registrations and psychosis indicators, as well as details of any care plans created for a participant. |
| mhsds\_curated\_community | Overview of community (outpatient) care. This includes details on referrals, discharge agreements and care contacts with associated care activities. |
| mhsds\_curated\_inpatient | Overview of inpatient care. This includes details of hospital spells, ward stays, delayed discharge periods and associated clinicians and care professionals. |
| mhsds\_curated\_assessment\_diagnoses\_and\_cluster | Overview of scored assessments and clustering tool assessments completed, patient diagnoses and allocated care clusters. |
| mhsds\_dataset\_flags | Contains, for each participant in mhsds, a flag of which mhsds tables they appear in. This only applies to the individual tables, not the curated tables. |

#### NCRAS

Available for patients diagnosed with Cancer (ICD10 C00-97, D00-48) from 1 January 1995 - 31 December 2019.

This dataset brings together data from more than 500 local and regional datasets to build a picture of an individualâs treatment from diagnosis.

> **Note:**
>
> Please note that anon\_tumour\_ids in AV tables and in SACT are assigned to participants by NCRAS and do not link to the tumour\_ids assigned by GEL for sequencing and clinical data. Whilst (particularly in the case of single tumour) this may refer to the same cancer, caution should be applied prior to any analysis.

> **Note:**
>
> The anon\_tumour\_id column replaced the tumour\_pseudo\_id column in data release v17. anon\_tumour\_id contains a different set of pseudonymised tumour ids to tumour\_pseudo\_id, so the NCRAS assigned ids in releases prior to v17 will not match the ids present in release v17 and onwards.

> **Bug inrtdstable:**
>
> There is a bug in the NCRAS radiotherapy table, `rtds`. Approximately 8% of all records in this table are missing dates. This is due to a bug translating `Sep` in three-letter months to numbered dates.

| Name of table / data view | Description |
| --- | --- |
| av\_patient | Patient information - demographics and death details. |
| av\_tumour | Tumour catalogue and characterisation for all patients with registerable tumour. Table's `anon_tumour_id` is used to link treatment tables also available in NCRAS. One row per tumour (av\* table specific anon\_tumour\_id), per participant at the point of registration of that cancer/tumour with NCRAS. |
| av\_treatment | Tumour linked catalogue of treatments and sites that provided them for all patients with registerable tumour. |
| av\_imd | The Income Deprivation Domain (IMD table) measures the proportion of the population experiencing deprivation relating to low income. The definition of low income used includes both those people that are out-of-work and those that are in work but who have low earnings. |
| av\_rtd | Routes to Diagnosis: cancer registration data are combined with Administrative Hospital Episode Statistics data, Cancer Waiting Times data and data from the cancer screening programmes. Using these datasets cancers registered in England which were diagnosed in 2006 to 2016 are categorised into one of eight Routes to Diagnosis. The methodology is described in detail in the British Journal of Cancer article 'Routes to Diagnosis for cancer - Determining the patient journey using multiple routine datasets'. |
| cwt | The National Cancer Waiting Times Monitoring Data Set supports the continued management and monitoring of waiting times. |
| sact | Systemic Anti-Cancer Therapy (chemotherapy detail) data for cancer participants from NHSE covering regimens between 04/2012 and 08/2022. One row per chemotherapy cycle, per tumour (SACT-specific anon\_tumour\_id), per participant. |
| rtds | The Radiotherapy Data Set (RTDS) standard (SCCI0111) is an existing standard that has required all NHS Acute Trust providers of radiotherapy services in England to collect and submit standardised data monthly against a nationally defined data set since 2009. The purpose of the standard is to collect consistent and comparable data across all NHS Acute Trust providers of radiotherapy services in England in order to provide intelligence for service planning, commissioning, clinical practice and research and the operational provision of radiotherapy services across England. Data is available from 01/04/2009. The data is linked at a patient level and can be linked to the latest available av\_patient table. |
| ncras\_did | The Diagnostic Imaging Dataset (DID) is a central collection of detailed information about diagnostic imaging tests carried out on NHS patients, extracted from local radiology information systems and submitted monthly. The DID captures information about referral source, details of the test (type of test and body site), demographic information such as GP registered practice, patient postcode, ethnicity, gender and date of birth, plus data items about different events (date of imaging request, date of imaging, date of reporting, which allows calculation of time intervals. |
| lucada\_2013 | The National Lung Cancer Audit (LUCADA) looks at the care delivered during referral, diagnosis, treatment and outcomes for people diagnosed with lung cancer and mesothelioma. The data items in the LUCADA dataset have been compiled to meet the requirements of audit, and are not to be confused with the data items identified as Lung Cancer in the National Cancer dataset. The audit focuses on measuring the care given to lung cancer patients from diagnosis to the primary treatment package, assessing against standards and bringing about necessary improvements. The project supports the Calman Hine recommendations, the National Cancer Plan and other national guidance (e.g. NICE guidance) as it emerges. |
| lucada\_2014 | As above. Different schema to lucada\_2013. |

#### Cancer-specific GEL curated datasets - pilot

Genomics England are striving to improve the clinical data provided for its researchers. We understand the value of accurate and granular clinical data, especially in the context of cancer.

In order to deliver this, we are planning a series of pilot datasets, aiming to incorporate additional clinical data provided by Public Health England cancer registry (NCRAS). Genomics England will aim to deliver cancer specific datasets, with the initial focus being on providing a broad pathological understanding. This will aim to incorporate data points such as molecular mutations and resection margins in pathology reports. The focus will then incorporate radiological imaging reports and finally focus on live/ up-to-date clinical data. In addition, we are also including the date each participant was last seen alive (data provided up to October 2020) and dates and causes of death to aid with outcomes.

It must be stressed that this work is a development process, and we are working in unison with NCRAS to progress this. Whilst we do not possess the extensive experience and resource of Public Health England, we are developing a natural language based algorithm for focused data extraction. NCRAS have a dedicated team to curating clinical data and the gold standard remains the NCRAS curated tables. However, for this dataset to improve and move forward, Genomics England are keen for feedback and for you to highlight areas for improvement.

You will note subtle differences to the structure of the table compared to the curated NCRAS tables and thus additional data dictionaries have been provided. Genomics England hopes to continue developing this uncurated live dataset with feedback and look forward to hearing your thoughts. Please reach out to us with related thoughts and suggestions via the Genomics England [Service Desk](https://www.genomicsengland.co.uk/service-desk), including "cancer\_specific\_datasets\_pilot" in the title of your enquiry.

With the addition of the new `pathology_reports` dataset introduced in v16, the `aml_path_reports` and `testes_path_reports` datasets have been deprecated in v17.

| Name of table / data view | Description |
| --- | --- |
| sact\_uncurated | table is the raw feed from NCRAS which feeds into their curation process producing the sact table (both under NCRAS section). This table extracts chemotherapy (SACT) information for cancer participants in the 100,000 genomes project from unlinked and unprocessed NCRAS chemotherapy data from 2008 until March 2021. It is likely to contain some errors, however it contains clinical therapy data that is not yet available in the curated NCRAS registries, such as SNOMED CT diagnosis codes alongside ICD10. A major point to raise is that this SACT curation does not provide tumour IDs, thus you must match this dataset to other NCRAS registries by adjusting for date. Please refer to background and use caveats in the quality notes section of this release note. |
| Pathology Reports | Full text pathology reports pertaining to participants from 100kGP Genomes Project across all cancer types. Multiple reports per participants are provided where available prior, around and post WGS sample. |

#### Activity period coverage for the longitudinal secondary data tables

| Source | Category | Dataset | Start | End |
| --- | --- | --- | --- | --- |
| NHSE | Hospital Episode Statistics | op | 01/04/2003 | 31/07/2022 |
| NHSE | Hospital Episode Statistics | apc | 13/09/1992 | 31/07/2022 |
| NHSE | Hospital Episode Statistics | ae | 01/04/2007 | 31/03/2020 |
| NHSE | Hospital Episode Statistics | ecds | 05/04/2017 | 04/08/2022 |
| NHSE | Hospital Episode Statistics | cc | 01/04/2008 | 29/07/2022 |
| NHSE | Other | covid\_test\_results | 16/03/2020 | 05/01/2022 |
| NHSE | Other | cancer\_register\_nhsd | 07/09/1971 | 15/05/2022 |
| NHSE | Other | did | 19/05/2000 | 28/02/2022 |
| NHSE | Mental Health | mhmd | 01/04/2011 | 31/03/2014 |
| NHSE | Mental Health | mhldds | 01/04/2014 | 30/11/2015 |
| NHSE | Mental Health | mhsds | 01/04/2016 | 01/03/2019 |
| NHSE | Office of National Statistics Mortality | mortality | 27/06/1995 | 19/07/2022 |
| NCRAS | NCRAS | sact\_uncurated | 09/04/2008 | 30/12/2022 |
| NCRAS | NCRAS | sact | 06/04/2012 | 30/08/2022 |
| NCRAS | NCRAS | rtds | 15/04/2009 | 28/02/2022 |
| NCRAS | NCRAS | av\_treatment | 08/02/1985 | 22/08/2022 |
| NCRAS | NCRAS | av\_tumour | 01/01/1985 | 31/12/2019 |
| NCRAS | NCRAS | cwt | 05/01/2009 | 31/12/2018 |
| NCRAS | NCRAS | lucada\_2013 | 25/02/2005 | 02/01/2015 |
| NCRAS | NCRAS | lucada\_2014 | 23/03/2012 | 08/12/2014 |
| NCRAS | NCRAS | ncras\_did | 01/03/2012 | 26/03/2019 |

### Genomics England data resources

Genomics England data resources are available in the following locations:

From the AWS desktop:

`~/gel_data_resources/`

From the high performance compute (HPC) cluster:

`/gel_data_resources/`

The data resources available here are:

**Tiering data for rare disease:** Tiering data are available for rare disease participants who have been through the Genomics England interpretation platform. These data provide information on the pathogenicity of variants that have been identified in the probandâs genome. Tiering data for rare disease probands can also be found in the designated LabKey table outlined above (see tiering\_data table in section 9.3). We have discontinued updating these data until further notice, and refer to the information provided in LabKey which is updated every release.

**GMC exit questionnaires for rare disease:** Outcomes questionnaire for interpreted genomes generated by Genomics England and Clinical Interpretation Providers (gmc\_exit\_questionnaire table in section 9.3). We have discontinued updating these data until further notice, and refer to the information provided in LabKey which is updated every release.

**Interpretation request data for rare disease:** The following information can be found within the interpretation request JSON file: Family Pedigree and Other Family History, Analysis Panels and versions, Specific Disorder, Tiered Variants and Tiering version, HPO terms, Workspace (NHS GMC or LDP site code), Gene Panel Coverage, Disease Penetrance, Variant Classification. We have discontinued updating these data until further notice, and refer to the information provided in LabKey which is updated every release.

**Tiering, structural, and copy-number variant reports for Cancer:** Annotated in JSON format. The file paths are available in the Quick View titled cancer\_analysis.

**Aggregated gVCF dataset (aggV2):** This is a set of multi-sample VCF files containing germline genomic data from 78,141 participants â termed the âaggV2â â from Main Programme Data Release v10. This is an increase of genomic data of ~20,000 participant compared to our original aggregated dataset (âaggV1â). The file contains germline samples from both the rare disease and the cancer programs including only genomes aligned to the Homo Sapiens NCBI GRCh38 assembly with decoys. All included samples have passed a set of basic QC metrics:

- Sample Contamination (freemix) < 0.03
- Ratio of SNV Het-to-Hom calls < 3
- Total Number of SNVs Between 3.2M-4.7M
- Array Concordance > 90%
- Median Fragment Size > 250bp
- Excess of Chimeric Reads < 5%
- Percentage of Mapper Reads > 60%
- Percentage of AT Dropout < 10%

These [QC metrics](../sample_qc/) are provided in the LabKey table aggregate\_gvcf\_sample\_stats.

The aggregated dataset is split into 1,371 genomic regions or 'chunks' by physical position, to process the aggregation in parallel and to ensure that the resulting output files are not too large. No variant (= site) QC filters were applied in the dataset, but the VCF filter was set to PASS for variants which passed the following parameters:

- Missingness (fully missing genotypes with DP=0) â¤ 5%
- Coverage (Median Depth) â¥ 10X
- GQ (Median GQ) â¥ 15
- ABratio (Percentage of het calls not showing significant allele imbalance for reads supporting the ref and alt alleles) â¥ 25%
- completeGTRatio (Percentage of complete sites (sites with no missing data)) â¥ 50%
- phwe\_eur (p-value for deviations from HWE in unrelated samples of inferred European ancestry) â¥ 1e-5

We recommend only using variants that have PASS in the filter column in your analyses which will have passed all the parameters above. If a site does not pass the parameters above, the failing criteria/criterion will be listed in the FILTER field in place of a 'PASS' flag, as detailed in the [Site QC](../site_qc/) documentation.

In addition to the genotypes we provide pairwise kinship and relatedness information (PLINK2 implementation of the KING-Robust algorithm), principal components (of which the first 20 can be found in the aggregate\_gvcf\_sample\_stats LabKey table), and predicted ancestry probabilities for all samples.

All data can be found at:

`/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/`

[Detailed documentation](../aggv2/) and [examples for querying the data](../aggv2_code_book/) are available.

Phased data is now also available for participants in our aggV2 dataset (autosomes only). The data contains over 342 million phased small variants (SNPs and short indels). Detailed documentation can be found here: [Aggv2 Phased Data (Provided by University of Oxford)](../ox_aggv2/). This data was provided by Sinan Shi from the University of Oxford.

Our previous aggregated dataset (âaggV1â) containing germline genomic data from 59,464 participants can still be found at `/gel_data_resources/main_programme/aggregated_illumina_gvcf/GRCH38/20190228/`. However, we strongly recommend using the âaggV2â moving forward for all new analyses.

> **Note:**
>
> This aggregate dataset contains information on a subset of participants who have since been withdrawn from research. Their use in any new analyses is not permitted. Thus, it is extremely important to remove these samples from your analyses and ensure that you are only using samples included in the latest data release. The list of samples for the consented participants can be found in the 'aggregate\_gvcf\_sample\_stats' table in the labkey, for the latest data release. Submit a ticket to the Genomics England Service desk if you are unsure of how to filter the dataset for any other use.

### Cohort metadata

Within the data release, there is genomic data and clinical data for participants that are part of non-NHS research cohorts that have been sequenced by Illumina and analysed via the Genomics England pipeline.

These research cohorts can be distinguished via their clinic ID as each has been given their own unique code. These clinic IDs are primarily located in the participant table filtering either the registered\_at\_ldp\_ods\_code or registered\_at\_ldp\_bioinformatics\_ods\_code for the respective clinic ID. If any genomic or clinical data from the research cohorts is used in your analysis and subsequent publication, reference to the cohort organisation in the first column of the below table will need to be made.

| Non-NHS Cohort Name | Clinic ID | Rare Disease/ Cancer | Description | Constraints | Requirements of Use | Number of genomes (in v17 data release) | Opportunities for further research |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Breast Cancer Now | BCN | Cancer | The Breast Cancer Now Tissue Bank (BCNTB) is a multi-centre tissue bank established to fill the gap in the Triple Negative breast cancer (TNBC) research community. It systematically collects high quality tissues and data under an established ethical framework. Full clinico-pathological and follow-up data is due to be made available with ongoing longitudinal data collection. This cohort is curated group of 81 treatment naÃ¯ve TNBC patients. Additional tissue for many is available through the BCNTB for further matched âomic analysis. | Consistent with Genomics England acceptable uses | Any publication referencing the Sequence Data generated, needs to ensure reference is made to the contribution of the Provider to the generation of the Sequence Data | 81 | Potential to remove identifiers for the purpose of requesting access to Breast Cancer Now biobank samples. |
| Genomics England CLL pilot study | CLL | Cancer | The original Chronic lymphocytic leukaemia (CLL) Genomics England Pilot aimed to develop the protocols and analytical methods required to perform whole genome sequencing (WGS) at scale for patients with CLL recruited into national clinical trials as a prelude to the Genomics England main programme. This cohort is a small subset of the pilot to allow for the provision of validation data. | Consistent with Genomics England acceptable uses | Any publication referencing the Sequence Data generated, needs to ensure reference is made to the contribution of the Provider to the generation of the Sequence Data | 4 |  |
| UKALL2003 trial | ALL | Cancer | The aim of this project is to explore the genomic landscape of patients with acute lymphoblastic leukaemia at initial presentation in order identify mutations that could explain their poor response and potentially be future biomarkers. The objective was to perform whole genome sequencing and targeted screening for mismatch repair deficiency on a large well annotated cohort of patients with ALL treated on the UKALL2003 trial. This will generate, for the first time, a comprehensive genomic landscape of chemo-resistant acute lymphoblastic leukaemia. | Consistent with Genomics England acceptable uses | Any publication referencing the Sequence Data generated, needs to ensure reference is made to the contribution of the Provider to the generation of the Sequence Data | 67 |  |
| NIHR Bioresource | NB3 | Rare Disease | The NIHR BioResource is comprised of volunteers from around the country who have given their consent to taking of a biological sample, and they are willing to be approached to participate in research studies and trials on the basis of their genotype, and or phenotype. This cohort consists of rare disease participants who consented to WGS as part of the 100,000 Genomes Project. | Consistent with Genomics England acceptable uses, | Any publication referencing the Sequence Data generated, needs to ensure reference is made to the contribution of the Provider to the generation of the Sequence Data | 309 | Anyone who wishes to be granted permission to contact any of the NIHR BioResource participants should follow the process of applying to the NIHR BioResource. The steps to be made can be found on the [NIHR BioResource website](https://bioresource.nihr.ac.uk/about-us/about-the-bioresource/) |

## Contact and support

For all queries relating to this data release please contact the Genomics England Service Desk portal: [Service Desk](https://www.genomicsengland.co.uk/service-desk) (accessible from outside the Research Environment). The Service Desk is supported by dedicated Genomics England staff for all relevant questions.

---

1. Some Rare Disease participants have multiple genomes, aligned to both GRCh37 and GRCh38Â [â©](#fnref:1 "Jump back to footnote 1 in the text")
2. This excludes 86 TracerX genomes from 99 participants (refer to 6.4 for further information).Â [â©](#fnref:2 "Jump back to footnote 2 in the text")
3. Please note that long read samples are excluded from these counts.Â [â©](#fnref:3 "Jump back to footnote 3 in the text")
4. On average 2.1 genomes per cancer participant per delivery type.Â [â©](#fnref:4 "Jump back to footnote 4 in the text")
5. Please note that these counts exclude experimental types.Â [â©](#fnref:5 "Jump back to footnote 5 in the text")

January 29, 2026
