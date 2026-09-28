---
title: 'HPC submission scripts - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/hpc_scripts/
scraped_at: 2026-05-04T06:32:37Z
---

# HPC submission scripts

We recommend running your batch jobs using submission scripts, as this makes it easier to see and edit your commands, and to re-run your job with modified parameters.

## Script template

Here is template you can follow:

```
#!/bin/bash  

# Include your job submission details as #BSUB headers
#BSUB -q <your_queue>  
#BSUB -P <yourProject>  
#BSUB -o <path_to/job.%J.out>  
#BSUB -e <path_to/job.%J.err>  
#BSUB -J <jobName>  
#BSUB -R "rusage[mem=1000] span[hosts=1]"  
#BSUB -M <max_memory_in_MB>
#BSUB -n <number_of_cores>  
#BSUB -cwd <"your_dir">  

# Set your temp directory as the re_scratch folder
export TMPDIR=/re_scratch/re_gecip/<your_GECIP>/<your_username>  
export TMPDIR=/re_scratch/re_discovery_forum/<your_discovery_forum_folder>/<your_username>

# Load any required modules from the HPC
module load <moduleName>  

# The actual script you want to run
```

### Job submission options

| option | definition | example input |
| --- | --- | --- |
| `-q` | The [queue](../hpc_queues/) you want to run your job in | `-q short` `-q medium` `-q long` |
| `-P` | Your [LSF project code](../lsf_codes/) | `-P re_gecip_cancer_breast` `-P re_df_illumina` |
| `-o` | Where you want your standard output to go, in your working folder | `/re_gecip/re_gecip_cancer_breast/jane_doe_analysis/job.%J.out` `discovery_forum/re_df_illumina/john_doe_work/job.%J.out` |
| `-e` | Where you want your standard error to go, in your working folder | `/re_gecip/re_gecip_cancer_breast/jane_doe_analysis/job.%J.err` `discovery_forum/re_df_illumina/john_doe_work/job.%J.err` |
| `-J` | A name for your job, with no spaces | `script_test_1` `analysis-breast-cancer` |
| `-R "rusage[mem=###] span[hosts=#]"` | The [memory you wish to allocate](../hpc_memory/) to your job, where `mem` is the memory allocation in MB and `hosts` is the number of cores to use. | `-R rusage[mem=500]` |
| `-M` | The [maximum memory](../hpc_memory/) for your job to use | `-M 500` |
| `-n` | The [number of cores](../hpc_memory/) for your job to use. | `-n 2` |
| `-cwd` | Your [working directory](../home_directory/) | `/re_gecip/re_gecip_cancer_breast/jane_doe_analysis` `discovery_forum/re_df_illumina/john_doe_work` |

### Temporary files

We recommend that you use the [`re_scratch` folder](../home_directory/#temporary-files) for your temporary files. These folders are not included in our [regular back-ups](../backup/), so this prevents using up finite space.

### Load any required modules from the HPC

You can make use of any of the [modules installed on the HPC](../hpc_using_software/). Load these here, making sure you have previously run `module avail` in the terminal to get the correct path.

This can include nextflow for pipelines, and singularity for [using containers](../hpc_containers/).

## Submitting your script

Use the following command to submit the script:

`bsub < myscript.sh`

The `<` sign indicates that your script is fed into the submission command.

August 13, 2024
