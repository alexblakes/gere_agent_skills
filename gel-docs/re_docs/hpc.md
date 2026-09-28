---
title: 'About the HPC - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/hpc/
scraped_at: 2026-05-04T06:34:39Z
---

# About the HPC

> **Memory usage:**
>
> There is less memory available in Double Helix than there was in the previous HPC. This is based on actual memory usage on Helix, and there should be sufficient memory available for all jobs. However we suggest that you reduce the [amount of memory you request for your jobs](../hpc_memory/), as most requests are significantly more than is actually used.

Genomics England provides a High Performance Computing Cluster (HPC) called Double Helix. You should use this to run all production-worthy scripts and workflows.

> **About high performance computing:**
>
> High performance computing (HPC) is the application of collection of computers to crunch large values of data. HPC also refers to the cluster of computers itself. An HPC is collocation of computer cores organised in nodes.
>
> HPCs are usually accessed from the command line via ssh. When you do so, you access a login node. These nodes have limited computer power, but they serve as a platform for scripting and job submission.
>
> A job is a task you want to perform that will be placed in a queue and run accordingly. For large jobs, i.e. jobs that deal with lots of data, it is important to specify the number of cores and memory needed to run your job. You can read more on how to do that, as well as how to run an array of jobs, which are jobs that are identical except for their input, [in our HPC guidelines](../hpc_memory/).

## Genomics England Double Helix setup

For most of the nodes, Double Helix uses the IBM Load Sharing Facility (LSF) platform to schedule jobs, by organising each job requirement and managing the job queue in an efficient and fair way.

Each node has a fixed number of 'job slotsâ. A job typically consumes one slot (though this can be more for parallel jobs), and the standard policy is one job slot per core. Consequently, the cluster has a maximum concurrent job limit to allow a fast dispatch. In our infrastructure, this means each compute node can accommodate 24 concurrent jobs (batch jobs).

For interactive jobs, we allow more job slots per node with the assumption that interactive workloads are not resource intensive. Interactive sessions should be used mostly as a way to submit jobs to the cluster, rather than for running day-to-day activities directly.

## Double Helix specifications

This is our main production grid. All workloads are expected to be submitted to this grid targeting the right queue.

- Cluster name: Double helix
- Number of physical compute nodes: 80
- Operating system: Amazon Linux 2
- Queueing system and schedulers: LSF
- Number of CPU cores: 24 cores/node ~ 1900
- Total number of job slots: 1900
- Available queues:
  - inter
  - short
  - medium
  - long
- CPU:mem: 24:92GB

## View cluster information

To view cluster information (LSF version, Cluster name, Master host) and check if your environment is correctly setup, run command `lsid`.

```
$ lsid
IBM Spectrum LSF Standard 10.1.0.14, April 20 2023
Copyright International Business Machines Corp. 1992, 2016.
US Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP Schedule Contract with IBM Corp.

My cluster name is helixprod
My master name is lsfmaster001-helix0.helix.prod.aws.gel.ac
```

### Resources in LSF

LSF tracks resource availability and usage. LSF Jobs can use defined resources to request specific resource.

All hosts have static numeric resources. e.g

**maxmem** total physical memory  
**ncpus** number of CPUs  
**maxtmp** maximum available space in /tmp  
**cpuf** CPU factor (relative performance)

as well as all hosts have dynamic numeric resources. e.g

**mem** available memory  
**tmp** available space in /tmp  
**ut** CPU utilisation

Ways to specify resources strings requirement (**-R** option):

`Select`: It is a logical expression built from a set of resource names  
`Order`: The order string is used for host sorting and selection  
`Usage`: It is used to specify resource reservations for jobs  
`Span`: A span string specifies the locality of a parallel job.  
`Same`: The same string specifies that all processes of a parallel job must run on hosts with the same resource.

Check out our documentation to learn more about [memory usage](../hpc_memory/) and [queues](../hpc_queues/).

## History

Double helix was released in 2024, replacing its predecessor Helix.

March 26, 2026
