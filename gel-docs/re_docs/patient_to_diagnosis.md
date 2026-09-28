---
title: "I want to find a diagnosis for patients who didn't get one through primary clinical interpretation - Genomics England Research Environment User Guide"
source_url: https://re-docs.genomicsengland.co.uk/patient_to_diagnosis/
scraped_at: 2026-05-04T06:33:09Z
---

# I want to find a diagnosis for patients who didn't get one through primary clinical interpretation

How to use this page

Below you can switch between three categories: *no code*, *pre-run algorithms* and *from scratch*. Please select the version that matches your skills and the scale of the task you want to do.

| Category | Scale | Skills needed | Overview | Audience |
| --- | --- | --- | --- | --- |
| no code | small | basic IT skills | Uses no code tools in the RE | Clinicians and biologists without coding or command line skills |
| pre-run algorithms | small | basic IT skills | uses data generated in-house | Clinicians and biologists without coding or command line skills |
| from scratch | large | command line, coding and common bioinformatics tools | illustrates the steps you might follow using common bioinformatics tools to carry out custom analyses | bioinformaticians/computational biologists doing custom analyses |

The instructions in each section include links to the relevant pages in the documentation. Links are tagged as:

- Tutorials
- Tools - descriptive
- Data - descriptive
- Pre-made workflows
- Reference lists/tables

no codepre-run algorithmsfrom scratch

## Identify participant(s)

You can identify participants of interest using either LabKey or Participant Explorer. These will usually be participants where the case is not listed as solved in the `gmc_exit_questionnaire` (100kGP) or `report_outcome_questionnaire` (GMS), and often participants who are still alive.

- [100kGP clinical and phenotype data](../clinical_data/)
- [Exit questionnaire (rare disease) or Report Outcome Questionnaire](../exit_questionnaire/)
- [Participant Explorer](../pxa/)
- [Search for participants](../pxa_search/)
- [LabKey](../labkey/)

## Filter variants in participant(s)

You can identify variants in your participant of interest in the IVA Case portal.

- [Interactive Variant Analysis (IVA) - catalogue of variants](../iva/)
- [IVA case interpretation, case portal](../iva_case/)

You can filter by mode of inheritance, by variant population frequency, by variant consequences on genes and other factors. You can also filter by gene lists from PanelApp.

- [PanelApp - curated gene lists](../panelapp/)

## Identify participant(s)

You can identify participants of interest using either LabKey or Participant Explorer. These will usually be participants where the case is not listed as solved, and often participants who are still alive.

- [100kGP clinical and phenotype data](../clinical_data/)
- [Exit questionnaire (rare disease)](../exit_questionnaire/)
- [Participant Explorer](../pxa/)
- [Search for participants](../pxa_search/)
- [LabKey](../labkey/)

## View tiered and exomiser variants

We have run tiering analysis and Exomiser on all rare disease participants to identify potentially causal variants.

- [Rare disease tiering](../tiering/)
- [Exomiser](../exomiser/)

## Identify participant(s)

You can identify participants of interest using the LabKey API. These will usually be participants where the case is not listed as solved, and often participants who are still alive. You can create a list of gVCF or BAM filepaths. We also have a tutorial on cohort building to work through:

- [100kGP clinical and phenotype data](../clinical_data/)
- [Exit questionnaire (rare disease)](../exit_questionnaire/)
- [Labkey API](../labkey_api/)
- [Building cohorts](../cohorts/)

## Working with the HPC

Tools such as Exomiser and VEP are available on the HPC and can be incorporated into your own algorithms and pipelines for analysing genomes, or you can write these from scratch.

- [High Performance Cluster (HPC)](../hpc/)
- [Accessing the HPC](../hpc_access/)
- [Using software on the HPC](../hpc_using_software/)
- [How to submit jobs to LSF](../hpc_jobs/)

## Create or import pipelines

You can use any programming languages that are provided on the HPC. We also provide conda environments for working in Python and R libraries.

- [Personal conda environments](../hpc_conda/)
- [Libraries available in R](../r_packages/)

If you have your own pipelines written as containers, you can use Singularity to bring them into the RE.

- [Using containers within the Research Environment](../hpc_containers/)

## Validate variants

You may wish to validate any variants you have identified in IGV. To do this you will need to get the BAM file locations for the participant and their family members, which you can do from the file locations in Participant Explorer. You can upload these files to view in IGV.

- [Integrative Genome Viewer (IGV) - visualise genomic data](../igv/)

You may wish to work with some tools outside of the RE to see what other data has been associated with your variants of interest, such as gnomAD, Decipher, ClinVAR and Varsome.

## Compile text and figures

You can use LO Calc to create figures and tables. You can also write any notes in LO Writer.

- [LibreOffice](../LibreOffice/)

## Export

If you think you have identified potentially diagnostic genetic variants and you would like to report these back to the GMS, or to get in contact with the clinical team to carry out further tests, you can get in contact using a form available through Airlock.

- [Reporting potential diagnoses and contacting clinicians](../cri/)

March 12, 2025
