---
title: 'Application profile - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/hpc_application_profile/
scraped_at: 2026-05-04T06:32:29Z
---

# Application profile

LSF's application profile is used to define common parameters for the same type/similar resource requirement jobs and workflows, i.e. including the execution requirements of the applications, the resources they require, and how they should be run and managed.

It provides you a simpler way to job submission without having to extend all the job's resources requirement. For instance, to submit a job (for the sake of argument lets call the workflow name as `nsv4`) that requires 4 cpu core and 4 GB of memory you would normally submit like:

`bsub -q medium -n 4 -R âspan[ptile=4] rusage[mem=4000]â -o /path/to/jobout <myjob>`

With application profile, the job requirements are predefined in LSF config, so it would allow the submission as:

`bsub -q medium-app <application name> -o /path/to/jobout <myjob>`

Run `bapp`. You can view a particular application profile or all profiles define in the cluster. To see the complete configuration for each application profile, `run bapp -l`. If you require an application profile created for your job, please raise a ticket with the

- preferred name of the profile
- complete list of your jobs resources requirements (viz, number of cores, approximate memory, expected runtime, local disk requirement etc.)

July 12, 2024
