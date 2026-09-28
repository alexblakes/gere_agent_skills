---
title: 'COVID-19 publication - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/covid_pub/
scraped_at: 2026-05-04T06:31:58Z
---

# COVID-19 publication

This page describes the resource methods that accompany the Nature paper [Kousathanas *et al*. 2022, "Whole genome sequencing reveals host factors underlying critical Covid-19"](https://europepmc.org/article/PPR/PPR390551).

## Genomic aggregation

Aggregation was conducted separately for the samples analysed with Genomics England pipeline 2.0 (severe-cohort, mild-cohort, cancer-realigned-100K), and those analysed with the Illumina North Star Version 4 pipeline (100K-Genomes).

For the first three, the WGS data were aggregated from single sample gVCF files to multi-sample VCF files using GVCFGenotyper (GG) v3.8.1, which accepts gVCF files generated via the DRAGEN pipeline as input. GG outputs multiallelic variants (several ALT variants per position on the same row), and for downstream analyses the output was decomposed to bi-allelic variants per row using software vt v0.57721.

Aggregation for the 100K-Genomes cohort was performed using Illuminaâs gvcfgenotyper v2019.02.26, merged with bcftools v1.10.2 and normalised with vt v0.57721.

## Sample Quality Control (sample QC)

Samples that failed any of the following four BAM-level QC filters: freemix contamination (>3%), mean autosomal coverage (<25X), percent mapped reads (<90%), and percent chimeric reads (>5%) were excluded from the analysis.

Additionally, a set of VCF-level QC filters were applied post-aggregation on all autosomal bi-allelic SNVs (akin to [gnomAD v3.1(https://europepmc.org/article/PPR/PPR68617)]). Samples were filtered out based on the residuals of eleven QC metrics (calculated using bcftools) after regressing out the effects of sequencing platform and the first three ancestry assignment principal components (including all linear, quadratic, and interaction terms) taken from the sample projections onto the SNP loadings from the individuals of 1000 Genomes Project phase 3 (1KGP3). Samples were removed that were four median absolute deviations (MADs) above or below the median for the following metrics: ratio heterozygous-homozygous, ratio insertions-deletions, ratio transitions-transversions, total deletions, total insertions, total heterozygous snps, total homozygous snps, total transitions, total transversions. For the number of total singletons (snps), samples were removed that were more than 8 MADs above the median. For the ratio of heterozygous to homozygous alternate snps, samples were removed that were more than 4 MADs above the median.

## Variant Quality Control (site QC)

### Masking

Prior to any analysis we masked low quality genotypes using [bcftools setGT](https://samtools.github.io/bcftools/howtos/plugins.html) module.

For chr1-22, chrX in females and chr1-22 in males, genotypes with DP < 10, GQ < 20, and heterozygote genotypes failing an AB-ratio binomial test with P-value < 1e-3 were set to missing.

For chrX in males, genotypes with DP<5, GQ<20 were set to missing.

### Merging of aggregates

Merging of aggCOVID\_v4.2 and aggV2 samples was done by first transforming each aggregate VCF file with masked genotypes to plink format and the merge function of plink v.1.9.

For the GWAS analyses described in the Kousathanas et al. (2022) paper, we used only variants that existed in both aggregates. In the provided joint aggCOVID\_v4.2\_aggV2 aggregate files, we also include sites that only segregate in aggCOVID\_v4.2 or aggV2. These variant sites are very low frequency and we have included them for enabling unbiased aggregate variant burden testing analysis across aggregates. For variants that exist in aggCOVID\_v4.2 but not in aggV2, we have set the genotypes of individuals of aggV2 to homozygote reference (0/0) and vice-versa.

## High-quality (HQ) independent SNPs

### Common HQ SNPs

**aggV2:** We started with autosomal, bi-allelic SNPs which had MAF > 0.05 in aggV2 (100K participant aggregate) and in the 1KGP3. We then restricted to variants that had missingness < 1%, median genotype quality QC > 3 0, median depth (DP) â¥ 30 and â¥ 90% of heterozygote genotypes passing an ABratio binomial test with P-value > 1e-2 for aggV2 participants. We also excluded variants in [complex regions](https://genome.sph.umich.edu/wiki/Regions_of_high_linkage_disequilibrium_(LD)) (lifted over for GRCh38), and variants where the ref/alt combination was CG or AT (C/G, G/C, A/T, T/A). We also removed all SNPs which were out of Hardy Weinberg Equilibrium (HWE) in any of the AFR, EAS, EUR or SAS super-populations of aggV2, with a P-value cutoff of pHWE < 1e-5. We then LD-pruned using plink v1.9 with an r^2 = 0.1 and in 500kb windows. This resulted in a total of 63,523 high-quality sites from aggV2.

**aggCOVID\_v4.2:** We then extracted these high-quality sites from the aggCOVID\_v4.2 aggregate and further applied variant quality filters (missingness <1%, median QC>30, median depth â¥ 30 and â¥ 90% of heterozygote genotypes passing an ABratio binomial test with P-value > 1e-2, per batch of sequencing platform (i.e, HiseqX, NovaSeq6000).

**aggCOVID\_v4.2\_aggV2:** After applying variant filters in aggV2 and aggCOVID\_v4.2, we merged the genomic data from the two aggregates for the intersection of the variants which resulted in a final total of 58,925 sites.

## Relatedness/Kinship

We calculated kinship coefficients among all pairs of samples using software plink2 and its implementation of the KING robust algorithm. We used a kinship cutoff < 0.0442 to select unrelated individuals with argument [`--king-cutoff`](https://www.cog-genomics.org/plink/2.0/distance#king_cutoff).

For each aggregate, we provide a set of unrelated participants and the kinship matrix in KING and GCTA compatible formats.

## Ancestry

To infer the ancestry of each individual we performed principal components analysis (PCA) on unrelated 1KGP3 individuals with [GCTA(https://yanglab.westlake.edu.cn/software/gcta/#Overview)] v1.93.1\_beta software using HQ common SNPs and inferred the first 20 PCs. We calculated loadings for each SNP which we used to project aggV2 and aggCOVID\_v4.2 individuals onto the 1KGP3 PCs. We then trained a random forest algorithm from R-package randomForest with the first 10 1KGP3 PCs as features and the super-population ancestry of each individual as labels. These were âAFRâ for individuals of African ancestry, âAMRâ for individuals of American ancestry, âEASâ for individuals of East Asian ancestry, âEURâ for individuals of European ancestry, and âSASâ for individuals of South Asian ancestry. We used 500 trees for the training. We then used the trained model to assign probability of belonging to a certain super-population class for each individual in our cohorts. We assigned individuals to a super-population when class probability >=0.8. Individuals for which no class had probability >=0.8 were labelled as âunassignedâ and were not included in the analyses.

## Principal components

After labeling each individual with predicted genetic ancestry, we calculated ancestry-specific PCs using [GCTA](https://yanglab.westlake.edu.cn/software/gcta/#Overview) v1.93.1\_beta using unrelated individuals. We computed 20 PCs for each of the ancestries that were used in the association analyses (AFR, EAS, EUR, and SAS). We computed PCs by projecting all the individuals using SNP-loadings from the PCA of the unrelated individuals.

## GWAS analyses

### GWAS model

We used a two-step logistic mixed model regression approach as implemented in SAIGE v0.44.5 for single variant association analyses. In step one, SAIGE fits the null mixed model and covariates. In step two, single variant association tests are performed with the saddlepoint approximation (SPA) correction to calibrate unbalanced case-control ratios. We used the HQ common variant sites for fitting the null model and sex, age, age^2, age\*sex and 20 principal components as covariates in step one. The principal components were computed separately by predicted genetic ancestry (i.e, EUR-specific, AFR-specific, etc.), to capture subtle structure effects.

### GWAS variant QC

We restricted all GWAS analyses to common variants applying the following filters using plink v1.9: MAF > 0 in both cases and controls, MAF> 0.5% and MAC >20, missingness < 2%, Differential missingness between cases and controls, mid-P-value<1e-5, HWE deviations on unrelated controls, mid-P-value < 1e-6, Multi-allelic variants were additionally required to have MAF > 0.1% in both aggV2 and aggCOVID\_v4.2.

### Control-control AF filter

100K aggV2 samples that were aligned and genotype called with the Illumina North Star Version 4 pipeline represented the majority of control samples in our GWAS analyses, whereas all of the cases were aligned and called with Genomics England pipeline 2.0. Therefore, the alignment and genotyping pipelines partially match the case/control status which necessitates additional filtering for adjusting for between-pipeline differences in alignment and variant calling. To control for potential batch effects, we used the overlap of 3,954 samples from the Genomics England 100K participants that were aligned and called with both pipelines. For each variant, we computed and compared between platforms the inferred allele frequency for the population samples. We then filtered out all variants that had > 1% relative difference in allele frequency between platforms. The relative difference was computed on a per-population basis for EUR (n=3,157), SAS (n=373), AFR (n=354) and EAS (n=81).

### LD-based validation of lead GWAS signals

In order to quantify the support for genome-wide significant signals from nearby variants in LD, we assessed the internal consistency of GWAS results of the lead variants and their surroundings. To this end, we compared observed z-scores at lead variants with the expected z-scores based on those observed at neighbouring variants. The validation was done using the code deposited [here](https://github.com/baillielab/GenOMICC_GWAS) and is similar to the [DENTIST approach](https://europepmc.org/article/MED/34880243).

### Fine-mapping

We performed fine-mapping for 17 regions around genome-wide significant signals using Rpackage [SusieR v0.11.42](https://github.com/stephenslab/susieR). For each genome-wide significant variant locus, we selected the variants 1.5 Mbp on each side and computed the correlation matrix among them with plink v1.9. We then ran the susieR summary-statistics based function susie\_rss and provided the summary z-scores from SAIGE (i.e, effect size divided by its standard error) and the correlation matrix computed with the same samples that were used for the corresponding GWAS. We required coverage >=0.95 for each identified credible set and minimum and median absolute correlation coefficients (purity) of r=0.1 and 0.5, respectively.

## Post-GWAS analyses

### TWAS

We performed TWAS in the MetaXcan framework and the GTExv8 eQTL and sQTL MASHR-M models available for download in <http://predictdb.org/>. We first calculated, using the European summary statistics, individual TWAS for whole blood and lung with the [S-PrediXcan](https://europepmc.org/article/MED/29739930) function. Then we performed a metaTWAS including data from all tissues to increase statistical power using [s-MultiXcan](https://github.com/hakyimlab/MetaXcan). We applied Bonferroni correction to the results in order to choose significant genes and introns for each analysis.

### Colocalisation

Significant genes from TWAS, splicing TWAS, metaTWAS and splicing metaTWAS, as well as genes where one of the top variants was a significant eQTL or sQTL were selected for a [colocalisation analysis](https://europepmc.org/article/MED/24830394) using the [coloc R](https://cran.r-project.org/web/packages/coloc/index.html) package. We chose the lead SNPs from the European ancestry GWAS summary statistics and a region of 200 kb around each SNP to do the colocalisation with the identified genes in the region. [GTExv8 whole blood and lung tissue](https://www.gtexportal.org/home/datasets) summary statistics and eqtlGen (which has blood eQTL summary statistics for > 30,000 individuals) were used for the analysis.

We first performed a sensitivity analysis of the posterior probability of colocalisation (PP\_H4) on the prior probability of colocalisation (P\_12), going from P\_12=1e-8 to P\_12=1e-4 with the default threshold being P\_12=1e-5. eQTL signal and GWAS signals were deemed to colocalise if these two criteria were met: (1) At P\_12=5e-5 the probability of colocalisation PP\_H4>0.5 and (2) At P\_12=1e-5 the probability of independent signal (PP\_H3) was not the main hypothesis (PP\_H3<0.5). These criteria were chosen to allow eQTLs with weaker P-values due to lack of power in GTExv8, to be colocalised with the signal when the main hypothesis using small priors was that there was not any signal in the eQTL data.

As the chromosome 3 associated interval is larger than 200kb, we performed additional colocalisation including a region up to 500 kb, but no further colocalisations were found.

## HLA analysis

HLA types were imputed at two field (4-digit) resolution for all samples within aggV2 and aggCOVID\_v4.2 for the following seven loci: HLA-A, HLA-C, HLA-B, HLA-DRB1, HLA-DQA1, HLA-DQB1, and HLA-DPB1 using the [HIBAG package in R](https://bioconductor.org/packages/devel/bioc/vignettes/HIBAG/inst/doc/HIBAG.html).

HLA association analysis was run under an additive model using SAIGE, in an identical fashion to the SNV GWAS. The multi-sample VCF of aggregated HLA type calls from HIBAG were used as input where any allele call with posterior probability T < 0.5 were set to missing.

## Aggregate Variant Testing (AVT) analysis

Aggregate variant testing was performed on aggCOVID\_v4.2 samples using SKAT-O as implemented in SAIGE-GENE v0.44.5 on all protein-coding genes.

We did not use the combined aggCOVID\_v4.2\_aggV2 aggregate for this analysis, as it was difficult to control batch effects from the different sequencing, alignment and genotyping pipelines when analysing the very rare variants that are used in AVT. More specifically, the control-control allele frequency filter that was used for identifying false positives in the GWAS analysis was not of high enough precision to "clean" the very rare variants because it depended on a much smaller set of samples that were processed with both pipelines.

### Variant QC

We excluded SNPs with differential missingness between cases and controls (mid-P value < 1e-5) or a site-wide missingness above 5% and only bi-allelic SNPs with a MAF < 0.5% were included.

### Masks

We filtered the variants to include in the aggregate variant testing by applying two functional annotation filters: A putative loss of function `pLoF` filter, where only variants that are annotated by LOFTEE as high confidence loss of function were included, and a more lenient missense filter where variants that have a consequence of missense or worse as annotated by VEP, with a CADD\_PHRED score of â¥ 10, were also included. All variants were annotated using VEP v99.

### Model and covariates

SAIGE-GENE was run with the same covariates used in the single variant analysis: sex, age, age^2, age\*sex and 20 (population-specific) principal components generated from common variants MAF â¥ 5%.

We ran the tests separately by genetically predicted ancestry, as well as across all four ancestries as a mega-analysis. We considered a gene-wide significant threshold on the basis of the genes tested per ancestry, correcting for the two masks `pLoF` and `missense`.

January 19, 2026
