---
title: 'The GWAS pipeline - detailed process output - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/gwas_process_output/
scraped_at: 2026-05-04T06:32:25Z
---

# The GWAS pipeline - detailed process output

Each process of the [GWAS pipeline](../gwas/) emits outputs that are directed to the child processes. Certain outputs are saved and copied to the final results folder.

Those outputs are:

| Process group | Process output | subfolder | suffix | Output linkage | Process function |
| --- | --- | --- | --- | --- | --- |
| QC | gwas\_maskingQC | masked bgen v.1.2 files, 8-bit, ref-first | gwas\_bgen\_siteQC | \_maskedQC.bgen \_maskedQC.bgen.bgi \_maskedQC.sample | soft linkÂ from /work |
| QC | gwas\_siteQC | siteQC-filtered bgen v.1.2 files, 8-bit, ref-first siteQC-filtered pgen files | \_filtered\_final.bgen \_filtered\_final.bgen.bgi \_filtered\_final.sample | soft link from /work | This process performs siteQC on the primary input files: filters for maf and low missingness and performs a differential missingness test between cases and controls, and an HWE test on unrelated controls |
| SAIGE | gwas\_SAIGE\_fit\_null\_glmm | output from SAIGE step 1 Robject and text files containing the null fit | gwas\_1\_fit\_null\_glmm | .rda .results.txt .varianceRatio.txt | soft linkÂ from /work |
| SAIGE | gwas\_SAIGE\_spa\_tests\_bgen | per chunk/chr output from SAIGE step 2 (association tests) | gwas\_2\_spa\_tests | .SAIGE.gwas.txt | soft linkÂ from /work |
| GCTA | gwas\_GCTA\_sparse\_GRM | sparse GRM files | gwas\_GCTA\_sparse\_GRM |  | soft linkÂ from /work |
| GCTA | gwas\_GCTA\_fit\_null\_glmm | null GCTA fit | gwas\_GCTA\_fit\_null\_glmm |  | soft linkÂ from /work |
| GCTA | gwas\_GCTA\_spa\_tests\_pgen | per chunk/chr output from GCTA association tests | gwas\_GCTA\_spa\_tests | .GCTA.gwas.txt | soft linkÂ from /work |
| plotting | plotting | concatenated GWAS summaries | manhattan and qqplot for GWAS | plotting | \_summaries.txt \_qqplot.png \_manhattan.png |

October 24, 2024
