---
title: 'Data available for the COVID-19 aggregation - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/covid_agg_data/
scraped_at: 2026-05-04T06:31:55Z
---

# Data available for the COVID-19 aggregation

`aggCOVID_v4.2_aggV2` data is provided as a private s3 bucket that can only be accessed through the [Genomics England Cloud Research Environment](../cloudos/).

The s3 bucket folder containing the data is found under:
`GEL data resources > aggregations > covid-19 > aggCOVID_v4.2_aggV2`

And the s3 path is:
`s3://512426816668-gel-data-resources/aggregations/covid-19/aggCOVID_v4.2_aggV2/`

## Resource Files

### Genomic aggregate data

Genomic data for joint aggregate aggCOVID\_v4.2\_aggV2 is provided in bgen and pgen format within folder `genomic/`:

For bgen format we provide the data split into 1348 chunks and also in 23 chromosomes:

```
bgen/bgen_bychunk/aggCOVID_v4.2_aggV2_${chunk}_finalmerge_nodups.{bgen,bgen.bgi,sample}
bgen/bgen_mergedbychr/aggCOVID_v4.2_aggV2_${chr}_finalmerge_nodups.{bgen,bgen.bgi,sample}
```

For pgen format we provide the data split in 23 chromosomes:

`pgen/pgen_mergedbychr/aggCOVID_v4.2_aggV2_${chr}_finalmerge_nodups.{pgen,pvar,psam}`

The data split by chunk or split by chromosome contain identical information. The splitting is done to facilitate different types of analyses that may want to optimise maximum parallelism (e.g., GWAS using the by-chunk data) or analyses that require intact whole chromosome data (e.g., to calculate LD).

### High-quality (HQ) independent SNPs

Genomic data for high-quality independent SNPs is provided in plink format for each aggregate separately within folder `HQ_SNPs/`:

`aggCOVID_v4.2_aggV2_HQSNPs_common.{bed,fam,bim}`

These files were used for the calculation of relatedness, PCs and ancestry and also for generating genetic relatedness matrices for the logistic mixed model methods from SAIGE.

### Relatedness/Kinship

We provide lists with unrelated sets of individuals within directory `relatedness/`:

```
aggCOVID_v4.2_aggV2_unrelatedset.id
aggCOVID_v4.2_aggV2_relatedset.id
aggCOVID_v4.2_aggV2_optim_unrelatedset.id
```

Files without prefix `optim` do not take into account COVID-19 status when creating related and unrelated sets of individuals.

File with prefix `optim` was used in the primary GWAS analysis and preferentially retained individuals that were COVID-19 severe or mild from related pairs with 100K participants.

### Genetic Relatedness Matrices (GRM)

We provide dense and sparse GRMs calculated with GCTA within directory `GRM/GCTA/`:

```
aggCOVID_v4.2_aggV2_HQSNPs_common.grm.{id, bin, N.bin}
aggCOVID_v4.2_aggV2_HQSNPs_common_sparse0.05.grm.{id, sp}
```

### Ancestry probabilities

We provide ancestry probabilities and assigned ancestry for each participant within folder `ancestry/` and provided in file:

`aggCOVID_v4.2_aggV2_predanc.txt`

The column format is the following:

```
Ancestry file header
platekey AFR AMR EAS EUR SAS ancestry

Ancestry file header info
platekey: platekey ID of participant.
AFR, AMR, EAS, EUR, SAS: probability of assignment to a super-population ancestry (row-wise sums to 1).
ancestry: assigned ancestry (P >=0.8).
```

### Principal components (PCs)

PCA is always performed on unrelated participants and then a projection of the rest of the individuals is calculated.

We provide PCs for all individuals of `aggCOVID_v4.2_aggV2` and also population-specific PCs for individuals with assigned ancestry `${pop}=AFR, AMR, EUR, EAS, SAS`

Files have suffix `proj.eigenvec`, are located in folder `PCA/` and are named as follows: `aggCOVID_v4.2_aggV2_${pop}.proj.eigenvec`

### GWAS

### GWAS phenofiles

We provide the phenotype files with covariates used for the main GWAS analyses for pop=AFR, EAS, EUR, SAS within folder `GWAS/phenofiles/`:

`aggCOVID_v4.2_aggV2_anc${pop}_sev_vs_mld_aggV2_unreloptim.pheno`

The columns inside these files are:

