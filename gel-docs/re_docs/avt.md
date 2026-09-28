---
title: 'Aggregate Variant Testing (AVT) workflow - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/avt/
scraped_at: 2026-05-04T06:34:24Z
---

# Aggregate Variant Testing (AVT) workflow

[pipeline version: v4.2.0](../avt_changelog/)

> **Info:**
>
> AVT v4 is currently only available on our [HPC system (Double Helix)](../hpc/) and is not available in [CloudOS](../cloudos/). You can use [version 3](../avt3/) on [CloudOS](https://lifebit.atlassian.net/wiki/spaces/CD/pages/813040367/Advanced+Analytics).

The **Aggregate Variant Testing (AVT)** workflow allows you to run rare variant association tests on Genomics England data. It compares a case and control cohort to determine the cumulative effects of multiple rare variants within genomic regions defined by coordinates, variants, genes, or chromosomes.

As of v4.2.0, the analysis is run on three "branches" (one for each of the programs mentioned below), which can be enabled or disabled independently for each run using input parameters.

The workflow works by pulling out all the variants in the specified region or gene and their functional annotation, and tailoring that to the input cohorts of participants. The workflow then uses one or more of the following three third-party tools (see the [Output](../avt_output_files/#association-output-files) section for links to their documentation) to calculate aggregate variant effects:

| Tool | Publication | Tests implemented | Handles relatedness? | Handles unbalanced cohort sizes? |
| --- | --- | --- | --- | --- |
| SAIGE-GENE | [Nature Genetics](https://europepmc.org/article/MED/32424355) | SKAT-O, burden and SKAT tests | Yes | Yes |
| regenie | [Nature Genetics](https://europepmc.org/article/MED/34017140) | burden test | Yes | Yes |
| Rvtests | This is implemented following the method described in [this Nature paper](https://europepmc.org/article/MED/34375979), so not all the functionality of Rvtests is available - in particular, this implementation of Rvtests "collapses" all variants for each gene, and does not use covariates. | Fisher exact test, following the variant collapsing method | This method does NOT use any covariates, so it is only suitable for unrelated cohorts that share the same ancestral background. | Yes |

> **SAIGE-GENE:**
>
> The mixed model regression employed by SAIGE may require at least 50 cases to converge. Using this method with too few cases can return results with significant noise and limited power ([Verma et al](https://europepmc.org/article/MED/29618318)).

Rvtests variant collapsing method

In dominant mode, a participant with no qualifying variants in a particular gene is collapsed to 0/0, a single het variant collapses to 0/1, and two or more het variants or one or more hom alt variants collapses to 1/1.

In recessive mode, a participant with no qualifying variants or a single het variant in a particular gene is collapsed to 0/0, and two or more het variants or one or more hom alt variants collapses to 1/1.

## Usage

1. Copy the LSF submission script `/gel_data_resources/workflows/rdp_aggregate_variant_testing/v4.2.0/submit.sh` to your own folder.
2. Create your [input files](../avt_input_files/).
3. Update your submission script.

   - Update your [LSF project code](../lsf_codes/).
   - Set your working directory (ideally within `/re_scratch`).
   - Set [parameters](../avt_parameters/), such as AVT options and your input files.
   submit.sh

   ```
   #!/bin/bash

   #BSUB -P <project_code>
   #BSUB -q inter
   #BSUB -R rusage[mem=10000]
   #BSUB -M 12000
   #BSUB -J avt
   #BSUB -o logs/%J_avt.stdout
   #BSUB -e logs/%J_avt.stderr

   module purge
   module load singularity/4.1.1 nextflow/23.10

   LSF_JOB_ID=${LSB_JOBID:-default}
   export NXF_LOG_FILE="logs/${LSF_JOB_ID}_avt.log"

   SINGULARITY_TMPDIR=/re_scratch/$USER
   export SINGULARITY_TMPDIR

   avt="/gel_data_resources/workflows/rdp_aggregate_variant_testing/v4.2.0"

   nextflow run "${avt}"/main.nf \
       --project_code "<project_code>" \
       --outdir results \
       --output_file_name_suffix "avt_output" \
       --run_saige_gene true \
       --run_regenie true \
       --run_fishers_test true \
       -work-dir "/re_scratch/$USER" \
       -profile cluster \
       -ansi-log false \
       -resume
   ```
4. Run the workflow.

   ```
   bsub < submit.sh
   ```

> **Default parameters:**
>
> Default parameters will run the workflow on an example cohort of 147 cases and 7452 controls (the controls were NOT matched for age, sex or ancestry, and were just randomly subset from the full aggV2 cohort for Data Release 13), on chromosomes 21 and 22 only. Any arguments added to the submission script will overwrite the defaults.

Refer to [Output](../avt_output_files/) for references for the third-party programs run by the workflow, useful to interpret the output files.

## Design

The workflow is written in [Nextflow DSL2](https://www.nextflow.io/docs/latest/index.html) and includes the following steps (with corresponding Nextflow `MODULE`).

**pre-processing**

- Make sure input files are valid (`VALIDATE_INPUT_FILES`)
- Filter inputs according to user's criteria (`INPUT_FILTERING`)
- Prepare user input cohort file (`NORMALISE_COHORT_FILE`)
- Perform the first round of filtering on the genomic data (`COHORT_FREQUENCY_REGION_TYPE_FILTERING`)
- Remove samples present in the cohort files but not in the genomic data (`FILTER_SAMPLES_IN_COHORT_FILE`)
- Extract the list of masks from the variant list (`CREATE_MASK_LIST`)

**optional annotation filtering**

- Extract headers for functional annotation fields (`GET_ANNOTATION_HEADERS`)
- Get the functional annotations for each variant (`EXTRACT_VARIANTS_WITH_ANNOTATIONS`)
- Filter the extracted annotations based on the user's variant mask(s) (`FILTER_VARIANTS_ON_ANNOTATIONS`)
- Aggregate filtered variants into a whole genome file (`AGGREGATE_FILTERED_VARIANTS`)
- Filter the genomic data based on variant annotations as specified by the user (`ANNOTATION_FILTERING`)

**genomic data filtering**

- Convert plink2 PGEN format files to plink1 BED format (`CONVERT_PGEN_TO_BED`)
- Identify differentially missing sites per binary phenotype in the filtered genomic data (`TEST_GENOMIC_DATA_FOR_DIFFERENTIAL_MISSINGNESS`)
- Aggregate differentially missing sites for genomic data (`AGG_DIFF_MISSING_GD`)
- Filter the genomic data to remove any variants that are identified as being differentially missing between cases and controls(`FILTER_GENOMIC_DATA_FOR_DIFFERENTIAL_MISSINGNESS`)
- Convert plink2 PGEN format files to BGEN format (`CONVERT_PGEN_TO_BGEN`)
- Create BGEN index files for a BGEN fileset (`INDEX_BGEN_FILES`)

**grm filtering**

- Filter pre-computed GRM files to include only samples in user cohort (`FILTER_GRM_FILES_TO_COHORT`)
- Test pre-computed GRM files for differential missingness for each binary phenotype (`TEST_GRM_FOR_DIFFERENTIAL_MISSINGNESS`)
- Aggregate GRM differentially missing sites (`AGG_DIFF_MISSING_GRM`)
- Filter the GRM files to remove variants that are differentially missing in any phenotype (`FILTER_GRM_FOR_DIFFERENTIAL_MISSINGNESS`)

**association testing**

- Create the group files used by SAIGE-GENE and REGENIE for testing (`CREATE_GROUP_FILES`)

*regenie*

- Filter the pre-selected HQ SNP variants to common variants for REGENIE GRM (`REGENIE_FILTER_GRM_FILES`)
- Run step 1 of REGENIE (`REGENIE_STEP_1`)
- Run step 2 of REGENIE (`REGENIE_STEP_2`)
- Aggregate REGENIE association summary statistics (`REGENIE_AGGREGATE_SUMMARY_STATISTICS`)

*SAIGE-GENE*

- Subset GRM files to contain variants of MAC 10 or greater (`SAIGE_SUBSET_FILES_FOR_SPARSE_GRM`)
- Create the sparse GRM used in SAIGE-GENE (`SAIGE_CREATE_SPARSE_GRM`)
- Fit the null GLMM with SAIGE-GENE (`SAIGE_FIT_NULLGLMM`)
- Run the SKAT-O, SKAT and burden tests with SAIGE-GENE (`SAIGE_RUN_SPA_TESTS`)
- Aggregate SAIGE-GENE association summary statistics (`SAIGE_AGGREGATE_SUMMARY_STATISTICS`)

*Fisher's test (using Rvtests)*

- Extract the variant information in the PGEN files into a matrix for collapsing (`EXTRACT_VARIANTS_FOR_COLLAPSING`)
- Create a pseudo VCF file from the variant matrix (`CREATE_PER_CHROMOSOME_PSEUDO_VCF`)
- Merge the per-chromosome VCF files used in the Fisher's test branch of the workflow (`CREATE_WHOLE_GENOME_PSEUDO_VCF`)
- Run Fisher's exact test on the pseudo VCF file with Rvtests (`RUN_FISHERS_TEST_USING_RVTESTS`)

April 3, 2025
