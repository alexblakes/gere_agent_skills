---
title: 'HPC troubleshooting - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/hpc_troubleshooting/
scraped_at: 2026-05-04T06:32:38Z
---

# HPC troubleshooting

Before you start troubleshooting, make sure you have included a standard error and standard output for your jobs (`-o <path_to/job.%J.out> -e <path_to/job.%J.err>`). You will need this to identify the cause of the problem and to fix it.

My job is PENDING for a long time

I have set my job to run, but I am getting no output. When I run `bjobs`, I see that my job is PENDING for a very long time.Â

---

Â There is limited memory available on the cluster. When you request a job asking for a lot of memory, the cluster is waiting for that amount of memory to be available before it starts your job. Try to only [request as much memory as your job will use](../hpc_memory/) next time you run your job. If you have run a similar job before, check the standard output for how much memory you used and request a rounded-up value.

You can check this by running `bjobs -l` with your job number. You will see something like:

`Job requirements for reserving resources (mem) not satisfied`

You can also run `bqueues` to see the availability on each [queue](../hpc_queues/).

`bhosts` will tell you how busy each node is.

Are there GPU resources on the HPC?

Are there any GPU resources on the Double Helix HPC, or just CPUs?

---

Â No, there are no GPU resources on Double Helix.

How do I find out why my job has failed?

My job has failed and I want to know why?Â

---

Â Make sure you run your job using a [standard error and standard output](../hpc_scripts/). Open the standard output and go to the end of the file to see the last thing that happened. This will include why your job failed.

You are not a member of project group

When you are trying to submit a job to the one of the queues using the Project code flag -P , LSF returns the following message:

```
ERROR: You are not a member of project group PROJECTNAME. Check with 'bugroup PROJECTNAME'
Request aborted by esub. Job not submitted.Â 
```

---

Â As the message says, you are not a member of the AD groups that you trying to submit the job against. You need to find the correct project name. You can do this by [checking the list](../lsf_codes/) or by running:

`bugroup -w PROJECTNAME`

`LSF Error: Bad resource requirement syntax`

When you are trying to submit a job, LSF returns the following message:

`Bad resource requirement syntax. Job not submitted`

---

Â One or more of the resources you're requesting is not valid, perhaps you have typed your command incorrectly.

Use the `lsinfo` command to verify the resources you are requesting are valid. Use the `bhosts` and `lshosts` command to verify there are hosts with the resources you are requesting.

How do I find out how much memory my job has used?

I want to correctly estimate how much memory to request for my next job. To do this, I need to know how much memory a similar job used. How do I find this out?Â

---

Â Make sure you run your job using a [standard error and standard output](../hpc_scripts/). Open the standard output and go to the end of the file to see the total amount of memory used.

My job has failed: `TERM_RUNLIMIT`

My job has failed. When I check the standard output, it says `TERM_RUNLIMIT: job killed after reaching LSF run time limit.`Â

---

Â You have reached the time limit of the queue you have selected. You need to [select a longer-running queue](../hpc_queues/) for your job. If you're already using the `long` queue, you will need to specify the run-time limit.

My job has failed: `TERM_MEMLIMIT`

My job has failed. When I check the standard output, it says `TERM_MEMLIMIT: job killed after reaching LSF memory usage limit.`Â

---

Â You have not requested sufficient memory for your job. You need to increase the [memory allocation](../hpc_memory/) for your job. If you require more than 1 GB, you will also need to request additional CPUs.

July 7, 2025
