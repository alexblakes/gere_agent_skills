---
title: '100kGP Rare disease-specific clinical data - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/rare_disease_clinical/
scraped_at: 2026-05-04T06:33:27Z
---

# 100kGP Rare disease-specific clinical data

Some tables in LabKey contain data specific to the rare disease participants. Some of these tables include data only on rare disease probands, others contain data for their relatives too. All rare disease tables are prefixed by `rare_diseases_` at the beginning of the table name. All tables and their fields are described in our [data dictionary](../100k_data_dictionary/).

> **Primary and secondary data tables:**
>
> Primary clinical data were collected when participants were enrolled in the programme; tables are tagged with .
>
> Secondary clinical data were obtained from third parties such as NHSE; tables are tagged with .

## Central tables

| LabKey table | Description | Primary or secondary | CloudOS tsv filename |
| --- | --- | --- | --- |
| `rare_disease_analysis` | including: sex, ethnicity, disease recruited for and relationship to proband; latest genome build, QC status of latest genome, path to latest genomes and whether tiering data are available; as well as family selection quality checks for rare disease genomes on GRCh38, reporting abnormalities of the sex chromosomes, family relatedness, Mendelian inconsistencies and reported vs genetic sex summary checks. Please note that only sex checks are unpacked into individual data fields; a final status is shown in the âgenetic vs reported resultsâ column. Samples are uniquely identified by their *platekey* number. Note that, one participant may have more than one sample, one built for genome GRCh37 and GRCh38. |  | `gel_rare_disease_analysis_100k.tsv` |
| `rare_disease_interpreted` | including: sex, recruited disease of the proband, delivery IDs and file paths of the BAMs used for each interpretation, file path to the raw platypus vcf used for each interpretation, and the status of each interpretation (please see the [data dictionary](../r18_data_dictionary.xlsx) for more details). This table includes entries from the `gmc_exit_questionnaire` such as: `case_solved_family` and `gmc_exit_q_event_date` (= `event_date` in `gmc_exit_questionnaire`). Furthermore, the `rare_disease_interpreted` table contains interpretations that have not yet been fully evaluated by a Genomic Laboratory Hub and thus will not appear in the `gmc_exit_questionnaire`. We therefore added an additional status in `case_solved_family` called `report_not_available`. Finally, this table provides a column called `last_status`. This refers to the last available status of an interpretation. For more details, please see the [data dictionary](../r18_data_dictionary.xlsx). Please note that for families and relatives for who have (partially) withdrawn consent, the platypus genomes have not been made available and thus `NA` may appear in the `platypus_vcf_path` field. |  | `gel_rare_disease_interpreted_100k.tsv` |

## Rare disease phenotype tables

| LabKey table | Description | Primary or secondary | CloudOS tsv filename |
| --- | --- | --- | --- |
| `rare_diseases_participant_disease` | describes the proband's disease type/subtype assigned to them upon enrolment. This is as for `rare_diease_pedigree_member`, with the addition of a date of diagnosis. |  | `gel_rare_participant_disease_100k.tsv` |
| `rare_diseases_participant_phenotype` | describes the probands' phenotype(s). The phenotypic abnormality are defined as whether an HPO term that is present or not and what the HPO term is, as well as the age of onset, the severity of manifestation, the spatial pattern in the body and whether it is progressive or not. See details below on how HPO terms are assigned. |  | `gel_rare_participant_phenotype_100k.tsv` |
| `rare_diseases_early_childhood_observation` | contains, for a subset of rare disease participants, measurements and milestones provided by the Genomic Laboratory Hubs, related to childhood development. |  | `gel_rare_disease_childhood_100k.tsv` |
| `rare_diseases_gen_measurement` | contains, for a subset of rare disease participants, general measurements relevant to the disease, alongside the date that the measurements were taken on. |  | `gel_rare_disease_general_measurement_100k.tsv` |
| `rare_diseases_imaging` | contains, for a subset of rare disease participants in the 100,000 Genomes Project, various data and measurements from past scans, alongside the date of the scans. |  | `gel_rare_disease_imaging_100k.tsv` |
| `rare_diseases_invest_blood_laboratory_test_report` | contains, for a proportion of rare disease participants, the results of any blood tests carried out. Over 400 blood values are recorded alongside type and technique of testing and the status of the participating patient in the care pathway. |  | `gel_rare_disease_blood_test_results_100k.tsv` |
| `rare_diseases_invest_genetic` | contains, for a proportion of rare disease participants in the 100,000 Genomes Project, information on any genetic tests carried out. Data characterising the genetic investigation is recorded alongside records of the sample tissue source and the type of testing laboratory. |  | `gel_rare_disease_genetic_test_100k.tsv` |
| `rare_diseases_invest_genetic_test_result` | contains, for a proportion of rare disease participants in the 100,000 Genomes Project,the results of any genetic tests carried out. Following on from the rare\_diseases\_invest\_genetic table, a summary of the results is presented and contextualised by testing method and scope. |  | `gel_rare_disease_genetic_test_result_100k.tsv` |