```
GWAS phenofile columns
FID IID sev_vs_mld_aggV2 concordant_sex age age_sq age_sex ancestry cohort pc1_${pop} pc2_${pop} pc3_${pop} pc4_${pop} pc5_${pop} pc6_${pop} pc7_${pop} pc8_${pop} pc9_${pop} pc10_${pop} pc11_${pop} pc12_${pop} pc13_${pop} pc14_${pop} pc15_${pop} pc16_${pop} pc17_${pop} pc18_${pop} pc19_${pop} pc20_${pop}
```

Note that variable `${pop}` = AFR or EAS or EUR or SAS

#### Control-control AF filter

We provide allele frequency comparison for a smaller set of samples that were processed with both Genomics England pipeline 2.0 and Illumina NSV4 across all variants that segregate in both datasets.

We provide files by ancestry ${pop}=AFR, EAS, EUR, SAS within folder GWAS/`control_control_AF_filter/`:

`aggCOVID_v4.2_aggV2_AFfilter_gel2_nsv4_${pop}.txt`

```
control-control AF comparison header
varID AF_gel2 N_gel2 AF_nsv4 N_nsv4 AFreldiff
```

control-control AF comparison header info

```
varID: variant ID with format CHR:POS_REF_ALT
AF_gel2: Allele frequency in sub-sample processed with Genomics England pipeline 2.0
N_gel2: Sample size in sub-sample processed with Genomics England pipeline 2.0
AF_nsv4: Allele frequency in sub-sample processed with Illumina NSV4
N_nsv4: Sample size in sub-sample processed with Illumina NSV4
AFreldiff: relative allele frequency difference between platforms
```

#### GWAS summaries

We provide the summaries for the main GWAS that was run in the paper using SAIGE. This analysis used the COVID-19 critically ill patients as cases and 100K participant cohort and COVID-19 mild cohort as controls.

##### Per-population summaries

GWAS summaries are provided as tab-separated txt files within folder GWAS/summaries/ with name:

`aggCOVID_v4.2_aggV2_${pop}_sev_vs_mld_aggV2_unreloptim_bimulti_AFcontrolcontrol0.01_allvariants_nodups.txt`

for pop=AFR, SAS, EAS, EUR.

The columns inside these files are:

```
GWAS summaries file header
CHR POS REF ALT varID rsid BETA SE p.value p.value.NA Tstat varT varTstar N N_Cases N_Controls AF AF_Cases AF_Controls nallele_type AFreldiff P_miss P_hwe
```

GWAS summaries file header info

```
CHR: chromosome
POS: genome position
REF: reference hg38 allele (allele 1)
ALT: alternate allele (allele 2)
varID: variant ID with format CHR:POS_REF_ALT  
rsid: variant rsid
BETA: effect size of ALT/allele 2
SE: standard error of BETAp.value: p value (with SPA applied for binary traits)
p.value.NA: p value when SPA is not applied (only for binary traits)
Tstat: score statistic of ALT allele
varT: estimated variance of score statistic with sample relatedness incorporated
varTstar: variance of score statistic without sample relatedness incorporated
N: total sample size
N_Cases: sample size of cases
N_Controls: sample size of controls
AF: allele frequency of ALT/allele 2
AF_Cases: allele frequency of ALT/allele 2 in cases
AF_Controls: allele frequency of ALT/allele 2 in controls
nallele_type: biallelic or multiallelic
AFreldiff: control-control relative allele frequency
P_miss: mid-P value from plink1.9 for differential missingness between cases and controls
P_hwe: mid-P Hardy-Weinberg equilibrium value from plink1.9 for unrelated control
```

##### Meta-analysis summaries

GWAS summary results from METAL meta-analysis of EUR, SAS, AFR, EAS summaries within folder `GWAS/summaries/` with name:

`gwas.meta.genomicc.final.txt`

GWAS meta-analysis summaries file header

`CHR ID POS REF ALT BETA SE p.value N`

GWAS meta-analysis summaries file header info

```
CHR: chromosome
ID: variant ID with format CHR:POS_REF_ALT
REF: reference hg38 allele (allele 1)
ALT: alternate allele (allele 2)
BETA: meta-analysis effect size of ALT/allele 2 from METAL
SE: meta-analysis standard error of BETA from METAL
p.value: meta-analysis p value from METALN: total sample size
```

#### GWAS genomic data subset

