---
title: 'The GWAS workflow - Versions and history - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/gwas_versions/
scraped_at: 2026-05-04T06:32:27Z
---

# The GWAS workflow - Versions and history

## Version v.1.3

New feature:

- Plotting improvements. Manhattan now plotted with ggplot2 with more flexible axes.

Bugfixes:

\*fixed siteQC issue where option `--1` forces plink1.9 to read the phenotype as cases/controls. This creates the issue for continuous traits, that for the chrX, the subsetting to female controls is not done correctly with the result of excessive number of sites being removed
\* fixed issue where clusterOptions conflicted with memory and cpu parameters for helix.
\* adjust singularity arguments for helix, adding `--cleanenv` `--no-home` and `--bind` arguments to not load home env that could conflict with container+mount additional locations for files.

## Version v.1.2

New feature:

- Ability to run GWAS on time-to-event phenotypes through the incorporation of GATE (Genetic Analysis of Time-to-Event phenotypes).

Additional fixes:

- Error "No such variable: genolistChsample" when input files are VCF resolved
- Issue with not enough memory for intersect\_hq process resolved
- Error strategy for all processes set to 'finish' by default instead of 'ignore'
- Erase phase if preserved in input files with plink, to avoid issues with downstream software

## Version v1.2-beta

(pre-release for v1.2)

fixes and changes:

- Error "No such variable: genolistChsample" when input files are VCF resolved
- Issue with not enough memory for intersect\_hq process resolved
- Error strategy for all processes set to 'finish' by default instead of 'ignore'

## Version v1.1

- Integration of SAIGE v1.0.7 and compatibility with previous versions.
- Issue with SAIGE runs never finishing resolved.
- Issue when input vcf/bgen/pgen filenames have dots (.) in filename resolved.
- Now passing VCF filtering arguments in a more general fashion with --vcfQC\_additional\_args flag, e.g. '-i --vcfQC\_additional\_args 'INFO/OLD\_MULTIALLELIC="."''.

## Version v1.0

First wide release of pipeline.

Supports:

- Direct masking and filtering of VCF file data.
- Conversion between VCF and bgen format.
- SAIGE association analysis for binary and quantitative traits.
- GCTA association analysis for binary traits.

Compatibility with research environments:

- RE 1/AWS
- AWS cloudRE

Known issues:

- When site quality control (process gwas\_siteQC) removes all variants, plink generates an error exit code. This should almost never happen when chromosome-wide data is processed but is more common when smaller genomic chunks are processed. This case is currently handled by ignoring the error and outputting the name of the chunk/chromosome input genomic file that produced this type of error in output folder error\_report. These process jobs will appear as "COMPLETED" in the .trace file, but will not pass variants for testing to SAIGE/GCTA. As a result, the number of "COMPLETED" gwas\_SAIGE\_spa\_tests or gwas\_GCTA\_spa\_tests\_pgen processes that run the association testing might be fewer compared to the number of input files in vcflist or bgenlist.
- On HPC, SAIGE step 2 can hang until job time-limit termination. This will trigger a retry which usually resolves the issue. Please use the short queue (default) to minimise the time that is spent hanging. This issue was not observed when using the pipeline in cloudRE.

October 24, 2024
