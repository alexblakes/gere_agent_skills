---
title: 'The Aggregrate Variant Testing workflow - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/avt1/
scraped_at: 2026-05-04T06:34:25Z
---

# The Aggregrate Variant Testing workflow

This workflow runs aggregate variant tests on rare small variants in the Genomics England V2 aggregate (aggV2). The tests are run using SAIGE-GENE v0.39 (06 Aug 2020 <https://github.com/weizhouUMICH/SAIGE>). The aforementioned SAIGE-GENE implementation performs SKAT-O, SKAT and Burden tests.

The workflow is located in directory:

`/gel_data_resources/workflows/BRS_tools_aggregateVariantTestingWorkflow/v1.0`

## Description

The workflow performs aggregate variant testing on rare variants using SAIGE-GENE implementations of the SKAT-O, SKAT and Burden tests. The SAIGE-GENE approach is described in [this bioRxiv pre-print](https://www.biorxiv.org/content/10.1101/583278v2.full.pdf). It should be capable of handling relatedness in the cohort, as well as unbalanced cohorts in terms of case-control sizes. The workflow is written in [WDL](https://github.com/openwdl/wdl/blob/main/versions/1.0/SPEC.md) and is run using the [Cromwell engine](https://cromwell.readthedocs.io/). Internally, the workflow will call upon a number of different tools to execute all steps of the workflow. These are:

- [python](https://www.python.org/)
- [bedtools](https://bedtools.readthedocs.io/en/latest/)
- [bcftools](https://samtools.github.io/bcftools/bcftools.html)
- [singularity](https://sylabs.io/docs/)
- [SAIGE-GENE](https://sylabs.io/docs/)
- [plink](https://www.cog-genomics.org/plink/1.9/)
- [plink2](https://www.cog-genomics.org/plink/2.0/)

Briefly, the workflow, submitted to the  queue, consists of various steps which will generate subsequent scripts which are submitted to the HPC in the  and  queues. This may lead up to a few thousand jobs being submitted from your username, but most of these should not run for a very long time (traffic depending) - however, please note that one full end-to-end run of this workflow may end up taking a few days in its current form. The main output files will be saved in a folder called "**`final_output/data/`**" by default.

An in-depth description of the workflow steps can be found below.

## Overview of workflow files

The workflow files are located in:

`/gel_data_resources/workflows/BRS_tools_aggregateVariantTestingWorkflow/[version]`

The workflow consists of many files, broadly grouped into the following categories:

- .wdl files (the main workflow)
- input\_user\_data/\* (chromosomes, genes, regions, phenotype files)
- input\_variables/\*.json (all the default and user configurable settings for the workflow)
- resources/\* (multiple helper files and auxiliary scripts needed by the workflow)
- options.json (small set of user configurable options, such as the final output folder)

## Instructions

### Setting up

1. Copy the workflow folder into your shared working directory (/re\_gecip/ *or /discovery\_forum/*), as you will not have write access to where it is stored on the filesystem. Also, please note that the workflow will not run correctly if you try to run it from your home folder.
2. Create a phenotype file for your cohort of interest. It has a few mandatory columns:
   1. IID - containing IDs as platekeys
   2. A column of binary phenotypes, with value "0" for controls and "1" for cases
      - Note - this version of the workflow has been tested only for binary phenotypes, quantitative traits are not supported
   3. Additional columns for covariates to be used in the model, such as age, sex, and principal components; these need to be specified as a comma separated list in variable "`part_4_testing.phenotype_covariate_column_names`" in the [input variables file](../avt_input1/).
3. Decide the regions what you want to test. The workflow can accommodate any of the following:
   1. Any number of whole chromosomes
   2. Any number of genomic regions
   3. Any number of genes

> **Note:**
>
> Please note that the workflow will always assume this is a per-gene test, so if you pass chromosomes (or genomic regions) in the input it will automatically split them up according to the Ensembl list of genes

### What do I need to change to run the workflow?

The following files should be modified by the user:

1. `submit_workflow.sh`
   1. Change to the correct project code
   2. *(If needed)* Change to the correct input.json
   3. *(If needed)* Change to the correct options.json
2. `input_variables/for_master_aggregate_variant_testing.json` - Described in detail here: [Aggregate Variant Testing Inputs File](../avt_input1/).
3. **one** of these files needs to be modified, and its path specified in the [input variables file](../avt_input1/) - while the other two of these can be neglected and the corresponding variables set to null in that input file, as can be seen in the [input variables file example](../avt_input1/):
   1. `input_user_data/chromosomes.txt`
   2. `input_user_data/regions.tsv`
   3. `input_user_data/genes.txt`
4. `options.json`
   1. *(If needed)* Change to select the output directories for your output files

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
#BSUB -R "rusage[mem=10000] span[hosts=1]"

module load bio/cromwell/51

java -Dconfig.file=cromwell.conf \
     -jar $CROMWELL_JAR \
     run workflow.wdl \
     -i inputs.json \
     -o options.json
```

#### The input variables file

The input variables file is a large file containing options for filtering the data and selecting a set of variants to run the tests on, as well as for tuning the parameters of SAIGE-GENE. It is described in detail here, with comments on which options will need to be changed and which should remain as they are: [Aggregate Variant Testing Inputs File](../avt_input1/)

#### The options file

The options file is used to specify the paths to where the outputs should be saved. These paths do not need to exist beforehand, but should be in a location where you have permission to create folders (*e.g.* your shared GECIP or company folder). It also controls whether to use workflow caching, which will greatly speed up reruns with slightly tweaked settings (highly recommended).

options.json

```
{
    "final_workflow_outputs_dir": "final_output/data",
    "use_relative_output_paths": true,
    "final_workflow_log_dir": "final_output/workflow_logs",
    "final_call_logs_dir": "final_output/call_logs",
    "maxRetries": 5,
    "write_to_cache": true,
    "read_from_cache": true
}
```

#### The cromwell configuration file

The cromwell configuration file controls all aspects of how cromwell submits jobs to the cluster, how to run in general. This file should **NOT** be changed.

The line *jdbc:hsqldb:file:cromwell-executions/cromwell-db/cromwell-db;* sets the name and location of the database used for call caching. This can be changed, to use different databases for different analyses.

> **Note:**
>
> **Only run one workflow at a time per database**. Multiple running workflows pointing to the database will lead to database corruption. This will prevent the workflows running, and prevent call caching. The only way to get past this is to delete the database (and take the hit to computation again).

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
                Float memory_mb
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
                /usr/bin/env bash ${script}
                """

                job-id-regex = "Job <(\\d+)>.*"
                kill = "bkill ${job_id}"
                check-alive = "bjobs ${job_id}"

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

The first time the workflow is run, it will usually take one to three days, depending on the traffic on the HPC. The runtime is mostly taken up by the selection of random, low MAC SNPs in your cohort for GRM creation. The second greatest component of the runtime is extracting the regions from the aggregate for the genes / regions that are being queried.

#### Running the same cohort again, but with different annotation filters

The GRM creation step is the most computationally costly part of the workflow. Rerunning the workflow on the same cohort, but with different variant filters (e.g. different functional annotation filters for variant inclusion, for the same cohort) is much faster than running the workflow from scratch, as long as the workflow is able to read from the same workflow cache. Please note the warning above about simultaneously running multiple workflows pointing to the same cache. A good idea here is to create separate inputs and options file for each cohort + filtering combination, so that each workflow output is written to a different folder, and so you can refer back to all the inputs used for each run.

An example of this would be a setup like the following, where you have two separate sets of files for either including

1. variants annotated by vep as being missense or worse or
2. high confidence loss-of-function variants, as identified by LOFTEE.

Both of these setups point to the same cromwell configuration file that has a single database. This way, only the first run will need to select sites for the GRM and the second run will be greatly sped up.

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

### Output breakdown

#### Workflow logs

The logfile for the workflow will be copied to the folder specified in the options.json file, upon successful completion of the workflow. This contains the log information generated by cromwell while the workflow is running.

#### Workflow outputs

All workflow outputs are copied into the data folder specified in the options.json file. There are four main output types for the workflow.

**regions\_names\_sorted.bed**

This file contains the genes or genomic regions on which the tests were run. It is a four column file with the following information:

| Column | Description |
| --- | --- |
| Chr | The chromosome that the Gene or region is located in. |
| Start | The start location of the gene or region. |
| End | The end location of the gene or region. |
| Gene Name | The HGNC gene symbol of the gene. |

**output\_file\_name.txt**

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

**output\_vcf.gz**

There is a vcf file produced that includes each variant that was tested from each chunk of the aggregate (aggV2). For example, if you test only a singe gene, then there will be one output vcf file that contains all the variants tested, after all filters have been applied. If you test every regions across all autosomes, there will be 1253 vcf files produced. Please see [here](../gvcf_agg/) for information on the chunks of aggV2.

**output\_regions.tsv**

There is a corresponding regions file for every vcf file. This is also known as the group file for SAIGE-GENE (and other software). It contains the markerID (e.g. gene) that was tested, and each variant in that marker. For example, a regions file could look like the following:

```
INVS_ENSG00000119509__chunk_chr9_99887805_102432467     chr9:100253002_G/T      chr9:100273018_C/T
MSANTD3-TMEFF1_ENSG00000251349__chunk_chr9_99887805_102432467   chr9:100498821_G/T
TMEFF1_ENSG00000241697__chunk_chr9_99887805_102432467   chr9:100498821_G/T
ALDOB_ENSG00000136872__chunk_chr9_99887805_102432467    chr9:101424886_G/A
RNF20_ENSG00000155827__chunk_chr9_99887805_102432467    chr9:101540562_C/T      chr9:101550689_T/G      chr9:101553995_C/T
```

### FAQ

Â I'm getting the error: `âFATAL: failed to initialize runtime: engine ââ is not foundâ`

Â This is caused by having too many paths and settings loaded in your bash environment. This happens if a large number of modules have been loaded. To solve this, you should make sure you run "module purge" before submitting the script.

Â I'm getting the error: `Error in solve.default(obj.glmm.null.sub$obj.noK$XVX); system is computationally singular: reciprocal condition number = 9.13132e-20`

This is an error generated by SAIGE-GENE during the running of the tests. We are currently contacting the developer to find the best way of solving this.

Â What variant types have the workflow been tested on?

Â The workflow has only been tested on biallelic SNPs. Behaviour on multiallelic SNPs could be strange and would warrant further investigation.

Â What chromosomes can I run this workflows on?

Â The workflow will not work with chromosomes Y and mitochondrial (M), please avoid these.

### Version history

#### 1.0

Initial release.

## Help and support

Please reach out via the [Genomics England Service Desk](../help/) for any issues related to running this script, including "AVT\_workflow" in the title/description of your inquiry.

January 31, 2023
