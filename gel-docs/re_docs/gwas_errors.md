---
title: 'The GWAS pipeline - common errors - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/gwas_errors/
scraped_at: 2026-05-04T06:32:24Z
---

# The GWAS pipeline - common errors

Here we list most common errors you might encounter when using the pipeline and their solutions. We recommend running the pipeline with `-resume` argument so that progress is not lost when encountering errors.

Missing 'fromPath' argument

This error indicates that you did not provide one of the required input files. Double check the list of required inputs.

Command not found

Check that no spaces are added at the end of arguments.

for example, if your command spans multiple lines with the use of slashes (`\`) be careful to not add space after the slash as shown below.

```
Incorrect
--gwasmethod 'SAIGE' \

Correct
--gwasmethod 'SAIGE' \
```

Memory errors - termination with exit codes 2/130

We have set up the defaults in terms of job submission to accommodate a common set of typical usage scenarios for Genomics England data.

However, the user might get errors if they use larger files than expected or bespoke/custom resources that they created.

```
Command error:
  Error: Out of memory.  The --memory flag may be helpful.
```

To address these issues re-run the pipeline and increase the defaults for memory by using the following arguments:

```
--plinkmem '20000'
--memory '22 GB'
--clusterOptions '-P Bio -R rusage[mem=22000] -M 22000'
```

plinkmem should always be less or equal than what is provided to the processes (`--memory` argument) and to the cluster (`--clusterOptions` argument)

Check also additional [optional arguments on the HPC](../gwas_optional/) for an even higher level of control of the memory allocated for processes (e.g., memory allocated for processes inferring the GRM).

Queue errors - unexplained termination with exit codes 130/137

We have set up the defaults for the submission queue for typical usage.

If your jobs unexpectedly terminate early at around 4h, then it means that the default 'short' queue is not appropriate

Change this with:

```
--queue 'medium'
```

(24h)

or

```
--queue 'long'
```

Check also [additional optional arguments on the HPC](../gwas_optional/) for an even higher level of control of the queue for processes.

chrX has very few tested variants in the manhattan

siteQC for chromosome X is different. Currently we capture the info on which chromosome is processed by the first line in the .csv file of the vcf/bgen/pgen list

Make sure that chromosome is specified as "chrX" (or "chr1","chr2",...,e.t.c) in the vcf/bgen/pgen list. Not as "X" or "23".

October 24, 2024
