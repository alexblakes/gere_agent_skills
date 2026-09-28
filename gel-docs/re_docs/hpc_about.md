---
title: 'What is an HPC? - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/hpc_about/
scraped_at: 2026-05-04T06:32:28Z
---

# What is an HPC?

A High Performance Cluster (HPC) is a way to carry out large-scale analysis, using centralised compute.

```
flowchart TD
  A(Researcher submits job) --> B[Master host and candidates]
  B --> C[Queues]
  C --> |jobs wait in queues until the required resources are ready| D[Resources]
  D <-.-> |Master host and resources are in frequent communication| B
  D --> E(Job runs and finishes)
  classDef researcher fill:#DF007D,stroke:#DF007D,color:#FFFFFF;
  class A,E researcher;
  classDef RE fill:#FFC6E6,stroke:#FFC6E6,color:#2B2F3B;
  class B,C,D RE;
```

## Overview of usage

To use the HPC, you start by [logging onto the cluster](../hpc_access/). This brings you to the login node. From here you can `cd` into your [working folder](../home_directory/). It is possible to [load and run software](../hpc_using_software/) from the login node, but to make use of the full compute, you should [launch jobs](../hpc_jobs/).

```
%%{init: {"flowchart": {"htmlLabels": false, 'curve': 'linear'}} }%%
flowchart TB
  subgraph "`RE`"
    direction TB
    B["Research Environment"] --> C["Terminal"]
  end
  subgraph "`HPC`"
    direction TB
    D["`**Login node** low resourced`"] -- "`create job`" --> E["`**Worker node** high resourced`"]
  end  
  subgraph "`Weka`"
    direction LR
    F[Weka storage] --> G["`**discovery_forum:** read/write folder for Industry Research Network members`"]
    F --> H["`**re_gecip:** read/write folder for Academic Research Network members`"]
    F --> I["`**genomes:** read only, contains all consented genomes`"]
    F --> J["`**public_data_resources:** read only, contains public resources, eg gnomAD`"]
    F --> K["`**gel_data_resources:** read only, contains GEL-generated datasets, eg AggV2`"]
  end
  A("`Researcher`") --> RE
  C -- "`ssh`" --> HPC
  HPC --> Weka
  RE --> Weka
  classDef node fill:#FFC6E6,stroke:#FFC6E6,color:#2B2F3B;
  class A,B,C,D,E,F,G,H,I,J,K node;
```

## Terminology

| Term | Meaning |
| --- | --- |
| LSF | Load Sharing Facility - the tool we use to schedule jobs on the HPC |
| CPU | Central Processing Unit, the main processors |
| Nodes | Ephemeral storage, networking, memory and processing resources that can be consumed by virtual machine instances. Sometimes referred to as `hosts`. |
| [Job](../hpc_jobs/) | A task that you run on the HPC. Jobs can spawn other jobs. |
| [Queue](../hpc_queues/) | When you submit a job, it joins a queue. You can choose which queue to join, depending on the length of the job. |
| Batch jobs | A job that you set off, then it runs independently in the background |
| Interactive jobs | A job that opens access to the HPC, allowing you to run commands and tools on the cluster |
| [Running](../hpc_monitoring/) | A job that is in progress |
| [Pending](../hpc_monitoring/) | A job that is waiting in the queue |
| [working directory](../home_directory/) | The folder where you put all your files. |
| standard output | Information about the job as it runs. If you were running a job normally, this would appear in the terminal, however on an HPC, you should set a file to write this to. |
| [standard error](../hpc_scripts/) | Information about errors from the job. If you were running a job normally, this would appear in the terminal, however on an HPC, you should set a file to write this to. |
| scratch | A location to write any temporary files creating during the job. |
| [project code](../lsf_codes/) | researchers are grouped based on Research Network membership, with compute resources shared between the groups |
| [modules](../hpc_using_software/) | Software that has been loaded onto the HPC, which you can use in your analysis |

## Usage guidelines

> **DO:**
>
> DO launch [interactive jobs](../hpc_queues/) to run software on the HPC.
>
> DO kill interactive jobs when you've finished with them.
>
> DO choose the appropriate [length queue](../hpc_queues/) for your job.
>
> DO [estimate the memory](../hpc_memory/) required for your job.
>
> DO [use scripts](../hpc_scripts/) to launch your batch jobs.
>
> DO set LSF parameters (`#BSUB`) [*within* your scripts](../hpc_scripts/) for improved traceability in your batch jobs.
>
> DO specify the location for your [standard output and error](../hpc_scripts/) to help with [troubleshooting](../hpc_troubleshooting/)
>
> DO use [scratch directories](../home_directory/#temporary-files) for your temporary files.
>
> DO use [containers](../hpc_containers/) to import software.
>
> DO work with interactive coding tools such as [Rstudio](../enable_rstudio/) and [Jupyter](../hpc_jupyter/) on the HPC.
>
> DO set up [`.netrc`](../labkey_api_configuration/) to use the LabKey API.

> **DON'T:**
>
> DON'T run software on the login node.
>
> DON'T [request more memory than you need](../hpc_memory/).
>
> DON'T keep your temporary files in folders that will be [backed up](../backup/).

November 6, 2024
