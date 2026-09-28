---
title: 'Queues on the HPC - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/hpc_queues/
scraped_at: 2026-05-04T06:32:36Z
---

# Queues on the HPC

To see all available queues in the grid, run [`bqueues`](https://www.ibm.com/docs/en/spectrum-lsf/10.1.0?topic=information-view-available-queues-queue-status).

```
QUEUE_NAME      PRIO STATUS          MAX JL/U JL/P JL/H NJOBS  PEND   RUN  SUSP
inter            50  Open:Active       -    -    -    -     0     0     0     0
short            30  Open:Active       -    -    -    -     0     0     0     0
medium           20  Open:Active       -    -    -    -     0     0     0     0
long             10  Open:Active       -    -    -    -     0     0     0     0
```

| Field | Definition |
| --- | --- |
| `QUEUE_NAME` | the name of the queue |
| `PRIO` | the priority of the queue, where higher numbers indicate more important |
| `STATUS` | if the queue is currently availabale |
| `MAX` | maximum job limit - this is not set so appears as `-` |
| `JL/U` | job limit per user - this is not set so appears as `-` |
| `JL/P` | job limit per processor - this is not set so appears as `-` |
| `JL/H` | job limit per host - this is not set so appears as `-` |
| `NJOBS` | total number of jobs currently in the queue |
| `PEND` | the number of pending jobs in the queue |
| `RUN` | the number of jobs currently running in the queue |
| `SUSP` | the numer of suspended jobs in the queue |

## The `inter` queue

The `inter` queue is for lightweight interactive or GUI tools.

You should use the `inter` queue when you want to use tools and act immediately upon the output. For example, if you're working with our [aggregate VCF files](../aggv2_code_book/), using bedtools to find the correct chunk, then bcftools to act upon then.

You should also use the `inter` queue to work with GUI coding tools such as [jupyter](../hpc_jupyter/) or [Rstudio](../enable_rstudio/).

For example, this will start a job on the `inter` queue, for the [project code](../lsf_codes/) Bio, using bash.

`bsub -q inter -P bio -Is bash`

Jobs on the `inter` queue will keep going until you kill them, even if you close the terminal. You can have a maximum of five jobs running on the `inter` queue. When you have finished your work, you should kill your job:

`bkill <job number>`

## Batch queues

Genomics England HPC batch queues are time based queues (`short`, `medium`, `long`). This means you need to submit the jobs to the queue that reflects the runtime of your job.

| Queue name | Description |
| --- | --- |
| `short` | This queue is for jobs with maximum RUNTIME of four hours |
| `medium` | This queue is for jobs with maximum RUNTIME of 24 hours |
| `long` | This queue is for jobs with unlimited RUNTIME (*default* to seven days if not specified - or specify the limit as `-W [hours:]minutes` ) |

We recommend using a [script](../hpc_scripts/) to submit jobs to the batch queues.

### Choosing the right queue

This decision tree gives some examples of when you might choose which queue. However, every job is different, and in some cases you may need a longer queue than is recommended here.

Make sure include standard output and error files in your run command | `-o <path_to/job.%J.out> -e <path_to/job.%J.err>`.

If your job has failed, and the `.out` file states `Job killed after reaching LSF run time limit`, you should retry your job in a longer queue.

```
graph LR
  F([Type of job]) --> |interactive| G[interactive queue];
  F --> |batch| A([How many files?]);
  A --> |one| B[short queue];
  A --> |more than one| C([What type of files?]);
  C --> |BAM or CRAM| D[long queue];
  C --> |other| E[medium queue];
  classDef node fill:#FFC6E6,stroke:#FFC6E6,color:#2B2F3B;
  class A,B,C,D,E,F node;
```

September 6, 2024
