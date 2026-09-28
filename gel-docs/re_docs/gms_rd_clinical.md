---
title: 'Rare disease-specific NHS GMS clinical data - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/gms_rd_clinical/
scraped_at: 2026-05-04T06:32:19Z
---

# Rare disease-specific NHS GMS clinical data

Some tables in LabKey contain data specific to rare disease participants. All tables and their fields are described in our [data dictionary](../GMS_data_dictionary/).

> **Primary and secondary data tables:**
>
> Primary clinical data were collected when participants were enrolled in the programme.
>
> Secondary clinical data were obtained from third parties such as NHSE.

| Name of Table/Data view | Description | Primary or secondary |
| --- | --- | --- |
| `condition` | Information about OMIM or orphanet rare conditions suspected by the clinician, including whether the condition is suspected or confirmed. This is optional information captured during recruitment so it may not be available for all participants. |  |
| `observation` | Information about the phenotypes, described as HPO terms, observed in a patient. |  |
| `observation_component` | Further data associated with an observation in the NHS GMS. |  |
| [`report_outcome_questionnaire`](../exit_questionnaire/) | Data reporting back from the Genomic Laboratory Hubs, for variants reported to them by Genomics England, to what extent a familyâs presenting case can be explained by the combined variants reported to them (including any segregation testing performed); confidence in the identification and pathogenicity of each variant; and the clinical validity of each variant or variant pair in general and clinical utility in a specific case (only the most recent update will be shown and only one questionnaire per report). |  |
| `panels_applied` | For each participant enrolled in the NHS Genomic Medicine Service (GMS), this table contains the [name and version of the panel(s)](../panelapp/) that was applied to their genome. |  |
| `tiered_variants_frequency` | This table contains the frequencies of each tiered variant for every Project participant for whom we provide tiered variants. |  |
| `tiering_data` | For each participant enrolled in the NHS GMS who has been through the Genomics England [interpretation pipeline](../tiering/), this table contains data describing the variants that are identified as plausibly pathogenic for a participant's phenotype. The tiering process is based on a number of variant features such as their segregation in the family, frequency in control populations, effect on protein coding, and mode of inheritance. and whether they are in a gene in the virtual gene panel(s) applied to the family. The applied panels can be found in the respective table `panels_applied`. |  |
| `exomiser` | This table contains the full results from the [Exomiser](../exomiser/) rare disease SNV and Indel Prioritisation Process. All rare disease cases are now run through the Exomiser automated variant prioritisation framework as part of the interpretation pipeline. Given a multi-sample VCF file, family pedigree and proband phenotypes encoded by Human Phenotype Ontology(HPO) terms, Exomiser annotates the consequence of variants (based on Ensembl transcripts) and then filters and prioritises them for how likely they are to be causative of the probandâs disease based on: 1) the predicted pathogenicity and allele frequency of the variant in reference databases 2) how closely the patientâs phenotypes match the known phenotypes of diseases and model organisms associated with the gene. Exomiser was developed by members of the Monarch initiative: principally Dr. Damian Smedleyâs team at Queen Mary University London and Professor Peter Robinsonâs team at Jackson Laboratory, USA, with previous contributions from staff at CharitÃ© âUniversitÃ¤tsmedizin, Berlin and the Sanger Institute. References: Publication: <https://www.nature.com/articles/nprot.2015.124> Website: <https://github.com/exomiser/Exomiser> |  |

October 24, 2024
