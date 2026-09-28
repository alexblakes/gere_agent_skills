---
title: 'AggV3 site QC - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/aggv3_site_qc/
scraped_at: 2026-05-04T06:34:23Z
summary: "AggV3 per-variant site QC metrics (MEDIAN_DP, MEDIAN_GQ, MISSINGNESS_RATE, AB_RATIO) stored in INFO fields of siteQC VCFs, with Illumina LowGTR/LowMLSQ filters on biallelic sites."
---

# Aggv3 site QC

For all variants on autosomes and chrX, we applied a number of quality control (QC) metrics. All the metrics are reported in the INFO column in a separate siteQC VCF file corresponding to each shard and subshard. The first iteration of the siteQC VCFs do not include a FILTER column based on these QC metrics, but this will be updated in the future. We do not remove any variants from these files.

The biallelic VCF files contain a FILTER field provided by Illumina. The sites can fail on two conditions:

- `LowGTR` - variants with genotyping rate <0.9
- `LowMLSQ` - variants with Machine Learning Site Quality < 0.1. The MLSQ takes into consideration genotyping rate and genotyping quality from all samples. This filtering is applied only to variants passing the LowGTR filter.

  > **Note:**
  >
  > We have observed that variants and sites have been flagged by the `LowMLSQ` filter which are seemingly fine in terms of missingness, depth, and quality. This becomes apparent for some multiallelic sites where the most common variant may be flagged with this filter while the less common variant receives a `PASS` filter even though the site metrics and quality are largely similar if not identical. This may be caused by the model which was trained on UK Biobank data which would have different characteristics than Genomics England data, hence this 'over-filtering' was not observed in the UK Biobank data. We are working with Illumina to better understand this, and to provide an alternative solution or strategy for filtering (April, 2026).

A file containing paths to the siteQC VCFs is available in BED format at `s3://512426816668-gel-data-resources/dragen3.7.8/AggV3_resources/manifests/site_qc/2026-01-06/siteqc_shards.bed`. For guidance on working with these VCFs, please refer to our [code book](../aggv3_code_book_qc/).

## Site QC of autosomes

To calculate the SiteQC metrics, we first decomposed the multiallelic VCF ([Processing of Multiallelic VCFs](../aggv3_site_qc_decomposition/)), and calculated the following per-variant quality metrics. They can be found in the INFO field of site QC VCF files.

| Metric TAG | Description | Further description |
| --- | --- | --- |
| `MEDIAN_DP` | Median DP calculated across all samples. |  |
| `MEDIAN_GQ` | Median GQ calculated across samples with complete genotypes. | The median GQ was calculated from GTs in which fully missing genotypes were filtered out. Values are capped at 99. The filtering method was equivalent to: `bcftools query $infile -e "GT=\\".\\"" [...]` |
| `MISSINGNESS_RATE` | Fraction of samples with fully missing genotypes. | Missingness is calculated as: `missing_genotypes/(complete_genotypes+missing_genotypes)`. Missing genotypes: `bcftools query $infile -e "GT=\\".\\"" [...]`. Complete genotypes: `bcftools query $infile -e "GT!=\\".\\"" [...]` |
| `AB_RATIO` | For each heterozygous genotype, a binomial test is performed on reads supporting the called alleles (ref/alt or alt1/alt2). AB\_RATIO is the proportion of heterozygotes passing the test (p>0.01) out of all heterozygotes. | The AB ratio is a measure of the evidence supporting whether a heterozygous call is correct or not. This is achieved by testing the distribution of reads supporting ref and alt alleles for each genotype. We apply a binomial test with a strict threshold of p-value >0.01. The ratio is number of heterozygous calls passing this test divided by the total number of heterozygous calls for a variant. For heterozygotes containing a reference allele, `LAD[0]` and `LAD[1]` are used for the binomial test, where `LAD[0]` refers to the REF, and `LAD[1]` refers to the ALT allele. For heterozygotes where there is no reference allele (e.g., with a `1/3` genotype in the multiallelic VCF), we calculate the binomial test on `LAD[1]` and `LAD[2]`. This ensures that AB ratio is calculated using the correct numbers even if the sites are represented as `0/1` and `1/0` in the biallelic VCF (the LAD retains 3 values). |
| `AN` | Total number of alleles in called genotypes calculated across all samples. | These values are all calculated using the BCFtools plugin [fill-tags](https://samtools.github.io/bcftools/howtos/plugin.fill-tags.html). |
| `AC_Hom` | Allele counts in homozygous genotypes calculated across all samples. | As above. |
| `AC_Het` | Allele counts in heterozygous genotypes calculated across all samples. | As above. |
| `AC_Hemi` | Allele counts in hemizygous genotypes calculated across all samples. | As above. |
| `AF` | Allele frequency calculated across all samples. | As above. |

## Site QC of chrX

Sex chromosome QC was handled in a similar manner to autosomal QC, however some metrics were calculated separately for XX and XY samples. The table below provides a summary of the sex-specific metrics and their names. Sex chromosome karyotype was determined on the basis of [DRAGEN 3.7.8](../dragen_378/) ploidy estimation.

| Metric type | Metric | Metric TAG |
| --- | --- | --- |
| Metrics calculated on all samples | AN, AC, AC\_Hemi, AC\_Het, AC\_Hom | AN, AC, AC\_Hemi, AC\_Het, AC\_Hom / unchanged |
| Metrics calculated on XX and XY samples separately | AN, AC, AC\_Hemi, AC\_Het, AC\_Hom, MISSINGNESS\_RATE, MEDIAN\_DP, MEDIAN\_GQ | e.g. AN\_XX or MEDIAN\_DP\_XY |
| Metrics calculated only on XX samples | AB\_RATIO | AB\_RATIO\_XX |

## Site QC of chrY

Variant-level QC metrics are challenging for chromosome Y because standard QC methods (e.g., HardyâWeinberg equilibrium, heterozygosity-based filters, allele balance expectations) assume diploidy and are not directly applicable to a largely haploid chromosome. In addition, the Y chromosome contains extensive repetitive and multi-copy regions that introduce systematic mapping ambiguity, which is not fully captured by generic site-level QC metrics such as depth or variant quality scores.

Reliable Y chromosome analysis typically requires ad hoc and analysis-specific QC, including restriction to high-confidence regions, removal of heterozygous calls, and context-dependent thresholds for coverage and mapping quality. Because appropriate variant filtering on chromosome Y depends strongly on the downstream application, we recommend performing variant QC in an analysis-specific manner. Providing chromosome Y QC metrics is not on our product development roadmap.

April 13, 2026
