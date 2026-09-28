---
title: 'AggV3 processing of multiallelic VCFs - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/aggv3_site_qc_decomposition/
scraped_at: 2026-05-04T06:31:12Z
summary: "AggV3 multiallelic msVCF pre-processing pipeline: missing genotype conversion, LAD-to-AD transformation, and bcftools decomposition/normalisation to biallelic form for siteQC metrics."
---

# Processing of multiallelic VCFs

Before calculating siteQC metrics, several pre-processing steps were applied to the multiallelic msVCFs to ensure variants were represented in the biallelic form. These biallelic VCFs were then used as the basis for calculating siteQC metrics.

## Pre-processing steps

- **Convert missing genotypes** - Missing genotypes (`./.` or `.`) with local allele depth (LAD) â¥ 4 were converted to reference alleles (`0/0` or `0`). This follows Illuminaâs convention for generating the [biallelic msVCFs](../aggv3_data_overview/#data-and-file-structure).
- **Transform LAD field** - The LAD field was converted into a standard AD field.
- **Decompose and normalise variants** - multiallelic sites were decomposed into their biallelic representation, and INDELs were left-aligned. Please note that in our pre-processing, variant normalisation includes both left-alignment and right-trimming, but in the Illumina biallelic representation only right-trimming is performed. As a result, there may be a small number of cases where variant representation may differ between our siteQC VCFs and the Illumina biallelic VCFs. Early findings show that most subshard VCFs are unaffected (~76%) and in those where differences occur, the majority of subshards contain less than 10 affected sites, and the maximum observed per subshard is approximately 50 sites.

A representative command for this step is:

```
bcftools +setGT -- ${VCF} \
    --target-gt q \
    --new-gt 0 \
    --include '(GT="./." | GT=".") & LAD>=4' | \
bcftools +tag2tag -- \
    --LAD-to-AD \
    --output-type u | \
bcftools norm \
    --multiallelics -both \
    --multi-overlaps 0 \
    --old-rec-tag SOURCE_RECORD \
    --fasta-ref ${REFERENCE_FASTA}
```

- `--multiallelics -both` splits both SNPs and INDELs at multiallelic sites into biallelic records
- `--multi-overlaps 0` uses the reference (0) allele for overlapping alleles after splitting multiallelic sites
- `--old-rec-tag SOURCE_RECORD` adds a new INFO field describing the original record

## SOURCE\_RECORD INFO Field

During decomposition, a new INFO field called `SOURCE_RECORD` is added to variants that undergo adjustments. Adjustments occur in the following events:

- Multiallelic sites split into multiple biallelic records during decomposition.
- Sites with position changes due to left-alignment.

The `SOURCE_RECORD` captures the original representation of the variant in the input VCF. The format of this tag varies depending on whether or not the variant was derived from a multiallelic site.

- For multiallelic sites the format is `CHROM|POS|REF|ALT|USED_ALT_IDX`. This includes an index indicating which alternate allele in the original site corresponds to the current biallelic record.

  For example:

  Multiallelic VCFAfter decomposition and left-alignment

  ```
  #CHROM  POS             ID      REF     ALT         QUAL    FILTER  INFO
  chrX    153390356       .       CT      C,CAT,CCT   .       .       .
  ```

  ```
  #CHROM  POS             ID      REF     ALT     QUAL    FILTER  INFO
  chrX    153390356       .       CT      C       .       .       SOURCE_RECORD=chrX|153390356|CT|C,CAT,CCT|1
  chrX    153390356       .       C       CA      .       .       SOURCE_RECORD=chrX|153390356|CT|C,CAT,CCT|2
  chrX    153390355       .       A       AC      .       .       SOURCE_RECORD=chrX|153390356|CT|C,CAT,CCT|3
  ```
- For biallelic sites the format is `CHROM|POS|REF|ALT` which is only included when the variantâs position changes due to left-alignment. These events are very rare.

  For example:

  Multiallelic VCFAfter decomposition and left-alignment

  ```
  #CHROM  POS         ID      REF     ALT     QUAL    FILTER  INFO
  chr10   72650669    .       G       GCG     .       .       .
  ```

  ```
  #CHROM  POS         ID      REF     ALT     QUAL    FILTER  INFO
  chr10   72650668    .       A       AGC     .       .       SOURCE_RECORD=chr10|72650669|G|GCG
  ```

This `SOURCE_RECORD` INFO field is available it the siteQC VCFs.

## Duplicated variants

In some cases, variant decomposition and left alignment can result in multiple records that share the same normalised variant, defined by the combination of `CHROM`, `POS`, `REF`, and `ALT`. These records originate from different variants in the original multiallelic VCFs and can be distinguished from each other using the `SOURCE_RECORD` field.

Most SiteQC VCFs do not contain duplicate variants, approximately 92% contain none, and a further ~5% contain only a single duplicate variant.

> **Note:**
>
> Due to an issue in the behaviour of bcftools annotate during the annotation step, less than 400 duplicate variants have been assigned incorrect quality control metrics. This issue will be corrected in future releases. Further details on the underlying bcftools behaviour are described in GitHub issue [#2506](https://github.com/samtools/bcftools/issues/2506)

## Genotype representation after decomposition

During VCF processing, there are two stages at which a reference allele (0) can be introduced into genotypes.

1. When missing genotypes with LAD >= 4 are converted to reference alleles. This event we refer to as `missing2ref`. This conversion introduces reference alleles which can increase the AN value.

   For example:

   Multiallelic VCFAfter decomposition and left-alignment

   ```
   #CHROM  POS             ID      REF     ALT     QUAL    FILTER  INFO  FORMAT  HG001         HG004
   chr22   50808373        .       A       AG      .       .       .     GT:LAD  1/1:0,21      ./.:10
   ```

   ```
   #CHROM  POS             ID      REF     ALT     QUAL    FILTER  INFO  FORMAT  HG001         HG004
   chr22   50808373        .       A       AG      .       .       .     GT:LAD  1/1:0,21      0/0:10
   ```
2. During multiallelic site decomposition, the reference allele is inserted into the genotype for alleles not present in a given decomposed record. This we refer to as `decomposed2ref`. Note that because of this conversion, heterozygous alternate genotypes (e.g. 1/2) are represented as heterozygous reference genotypes for each corresponding biallelic record, therefore, the AC\_Het value in the siteQC VCFs includes all heterozygous samples, regardless of whether the original genotype contained a reference allele.

   For example:

   Multiallelic VCFAfter decomposition and left-alignment

   ```
   #CHROM  POS             ID      REF     ALT     QUAL    FILTER  INFO    FORMAT  HG001   HG005   HG006
   chr22   10515074        .       A       AAG,G   .       .       .       GT      0/0     0/2     1/1
   ```

   ```
   #CHROM  POS             ID      REF     ALT     QUAL    FILTER  INFO    FORMAT  HG001   HG005   HG006
   chr22   10515074        .       A       AAG     .       .       .       GT      0/0     0/0     1/1
   chr22   10515074        .       A       G       .       .       .       GT      0/0     0/1     0/0
   ```

April 16, 2026