### HPO terms in the `rare_diseases_participant_phenotype` table

Rare disease participants are phenotyped using the Human Phenotype Ontology (HPO).

The ontology comprises over 10,000 terms for describing phenotypic abnormalities and also contains over 50,000 annotations of HPO terms to hereditary diseases. The terms collectively form a relational network (connected by **is-a** connections), such that each term is a more specific, or more limited, instance of its parent term - eg *abnormality of the foot* **is-a** *abnormality of the lower limbs*.

The presence or absence of particular HPO terms in each of the rare disease participants are given in the HPO dataset, along with *modifiers* that give further specifics on how that phenotype is manifested in that individual. These modifiers are the laterality, age of onset, progression, severity and spatial pattern. Clicking on the field name in LabKey and selecting `Filter` will give you an idea of the values present for each of these modifiers.

Genomics England has developed what we call 'disease data models', a list of HPO terms that define each disease, to aid the process of phenotyping at the Genomic Laboratory Hub end. The list of rare disease data models can be found in the [Rare Disease Data Models pdf](https://www.genomicsengland.co.uk/about-genomics-england/the-100000-genomes-project/information-for-gmc-staff/rare-disease-documents).

In addition, for each participant the Genomic Laboratory Hub can also enter additional HPO terms that are not necessarily listed in the clinical data model, if they think it is useful to drive the selection of additional panels. The above will typically comprise the list of HPO terms that have been specifically assessed for each participant.

## Rare disease families

Rare Disease data are presented at the level of rare disease families (families of probands), rare disease pedigrees and participants:

- *Participants* are individuals who have consented to be a part of the project with the expectation that a sample of their DNA will be obtained and their genome sequenced. Participants can be proband or relatives.
- *Probands* are the affected individuals that started the participation of that family into the programme, and for who most of the analyses are done.
- *Relatives* are other participants that may or may not be affected.
- *Pedigree members* are extended members of the proband's family, which will include some participants (relatives) as well as a number of other individuals who will have no contact with the project, have not consented, but for whom a small amount of data are recorded to allow a full picture of the proband's extended family to be gathered.

| LabKey table | Description | Primary or secondary | CloudOS tsv filename |
| --- | --- | --- | --- |
| `rare_diseases_family` | describes the families of rare disease probands participating in the 100,000 Genomes Project. It includes the family group type, the status of the family's pre-interpretation clinical review and the settings that were chosen for the interpretation pipeline at the clinical review. |  | `gel_rare_disease_family_100k.tsv` |
| `rare_diseases_pedigree` | describes the Rare Disease participants, linking pedigrees to probands and their family members. |  | `gel_rare_pedigree_100k.tsv` |
| `rare_diseases_pedigree_member` | describes the Rare Disease pedigree members, similar to the data about each individual participant in the `participant` table. It includes some additional data, such as the age of onset of predominant clinical features, data on links to other family members, as well as data collected only for phenotypes. |  | `gel_rare_pedigree_member_100k.tsv` |

## Rare disease bioinformatic analyses

These tables contain data from and information about Genomics England interpretation pipelines.

| LabKey table | Description | Primary or secondary | CloudOS tsv filename |
| --- | --- | --- | --- |
| [`tiering_data`](../tiering/) | describes, for each rare disease participant of the 100,000 Genomes Project who has been through the Genomics England interpretation pipeline, this table contains data describing the variants that are identified as plausibly pathogenic for a participant's phenotype. The tiering process is based on a number of features such as their segregation in the family, frequency in control populations, effect on protein coding, and mode of inheritance. and whether they are in a gene in the virtual gene panel(s) applied to the family. The applied panels can be found in the respective table `panels_applied`. |  | `gel_tiering_data_100k.tsv` |
| `tiered_variants_frequency` | contains, for each pathogenic variant found on the Genomics England rare disease database, information of the variant consequence, as well as annotation results from gnomAD and 1000 genomes. |  | `gel_tiered_variants_frequency_100k.tsv` |
| `exomiser` | contains, for each participant of the Rare Disease programme, the results of the [Exomiser](../exomiser/) variant prioritisation framework. All rare disease cases are now run through the [Exomiser](https://github.com/exomiser/Exomiser) automated variant prioritisation framework as part of the interpretation pipeline. Given a multi-sample VCF file, family pedigree and proband phenotypes encoded by Human Phenotype Ontology (HPO) terms, Exomiser annotates the consequence of variants (based on Ensembl transcripts) and then filters and prioritises them for how likely they are to be causative of the probandâs disease based on: 1) the predicted pathogenicity and allele frequency of the variant in reference databases 2) how closely the patientâs phenotypes match the known phenotypes of diseases and model organisms associated with the gene. [Exomiser was developed](https://europepmc.org/article/MED/26562621) by members of the Monarch initiative: principally Dr. Damian Smedleyâs team at Queen Mary University London and Professor Peter Robinsonâs team at Jackson Laboratory, USA, with previous contributions from staff at CharitÃ©âUniversitÃ¤tsmedizin, Berlin and the Sanger Institute. |  | `gel_exomiser_100k.tsv` |
| `gmc_exit_questionnaire` | contains, for each family with a closed case, information extracted from the [GMC exit questionnaire](../exit_questionnaire/). Data reporting back from the Genomic Medicine Centres, for variants reported to them by Genomics England, to what extent a family's presenting case can be explained by the combined variants reported to them (including any segregation testing performed); confidence in the identification and pathogenicity of each variant; and the clinical validity of each variant or variant pair in general and clinical utility in a specific case (only the most recent update will be shown and only one questionnaire per report). |  | `gel_genomic_medical_centre_exit_questionnaire_100k.tsv` |
| `submitted_diagnostic_discovery` | a summary of variants that have been reported back to the Genomic Laboratory Hubs as potentially causal as a result of analyses that have taken place after the initial standard 100,000 Genomes Project analysis by Genomics England. It combines both findings sourced internally within GEL, and from the research community. The motivation behind curating this table from data Genomics England uses to report to the Genomic Laboratory Hubs (GLHs) is to avoid duplicated effort within our research community (by which a variant that has been reviewed and submitted to a GLH is investigated again by a different member of the research community). |  |  |
| `denovo_cohort_information` | contains cohort information for all participants included in the [de novo variant (DNV) research dataset](../de_novo_data/). Attributes within this table include: participant ID, sex, affection status, family ID, pedigree ID, and the path to each family's multi-sample VCF with flagged DNVs. |  | `gel_denovo_cohort_information_100k.tsv` |
| `denovo_flagged_variants` | contains all variants that pass *base\_filter* for all trios within the DNV dataset. The table does not include variants that fail the *base\_filter* due to size restrictions, but these can be found in the annotated multi-sample VCFs. This table includes all flags from the DNV annotation pipeline for each variant. |  | `gel_denovo_flagged_variants_100k.tsv` |

January 5, 2026
