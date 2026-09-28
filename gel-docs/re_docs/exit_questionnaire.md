---
title: 'Solved cases (rare disease) - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/exit_questionnaire/
scraped_at: 2026-05-04T06:32:05Z
---

# Solved cases (rare disease)

For rare disease cases, an important goal is to solve them, identifying the causal variant for the rare disease.

For NHS GMS, we have the `report_outcome_questionnaire` table in LabKey, which describes solved cases and the identified variants that have been approved by the Genomic Laboratory Hubs (GLHs).

For 100kGP, we have two tables in LabKey: `gmc_exit_questionnaire`, equivalent to the `report_outcome_questionnaire` mentioned above, and `submitted_diagnostic_discovery`, which includes diagnoses that have been submitted to Genomics England by researchers.

## report\_outcome\_questionnaire (GMS) or gmc\_exit\_questionnaire (100kGP)

A questionnaireÂ isÂ filled in by the clinicians at the NHS Genomic Laboratory Hubs (GLH) for each closed case. During the 100,000 Genomes Project this was done at the Genomics Medicine Centres (GMC). The given data inform to what extent a familyâs presented case can be explained by the combined variants reported to the GLH/GMC from Genomics England and the Clinical Interpretation Providers (CIPs). It also includes information on any segregation testing performed, the confidence in the identification and pathogenicity of each variant, and the clinical validity of each variant or variant pair in general and clinical utility in a specific case. One questionnaire is completed per case.Â

The questionnaire is divided intoÂ **family-level**Â andÂ **variant-level**Â questions. For ânegativeâ reports containing no variants, the questionnaire will only present the family level questions.

TheÂ **family-level**Â questions ask whether the combined variants between them explain the genetic basis of the familyâs presenting phenotype(s). Firstly it is asking whether the case can be considered fully or partially solved, and secondly,Â whether any segregation testing in the family has bene performed.

TheÂ **variant-level**Â questions ask for information onÂ each individual reported variant.Â

The fields in the questionnaire are listed below:Â

| Field | Description | Level |
| --- | --- | --- |
| `event_date` | The date when the questionnaire was submitted | Family-level |
| `additional_comments` | Comments regarding report | Family-level |
| `case_solved_family` | Have the results reported here explained the genetic basis of the family's presenting phenotype(s)? | Family-level |
| `segregation_question` | Have you done any segregation testing in non-participating family members? | Family-level |
| `actionability` | Is evidence for this variant/variant pair sufficient to use it for clinical purposes such as prenatal diagnosis or predictive testing? | Variant-level |
| `variant_group` | This value groups variants that together could explain the phenotype according to the mode of inheritance used. (e.g.: compound heterozygous). All the variants in the same report sharing the same value will be considered in the same group (i.e.: reported together). This value is an integer unique in the whole report. These values are only relevant within the same report. | Variant-level |
| `clinical_utility` | Has the clinical team identified any changes to clinical care which could potentially arise as a result of this variant/variant pair? | Variant-level |
| `acmg_classification` | What ACMG pathogenicity score (1-5) did you assign to this variant? | Variant-level |
| `confirmation_decision` | Did you carry out technical confirmation of this variant via an alternative test? | Variant-level |
| `confirmation_outcome` | Did the test confirm that the variant is present? | Variant-level |
| `reporting_question` | Did you include the variant in your report to the clinician? | Variant-level |
| `publications` | PMIDs of supporting scientific publications | Family-level |

The variants, if any, are described in the `genome_build` (GMS) / `assembly` (100kGP) , `chromosome`, `position`, `reference` and `alternate` columns.

You can also look at full details of the report models for [Exit Questionnaires](https://gelreportmodels.genomicsengland.co.uk/html_schemas/org.gel.models.report.avro/5.0.0/ExitQuestionnaire.html#/schema/org.gel.models.report.avro.RareDiseaseExitQuestionnaire).

### FAQs

What is the difference between "yes", "partially", "unknown" and "no" categories within the "Case Solved Family" column?

The reporting of variants is carried out by clinical scientists in NHS clinical labs. These reports are then passed on to clinicians. It is then the clinician's decision whether the variants reported have adequately explained the genetic basis of the family's presenting phenotype(s). They will select one of "yes", "partially", "unknown" or "no" in response to this question. The clinical scientists generating the reports may not have the full clinical picture surrounding a given participant when reporting variants back to the clinician. Therefore, the clinical scientists may report Variants of Unknown Significant (VUS) back to the clinician. Variants in the VUS category can cover a large probability range, and so the decision as to whether these variants explain the genetic basis of the family's presenting phenotype is made by the clinician, and is dependent on other information about the participant (such as the clinical suspicion for the condition, whether there are further investigations that could help to prove/disprove this etc.). As a result, it is possible that responses with 'no', 'unknown' or 'partially' contain variants in the VUS category.

---

What does it mean that "This case was closed by Genomics England on behalf of - GMC as a part of deviation ticket --", and can I work with this data?

In these scenarios the GMC will have reviewed the 100kGP case without closing it. Therefore, it was agreed for the case to be closed by Genomics England on behalf of the GMC and the case will have the additional comment âThis case was closed by Genomics England on behalf of -- GMC as a part of deviation ticket --â. It is fine to work with this data.

---

There are multiple genes listed in the `gene_name` column. How do I determine which is these is relevant to the diagnosis?

All genes that are affected by the variant are listed here. Where there are multiple genes, this indicates that the variant affects all these genes, perhaps due to the variants overlapping.

To identify which of these genes is the most relevant to the diagnosis, there might be information in the `additional_comments` column. Otherwise, check the `tiering_data` table for the variant of interest and the genes that were assessed.

## submitted\_diagnostic\_discovery

If you discover any potential diagnoses, you can report these to us using the [Contact clinical team and/or report potential diagnosis form](../cri/) which is available in [Airlock](../airlock/). These will be sent onto the Genomic Laboratory Hubs for approval, but in the meantime, all submitted diagnoses will be added to the `submitted_diagnostic_discovery` table.

| Field | Description |
| --- | --- |
| `participant_id` | the participant ID of the proband |
| `gene_of_interest` | the gene containing the causal variant, as a gene name |
| `variant_of_interest` | the genomic location and allele change of the causal variant in the form chr:location:ref:alt |
| `genome_build` | The genome build of the variant coordinates |
| `reporting_date` | when the association was reported |
| `notes` | any further relevant information |

> **Note:**
>
> We do not remove any entries from the `submitted_diagnostic_discovery` table when these have been examined by the Genomic Laboratory Hubs, whether they approve the diagnoses or not.

January 5, 2026
