---
title: 'Detailed methods as provided by Illumina - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/aggv3_detailed_methods/
scraped_at: 2026-05-04T06:31:07Z
summary: "GEL small variant calls for 138,406 WGS samples using DRAGEN MLR, IGG, and Annotation pipelines on hg38 via ICA cloud."
---

# Detailed methods as provided by Illumina

This release of the GEL small variant joint analysis includes 138,406 whole genome sequencing samples. The small variants are called using DRAGEN Germline Variant Calling (VC) Pipeline (v3.7.8) with reference genome hg38, recalibrated using DRAGEN Machine Learning Recalibration (MLR) pipeline (v4.2.4), and aggregated using DRAGEN IterativegVCF Genotyper (IGG) pipeline (v4.3.7), and annotated using DRAGEN Illumina Connected Annotation (DRAGEN Annotation) pipeline (v3.24). All analyses are performed on Illumina Connected Analytics (ICA) cloud platform. Analysis jobs are submitted and managed using PopGen CLI (v2.1). The data analysis pipelines are the same as those used for DRAGEN joint analysis of UK BioBank 500K WGS samples. Among 138,406 samples, 138,399 are GEL samples, and 7 samples are from Genome-In-A-Bottle (GIAB) data set for which the truth genotype data are publicly available and are included for quality validation purposes. In total, there are 67,025 male samples, 71,381 female samples. The gender information is based on DRAGEN germline VC ploidy estimation.

## Data analysis stages

The joint analysis consists of two stages. In the first stage, to improve variant calling quality, DRAGEN MLR pipeline is performed at sample level to recalibrate the variant quality (QUAL and GQ). The input of MLR pipeline is the per-sample gVCF file and BAM file, both generated from DRAGEN VC. The output of MLR pipeline is the recalibrated per-sample gVCF file.

In the second stage, the ML recalibrated gVCF files of 138,406 WGS samples are aggregated using DRAGEN IGG pipeline. Variants with recalibrated variant quality QUAL less than 3.0 are filtered before the aggregation. The aggregation process contains four steps.

1. Aggregation of gVCFs into customised data format (cohort and census). This step is performed in parallel per batch of samples, and per shard of genomic regions. Each batch contains a maximum of 1000 samples, and [each shard is about 30Mbp](../aggv3_shard_lookup/) (in total 102 shards covering autosomes, sex chromosomes, mitochondria, and ALT contigs). 138,406 samples are split into 140 batches (one batch with seven GIAB samples, and 139 batches with 138,399 GEL samples).
2. Aggregation of batch census files into global census files. This step is performed in parallel per shard of genomic regions. In addition to global census files, it also generates site level VCFs (first 8 columns of multiallelic VCF), and variant level annotation JSON files from DRAGEN Annotation pipeline. The annotation includes Illumina AI-based functional annotations such as SpliceAI, PrimateAI-3D, which are important in GWAS and rare variant burden tests. This step and following steps are done across all 140 batches.
3. Generation of multi-sample VCF (msVCF), cohort level ML filtering and PLINK binary genotype files (PGEN, PVAR and PSAM). This step is performed in parallel per subshard of genomic regions. In total, there are 4,169 subshards with variants, and each subshard containing a maximum of 216,753 variant sites. Note that shard 16 covers the end of chromosome 2, so it contains no variant site hence no subshard. To scale with increasingly large number of samples, dynamic subsharding scheme is utilised (as opposed to fixed-size subsharding), with the maximum number of variant sites per subshard inversely scaling with the number of samples. In each subshard:
   1. DRAGEN IGG first generates full msVCF with multiallelic ALT alleles, and with samples from all the batches, and full sample level metrics (see Excel Sheet âVCF Formatâ). Accordingly, the site level VCF of full msVCF is also generated.
   2. Then DRAGEN cohort level ML filtering is performed, with the full msVCF as input, and generates postprocessed biallelic msVCF with genotype (GT) as the sample level metrics. During this process, multiallelic ALT alleles are split into bi-allelic ones, and multiallelic genotypes are adjusted accordingly into biallelic genotypes. For each bi-allelic ALT allele, a filter value is set. For variants with genotyping rate less than 90%, the FILTER is set as LowGTR, and QUAL=0. For variants with genotyping rate greater than 90%, the cohort level ML filtering is performed, based on genotyping rate, genotyping quality from all samples. The cohort level ML filtering calculates a ML Site Quality (MLSQ) and set as QUAL. The MLSQ ranges between 0 and 100, and it is not calibrated in Phredscale. For sites with QUAL>=0.1, the FILTER is set as PASS, and otherwise as LowMLSQ. The biallelic msVCF contains both PASS and non-PASS variants and users may choose to keep or filter depending on downstream needs.
   3. Lastly, the postprocessed biallelic msVCF is converted into PLINK2 genotype format (PGEN, PVAR and PSAM files) using PLINK2 (v2.00a6LM 18 Mar 2024).
4. Concatenation of subshard output into chromosomal-level output data. This step is performed in parallel per chromosome and per output file type. There are 26 chromosomal contigs: autosomes (#1-#22), sex chromosomes (#23, #24), mitochondria (#25), 3341 ALT contigs (#26). For each chromosome, the concatenated files include the following final output data from DRAGEN IGG pipeline (included in the joint analysis release bundle).
   1. postprocessed msVCF (biallelic)
   2. PLINK2 PGEN/PVAR/PSAM files (biallelic)
   3. site VCF of postprocessed msVCF (biallelic)
   4. site VCF of full msVCF (multiallelic)[1](#fn:1)
   5. variant level annotation JSON file (multiallelic)

---

1. The full msVCFs (multiallelic) are not concatenated per chromosome, due to output file size. They are available in the release bundle in the per subshard folder.Â [â©](#fnref:1 "Jump back to footnote 1 in the text")

March 26, 2026
