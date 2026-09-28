---
title: 'Troubleshooting the gene-variant workflow - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/gv_faqs/
scraped_at: 2026-05-04T06:32:23Z
---

# Troubleshooting the gene-variant workflow

## Why is my workflow encountering memory errors?

The most likely cause is that these genes contain an unusually high amount of variants, causing memory errors during the aggregation steps of the workflow. However, longer genes can also cause a problem, for example:

| Gene name | Ensembl ID |
| --- | --- |
| TNNI3 | ENSG00000129991 |
| KIF1A | ENSG00000130294 |
| ACTN2 | ENSG00000077522 |
| PRKAG2 | ENSG00000106617 |
| RYR2 | ENSG00000198626 |
| SCN5A | ENSG00000183873 |
| CRELD1 | ENSG00000163703 |
| BBS10 | ENSG00000179941 |

To run the workflow on such problematic genes, the following memory allocations may be used.

In `quick_merge.wdl`:

| Task to be edited | Parameter | Default | Change to... |
| --- | --- | --- | --- |
| split | memory | 1GB | 2GB |
|  | cpu | 1 | 1 |
|  | queue | short | short |
| first\_round\_merge | memory | 20GB | 32GB |
|  | cpu | 1 | 2 |
|  | queue | short | medium |
| second\_round\_merge | memory | 10 | 48GB |
|  | cpu | 1 | 3 |
|  | queue | short | medium |

In `annotation.wdl`:

| Task to be edited | Parameter | Default | Change to... |
| --- | --- | --- | --- |
| fill\_tags\_query | memory allocation | 2GB | 5GB |
|  | number of cores | 1 | 1 |
|  | queue | short | short |
| annotate | memory allocation | 1GB | 5GB |
|  | number of cores | 4 | 4 |
|  | queue | short | short |
| sum\_and\_annotate | memory allocation | 5GB | 10GB |
|  | number of cores | 1 | 1 |
|  | queue | short | short |

Note: A version of the workflow with these memory allocations is not actively supported.

## Questions relating to autosomal hemizygosity

### What do the `AC_count` and `NS_variant` columns mean?

The AC and NS columns produced by [bcftools "fill-tags"](https://samtools.github.io/bcftools/howtos/plugin.fill-tags.html).

| Column | Description |
| --- | --- |
| AC\_variant | Allele count in genotypes. This is the number of alleles for the given variant counted from the genotypes listed in the VCF. |
| NS\_variant | Number of samples with data. This is the number of samples which have been included for this particular variant, and is equal to the number of samples with any variant at the given chromosomal position. |

### Why is `AC_Hemi_variant` > 0 when my gene of interest is not on a sex chromosome?

For autosomal variants, the majority of samples will have diploid genotypes (e.g. 0/1). However, some samples will have haploid (hemizygous-like) calls (e.g. 1) for certain variants. Such haploid calls indicate that the respective sample-genotype identified on one chromosome is located within a deletion identified on the other chromosome for the same sample.

These haploid calls are **not** produced as part of the aggregation procedure, but are seen in the single-sample gVCFs.

#### Worked Example

In the single-sample gVCF, we have identified the following variant where the genotype is represented as haploid ALT call:

| CHROM | POS | REF | ALT | GT | Description |
| --- | --- | --- | --- | --- | --- |
| chr1 | 2118756 | A | T | 1 | Haploid ALT genotype identified |

On closer inspection in the single-sample gVCF, we see that there is a heterozygous call (0/1) for a 2 bp deletion (TGA > T) 2 bp upstream of the variant (from bases 2118755 - 2118756). Therefore, the A > T SNP above is represented as haploid, because it is located *within* a known deletion on the other chromosome.

Please note that reference calls spanning that deletion are also haploid (the G reference call).

| CHROM | POS | REF | ALT | GT | Description |
| --- | --- | --- | --- | --- | --- |
| chr1 | 2118754 | TGA | T | 0/1 | 2bp deletion of bases GA from position 2118755 - 2118756. Called as heterozygous (diploid). |
| chr1 | 2118755 | G | . | 0 | We know the G base in position 2118755 is deleted on one chromosome, but on the other it is REF - therefore the hemizygous genotype 0 is called (haploid). |
| chr1 | 2118756 | A | T | 1 | We know the A in position 2118756 is deleted on one chromosome, but on the other it is ALT - therefore a hemizygous genotype 1 is called (haploid). |

November 7, 2022
