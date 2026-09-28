---
title: 'Memory allocation on the HPC - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/hpc_memory/
scraped_at: 2026-05-04T06:32:34Z
---

# Memory allocation on the HPC

To run your jobs, you will need to specify how much memory you need. Memory management is enforced on the HPC to safeguard against rogue jobs consuming all the available memory on a node and crashing that node for everyone.

Specify how much memory you need with:

`-R rusage[mem=<memory_in_MB>]`

If you do not specify how much memory you need, this will be automatically set at 1000 MB.

The maximum memory allocation is 1000 MB per CPU. If you need more memory than this you can request additional CPUs. For example, to ask for 2 GB of RAM, use:

`-R rusage[mem=2000] -n 2`

The maximum number of CPUs you can request is 24, although if you request a lot of CPUs, your jobs may be [pending for some time](../hpc_troubleshooting/).

By default, LSF will reserve memory that is a factor higher than the amount you request. This is useful to capture spikes of memory increases above your regular memory usage to prevent your job suddenly crashing when it momentarily required 1 GB more, but it may also limit job allocation. For example, if your `-R` requests 4 GB of RAM, LSF may reserve 6-8 GB of RAM. This may result in you waiting longer because LSF is trying to allocate space for 6-8 GB instead of 4 GB. You can set these limits with `-M`.

Specify how much maximum memory LSF should reserve with:

`-R rusage[mem=2000] -M 2000`

We recommend setting `-R` and `-M` at identical levels when you start developing your scripts.

## How to estimate the amount of memory you need

If you're running a particular type of job for the first time, we recommend running it with a small memory allocation, checking the actual usage, then adjusting the memory allocation for subsequent runs.

For the first iteration, you can run the job with 1 GB: `-R rusage[mem=1000] -M 1000`

To see the actual memory usage, you must include standard output and error files in your run command: `-o <path_to/job.%J.out> -e <path_to/job.%J.err>`.

After your job has run successfuly, open the `.out` file. This will include the memory usage of your job in MB. If this is significantly less than the memory you requested, we recommend that you reduce the memory request for future jobs.

If your job has failed, and the `.out` file states `Job killed after reaching LSF memory usage limit`, you should retry your job with a higher memory allocation.

## Throttling jobs

If you are submitting large quantities of jobs and/or submitting jobs with long run time typically jobs that runs for hours and days, please be mindful of other users in the cluster. We strongly advise to throttle these jobs.

This means you can submit all jobs at once but control the number of concurrent RUNNING jobs at one go. On our LSF system we primarily allow this through job arrays.

- Control number of running jobs via job array

e.g. To submit an array with 100 jobs and throttle into 10 running at once

`bsub -q medium âJ âmyArray[1-100]%10â <rest of the submission>`

You may have experience with other LSF systems that allow job throttling or grouping through the use of jobgroups and setting specific reservation policies. We do not support these options, however if you believe you have a strong case for this usage we invite you to raise a [service desk ticket](https://jiraservicedesk.extge.co.uk/plugins/servlet/desk) with the relevant information for us to consider this.

## Multicore jobs

Sometimes you need to control how the selected processors for a parallel job are distributed across the hosts in the cluster.

You can again control this by changing the job submission parameters of LSF. By default, LSF does allocate the required processors for the job from the available set of processors.

A parallel job may span multiple hosts (= nodes), with a specifiable number of processes allocated to each host. A job may be scheduled on to a single multiprocessor host to take advantage of its efficient shared memory, or spread out on to multiple hosts to take advantage of their aggregate memory and swap space. The span string supports the following syntax: `span[hosts=1]`.

This indicates that all the processors allocated to this job must be on the same host - available nodes have a maximum of four available slots each, so when specifying this flag please use a value not larger than four for the `-n` flag.

For example, this will allocate four cores on a single machine:

```
bsub -q medium -n 4 -R "span[hosts=1]" <myjob>
```

And the following will allocate 12 cores spread across three nodes with 1GB of memory reserved for the job:

```
bsub -q medium -n 12 -R âspan[ptile=4] rusage[mem=1000]â -M 1000 -o /path/to/jobout -e /path/to/joberr <myjob>
```

## Examples of commands

| Job requirement(s) | `-R` option syntax |
| --- | --- |
| reserved 1 GB of memory for my job | `bsub -R ârusage [mem=1000]â -M 1000 <myjob>` |
| reserved 1 GB of memory for my job AND on a single host | `bsub -R ârusage [mem=1000] [hosts=1]â -M 1000 <myjob>` |
| nodes sorted by cpu and memory and reserved 1 GB memory | `bsub -R âorder[cpu:mem] rusage[mem=1000]â -M 1000 <myjob>` |
| nodes ordered by CPU utilisation (lightly loaded first) | `bsub -R "order[ut]" <myjob>` |
| multi-core jobs (e.g. four cpu cores on single host) | `bsub -n 4 -R "span[hosts=1]" <myjob>` |

July 29, 2024