We provide a subset of genomic data split by genetically inferred ancestry only for variants and individuals (post sample-QC, unrelated) included in the per-ancestry GWAS analysis.

Useful for downstream analyses that couple genomic data with GWAS summaries such as fine-mapping.

Files are provided in plink and vcf format for the population cohorts that we run GWAS (AFR, EAS, EUR, SAS) within folder `GWAS/genomic_data_subset/`:

```
plink/merged_bychr/aggCOVID_v4.2_aggV2_${chr}_finalmerge_nodups_${pop}.{bed,fam,bim}
plink/whole_genome_merged/aggCOVID_v4.2_aggV2_finalmerge_nodups_${pop}.{bed,fam,bim}
vcf/merged_bychr/aggCOVID_v4.2_aggV2_${chr}_finalmerge_nodups_${pop}.{vcf.gz,vcf.gz.tbi}
```

#### Finemapping

We provide susieR fine-mapping results for 17 3 Mb regions in EUR and one region in SAS.

Summary files are provided as text and as R objects and we also provide .png figures with output from susieR within folder `GWAS/finemapping/susieR_results/`:

```
aggCOVID_v4.2_aggV2_EUR_sev_vs_mld_aggV2_${sentinel_variant}.{txt,Rdata,png}
aggCOVID_v4.2_aggV2_SAS_sev_vs_mld_aggV2_${sentinel_variant}.{txt,Rdata,png}
```

##### Finemapping column headers

`HR POS REF ALT varID BETA SE p.value AF.Cases AF.Controls nallele_type focal CS susie_PIP purity_min purity_median CS_coverage`

Finemapping column headers info

```
CHR: chromosome
POS: genome position
REF: reference hg38 allele (allele 1)
ALT: alternate allele (allele 2)
varID: variant ID with format CHR:POS_REF_ALT  
rsid: variant rsid
BETA: effect size of ALT/allele 2SE: standard error of BETA
p.value: p value (with SPA applied for binary traits)
focal: focal/sentinel variant for fine-mapping. This is the top variant in the window examined. ID for focal variant is provided as CHR:POS:REF:ALT
CS: Index for identified credible set in region, can be L1, L2, L3, ...
susie_PIP: Posterior inclusion probability for variant.
purity_min: Minimum absolute correlation coefficient between variants in credible set.
purity_median: Median absolute correlation coefficient between variants in credible set.
CS_coverage: Posterior inclusion probability for credible set.
```

### Post-GWAS analyses

#### TWAS summaries

##### Per-tissue TWAS

We provide TWAS results using GTEX v8 data for lung and whole blood within folder `TWAS/summaries/`.

Files:

```
twas_Lung.csv
twas_Whole_Blood.csv
```

###### TWAS column headers

`gene,gene_name,zscore,effect_size,pvalue,var_g,pred_perf_r2,pred_perf_pval,pred_perf_qval,n_snps_used,n_snps_in_cov,n_snps_in_model`

TWAS column headers info

```
gene: a gene's id: as listed in the Tissue Transcriptome model. Ensemble Id for most gene model releases. Can also be a intron's id for splicing model releases.
gene_name: gene name as listed by the Transcriptome Model, typically HUGO for a gene. It can also be an intron's id.
zscore: S-PrediXcan's association result for the gene, typically HUGO for a gene.
effect_size: S-PrediXcan's association effect size for the gene. Can only be computed when beta from the GWAS is used.
pvalue: P-value of the aforementioned statistic.
var_g: variance of the gene expression, calculated as W' * G * W (where W is the vector of SNP weights in a gene's model, W' is its transpose, and G is the covariance matrix)
pred_perf_r2: (cross-validated) R2 of tissue model's correlation to gene's measured transcriptome (prediction performance). Not all model families have this (e.g. MASHR).
pred_perf_pval: pval of tissue model's correlation to gene's measured transcriptome (prediction performance). Not all model families have this (e.g. MASHR).
pred_perf_qval: qval of tissue model's correlation to gene's measured transcriptome (prediction performance). Not all model families have this (e.g. MASHR).
n_snps_used: number of snps from GWAS that got used in S-PrediXcan analysis
n_snps_in_cov: number of snps in the covariance matrixn_snps_in_model: number of snps in the model
```

##### Metatwas

We also provide TWAS results using GTEX v8 data with meta-analysis across all tissues.

Analysis is done per gene with results in within folder `TWAS/summaries/` and file: `metatwas.csv`

