---
title: 'Aggregrate variant testing workflow - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/avt3/
scraped_at: 2026-05-04T06:34:27Z
---

# Aggregrate variant testing workflow

> **This version is not actively supported:**
>
> The WDL AVT v3.1 continues to be available but is no longer supported. We plan to decommission it by the end of this fiscal year â March 2025.  
> The replacement, [Nextflow AVT v4](../avt/) is available now.

The aggregate variant testing (AVT) workflow looks at genomic regions, genes or variants, and determines the cumulative effects of multiple rare variants, comparing a case and control cohort.

It uses rare small variants in the [Genomics England V2 aggregate (aggV2)](../aggv2/). You need to provide this workflow with a list of genes, a list of genomic loci, a list of whole chromosomes or a list of variants, plus a list of individuals with and without the phenotype you're examining.

## Running the workflow

To run the AVT workflow, you need to run the following steps:

1. Build a case/control cohort
2. Create a phenofile of the cohort
3. Copy the workflow folder
4. Edit the input files
5. Run the workflow on the HPC

### Build a case/control cohort

You can build your cohort by your preferred method. We provide some [tutorials on building cohorts](../cohorts/) using our [Labkey API](../labkey_api/).

> **IMPORTANT NOTE::**
>
> The workflow will run on the cohort specified in the input, as described below. It is your responsibility to ensure that the cohort only includes participants whose data you are allowed to process and analyse. Ensure that you are only using samples included in the latest data release (main programme data release 19 (31st October 2024)). Please ask via [Service desk](https://jiraservicedesk.extge.co.uk/plugins/servlet/desk) if unsure.

### Create a phenofile of the cohort

Example file: `/gel_data_resources/workflows/BRS_tools_aggregateVariantTestingWorkflow/v3.0/examples/cohort.tsv`

The phenotype file is a text file of at least two columns that contain a sample identifier column (REQUIRED), one or more phenotype columns (REQUIRED), and any number of additional covariate columns. These columns **must** have headers as you will use them to specify the columns for the analysis in the `input.json` file.

This example includes the minimal required data (platekey and disease\_A) plus two commonly used covariate columns (age and sex):

```
plate_key   disease_A   age sex
sample1     0           25  0
sample2     0           50  1
sample3     1           33  0
```

## Copy the workflow folder

This version of the workflow can be found on the HPC. Copy the whole folder to your working directory:

```
mkdir my_avt_analysis
cd my_avt_analysis
cp /gel_data_resources/workflows/BRS_tools_aggregateVariantTestingWorkflow/v3.1 .
```

The workflow consists of many files, broadly grouped into the following categories:

- `submit_workflow.sh`: submission script for the HPC
- `master_aggregate_testing.wdl` files: the main workflow file
- `imports/*.wdl`: sub workflow files
- `input/*`: this folder contains example files of the inputs you can use, details of these are below
- `resources/*`: multiple helper files and auxiliary scripts needed by the workflow
- `cromwell.conf`: configuration file for Cromwell
- `options.json`: small set of configurable options, such as the final output folder

## Edit the input files

You will need to create the following:

- The phenotype file
- A genomic input filtering file
- Optional: a genomic variants exclusion file

You will also need to edit the following existing files:

- The input file `inputs.json`
- The submission script `submit_workflow.sh`
- The options file `options.json`
- Optional: the cromwell configuration file `cromwell.conf`

### Phenotype file

As described above

### Genomic filtering input file

You will need to provide one file for genomic filtering. This input file informs the workflow about the variants on which the tests are to be run. There are four possible types of input you can use:

- Chromosomes
- Genes
- Regions
- Variants

> **Note:**
>
> Only one of chromosome, gene, region or variant input file is allowed as input for each run.

Chromosome input fileGenes input fileRegion input fileVariant input file

Example file: `input/chromosomes.txt`

A chromosome input file is a single column text file that lists all the chromosomes that you wish to include for testing. This will run the analysis on all the protein coding genes on the specified chromosomes, which are defined in the Ensembl\_XX\_genes\_coordinates\_CRCh3X.tsv file in the resources directory. However, you can exclude specified genes from the analysis using a Gene exclusion file.

The file is headerless, and the chromosomes codes must match those used in your genomic data (i.e. with or without the chr prefix, note that the Genomics England genomic data includes the chr prefix).

A minimal example for aggV2 looks like:

```
chr16
```

Example file: `input/genes.txt`

A gene input file is a single column text file that lists all the genes that you wish to include for testing. It is headerless, and needs to contain Ensembl gene\_symbols. These genes are defined in the `Ensembl_XX_genes_coordinates_CRCh3X.tsv` file in the resources directory.

A minimal example looks like:

```
PKD1
CKLF
NOMO1
```

Example file: `input/coordinates.bed`

A region input file is a three column BED file that lists all the regions that you want to include for testing. It can be either headed or headerless, and must contain the columns CHR START END. The chromosomes codes must match those used in your genomic data (i.e. with or without the chr prefix, note that the Genomics England genomic data includes the chr prefix). It must be tab separated. If you include a header, it must start with the hash (#) symbol. This option is useful for testing variants that fall into non-coding regions of the genome, e.g. regulatory regions.

A minimal example looks like:

```
#CHROM  START   END
chr1    150000  180000
chr5    22000   27000
chr16   19500   27697
```

Example file: `input/variants.tsv`

A variant input file is a four column file that lists all the variants that you want to include for analysis. It is headerless. If not supplied as an input, this file is generated internally and output at the end of the workflow.

If a variant is included in the input file, but not the genomic data, then the testing will still run, but the specific variant will not be tested. This makes it easy to share the same variant file list between different cohorts.

This option is most useful when you have performed variant filtering previously (either from a previous run of AVT, or from some custom annotation/filtering of your choice) and you wish to use the list of variants again on a new cohort.

> **Note:**
>
> The variants in a group must be ordered in ascending order of position. If this is not the case, both SAIGE-GENE and REGENIE will crash.
>
> If you use a variant input file and but do not want to perform additional VEP filtering, make sure to set both `use_vep_filtering` and `use_ensembl_protein_coding_genes_only` to false. Failure to do so will cause the workflow to crash.

| Column | Description | Example | Mandatory? |
| --- | --- | --- | --- |
| Variant\_ID | The variant ID of the variant that you want to include for testing, expressed as a genomic location with alleles in the format:  `chromosome:location_reference_alternative` The chromosome must be in exactly the same format as in your genomic data (i.e. with or without the chr prefix, note that the Genomics England genomic data includes the chr prefix). | `chr1:50000_A_T` | Mandatory |
| Group\_ID | The Ensembl gene symbol or group name used to group the variants for rare variant testing. | MUC1 | Mandatory |
| Most\_severe\_mask | The strictest mask that the variant passes. This is needed to ensure that REGENIE functions properly. | LoF | Mandatory |
| All\_masks | A comma separated list of all masks that the variant passes. This is needed to ensure that SAIGE-GENE functions properly. | LoF,missense | Mandatory |

A minimal example looks like:

```
chr1:1_A_T  group1  LoF LoF
chr1:2_C_G  group1  LoF LoF,missense
chr1:50_AA_C    MUC1    LoF LoF,missense
chr1:51_T_G MUC1    missense    missense
```

This example will end up with two regions, the first labelled `group1` and the second `MUC1`. The variants that are included in each test depend on the masks used, `group1` has two variants that will be assessed under the LoF mask, and one under the missense mask, while `MUC1` has one variant that will be assessed under the LoF mask and two under the missense mask.

> **Note:**
>
> You can create your own masks and their definitions. Mask strictness is defined here by how many variants pass all the filters that are set for each mask. The fewer variants that pass the filters, the stricter the mask is.
>
> For example, consider two masks, both based on a CADD\_PHRED score threshold. CADD\_PHRED is a scaled score, where variants that have a higher score are more deleterious than those with a lower score. Therefore, a mask that sets a higher CADD\_PHRED score for inclusion is going to be more strict than one that sets a lower score.
>
> strict: CADD\_PHRED >= 20
>
> lenient: CADD\_PHRED >= 10
>
> A variant that has a CADD\_PHRED score of 23 will have a `most_severe_mask` of `strict` and an `all_masks` list of `strict, lenient`.
>
> A variant that has a CADD\_PHRED score of 13 will have a `most_severe_mask` of `lenient` and an `all_masks` list of `lenient`.

The workflow will run on any small variant genomic dataset that is in either BGEN or PGEN format. We recommend using PGEN format over BGEN, as the very first thing the workflow will do is convert BEGEN into PGEN. If you wish to supply your own PGEN input dataset, please make sure that the variant IDs are written in the format `chr:pos_ref_alt`, as this is the input format expected internally by plink. Additionally, functional annotation files are currently expected to be VCF files annotated by VEP. Functionality is undefined (but unlikely to work) if the variants have been annotated by a different annotation tool (the workflow uses bcftools +split-vep internally).

### (Optional) Genomic variants exclusion file

Gene exclusion fileVariant exclusion file

This is a single column, optional file that lists Ensembl gene symbols or gene IDs to be excluded from the analysis. It is headerless.

It is identical in format to the `input/genes.txt` file.

A minimal example looks like:

```
BRCA1
LRRK2
```

Example file: `input/variant_exclusion.txt`

This is a single column, headerless, optional file that lists variant IDs that are to be excluded from the current analysis, expressed as a genomic location with alleles in the format:

```
chromosome:location_reference_alternative
```

The chromosome must be in exactly the same format as in your genomic data (i.e. with or without the chr prefix, note that the Genomics England genomic data includes the chr prefix).

A minimal example for aggV2 looks like:

```
chr1:15000_A_C
chr4_94321_G_T
```

### Inputs JSON file

Example file: `input/inputs.json`

This file specifies which files to run the analysis on. You can customise this file to point to your input files. It also contains options that are needed for proper workflow functionality, which should be left alone.

There is a detailed description of this file, what it contains and what you can (and should) edit [here](../avt_input/).

### The submission script

You can change the submission script in order to point to different `input.json`, `options.json`, `cromwell.conf` and metadata files.

For example:

```
#BSUB -q inter
#BSUB -P bio
#BSUB -o avt_workflow_%J.stdout
#BSUB -e avt_workflow_%J.stderr
#BSUB -cwd .
#BSUB -n 1
#BSUB -R "rusage[mem=10000] span[hosts=1]"
#BSUB -M 20000

module purge
module load bio/cromwell/65

tstamp=$(date | sed 's/[ :]/_/g')

java -Dconfig.file=cromwell.conf \
     -jar $CROMWELL_JAR \
     run workflow.wdl \
     -i cohort_of_interest_input.json \
     -o cohort_of_interest_options.json \
     -m cohort_of_interest_metadata_"$tstamp".json
```

You should change:

- `#BSUB -P bio` to the correct project code (see [LSF Project Codes](../lsf_codes/) to find the project code for your user if you do not know it already)
- `#BSUB -o and #BSUB -e` if you wish to have stdout and stderr go to different files, or a different location.

### The options file

The options file is a small file that defines where you would like the workflow output to be placed, along with various logs.

```
{
    "final_workflow_outputs_dir": "final_output/data",      # Change this, if wanted
    "use_relative_output_paths": true,                      # Leave true
    "final_workflow_log_dir": "final_output/workflow_logs", # Change this, if wanted
    "final_call_logs_dir": "final_output/call_logs",        # Change this, if wanted
    "write_to_cache": true,                                 # Leave true
    "read_from_cache": true                                 # Leave true
}
```

The main output files will be saved in a folder called `final_output/data/` by default.

> **Note:**
>
> The workflow will crash if the final output subfolder already contains files with the same file name. For example, if you **successfully** ran the workflow with certain inputs on day one, you will have the corresponding outputs saved in the folder mentioned just above. If you run the workflow from the same location unchanged on day two, it will crash trying to copy the final data to the output subfolder (`data/` just above). This is done in order to protect your successful outputs from accidental overwriting - this means that after a successful run you should copy any useful outputs somewhere else and remove the output subfolder (by default, `data/` inside `final_output/`) with all its content before re-running the workflow in the same location.

If you have fully completed your analysis on a certain cohort in a given main folder, in order to save disk space, please delete the whole folders `cromwell-workflow-logs` and `cromwell-executions` found inside that main folder. Those folders contain the cached database (useful only if you want to re-run analysis on the same cohort possibly with different conditions), plus redundant data and files that can be useful for debugging when the run fails. Additionally, the content of folders `final_output/call_logs` and `final_output/workflow_logs` can also be deleted safely after a successful run, if not needed.

### The cromwell configuration file

The cromwell configuration file does not need to be edited by you, except for one case.

If you wish to run multiple workflows at the same time, you will need a separate cromwell.conf file for each. This is because the conf file defines the workflow database, and due to the nature of this file based database, multiple workflows pointing to the same one will not work. Therefore, you should make a copy of the cromwell.conf file and name it something unique. Then, change the following line:

```
Original
jdbc:hsqldb:file:cromwell-executions/cromwell-db/cromwell-db;

Changed
jdbc:hsqldb:file:cromwell-executions/cromwell-db/cromwell-db-cohort-of-interest;
Change the final cromwell-db to a unique name, and the workflow will run fine.
```

## Run the workflow on the HPC

To run the workflow, simply submit the submit\_workflow.sh script to LSF. This can be done with the following command:

`bsub < submit_workflow.sh`

### HPC usage

The workflow, typically submitted to the `<inter>` queue of the HPC, consists of various steps which will generate subsequent scripts which are submitted to the HPC in the `<short>` and `<medium>` queues. This may lead up to a few thousand jobs being submitted from your username, but most of these should not run for a very long time (traffic depending).

> **Note:**
>
> Please do not run the workflow from your home directory.

## Output

The output will depend on what tool you choose to run the workflow with. Please check the relevant publications and documentation:

| Tool | Documentation | Publication |
| --- | --- | --- |
| SAIGE-GENE v0.44.6.5 | [GitHub](https://github.com/weizhouUMICH/SAIGE) | [Nature Genetics](https://europepmc.org/article/MED/32424355) |
| REGENIE 2.2.4 | [GitHub](https://github.com/rgcgithub/regenie) | [Nature Genetics](https://europepmc.org/article/MED/34017140) |
| Rvtests v2.1 | [GitHub](https://genome.sph.umich.edu/wiki/Rvtests) | [Nature](https://europepmc.org/article/MED/34375979) |

## How the AVT workflow works

The workflow works by pulling out all the variants in the specified region or gene and their functional annotation. This is compared to the participants in the cohort to filter. Then it uses one or more of the following tools to calculate aggregate variant effects:

| Tool | Publication | Tests implemented | Handles relatedness? | Handles unbalanced cohort sizes? |
| --- | --- | --- | --- | --- |
| [SAIGE-GENE v0.44.6.5](https://github.com/weizhouUMICH/SAIGE) | [Nature Genetics](https://europepmc.org/article/MED/32424355) | SKAT-O, burden and SKAT tests | Yes | Yes |
| [REGENIE 2.2.4](https://github.com/rgcgithub/regenie) | [Nature Genetics](https://europepmc.org/article/MED/34017140) | burden test | Yes | Yes |
| [Rvtests v2.1](https://genome.sph.umich.edu/wiki/Rvtests) | [Nature](https://europepmc.org/article/MED/34375979) | Fisher exact test, following the collapsing method | The Rvtests method does NOT use any covariates, so it is only suitable for unrelated cohorts that share the same ancestral background. | Yes |

More information on the Rvtests collapsing method

In dominant mode, a participant with no qualifying variants in a particular gene is collapsed to 0/0, a single het variant collapses to 0/1, and two or more het variants or one or more hom alt variants collapses to 1/1.

In recessive mode, a participant with no qualifying variants or a single het variant in a particular gene is collapsed to 0/0, and two or more het variants or one or more hom alt variants collapses to 1/1.

The workflow is written in [WDL 1.0](https://github.com/openwdl/wdl/blob/main/versions/1.0/SPEC.md) and is run using the [Cromwell engine](https://cromwell.readthedocs.io/). Internally, the workflow will call upon a number of different tools to execute all the steps in the workflow. These are:

- [bedtools](https://bedtools.readthedocs.io/en/latest/)
- [bcftools](https://samtools.github.io/bcftools/bcftools.html)
- [SAIGE-GENE](https://github.com/weizhouUMICH/SAIGE)
- [plink](https://www.cog-genomics.org/plink/1.9/)
- [plink2](https://www.cog-genomics.org/plink/2.0/)
- custom sections written in [Python 3](https://www.python.org/)
- [regenie](https://github.com/rgcgithub/regenie)
- [rvtests](https://genome.sph.umich.edu/wiki/Rvtests)

The workflow executes all tasks inside docker containers pulled from [quay.io](https://quay.io/). On the Genomics England HPC, these docker containers are run using singularity, converting them to singularity images at runtime.

If you have previously used the VCF version of this pipeline, you may wish to see how these differ:

There are a few drawbacks to the VCF version of this workflow that prompted the development of this new version:

- It takes quite a long time, due to the large input VCF files and creating a GRM on the fly
- It can only run a single chromosome at a time
- It can only run on a single phenotype at a time
- It can only run on a single functional mask, and new masks can only be added with AND logic (e.g. no CADD\_PHRED >=10 OR VEP missense+)

The PGEN version

- Is fast (test runs on cohorts of ~3000 take ~2 hours on the whole genome, for LOFTEE HC variants only)
- Runs on the whole genome at once
- Runs on as many phenotypes as are wanted (and are defined in the phenotype file)
- Runs on as many functional masks as wanted, with a combination of AND and OR logic
- Cleans up the syntax for filtering strings, e.g. "==\"HC\"" is now just "HC"

This does come with some drawbacks, notably

> **Note:**
>
> The input PGEN files for aggV2 have been pre-masked, such that any single genotype that has depth (DP) < 10, genotype quality (GQ) < 20 or fails an allele balance ratio (ABratio) test of p value < 0.001 has had the genotype set to missing (./.).
>
> The PGEN files also only contain biallelic variants, as all multiallelic variants have been removed.

The reason that the files have been pre-masked is that the information required to mask the genotypes is lost during the VCF â PGEN conversion.

We understand that this masking strategy might not be optimal for everyone. Therefore, we are working on a small workflow that will let each user create their own set of PGEN files.

> **Note:**
>
> The PGEN AVT workflow may work on quantitative traits, but has not been tested for this functionality.

### Why PGEN (PLINK2) instead of BED (PLINK1) format?

Plink2 files are vastly smaller than Plink1 files containing the same information. aggV2 in plink1 format is ~14TB, whereas in plink2 format is it ~500GB.

## Examples

An example cohort is provided in the `/gel_data_resources/workflows/BRS_tools_aggregateVariantTestingWorkflow/v3.0/examples` folder, named `cohort.tsv`. The phenotype column in this cohort is `status`. The cohort contains 147 cases and 7452 controls. The controls were NOT matched for age, sex or ancestry, and were just randomly subset from the full aggV2 cohort for Data Release 13.

There are four sets of example files in the `examples` folder, corresponding to the four different modes of running the AVT workflow. Each example shares the same phenotype file `cohort.tsv`.

> **Whole chromosome example files:**
>
> ```
> examples/chr16_example_cromwell.conf
> examples/chr16_example_input.json
> examples/chr16_example_options.json
> examples/chr16_submit_workflow.sh
> ```

> **Genes example files:**
>
> ```
> examples/genes_example_cromwell.conf
> examples/genes_example_input.json
> examples/genes_example_options.json
> examples/genes_submit_workflow.sh
> ```

> **Regions example files:**
>
> ```
> examples/regions_example_cromwell.conf
> examples/regions_example_input.json
> examples/regions_example_options.json
> examples/regions_submit_workflow.sh
> ```

> **Variants example files:**
>
> ```
> examples/variants_example_cromwell.conf
> examples/variants_example_input.json
> examples/variants_example_options.json
> examples/variants_submit_workflow.sh
> ```

In the `/gel_data_resources/workflows/BRS_tools_aggregateVariantTestingWorkflow/v3.0/examples/data` folder, there is example output for the four different types of input, for both SAIGE-GENE and REGENIE.

## Troubleshooting and further help

Sometimes, things just don't work as expected. If that happens, please feel free to contact us via [service desk](https://jiraservicedesk.extge.co.uk/servicedesk/customer/portals).

However, issues with the workflow can often be diagnosed by examining the `stdout` and `stderr` files that the workflow generates during its run. There are two types of `stdout` and `stderr` files generated.

1. Those generated by the main submission script. With these files, the `stderr` is useless, if an error occurs the only entry in the stderr will be `Transitioned to state Failed`. You need to look through the `stdout` to identify the task that encountered the error.
2. Those generated by each task in the workflow. These can be found in sub-directories of the `cromwell-executions` folder. They will contain the error that occurred in the workflow run, and generally offer clues as to what needs to be changed, or how it can be fixed.

February 13, 2025
