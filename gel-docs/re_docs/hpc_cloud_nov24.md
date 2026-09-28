---
title: 'Using the HPC and Cloud to run jobs, November 2024 - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/hpc_cloud_nov24/
scraped_at: 2026-05-04T06:32:31Z
---

> **Archive training session:**
>
> Past training sessions may include information that is no longer true, in either the presentation or the Q&A. Please double check against the relevant documentation pages.

# Using the HPC and Cloud to run jobs, November 2024

The Genomics England Research Environment provides access to a High Performance Cluster (HPC) where you can access our genomic and clinical data and run large-scale analyses on these, using pre-installed bioinformatics tools, your own code and imported tools and software. This training introduces the HPC, including the compute and the queues available. We will show you how to access the available tools, including interactive coding tools, via the HPC, and how to run jobs using them. We will also cover bringing in tools and software from outside of the RE.

This training will be taught by our experts, including our HPC squad who create and maintain the cluster, and our bioinformaticians, who develop, install and work with the tools and workflows on the HPC.

## Timetable

1. Welcome and introduction
2. What is the High Performance Cluster?
3. Queues available on the HPC
4. How to create and monitor jobs on the HPC
5. Tools and software available and how to load them
6. Interactive coding tools
7. Bringing in your own tools and software
8. CloudOS â batch and interactive jobs on the Cloud
9. Questions

## Learning objectives

After this training you will be able to:

- Access the Genomics England Research Environment HPC
- Work with the available software to submit jobs to the different queues
- Create and work with your own software on the HPC

## Target audience

This training is aimed at researchers:

- working with the Genomics England Research Environment
- comfortable working on the command line
- who can programme in python and/or R

## Time

12th November 2024, 1.30 pm

## Materials

You can access the redacted slides and video below. All sensitive data has been censored.

### Slides

[Slides](../hpc_2024.pdf)

### Video

[Give us feedback on this tutorial](https://surveys.genomicsengland.co.uk/s/L7LYUK/)

### Q&A

Q&A

I will not be able to attend the whole session. Will you automatically circulate the link of the recording to all attendants?

live answered

---

i typed ls -lh, it shows âtotal 0â, is it normal?

Yes, without using â-aâ to also show the âhiddenâ files (named beginning with â.â), you probably donât have any files in your home directory (unless you have previously used the system) so itâs saying âtotal 0 files foundâ

---

on the interactive jobs is the max memory 1000? I have noticed if I try to request more than that it just seems to leave me in a queueâ¦.

No, the limit on the interactive queue is actually 244 GiB (although note that this is more than is actually available on any node). You can see the details of queue configurations with `bqueues -l`.

You can also see the reason why your job is pending with `bjobs -l <jobid>`. It may be that there is some other parameter causing your job to pend. Take care to set both `-M` and `-R rusage[mem=]` to ensure youy donât pick up the defaults.

I also experience this when doing my research work, so practically speaking I try to stick to smaller jobs when using the inter queue - However I find that just using the default parameters on the inter queue allows me to do most things

---

What if I donot set -n?

Youâll get the default, which is (I think) nearly always 1. You can see the queue (default) configuration with `bqueues -l` but it might not tell you *all* of the configuration defaults.

Thank you. And how to set mutiple cores when bsub some scrpipts?

This page has a section on multicore jobs: https://re-docs.genomicsengland.co.uk/hpc\_memory/

In practice, we recommend always working with submission scripts, and you can modify the number of cores at the tob with the rest of #BSUB parameters as #BSUB -n  https://re-docs.genomicsengland.co.uk/hpc\_scripts/

If you want to use multiple cores, you can request more cores (aka âslotsâ) with a higher value of n, eg `-n 2`.

Note, you can actually use as many cores as you like (up to the maximum available on the node) on Double Helix, but in times of contention (ie when multiple jobs are running on the same node), your job is weighted according to the requested slots for access to the CPUs."

Do you mean ânodeâ here equals to âcoreâ? Should I undersatnd like this?
which means that if I want to use 2 cores, I set up -n 2; 4 cores -n 4?

No, sorry. Some of the terminology was mixed in the slides â ânodeâ means compute host/server/machine, aka a worker where your job runs. On Double Helix these all have 24 cores. The bsub `-n` parameter maps to cores. Yes, exactly, `-n X` => X cores

This page might be useful to clarify some concepts too: https://re-docs.genomicsengland.co.uk/hpc/

Some basic specs for our HPC (copied from the page):  
Number of physical compute nodes: 80  
Memory per node: 1GB  
Operating system: Amazon Linux 2  
Queueing system and schedulers: LSF  
Number of CPU cores: 24 cores/node ~ 1900  
Total number of job slots: 1900  
CPU:mem: 24:92GB

Ah yes, thereâs a mistake there, âmemory per nodeâ is 96 GiB (barring the âbigmemâ node for very large jobs)

For reference you can see the number of CPU cores/slots and maximum usable memory on each node in the cluster with: `lshosts -w`

Going to pick up some tips myself from this training! Thanks Ian :-)

Thank you for your help. So you suggest to use singularity to use my own software, just wondering can I use conda to creat my own enviornment? Or is there any support team to help on installing software?

Iâm going to speak from personal experience: I personally have gotten on fine with conda environments for my work - it depends on the packages you require/if they are available from the white-listed sources https://re-docs.genomicsengland.co.uk/hpc\_conda/

If you need any package from outside the non-restricted channels then containers are the way to go. You can also ask for certain packages to be installed by submitting tickets, but have to take into account licensing (https://re-docs.genomicsengland.co.uk/hpc\_software\_request/)

Note: you should also take into account licensing when using personal conda envs/containers! But using personal environments is the quickest way vs asking for installation

Thank you. And where is the scrach folder which users could run jobs in?

---

How do you add new libraries not pre-installed to use on RStudio in HPC ?

See the docs here: https://re-docs.genomicsengland.co.uk/r\_packages/#installing-r-packages-from-cran â you can do this from within the RE desktop, and then use that on the HPC cluster, I think. Or you can request packages if you hit an error.

---

Thanks Emily, what is the current wait time?

I think itâs about 3 months, but donât hold me to that

---

how we can use nextflow in Cloudos ? Thanks

In batch jobs, Hamzah will show how shortly

---

I might have missed this but what is the reasoning to use CloudOS vs the HPC?

Personal preference, mainly

---

Do we pay when it is detailing costs?

$1000 dollars are available to you

October 7, 2025