And per intron with results in file: `metatwas_sqtl_genomicc.csv`

Both files have the following columns:

`gene,gene_name,pvalue,n,n_indep,p_i_best,t_i_best,p_i_worst,t_i_worst,eigen_max,eigen_min,eigen_min_kept,z_min,z_max,z_mean,z_sd,tmi,status`

Metatwas column headers info

```
gene: a gene's id: as listed in the Tissue Transcriptome model. Ensemble Id for most gene model releases. Can also be a intron's id for splicing model releases.
gene_name: gene name as listed by the Transcriptome Model, typically HUGO for a gene. It can also be an intron's id.
pvalue: significance p-value of S-MultiXcan associationn: number of "tissues" available for this gene
n_indep: number of independent components of variation kept among the tissues' predictions. (Synthetic independent tissues)
p_i_best: best p-value of single-tissue S-PrediXcan association.
t_i_best: name of best single-tissue S-PrediXcan association.
p_i_worst: worst p-value of single-tissue S-PrediXcan association.
t_i_worst: name of worst single-tissue S-PrediXcan association.
eigen_max: In the SVD decomposition of predicted expression correlation: eigenvalue (variance explained) of the top independent component
eigen_min: In the SVD decomposition of predicted expression correlation: eigenvalue (variance explained) of the last independent component
eigen_min_kept: In the SVD decomposition of predicted expression correlation: eigenvalue (variance explained) of the smalles independent component that was kept.
z_min: minimum z-score among single-tissue S-Predican associations.
z_max: maximum z-score among single-tissue S-Predican associations.
z_mean: mean z-score among single-tissue S-Predican associations.
z_sd: standard deviation of the mean z-score among single-tissue S-Predican associations.
tmi: trace of T * T', where Tis correlation of predicted expression levels for different tissues multiplied by its SVD pseudo-inverse. It is an estimate for number of indepent components of variation in predicted expression across tissues (typically close to n_indep)
status: If there was any error in the computation, it is stated here
```

#### Coloc summaries

We provide colocalisation summaries for GTEX v8 for lung and blood tissues and for eqtlgen blood data.

Files are within folder `TWAS/coloc/`:

```
coloc_eQTLGen.txt
coloc_gtexv8_eqtl_lung.txt
coloc_gtexv8_eqtl_whole_blood.txt
```

##### Colocalisation summaries column header

`gene.tested ensembl.id PP.H3.5e-5 PP.H4.5e.5 PP.H3.1e-5 PP.H4.1e-5 colocalisation`

### HLA resources

HLA resources are provided within folder `HLA/`.

#### HIBAG HLA allele calls

We provide the HIBAG HLA allele call probabilities in a tab-separated file:

`hibag_tsv_all_aggCOVID_v4.2_aggV2.tsv`

and we also provide a VCF indexed file where we make a call with probability â¥0.5 :

```
hibag_vcf_all_aggCOVID_v4.2_aggV2_probthres_0.5.vcf.gz
hibag_vcf_all_aggCOVID_v4.2_aggV2_probthres_0.5.vcf.gz.csi
```

#### HIBAG COVID-19 association summaries

We provide the association summaries using SAIGE for the HLA haplotypes for the main analysis of the paper.

This analysis used the COVID-19 critically ill patients as cases and 100K participant cohort + COVID-19 mild cohort as controls.

`aggCOVID_v4.2_aggV2_sev_vs_mld_aggV2_EUR_unrelated_masked_manual_hibag_probthres_0.5_rerun.SAIGE.gwas.txt`

and with the following header columns:

##### HIBAG association summaries header

`CHR POS SNPID Allele1 Allele2 AC_Allele2 AF_Allele2 imputationInfo N BETA SE Tstat p.value p.value.NA Is.SPA.converge varT varTstar AF.Cases AF.Controls N.Cases N.Controls homN_Allele2_cases hetN_Allele2_cases homN_Allele2_ctrls hetN_Allele2_ctrls`

HIBAG association summaries info

