---
title: 'Monitoring jobs on the HPC - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/hpc_monitoring/
scraped_at: 2026-05-04T06:32:35Z
---

# Monitoring jobs on the HPC

You can see how your all your jobs are running using:

`bjobs`

This will show you all jobs, both pending and running, for example:

```
JOBID   USER    STAT  QUEUE      FROM_HOST   EXEC_HOST   JOB_NAME   SUBMIT_TIME
78796   jdoe  RUN   inter      lsflogin-0e lsfworker-i demo_job       Jul 12 11:01
78798   jdoe  RUN   short      lsfworker-i lsfworker-d dependent_job Jul 12 11:02
78807   jdoe  PEND  inter      lsflogin-0e             another_job      Jul 12 11:04
```

| Field | Definition |
| --- | --- |
| `JOBID` | The identifier of the job, you can use this to look up this job with a `bjobs` or `bhist` command |
| `USER` | The username of the job submitter |
| `STAT` | Status - `RUN`: running, `PEND`: pending |
| `QUEUE` | The queue the job is running/pending on |
| `FROM_HOST` | The host that triggered the job. `lsflogin`: triggered by the user, `lsfworker`: triggered by another job. |
| `EXEC_HOST` | The host that is running the job |
| `JOB_NAME` | The name of the job, this may be set by you. |
| `SUBMIT_TIME` | When the job was submitted. |

To see a specific job, include the job number, which will come up when you submit your job.

`bjobs <JOBID>`

You can get more details using the long option:

`bjobs -l`

This shows high level view of why (in case of job pending in the queue), where, turnaround time, resource usage detail (for running jobs).

```
Job <78796>, Job Name <demo_job>, User <jdoe>, Project <bio>, Status <RUN>, Queue
                      <inter>, Command <#!/bin/bash; #BSUB -P bio;#BSUB -q inte
                     r;#BSUB -J smlv;#BSUB -o logs/%J_demo_job.stdout;#BSUB -e logs
                     /%J_demo_job.stderr; LSF_JOB_ID=${LSB_JOBID:-default};export N
                     XF_LOG_FILE="logs/${LSF_JOB_ID}_demo_job.log"; module purge;mo
                     dule load singularity/4.1.1 nextflow/22.10.5; mkdir -p log
                     s; small_variant='/gel_data_resources/workflows/rdp_small_
                     variant/main'; nextflow run "${small_variant}"/main.nf \;
                        --project_code "bio" \;    --data_release "main-program
                     me_v18_2023-12-21" \;    --gene_input gene_list.txt \;    
                     --sample_input sample_file.tsv \;    --use_sample_input fa
                     lse \;    --outdir "results" \;    --publish_all true \;  
                       -profile cluster \;    -ansi-log false \;    -resume>
Fri Jul 12 11:18:59: Submitted from host <lsflogin-0e703e26.helix.prod.aws.gel.
                     ac>, CWD </re_gecip/re_gecip_cancer_breast/jane_doe_analysis/demo_job>, Ou
                     tput File <logs/78856_smlv.stdout>, Error File <logs/78856
                     _smlv.stderr>;
Fri Jul 12 11:19:00: Started 1 Task(s) on Host(s) <lsfworker-interactive-04fa8c
                     58.helix.prod.aws.gel.ac>, Allocated 1 Slot(s) on Host(s)
                     <lsfworker-interactive-04fa8c58.helix.prod.aws.gel.ac>, Ex
                     ecution Home </home/eperry>, Execution CWD </re_gecip/re_gecip_cancer_breast/jane_doe_analysis/demo_job>;
Fri Jul 12 11:19:11: Resource usage collected.
                     MEM: 38 Mbytes;  SWAP: 0 Mbytes;  NTHREAD: 27
                     PGID: 7304;  PIDs: 7304 7335 7339 7372

 RUNLIMIT                
 20160.0 min

 MEMORY USAGE:
 MAX MEM: 38 Mbytes;  AVG MEM: 19 Mbytes; MEM Efficiency: 0.00%

 CPU USAGE:
 CPU PEAK: 0.00 ;  CPU PEAK DURATION: 0 second(s)
 CPU AVERAGE EFFICIENCY: 0.00% ;  CPU PEAK EFFICIENCY: 0.00%

 GUARANTEED RESOURCE USAGE:
 Job has started through loaning
 highpool: 1 Slots

 SCHEDULING PARAMETERS:
           r15s   r1m  r15m   ut      pg    io   ls    it    tmp    swp    mem
 loadSched   -     -     -     -       -     -    -     -     -      -      -  
 loadStop    -     -     -     -       -     -    -     -     -      -      -  

 RESOURCE REQUIREMENT DETAILS:
 Combined: select[type == any] order[r15s:pg]
 Effective: select[type == any] order[r15s:pg]
```

You can similarly use `bhist` to see all finished jobs, both successful and failed.

```
Summary of time in seconds spent in various states:
JOBID   USER    JOB_NAME  PEND    PSUSP   RUN     USUSP   SSUSP   UNKWN   TOTAL
78856   jdoe  demo_job     1       0       48      0       0       0       49
```

Have a look at our [troubleshooting page](../hpc_troubleshooting/) if your jobs are not running as expected.

July 12, 2024
