---
title: 'Using software on the HPC - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/hpc_using_software/
scraped_at: 2026-05-04T06:32:39Z
---

# Using software on the HPC

Software on the Genomics England HPC is managed through the module system framework.

## Module system commands

You can list the software available with:

`module avail`

Software available 14th January 2026

```
aliview/1.28        hmftools/2024-02-06            nf-test/0.8.2            
annovar/2019Nov     htslib/1.18                    nf-test/0.9.0            
annovar/2024-03-14  htslib/1.21                    openrefine/3.7.4         
ant/1.9.16          inkscape/1.3                   openssl/1.1.1o           
bamtools/2.5.2      java/1.8                       openssl/1.1.1t           
bcftools/1.16       java/11.0.2                    openssl/3.6.0            
bcftools/1.21       java/17.0.2                    perl/5.38.2              
beagle/5.4          java/19.0.2                    picard/3.1.1             
bedtools/2.30.0     java/21.0.2                    plink/1.9                
bedtools/2.31.1     java/23.0.1                    plink/2.0                
bison/3.8.0         jq/1.7.1                       plink/2.00a3.3LM         
blat/1.0            king/2.3.2                     postgresql/17.4          
boost/1.83          kraken/1.1.1                   proj/8.2.1               
boost/1.84          kraken2/2.1.3                  python/3.11              
cargo/0.10.5        libdeflate/1.20                python/3.13.9            
cmake/3.24.0        libffi/3.4.7                   qgrs-cpp/1.0             
cmake/ECM           libgit2/1.6.2                  qt/6.10.1                
conform/240524      libpcre/8.45                   R/4.3.3                  
cromwell/v65        libpng/1.6.43                  R/4.5.1                  
curl/7.81.0         libtiff/4.7.0                  regenie/3.4.1            
eigen/3.3.9         locuszoom/1.4                  REViewer/0.2.7           
exomiser/13.3.0     m4/1.4.19                      rust/1.91.1              
exonerate/2.2.0     magma/1.10                     samtools/1.16.1          
fetk/1.9.3          maven/3.9.6                    samtools/1.21            
flex/2.6.4          miniconda/23.11.0              singularity/3.8.3        
gatk/4.5.0.0        mpc/1.3.1                      singularity/4.1.1        
gcc/10.4.0          MPFR/4.2.0                     singularity/4.1.1-test3  
gdal/3.7.0          ncurses/6.4                    sqlite3/3.38.1           
geos/3.12.2         nextflow/22.10.5               tabix/1.21               
gmp/6.2.1           nextflow/23.04                 udunits/2.2.28           
go/1.25.0           nextflow/23.10                 xz/5.4.7                 
gsl/2.7             nextflow/23.10-with-plugins    yt-dlp/2025-12-08        
haplocheck/1.3.3    nextflow/24.04.2-with-plugins  zlib/1.3                 
hipstr/0.7          nf-core/0.3.1                  
hla-la/1.0.3        nf-test/0.7.3
```

> **Changes to installed packages:**
>
> The upgrade to Ubuntu has caused incompatibilities with a number of software packages. Many packages that were previously available on the HPC are no longer there, and many are only available in updated versions.
>
> If there is a package you need to use that is not available, we recommend that you use [containers](../hpc_containers/) to access it. Many bioinformatics containers are available from [biocontainers](https://hub.docker.com/r/biocontainers/biocontainers).

To load software, run:

`module load R/4.5.1`

> **Note:**
>
> Always specify the version of the software that you want to load, to avoid errors and unexpected results.

To unload software, run:

`module unload R/4.5.1`

Or you can switch to a different version of the same software (required software to be loaded first):

`module switch R/4.3.3`

## Video tutorial

## Python package and environment management

You can [use conda in the RE](../hpc_conda/) to access pre-made Python environments as well as creating your own. To install packages to your environments, you will need to use proxy paths.

## Bringing in software with containers

If you require software that is not available on the HPC, you can bring software in using containers with [Singularity](../hpc_containers/). If your workflow is written in Docker, Singularity is able to read Dockerfiles and convert them into Singularity images.

January 15, 2026