```
CHR: chromosome
POS: genome position
SNPID: variant ID
Allele1: allele 1
Allele2: allele 2
AC_Allele2: allele count of allele 2
AF_Allele2: allele frequency of allele 2
imputationInfo: imputation info. If not in dosage/genotype input file, will output 1
N: sample size
BETA: effect size of allele 2
SE: standard error of BETA
Tstat: score statistic of allele 2
p.value: p value (with SPA applied for binary traits)
p.value.NA: p value when SPA is not applied (only for binary traits)
Is.SPA.converge: whether SPA is converged or not (only for binary traits)
varT: estimated variance of score statistic with sample relatedness incorporated
varTstar: variance of score statistic without sample relatedness incorporated
AF.Cases: allele frequency of allele 2 in cases
AF.Controls: allele frequency of allele 2 in controls
N.Cases: sample size of cases
N.Controls: sample size of controls
homN_Allele2_cases: counts of allele 2 homozygotes in cases
hetN_Allele2_cases: counts of allele 2 heterozygotes in cases
homN_Allele2_ctrls: counts of allele 2 homozygotes in controls
hetN_Allele2_ctrls: counts of allele 2 heterozygotes in controls
```

## Summary of folders

| Subfolder | Content summary | Subfolder/file | Stats |
| --- | --- | --- | --- |
| `genomic/biallelic` | Genomic data for all masked bi-allelic variants of the joint aggregate. `${chr}=chr1-chr22, chrX` | `bgen/bgen_bychunk/aggCOVID_v4.2_aggV2_${chunk}_finalmerge_nodups.{bgen,bgen.bgi,sample}` `bgen/bgen_mergedbychr/aggCOVID_v4.2_aggV2_${chr}_finalmerge_nodups.{bgen,bgen.bgi,sample}` `pgen/pgen_mergedbychr/aggCOVID_v4.2_aggV2_${chr}_finalmerge_nodups.{pgen,pvar,psam}` | N\_variants= 495,784,356 N\_samples= 86,846 |
| `genomic/multiallelic/` | Genomic data for masked multiallelic variants with MAF > 0.1% in both aggV2 and aggCOVID\_v4.2. `${chr}=chr1-chr22, chrX` | `bgen/bgen_bychunk/aggCOVID_v4.2_aggV2_${chunk}_intersect_multiallelics.{bgen,bgen.bgi,sample}` `bgen/bgen_mergedbychr/aggCOVID_v4.2_aggV2_${chr}_intersect_multiallelics.{bgen,bgen.bgi,sample}` `pgen/pgen_mergedbychr/aggCOVID_v4.2_aggV2_${chr}_intersect_multiallelics.{pgen,pvar,psam}` | N\_variants= 6,036,414 N\_samples= 86,846 |
| `HQ_SNPs/` | Genomic data for high-quality independent SNPs | `aggCOVID_v4.2_aggV2_HQSNPs_common.{bed,fam,bim}` | N\_variants= 58,925 N\_samples=86,846 |
| `GRM/GCTA/` | Dense and sparse genetic relatedness matrices (GRM) generated with GCTA | `aggCOVID_v4.2_aggV2_HQSNPs_common.grm.{bin, N.bin ,id}` `aggCOVID_v4.2_aggV2_HQSNPs_common_sparse0.05.grm.{sp, id}` | N\_samples=86,846 |
| `relatedness/` | Unrelated sets of individuals. Files without prefix "optim" do not take into account COVID-19 status when creating related and unrelated sets of individuals. File with prefix "optim" was used in the primary GWAS analysis and preferentially retained individuals that were COVID-19 severe or mild from related pairs with 100K participants. | `aggCOVID_v4.2_aggV2_unrelatedset.id` `aggCOVID_v4.2_aggV2_relatedset.id` `aggCOVID_v4.2_aggV2_optim_unrelatedset.id` | N\_unrel=65,060 N\_rel=21,786 N\_optim\_unrel=65,025 |
| `PCA/` | Principal components calculated per genetically-inferred ancestry. `${pop}=ALL, AFR, AMR, EAS, EUR, SAS` | `aggCOVID_v4.2_aggV2_${pop}.proj.eigenvec` | N\_ALL=86,846 N\_AFR=2,484 N\_AMR=312 N\_EAS=827 N\_EUR=68,559 N\_SAS=8,109 |
| `ancestry/` | Ancestry probabilities and assigned ancestry for participants | `aggCOVID_v4.2_aggV2_predanc.txt` | N\_samples= 86,846 |
| `GWAS/phenofiles/` | Phenotype files with covariates used for the main GWAS analyses. `${pop}=AFR, EAS, EUR, SAS` | `aggCOVID_v4.2_aggV2_anc${pop}_sev_vs_mld_aggV2_unreloptim.pheno` | AFR: N\_case=440; N\_control=1,350 EAS: N\_case=274; N\_control=366 : N\_case=5989; N\_control=42,891 SAS: N\_case=788; N\_control=3,793 |
| `GWAS/control_control_AF_filter/` | Allele frequency comparison for a smaller set of samples that were processed with both Genomics England pipeline 2.0 and Illumina NSV4 across all variants that segregate in both datasets. `${pop}=AFR, EAS, EUR, SAS` | `aggCOVID_v4.2_aggV2_AFfilter_gel2_nsv4_${pop}.txt` | AFR: N\_samples=354; N\_var=33,232,684 EAS: N\_samples=81; N\_var=11,682,778 EUR: N\_samples=3,157;N\_var=55,187,051 SAS: N\_samples=373; N\_var=24,913,384 |
| `GWAS/summaries/` | GWAS summary statistics from analysis using SAIGE and the meta-analysed statistics using METAL. `${pop}=AFR, EAS, EUR, SAS` | `aggCOVID_v4.2_aggV2_${pop}_sev_vs_mld_aggV2_unreloptim_bimulti_AFcontrolcontrol0.01_allvariants_nodups.txt` `gwas.meta.genomicc.final.txt` | META: Nvar=8,121,396 AFR: Nvar=15,012,409 EAS: Nvar=6,000,811 EUR: Nvar=8,121,457 SAS: Nvar=9,092,222 |
| `GWAS/genomic_data_subset/` | Subset of genomic data split by genetically inferred ancestry only for variants and individuals (post sample-QC, unrelated) included in the per-ancestry GWAS analysis. Useful for downstream analyses that couple genomic data with GWAS summaries such as fine-mapping. `${pop}=AFR, EAS, EUR, SAS` `${chr}=chr1-chr22, chrX` | `plink/merged_bychr/aggCOVID_v4.2_aggV2_${chr}_finalmerge_nodups_${pop}.{bed,fam,bim}` `plink/whole_genome_merged/aggCOVID_v4.2_aggV2_finalmerge_nodups_${pop}.{bed,fam,bim}` `vcf/merged_bychr` `aggCOVID_v4.2_aggV2_${chr}_finalmerge_nodups_${pop}.{vcf.gz,vcf.gz.tbi}` | N\_AFR=1,790 N\_EAS=640 N\_EUR=48,880 N\_SAS=4,581 |
| `GWAS/finemapping/` | Results from fine-mapping GWAS hits for EUR and SAS summaries as .txt file, R-objects and .png plots are provided | `susieR_results/EUR/aggCOVID_v4.2_aggV2_EUR_sev_vs_mld_aggV2_${sentinel_variant}.{txt,Rdata,png}` `susieR_results/SAS/aggCOVID_v4.2_aggV2_SAS_sev_vs_mld_aggV2_${sentinel_variant}.{txt,Rdata,png}` | 17 fine-mapped regions for EUR and one for SAS |
| `TWAS/summaries` | Results from TWAS analysis using GTEX\_V8 pre-trained models for Lung, whole blood, meta-analysis using eQTL models across tissues, meta-analysis using sQTL models across tissues | `twas_Lung.csv` `twas_Whole_Blood.csv`<br`metatwas.csv` `metatwas_sqtl_genomicc.txt` | Nvar\_lung=12,485 Nvar\_Whole\_blood=10,473 Nvar\_metatwas=21,813 Nvar\_metatwas\_sqtl=117,610 |
| `TWAS/coloc` | Colocalisation results using GTEX\_V8 lung, whole blood and eqtlgen data. | `coloc_gtexv8_eqtl_lung.txt` `coloc_gtexv8_eqtl_whole_blood.txt` `coloc_eQTLGen.txt` | 71 loci in all files |
| `HLA/` | HLA calls from HIBAG-HLA caller and HLA association summary statistics | `hibag_vcf_all_aggCOVID_v4.2_aggV2_probthres_0.5.vcf.gz` `hibag_vcf_all_aggCOVID_v4.2_aggV2_probthres_0.5.vcf.gz.csi` `hibag_tsv_all_aggCOVID_v4.2_aggV2.tsv` `aggCOVID_v4.2_aggV2_sev_vs_mld_aggV2_EUR_unrelated_masked_manual_hibag_probthres_0.5_rerun.SAIGE.gwas.txt` |  |

October 24, 2024
