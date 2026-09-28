---
title: 'How to run jobs on the HPC - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/hpc_jobs/
scraped_at: 2026-05-04T06:34:40Z
---

# How to run jobs on the HPC

The Genomics England HPC uses [LSF (load sharing facility) from IBM](https://www.ibm.com/docs/en/spectrum-lsf/10.1.0?topic=started-quick-reference) to run your jobs. In order to run your job, you will need to:

- [select the correct queue](../hpc_queues/) depending on the type and length of your job.
- [reserve the memory you need](../hpc_memory/)
- [input your project code](../lsf_codes/)

We recommend [creating scripts to submit your jobs](../hpc_scripts/). You can [monitor the progress of your jobs](../hpc_monitoring/) as they run, and [troubleshoot](../hpc_troubleshooting/) any issues that arise.

Jobs will take time to run. You do not need to wait; you can navigate away from the terminal and even the Research Environment, and return later.

## Some basic LSF commands

| command | description |
| --- | --- |
| `bsub` | submits a job to the cluster |
| `bqueues` | shows info on the cluster queues |
| `bjobs` | shows info on the cluster jobs |
| `bhosts` | shows info on the cluster hosts |
| `bhist` | shows info on the finished cluster jobs |
| `bacct` | shows statistics and info on finished cluster jobs |
| `bkill` | removes a job from the cluster |
| `lshosts` | shows static resource info |
| `lsload` | shows dynamic resource info |

March 26, 2026
