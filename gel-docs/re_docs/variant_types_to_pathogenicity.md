---
title: 'I want to know more about pathogenicity of different variant types on a large scale - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/variant_types_to_pathogenicity/
scraped_at: 2026-05-04T06:34:12Z
---

# I want to know more about pathogenicity of different variant types on a large scale

The instructions in each section include links to the relevant pages in the documentation. Links are tagged as:

- Tutorials
- Tools - descriptive
- Data - descriptive
- Pre-made workflows
- Reference lists/tables

## Create cohort

You can use LabKey or Participant Explorer to create a cohort of interest. You will need to make yourself familiar with the clinical data we have available and the LabKey API which you will use to access it. You can use both of these to create a list of gVCF or BAM filepaths. We also have a tutorial on cohort building to work through:

- [100kGP clinical and phenotype data](../clinical_data/)
- [Participant Explorer](../pxa/)
- [Search for participants](../pxa_search/)
- [Labkey API](../labkey_api/)
- [Building cohorts](../cohorts/)

From either of these, you can create a list of filepaths to the gVCFs or BAM files for each participant:

- [Genomic data](../genomic_data/)

## Work with the HPC

You can use the gVCF files directly, or you can call the variants yourself from the BAM files, using some of the tools installed on the HPC. You can learn more about the HPC and how to work with it:

- [High Performance Cluster (HPC)](../hpc/)
- [Accessing the HPC](../hpc_access/)
- [Using software on the HPC](../hpc_using_software/)
- [How to submit jobs to LSF](../hpc_jobs/)

There are folders on the HPC for your GECIP domain or Discovery forum. You should use your relevant folder as your working directory. These are also accessible from the desktop:

- [Home directory contents](../home_directory/)

## Functional annotation

For functional annotation of VCFs, you can use the VEP:

- [Variant Effect Predictor (VEP)](../vep/)

If you have other functional annotation software you wish to use, you can bring this in using containers.

- [Using containers within the Research Environment](../hpc_containers/)

Alternatively, functionality annotated versions of our aggreagate VCFs are available. Code-books are available with examples of how to query them:

- [Functional annotation of germline aggregated variant calls](../functional_annotation/)
- [AggV2 code book functional annotation queries](../aggv2_functional_annotation_queries/)
- [Somatic aggregated variant calls](../somAgg/)

You can now filter the VCFs to find variant types of interest using your preferred programming language. We provide support for coding in Python or R in the RE. You can use interactive coding tools such as RStudio and Jupyter notebooks, which you can use on the HPC:

- [Jupyter Lab on the HPC](../hpc_jupyter/)
- [Using Rstudio on the HPC](../enable_rstudio/)

## Combine with publicly available data

A number of publicly datasets have been made available in the RE, such as gnomAD and ClinVar. You can include these in your analyses.

- [Publicly available data](../public_data/)

## Compile text and figures

Use your preferred programming language and statistical tools to compare, correlate, verify and model your results. You can use LO Calc to create figures and tables. You can also write any notes in LO Writer.

- [LibreOffice](../LibreOffice/)

## Export

The only way to get the results of your analysis out is using Airlock. You should include any notes you may have made by hand. It is **your** responsibility to ensure your data conforms to the Airlock rules and does not contain any identifying data.

- [Airlock](../airlock/)
- [Using the Airlock](../airlock_tool/)
- [What you can and can't export](../airlock_rules/)

March 12, 2025
