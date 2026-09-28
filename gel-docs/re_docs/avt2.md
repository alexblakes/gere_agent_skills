---
title: 'The Aggregrate Variant Testing workflow - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/avt2/
scraped_at: 2026-05-04T06:34:26Z
---

# The Aggregrate Variant Testing workflow

## Licensing

This workflow has been released under the MIT license.

Users of this workflow should note that the output will be subject to review by the Airlock committee. You will need to ensure that they are familiar with [Airlock procedures](../airlock/) and review the data that is submitted for export to ensure that it complies with the procedures and expectations stated in the user guide.

## Brief overview

The Aggregate Variant Testing (AVT) workflow runs aggregate variant tests on rare small variants in the Genomics England V2 aggregate (aggV2). In this release of the AVT workflow, the tests are run using [SAIGE-GENE v0.42.1](https://github.com/weizhouUMICH/SAIGE). The aforementioned SAIGE-GENE implementation performs SKAT-O, SKAT and Burden tests.

This version of the workflow can be found in the following directory:

`/gel_data_resources/workflows/BRS_tools_aggregateVariantTestingWorkflow/v2.3.1/`

> **IMPORTANT NOTE:**
>
> The workflow will run on the cohort specified in the input, as described below. Please remember that is the your responsibility to ensure that the cohort only includes participants whose data the user is allowed to process and analyse. The list of allowed participants will vary depending on the consenting status for each participant, exactly as elsewhere in the Research Environment - users should ask via Service Desk if unsure. Finally, please note that in some cases, the list of allowed participants may also vary depending on your level of clearance.

## Description

The workflow performs aggregate variant testing on rare variants using SAIGE-GENE implementations of the SKAT-O, SKAT and Burden tests. The SAIGE-GENE approach is described in [this bioRxiv pre-print](https://www.biorxiv.org/content/10.1101/583278v2.full.pdf). It should be capable of handling relatedness in the cohort, as well as unbalanced cohorts in terms of case-control sizes. The workflow is written in [WDL 1.0](https://github.com/openwdl/wdl/blob/main/versions/1.0/SPEC.md) and is run using the [Cromwell engine](https://cromwell.readthedocs.io/). Internally, the workflow will call upon a number of different tools to execute all steps of the workflow. These are:

- [bedtools](https://bedtools.readthedocs.io/en/latest/)
- [bcftools](https://samtools.github.io/bcftools/bcftools.html)
- [singularity](https://sylabs.io/docs/)
- [SAIGE-GENE](https://github.com/weizhouUMICH/SAIGE)
- [plink](https://www.cog-genomics.org/plink/1.9/)
- [plink2](https://www.cog-genomics.org/plink/2.0/)
- custom sections written in [Python 3](https://www.python.org/).

Briefly, the workflow, usually submitted to the  queue of the HPC, consists of various steps which will generate subsequent scripts which are submitted to the HPC in the  and  queues. This may lead up to a few thousand jobs being submitted from your username, but most of these should not run for a very long time (traffic depending) - however, please note that one full end-to-end run of this workflow may end up taking a few days in its current form for full aggV2 input, and several hours for protein-coding aggV2 input (see "Instructions - Overview" below to learn about these two options).

The main output files will be saved in a folder called `final_output/data/` by default.

- The workflow will crash if the same the final output subfolder already contains files with the same file name. For example, if you **successfully** ran the workflow with certain inputs on day 1, you will have the corresponding outputs saved in the folder mentioned just above. If you run the workflow from the same location unchanged on day 2, it will crash trying to copy the final data to the output subfolder (`data/` just above). This is done in order to protect your successful outputs from accidental overwriting - this means that after a successful run you should copy any useful outputs somewhere else and remove the output subfolder (by default, `data/` inside `final_output/`) with all its content before re-running the workflow in the same location.
- If you have fully completed your analysis on a certain cohort in a given main folder, in order to save disk space, please delete the whole folders `cromwell-workflow-logs` and `cromwell-executions` found inside that main folder. Those folders contain the cached database (useful only if you want to re-run analysis on the same cohort possibly with different conditions), plus redundant data and files that can be useful for debugging when the run fails. Additionally, the content of folders `final_output/call_logs` and `final_output/workflow_logs` can also be deleted safely after a successful run, if not needed.

> **NOTE:**
>
> This version of the AVT workflow can only be run on one chromosome at a time.
>
> If you wish to run tests on several chromosomes, please submit them separately either in parallel (each from a different folder) or serially (in this case, the same main folder can be used, but see the warning above about removing the output subfolder every time) - please remember that no more than one job should run for each folder/database at any given time.
>
> This can be easily achieved by making use of the `input_user_data/chromosomes.txt` file, which will subset any other input to the chromosome mentioned in that file.
>
> Finally, note that if you want to run several chromosomes and you do not have a GRM for your cohort yet, and you want to produce one as part of running the workflow, the plink files for the GRM (whose production can be a time-consuming step) can be produced the first time you run the workflow for the first chromosome, and then simply re-used as an input for all other chromosomes (see "Instructions - Setting up" below), which will save a lot of compute time.

## Workflow files

The workflow files are located inside:

`/gel_data_resources/workflows/BRS_tools_aggregateVariantTestingWorkflow/v2.3.1/`

The workflow consists of many files, broadly grouped into the following categories:

- `submit_workflow.sh` (submission script for the HPC)
- `.wdl` files (the main workflow, split into different parts)
- `input_user_data/*` (example chromosomes, genes, regions, phenotype files, to be amended by the users to create their own input files)
- `input_variables/*.json` (all the default and user configurable settings for the workflow)
- `resources/*` (multiple helper files and auxiliary scripts needed by the workflow)
- `cromwell.conf` (configuration file for Cromwell)
- `options.json` (small set of user configurable options, such as the final output folder. ## Instructions

### Overview

The AVT workflow will work on any variant genomic dataset that is formatted like [aggV2](../aggv2/). In most cases, it should be used on one of these two datasets:

- "aggV2", our main aggregate dataset (genes on chr1-22 or chrX can be tested)
- "aggV2\_PASS\_UTRplus\_proteincodinggenes", a dataset obtained from aggV2 which only contains PASS variants, with Ensembl Consequence severity equal to 5\_prime\_UTR\_variant or more severe, found in Ensembl 98 genes labelled "protein\_coding" (genes on chr1-22 or chrX can be tested. The choice is made by setting variable "input\_variants\_dataset" in the input variables file (see below: "What do I need to change to run the workflow?"). Note that currently, the selected dataset will be used both for extracting variants of interest for the analysis, and for extracting the rare variants needed for the creation of the GRM for SAIGE-GENE.

The workflow will then run per-gene tests, or per-region tests. Please see the next section, "Setting up", to learn more on how to specify the list of input genes or regions of interest.

### Setting up

1. Copy the workflow folder into your shared working directory (/re\_gecip/ *or /discovery\_forum/*), as you will not have write access to where it is stored on the filesystem.

   Also, please note that the workflow will not run correctly if you try to run it from your home folder.
2. Create a phenotype file for your cohort of interest. It has a few mandatory columns - please note that some of the formatting can be customised using the "input variables" file (see below: "What do I need to change to run the workflow?").

   Mandatory colums are:

   - IID - containing IDs as platekeys
   - A column of binary phenotypes, with value "0" for controls and "1" for cases
     - Note - this version of the workflow has been tested only for binary phenotypes, quantitative traits are not supported
   - Additional columns for covariates to be used in the model, such as age, sex, and principal components; these need to be specified as a comma separated list (variable `part_4_testing.phenotype_covariate_column_names` in the "input variables" file.
3. Decide the regions that you want to test. The workflow can accommodate any of the following:

   1. A whole chromosome (i.e. all genes on that chromosome)
   2. A list of genes
   3. A list of arbitrary genomic regions, specified by coordinates
   4. A list of variant "groups", i.e. individual variants grouped using arbitrary group identifiers

   In brief, example files for all of those are provided within the workflow directory (inside folder `input_user_data/` - files `chromosomes.txt`, `genes.txt`, `coordinates.bed`, and `groups.tsv`). For more detail, please read on.

   In our uses, a GRCh38 gene is defined by Ensembl release 98 - that is the Ensembl release that was used to [annotate aggV2](../functional_annotation/). We currently do not have an aggregate dataset for GRCh37 data, but the workflow can support use on GRCh37 data, in which case genes are defined according to Ensembl 37 release 87.

   Moreover, you can choose to add a fixed upstream/downstream region to all genes, no longer than 100kbp (variable `part_1_inputs.upstream_downstream_length` in the "input variables" file).

   In this version of the workflow, genes are processed as a whole, and all Ensembl transcripts found in the release mentioned above are processed for each gene. In particular, when looking at the Ensembl Consequence of a variant for each gene, only the "worst" transcript Consequence will be processed for that gene.

   If you input a chromosome and no other information (see below: "What do I need to change to run the workflow?"), the workflow will run on the list of **protein-coding** genes found in the Ensembl release mentioned above.

   if you input a list of genes, these will be screened against all genes (i.e. not only the protein-coding ones) found in the Ensembl release mentioned above - only valid Ensembl genes will be processed. Genes can be specified either with their approved HGNC gene symbol, or with their Ensembl gene ID. Please note that, if you use the smaller variant dataset ("aggV2\_PASS\_UTRplus\_proteincodinggenes"), you will not be able to specify protein-coding genes, as the others are not included in that dataset.

   Alternatively, you can choose to input your own list of genomic regions as coordinates. This needs to be specified as a valid BED file. Please note the [BED format is 0-based, half-closed](http://genome.ucsc.edu/FAQ/FAQformat#format1). Each line in the file, i.e. each coordinate block, will be tested separately.

   Finally, you can provide your own choice of variants instead. To do so, please provide a "groups" file instead - this is a TSV file that follows the [format guidelines of SAIGE-GENE's "Group file" input](https://github.com/weizhouUMICH/SAIGE/wiki/Genetic-association-tests-using-SAIGE#input-files-3). In such files, each line represents a group of variants, so the first field in the line is an identifier for the group, followed by TAB and then a TAB-separated list of the variants in that group, formatted as `CHR:POS_REF/ALT` . Please note that in this case you can still choose to filter your inputs, except that you cannot choose to filter it according to VEP annotations as your group identifiers can be arbitrary (see just below, point 4).

   **In summary**, you can choose to specify one of these:

   - your list of genes, one per line
   - your list of genomic regions, specified by coordinates, in a BED file
   - your list of variant "groups", in a SAIGE-GENE input format
   - one of the above lists, in combination with a chromosome file - this will subset your list to the chromosome indicated in the chromosome file
   - a chromosome file only and nothing else - this will be converted into the list of Ensembl protein-coding genes for that chromosome
4. Decide how to filter your inputs.

   Variants extracted according to your input can be filtered using the workflow. Available filters can be both toggled and customised using the "input variables" file. They include site-wide QC filtering, site-wide VEP functional annotation filtering, individual genotype masking: please see the section about the "input variables" file.

   Please note that in the case of coordinates-like input, the functional annotation filter will not check genes and therefore use the "worst" available consequence at each location. In case of groups-like input, the functional annotation filter will be disabled.
5. Decide whether you want to create a new GRM for your cohort, or re-use a previously computed GRM.

   This is useful for example if you want to run the workflow on several chromosomes for the same cohort: because the GRM only depends on your cohort, you can compute the GRM from scratch for the first chromosome of interest, and then re-use the GRM plink files for other chromosomes, which will significantly shorten running times.

   In case you want to re-use a previously computed GRM for SAIGE-GENE analysis, simply set the relevant variable (`use_precomputed_plink_files_for_grm`) to "true" and specify the 3 relevant plink files (variable `precomputed_plink_files_for_grm`) in the "input variables" file. Otherwise, just set `use_precomputed_plink_files_for_grm` to "false", and the GRM will be re-computed from scratch. Note that only if the GRM is re-computed from scratch those three plink files will be made available after a successful run, in a subfolder of the output folder, named "globXXXXXXXXXXXXXXX" by default.

### What do I need to change to run the workflow?

The following files should be modified by the user:

1. `submit_workflow.sh`
   1. Change to the correct project code
   2. *(If needed)* Change to the correct file name / file path for "input.json"
   3. *(If needed)* Change to the correct file name / file path for "options.json"
2. `input_variables/for_master_aggregate_variant_testing.json`

   - This is the input variables file - it contains an extensive list of variables used by the workflow, and it is described in detail here: [Aggregate Variant Testing "input variables" file](../avt_input2/). A non-exhaustive list of variables that are likely need to be edited would include:

     - `lsf_project_code` (your HPC project code)
     - `input_variants_dataset` ("aggV2" or "aggV2\_PASS\_UTRplus\_proteincodinggenes")
     - `phenotype_input_file` (your cohort's phenotype file) and variables regarding its format
     - `use_precomputed_plink_files_for_grm` ("true" or "false")
     - `precomputed_plink_files_for_grm` (empty array, or array of 3 paths to precomputed plink files)
     - Variables for files at points 3 and 4 below (`chromosomes_input_file`, `genes_input_file`, `coordinates_input_file`, `groups_input_file`)
     - **At most one** of these files needs to be modified, and its path specified in the input variables file - while the other two of these can be neglected and the corresponding variables set to null in that input file, as can be seen in the [input variables file example](../avt_input2/):
   - `input_user_data/genes.txt`
   - `input_user_data/coordinates.bed`
   - `input_user_data/groups.tsv`
   - `input_user_data/chromosomes.txt`
   - Edit this file to specify your chromosome of interest - either an autosome or chrX if you use "aggV2" or "aggV2\_PASS\_UTRplus\_proteincodinggenes". Note that if none of the files at point 3 above are used (by setting the 3 corresponding variables to null in the input variables file), this file **must** specify a chromosome, and all genes from that chromosome will be used.
   - `options.json`
   - *(If needed)* Change to select the output directories for your output files

### Running the workflow

After the workflow is set up in your folder of choice, you can run it by submitting it to the HPC system - from that folder, simply use this command in your terminal:

`bsub < submit_workflow.sh`

### Inputs and outputs

#### The submission script

The submission script is used to submit the main cromwell control job. This job will then control and run all subsequent parts of the workflow.

The submission script

```
#BSUB -q inter
#BSUB -P bio
#BSUB -o avt_workflow_%J.stdout
#BSUB -e avt_workflow_%J.stderr
#BSUB -cwd .
#BSUB -n 2
#BSUB -R "rusage[mem=50000] span[hosts=1]"
#BSUB -M 50000

. /resources/conda/miniconda3/etc/profile.d/conda.sh && conda deactivate
module purge
module load bio/cromwell/51

java -Dconfig.file=cromwell.conf \
     -jar $CROMWELL_JAR \
     run workflow.wdl \
     -i inputs.json \
     -o options.json</pre>
```

#### The "input variables" file

The input variables file, or inputs file, is a large file containing options for filtering the data and selecting a set of variants to run the tests on, as well as for tuning the parameters of SAIGE-GENE. It is described in detail here, with comments on which options will need to be changed and which should remain as they are: [Aggregate Variant Testing "input variables" file](../avt_input2/).

#### The options file

The options file is used to specify the paths to where the outputs should be saved. These paths do not need to exist beforehand, but should be in a location where you have permission to create folders (e.g. your shared GECIP or company folder). It also controls whether to use workflow caching, which will greatly speed up reruns with slightly tweaked settings (highly recommended).

options.json

```
{
    "final_workflow_outputs_dir": "final_output/data",
    "use_relative_output_paths": true,
    "final_workflow_log_dir": "final_output/workflow_logs",
    "final_call_logs_dir": "final_output/call_logs",
    "default_runtime_attributes": {
        "maxRetries": 5
    },
    "write_to_cache": true,
    "read_from_cache": true
}
```

#### The cromwell configuration file

The cromwell configuration file controls all aspects of how cromwell submits jobs to the cluster, how to run in general. This file should usually not be changed.

The line *jdbc:hsqldb:file:cromwell-executions/cromwell-db/cromwell-db;* sets the name and location of the database used for call caching. This can be changed, to use different databases for different analyses.

> **Only run one workflow at a time per database:**
>
> Multiple running workflows pointing to the database will lead to database corruption. This will prevent the workflows running, and prevent call caching. The only way to get past this is to delete the database (and take the hit to computation again).

cromwell.conf

```
include required(classpath("application"))
backend {
    default = LSF
    providers {
        LSF {
            actor-factory = "cromwell.backend.impl.sfs.config.ConfigBackendLifecycleActorFactory"
            config {
                exit-code-timeout-seconds = 600

                runtime-attributes = """
                Int cpu
                Int memory_mb
                String lsf_queue
                String lsf_project
                """

                submit = """
                bsub \
                -q ${lsf_queue} \
                -P ${lsf_project} \
                -J ${job_name} \
                -cwd ${cwd} \
                -o ${out} \
                -e ${err} \
                -n ${cpu} \
                -R rusage[mem=${memory_mb}] \
                -M ${memory_mb} \
                /usr/bin/env bash ${script}
                """

                job-id-regex = "Job <(\\d+)>.*"
                kill = "bkill ${job_id}"
                check-alive = "bjobs ${job_id} |& egrep -qvw 'not found|EXIT|JOBID'"

                filesystems {
                    local {
                        localization: [
                            "soft-link", "copy", "hard-link"
                        ]
                        caching {
                            duplication-strategy: [
                                "soft-link", "copy", "hard-link"
                            ]
                            hashing-strategy: "path+modtime"
                        }
                    }
                }
            }
        }
    }
}
call-caching {
    enabled = true
    invalidate-bad-cache-results = true
}
database {
    profile = "slick.jdbc.HsqldbProfile$"
    db {
        driver = "org.hsqldb.jdbcDriver"
        url = """
        jdbc:hsqldb:file:cromwell-executions/cromwell-db/cromwell-db;
        shutdown=false;
        hsqldb.default_table_type=cached;hsqldb.tx=mvcc;
        hsqldb.result_max_memory_rows=100000;
        hsqldb.large_data=true;
        hsqldb.applog=1;
        hsqldb.lob_compressed=true;
        hsqldb.script_format=3
        """
        connectionTimeout = 86400000
        numThreads = 2
   }
}
```

### Notes and tips

#### Workflow runtimes

The first time the workflow is run, it will usually take a few days for full aggV2 runs, and a few hours for protein-coding aggV2, depending on the traffic on the HPC. The runtime is mostly taken up by the selection of random, low MAC SNPs in your cohort for GRM creation. The second greatest component of the runtime is extracting the regions from the aggregate for the genes / regions that are being queried.

#### Running the same cohort again, but with different annotation filters

Rerunning the workflow on the same cohort, but with different variant filters (e.g. different functional annotation filters for variant inclusion, for the same cohort) is much faster than running the workflow from scratch, as long as the workflow is able to read from the same workflow cache. Please note the warning above about simultaneously running multiple workflows pointing to the same cache. A good idea here is to create separate inputs and options file for each cohort + filtering combination, so that each workflow output is written to a different folder (see "options" file), and so you can refer back to all the inputs used for each run.

An example of this would be a setup like the following, where you have two separate sets of files for either including

1. variants annotated by vep as being missense or worse or
2. high confidence loss-of-function variants, as identified by LOFTEE.

Both of these setups point to the same cromwell configuration file that has a single database. This way, all parts of the workflow that can possibly be re-used as-is will not be run again (this is done automatically by the Cromwell engine) and the second run will be greatly sped up.

```
submit_cardio_EUR_vep_missense.sh
cardio_EUR_vep_missense_inputs.json
cardio_EUR_vep_missense_options.json

submit_cardio_EUR_loftee_HC.sh
cardio_EUR_loftee_HC_inputs.json
cardio_EUR_leftee_HC_options.json

cardio_EUR_cromwell.conf
    - cromwell database named cardio_EUR
```

#### Example use cases

Please find some basic example use cases [here](../avt_example2/).

### Output breakdown

#### Workflow logs

The logfile for the workflow will be copied to the folder specified in the options.json file, upon successful completion of the workflow. This contains the log information generated by cromwell while the workflow is running.

#### Workflow outputs

All workflow outputs are copied into the data folder specified in the options.json file. There are four main output types for the workflow.

##### regions\_names\_sorted.bed

This file contains the genes or genomic regions on which the tests were run. It is a four column file with the following information:

| Column | Description |
| --- | --- |
| Chr | The chromosome that the Gene or region is located in. |
| Start | The start location of the gene or region. |
| End | The end location of the gene or region. |
| Gene Name | The HGNC gene symbol of the gene. |

##### saige\_output.txt

This is the default output file specified in the input\_variables.json. It contains all the output (association statistics) from [SAIGE-GENE](https://github.com/weizhouUMICH/SAIGE/wiki/Genetic-association-tests-using-SAIGE) for the above regions.

| Column | Description |
| --- | --- |
| Gene | Gene name or genomic region, as provided in the group file |
| Pvalue | p-value of SKAT-O test |
| Nmarker\_MACCate\_1 | number of markers in the gene falling in the 1st MAC category (The MAC category is corresponding to the one used for the variance ratio estimation). For example, by default, Nmarker\_MACCate\_1 is the number of singletons |
| Nmarker\_MACCate\_2 | number of markers in the gene falling in the 2nd MAC category |
| Nmarker\_MACCate\_3 | number of markers in the gene falling in the 3rd MAC category |
| Nmarker\_MACCate\_4 | number of markers in the gene falling in the 4th MAC category |
| Nmarker\_MACCate\_5 | number of markers in the gene falling in the 5th MAC category |
| Nmarker\_MACCate\_6 | number of markers in the gene falling in the 6th MAC category |
| Nmarker\_MACCate\_7 | number of markers in the gene falling in the 7th MAC category |
| Nmarker\_MACCate\_8 | number of markers in the gene falling in the 8th MAC category |
| markerIDs | IDs for variants included in the test |
| markerAFs | allele frequencies for variants included in the test |
| Pvalue\_Burden | p-value of Burden test |
| Pvalue\_SKAT | p-value of SKAT test |
| BETA\_Burden | effect size |
| SE\_Burden | standard error of BETA |
| Pvalue.NA | p-values of SKAT-O test without accounting for unbalanced case-control ratios for binary traits |
| Pvalue\_Burden.NA | p-values of Burden test without accounting for unbalanced case-control ratios for binary traits |
| Pvalue\_SKAT.NA | p-values of SKAT test without accounting for unbalanced case-control ratios for binary traits |
| BETA\_Burden.NA | effect size without accounting for unbalanced case-control ratios for binary traits |
| SE\_Burden.NA | standard error of BETA without accounting for unbalanced case-control ratios for binary traits |

##### chr*\_NNN\_MMM.vcf.gz, chr*\_NNN\_MMM.vcf.gz.tbi

There is a VCF file (plus index) produced that includes each variant that was tested from each chunk of the input dataset. For example, if you test only a single gene, then there will be one output VCF file that contains all the variants tested, after all filters have been applied. If you test every regions across all autosomes, there will be 1253 VCF files produced. Note that the start and end coordinates of the chunk specified in the output file name may be different from those of the input chunks, as some genes span more than one chunk and therefore chunks may be resized to accommodate them. Please see [here](../aggv2/) for information on the chunks of aggV2.

##### chr\*\_NNN\_MMM.regions.tsv

There is a corresponding regions file for every VCF file. This is also known as the group file for SAIGE-GENE (and other software). It contains the markerID (e.g. gene) that was tested, and each variant in that marker. For example, a regions file could look like the following:

```
INVS_ENSG00000119509     chr9:100253002_G/T      chr9:100273018_C/T
MSANTD3-TMEFF1_ENSG00000251349   chr9:100498821_G/T
TMEFF1_ENSG00000241697   chr9:100498821_G/T
ALDOB_ENSG00000136872    chr9:101424886_G/A
RNF20_ENSG00000155827    chr9:101540562_C/T      chr9:101550689_T/G      chr9:101553995_C/T
```

##### grm\_mac\_counts.tsv

File containing the counts of variants in each MAC category used in the GRM.

##### differentially\_missing\_sites.tsv

Finally, there is a file containing chromosome and coordinate of all sites that were excluded due to failing the differential missingness test.

### FAQ

Â  I'm getting the error: `Error in solve.default(obj.glmm.null.sub$obj.noK$XVX); system is computationally singular: reciprocal condition number = 9.13132e-20`

This is an error generated by SAIGE-GENE during the running of the tests. We are currently contacting the developer to find the best way of solving this.

Â  I'm getting the error: `Futures timed out after [60 seconds] on ...`

Â  This is an error generated by Cromwell in some cases. The issue does not seem to have a full resolution [on Cromwell's issue tracker](https://github.com/broadinstitute/cromwell/issues/4057). However, in our case, this is usually not a blocking error - please simply re-submit the workflow without changing anything, and it should move on with the analysis.

Â  What variant types has the workflow been tested on?

Â  The workflow has been extensively tested on biallelic SNPs. Starting from v2.2, biallelic INDELs should also work well (minimal testing). Behaviour on multiallelic SNPs could be strange and would warrant further investigation.

Â  What chromosomes can I run this workflow on?

Â  The workflow will not work with chromosomes Y and mitochondrial (M), please avoid these. Also, please remember that the workflow can be run on one chromosome at a time only.

## Help and support

Please reach out via the [Genomics England Service Desk](../help/) for any issues related to running this script, including "AVT\_workflow" in the title/description of your inquiry.

November 17, 2023
