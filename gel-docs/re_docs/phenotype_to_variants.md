---
title: "I'm interested in a phenotype and I want to know what variants are related - Genomics England Research Environment User Guide"
source_url: https://re-docs.genomicsengland.co.uk/phenotype_to_variants/
scraped_at: 2026-05-04T06:33:10Z
---

# I'm interested in a phenotype and I want to know what variants are related

How to use this page

Below you can switch between three categories: *no code*, *existing tools* and *from scratch*. Please select the version that matches your skills and the scale of the task you want to do.

| Category | Scale | Skills needed | Overview | Audience |
| --- | --- | --- | --- | --- |
| no code | small | basic IT skills | Uses no code tools in the RE | Clinicians and biologists without coding or command line skills |
| existing tools | large | command line and limited coding | uses pipelines generated in-house to carry out standardised analyses | bioinformaticians/computational biologists doing standard analyses |
| from scratch | large | command line, coding and common bioinformatics tools | illustrates the steps you might follow using common bioinformatics tools to carry out custom analyses | bioinformaticians/computational biologists doing custom analyses |

The instructions in each section include links to the relevant pages in the documentation. Links are tagged as:

- Tutorials
- Tools - descriptive
- Data - descriptive
- Pre-made workflows
- Reference lists/tables

no codeexisting toolsfrom scratch

## Find participants with a phenotype

To search for phenotypes our participants were recruited for or phenotypes that can be identified from participants' medical records, you can use Participant Explorer or LabKey:

- [Participant Explorer](../pxa/)
- [Search for participants with Participant Explorer](../pxa_search/)
- [Building cohorts with Participant Explorer](../pxa_cohorts/)
- [LabKey](../labkey/)

The IVA variant browser also allows you to search for variants by various filters, including HPO terms. This will give you all the variants found in participants who have a particular phenotype, not all variants found to be causal for a phenotype. Note that we only have HPO terms for rare disease participants, and that these are only those phenotypes identified on recruitment. Look at:

- [Interactive Variant Analysis (IVA)](../iva/)
- [IVA variant browser](../iva_variant/)

Once you've familiarised yourself with the tools, you can use this to create a cohort of participants with your phenotype of interest and filter variants.

You can compile together the data you've found in a text editor, but if you prefer a word processor or spreadsheet, we have LibreOffice available:

- [LibreOffice](../LibreOffice/)

You may be able to perform some statistical analysis on your data and identify correlations using LO Calc, however, some analysis may require the use of coding on the HPC. Please take a look at the other sections for help with this.

## Working with the HPC

You will need to work on the HPC for any large-scale analyses. You can learn more about the HPC and how to access it:

- [High Performance Cluster (HPC)](../hpc/)
- [Accessing the HPC](../hpc_access/)

There are folders on the HPC for your academic or industry Research Network domain. You should use your relevant folder as your working directory. These are also accessible from the desktop:

- [Home directory contents](../home_directory/)

## GWAS workflow

The prebuilt GWAS workflow allows you to carry out a GWAS analysis. The documentation includes an example that you can run to try out the pipeline yourself:

- [GWAS pipeline](../gwas/)

To work with the GWAS pipeline, you will need to build a cohort, which you can do using LabKey. You will need to make yourself familiar with the clinical data we have available and the LabKey API which you will use to access it. We also have a tutorial on cohort building to work through:

- [100kGP clinical and phenotype data](../clinical_data/)
- [Labkey API](../labkey_api/)
- [Building cohorts](../cohorts/)

Now you can create a cohort for your phenotype(s) of interest. These can be as complex as you need them to be, including sub-categories of phenotypes and modifiers.

We provide support for coding in Python or R in the RE. You can use interactive coding tools such as RStudio and Jupyter notebooks, which you can use on the HPC:

- [Jupyter Lab on the HPC](../hpc_jupyter/)
- [Using Rstudio on the HPC](../enable_rstudio/)

Use this cohort to run the GWAS pipeline. This will provide you with summary statistics and manhattan plots. You can further analyse these data using Python or R, or with LibreOffice Calc.

## Find VCFs

If you prefer to work with the VCF files directly, you can find out information about our gVCFs and aggregate VCFs:

- [Genomic data](../genomic_data/)
- [Aggregated variant calls](../aggv2/)

You can find out more about the file structure where these are located and your own working directories here:

- [Home directory contents](../home_directory/)

## Use tools on the HPC

You will find tools like BCFtools installed in the HPC, which you can use for exploring the VCFs.

- [High Performance Cluster (HPC)](../hpc/)
- [Accessing the HPC](../hpc_access/)
- [Using software on the HPC](../hpc_using_software/)
- [How to submit jobs to LSF](../hpc_jobs/)

## Filter for consented samples

To ensure you are working only with consented samples, you may need to carry out some filtering steps on your VCFs. There are details of how to do this with the aggregated VCFs.

- [AggV2 code book](../aggv2_code_book/)

If you are working with the gVCFs, you will need to use LabKey and the current data version to filter.

- [100kGP clinical and phenotype data](../clinical_data/)
- [Labkey API](../labkey_api/)

## Phenotypes associated with participants

You can also use LabKey to map participants to phenotypes, including HPO terms associated with rare disease, ICD10 codes in medical history and the disease participants were recruited for. We have tutorials on using the LabKey API to build cohorts based on phenotypes and fetching medical history for participants:

- [Building cancer cohorts programmatically](../cancer_cohorts/)
- [Building rare disease cohorts programmatically](../rd_cohorts/)
- [Accessing medical history data programmatically](../medhist_api/)

## Create or import pipelines

You can analyse and combine these data in any way you choose, using any programming languages that are provided on the HPC. We also provide conda environments for working in Python and R libraries.

- [Using software on the HPC](../hpc_using_software/)
- [Personal conda environments](../hpc_conda/)
- [Libraries available in R](../r_packages/)

If you have your own pipelines written as containers, you can use Singularity to bring them into the RE.

- [Using containers within the Research Environment](../hpc_containers/)

## Compile text and figures

You can use LO Calc to create figures and tables. You can also write any notes in LO Writer.

- [LibreOffice](../LibreOffice/)

## Export

The only way to get the results of your analysis out is using Airlock. You should include any notes you may have made by hand. It is **your** responsibility to ensure your data conforms to the Airlock rules and does not contain any identifying data.

- [Airlock](../airlock/)
- [Using the Airlock](../airlock_tool/)
- [What you can and can't export](../airlock_rules/)

November 6, 2024
