---
title: 'Somatic aggregated variant call (somAgg v0.2 [ALPHA version]) - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/somAgg/
scraped_at: 2026-05-04T06:34:48Z
---

# Somatic aggregated variant call (somAgg v0.2 [ALPHA version])

SomAgg is an aggregate of a large number of somatic VCFs. It was made from release 12 of the 100kGP project and comprises somatic genomic data fromÂ **16,341** tumour samples. These were all the consented somatic genomes that were aligned to GRCh38 and passed quality control available in release 12.

> **Note:**
>
> This aggregate dataset contains information on a subset of participants who have since been withdrawn from research. **Their use in any new analyses is not permitted**. Thus, it is **extremely** important to remove these samples from your analyses and ensure that you are only using samples included in the latest data release.
>
> The list of samples for the consented participants can be found in the `tumour_sample_platekey` column of the `cancer_analysis` table in LabKey, for the latest data release. There is also a current samples file available in `/gel_data_resources/main_programme/aggregation/aggregated_somatic_strelka/somAgg/v0.2/docs/`.
>
> To filter the aggregate to these samples, all bcftools commands should include the flag `-S /gel_data_resources/main_programme/aggregation/aggregated_somatic_strelka/somAgg/v0.2/docs/<nameofcurrentfile>`.
>
> Submit a ticket to the [Genomics England Service desk](https://www.genomicsengland.co.uk/service-desk) if you are unsure of how to filter the dataset for any other use.

## Description

We have aggregatedÂ **16,341**Â somatic vcf filesÂ from the 100,000 Genomes Project which we made available as a multi-sample VCF dataset (somAgg). somAgg comprises overÂ **573 million**Â annotated single nucleotide variants and small indels (â¤50bp) from quality controlled tumour whole genomes. For a breakdown of variants per chunk see [here](../somAgg_variant_counts/).

All samples in the datasetÂ have a matched germline, both deep whole-genome sequenced with an average coverage of 100x and 30x, respectively. All samplesÂ were sequenced with 150bp paired-end reads in a single lane of an Illumina HiSeq X instrument and uniformly processed on the Illumina North Star Version 4 Whole Genome Sequencing Workflow (NSV4, version 2.6.53.23); which comprises theÂ [iSAAC Aligner](https://europepmc.org/article/MED/23736529)Â (version 03.16.02.19) andÂ small variant calling using tumour-normal subtraction performed byÂ [Strelka2](https://europepmc.org/article/MED/30013048) (version 2.4.7). Samples were aligned to the *Homo sapiens* NCBI GRCh38 assembly with decoys.Â

The dataset was constructed from the aggregation of single-sample annotated somatic vcf files usingÂ [bcftools](https://samtools.github.io/bcftools/bcftools.html)Â (version:Â 2019.02.26). Variant normalisation and decomposition was implemented byÂ [vt](https://europepmc.org/article/MED/25701572/) (version 0.57721). Annotation was performed byÂ Cellbase against the Ensembl (version 90/GRCh38), COSMIC (version v86/GRCh38) and ClinVar (October 2018 release) databases.

The site QC annotation of the somAgg has been obtained from the single sample annotated VCFs.Â No additional site QC has beenÂ conducted and all samples in the *cancer\_analysis* table have been included (i.e. no sample QC/filtering was conducted).Â

TheÂ multi-sample VCF is split into **1,371**Â roughly equal chunks across the genome for faster processing. Each chunk contains the full set of samples and is in the VCF.gz file format with accompanying tabix index files (.tbi). Chromosomes 1-22, X, Y, and M are included.Â

### The usage of GT

In the somatic aggregated files there are only two possible GT values:

- 0/1 indicating that sample is a carrier of the variant
- 0/0 indicating that sample does not carry the variant

All variants are in their bi-allelic forms (instead of potential multiallelic) and samples that have multiallelic sites are indicated by the FORMAT tag: `SAMPLE_MULTIALLELIC` (See Genotype-level MetricsÂ for further details on `SAMPLE_MULTIALLELIC`).Â

#### Definitions

- *Multi-allelic:*Â where a single variant contains *three* or more observed alleles, counting the reference as one, therefore allowing for two or more variant alleles (heterozygous genotype example: 1/2)
- *Bi-allelic:*Â where a variant contains *two* observed alleles, counting the reference as one, and therefore allowing for one variant allele (heterozygous genotypes are always: 0/1)

### Extended details

Each step of the pipeline to generate somAgg is documented in the sections below:Â

- [Sample Stats](../somAgg_sample_stats/)
- [Variants per chunk](../somAgg_variant_counts/)
- [VCF Aggregation](../somAgg_VCF_aggregation/)

### Code book

A code book of popular queries to help you use somAgg is found here:Â Â [somAgg Code Book](../somAgg_code_book/)

## somAgg manifest and location

### Manifest

The somAgg dataset comprises aÂ multi-sample VCF file for each chunk containing the genotypes and per variant quality metrics and filter flags

### Location

All somAgg (v0.2) outputs can be found in the following folder within the Genomics England Research Environment:Â

`/gel_data_resources/main_programme/aggregation/aggregated_somatic_strelka/somAgg/v0.2/`

This folder is accessible from the Desktop Environment and from the HPC as shown below:

Desktop:

HPC:

## Overview of quality control flags

Variants in theÂ multi-sample VCF files are *flagged* against this set of basic site quality metrics. Hard variantÂ *filtering* has **not** been applied to the dataset (no variants have been removed).Â

For more information on the Strelka flags, please refer to their manual onÂ [GitHub](https://github.com/Illumina/strelka/tree/v2.9.x/docs/userGuide).

### Sample QC

All 16,341 samples included in somAgg have successfully passed our internal sequencing and interpretation pipeline. These samples are listed in the LabKey table *cancer\_analysis*. Some quality control statistics for these samples are provided below.

| Sample Attribute | Description |
| --- | --- |
| Tumour Cross-Contamination | less than 5% |
| Germline Cross-Contamination | less than 3% |
| Median Fragment Size | greater than 279bp |
| Excess of Chimeric Reads | mean of 0.3% |
| Percentage ofÂ SomaticÂ Mapped Reads | mean of 93.4% |
| Percentage AT Dropout | mean of 3.1% |

### Single sample Genomics England filters

On the single sample VCF level (somAgg input), Genomics England has defined extra FILTERs that are described here. In the single VCF file, a variant is only flagged with PASS after having passed all Strelka and the filters listed below.

#### BCNoise10Indel

Applied to indels only. It aims to flag calls with too many filtered basecalls. More specifically, a variant is flagged if the average fraction of filtered basecalls within 50 bases of the indel exceeds 0.1, i.e. FDP50/DP50 > 0.1.

#### PONnoise50SNV

Applied to SNVs only. It aims to flags variants in a region of mapping/sequencing error. More specifically, a variant is flaggedÂ if SomaticFisherPhred is below 50, indicating somatic SNV is systematic mapping/sequencing error. Different from other filters, this filter is only applied to variants that pass all Strelka filters.

#### SimpleRepeat

Applied to both SNVs and indels. It aims to flagÂ variantsÂ that overlap a repetitive regions, sinceÂ these are prone to error. More specifically, a variant is flagged if overlapping simple repeats as defined by [Tandem Repeats Finder](http://hgdownload.cse.ucsc.edu/goldenPath/hg38/database/simpleRepeat.txt.gz).

#### CommonGnomADVariant

Applied to both SNVs and indels. It aims to flagÂ variants commonly found in germline, assuming these are not cancer relevant.Â More specifically, a variant is flagged ifÂ its population germline allele frequency is above 1% in gnomAD dataset.

#### CommonGermlineVariant

Applied to both SNVs and indels. It aims to flagÂ variants commonly found in germline, assuming these are not cancer relevant.Â More specifically, a variant is flagged ifÂ its population germline allele frequency is above 1% in a Genomics England sub-cohort.

The cohort that was used to generate thisÂ GermlineÂ allele frequencies can be found on:

> **CGV:**
>
> `vi /gel_data_resources/interpretation_support_data/cancer/CommonGermlineVariant/agg_samples.non_genetic.tsv`

Note however, that a few samples have been analysed with previous versions of this cohort, and hence some inconsistency has been carried over to the somAgg.Â

#### RecurrentSomaticVariant

Applied to both SNVs and indels. It aims to flagÂ variants commonly found inÂ theÂ somatic samples. More specifically, a variant is flagged asÂ recurrent somatic variant if its frequency is above 5% in a Genomics England cohort. This cohort is made ofÂ 910 FF-PCRfree,Â 128 FF-nano andÂ 232 FFPE samples. AF are calculated individually and if AF > 0.05 in any of these three cohorts variants were flagged. This flag resulted from a study that showed that there was an increased number of small variants in FFPE. Also, AF is defined assumingÂ diploid and variant frequency (VF) = 2 \* AF.

The file with the resulting AFÂ that were used forÂ annotation can be found here:

> **CGV:**
>
> `vi /gel_data_resources/interpretation_support_data/cancer/RecurrantSomaticVariant/cancer_mainProgram_2017.merged.AF.sorted.vcf.gz`

### Variant- and genotype- level flags (FILTER)

The **FILTER** field has not been populated in this version of the aggregate. Hence, all variants have FILTER "." in the respective field of the aggregate VCF. All filter flags of the individual annotated VCF files have been moved to the INFO or FORMAT fields in the aggregate. Variant-level flags have been moved to the INFO field of the aggregate. Genotype-level flags have been kept in the FORMAT field of the aggregate. Note that no variants have been filtered out on the basis of these filters in this version of the aggregate.

Filter flags are marked in purple on the Variant- and Genotype- level metrics and flags below.

### Variant-level metrics (*INFO*)

Per variant quality metrics are kept in the ***INFO*** field of theÂ multi-sample VCF files. The *INFO* tags with descriptions are shown in the table below.Â Note that the source column in the table indicates if the TAG is generated by the variant caller (Strelka), has been added as part of Genomics England sequencing and interpretation pipeline (internal) or as part of post-processing/annotation specifically for the aggregate.

| INFO TAG | SNV/indel | Source | Description |
| --- | --- | --- | --- |
| RepetitiveRegion | SNV | Strelka | filter flag:Â variants that overlap LINE repeat region[1](#fn:3) |
| CommonGermlineVariant | both | Internal | filter flag: variants with a population germline allele frequency above 1% in a Genomics England sub-cohort |
| RecurrentSomaticVariant | both | Internal | filter flag: recurrent somatic variants with frequency above 5% in a Genomics England cohort |
| SimpleRepeat | both | Internal | filter flag: variants overlapping simple repeats as defined by [Tandem Repeats Finder](http://hgdownload.cse.ucsc.edu/goldenPath/hg38/database/simpleRepeat.txt.gz) |
| CommonGnomADVariant | both | Internal | filter flag: variants with a population germline allele frequency above 1% in gnomAD dataset |
| IC | indel | Strelka | Number of times RU repeats in the indel allele.Â (IndelÂ Counts of RU) |
| IHP | indel | Strelka | Largest reference interrupted homopolymer length intersecting with the indel |
| PNOISE | SNV | Strelka | Fraction of panel containing non-reference noise at this site |
| PNOISE2 | SNV | Strelka | Fraction of panel containing more than one non-reference noise obs at this site |
| RC | indel | Strelka | Number of times RU repeats in the reference allele. (Reference Counts of RU) |
| RU | indel | Strelka | Smallest Repeating sequence Unit in inserted or deleted sequence |
| AF1000G | - | Strelka | The allele frequency from all populations ofÂ  the 1000 genomes projected |
| AA | - | Strelka | The inferred allele ancestral (if determined) to the chimpanzee/human lineage |
| GMAF | - | Strelka | Global minor allele frequency (GMAF); technically, the frequency of the second most frequent allele Format: GlobalMinorAllele|AlleleFreqGlobalMinor |
| cosmic | - | Strelka | The numeric identifier for the variant in the Catalogue of Somatic Mutations in Cancer (COSMIC) database Format: GenotypeIndex|Significance |
| clinvar | - | Strelka | Clinical significance Format: GenotypeIndex|Significance |
| EVS | - | Strelka | Allele frequency, coverage and sample count taken from the Exome Variant Server (EVS) Format: AlleleFreqEVS|EVSCoverage |
| RefMinor | - | Strelka | Denotes positions where the reference base is a minor allele and is annotated as though it were a variant |
| phyloP | - | Strelka | PhyloP conservation score. Denotes how conserved the reference sequence is between species throughout evolution |
| CSQT | - | Strelka | Consequence type as predicted by the Illumina Annotation Engine (IAE). Format: GenotypeIndex|HGNC|Transcript ID|Consequence |
| CSQR | - | Strelka | Predicted regulatory consequence type. Format: GenotypeIndex|RegulatoryID|Consequence |
| CT | - | Internal | Consequence type as predicted by CellBase |
| AF\_GNOMAD | - | Internal | Allele frequency from all populations of gnomAD genome data set |
| AF\_GEL\_GL | - | Internal | Allele frequency from the Genomics England germline cohort |
| AN\_GEL\_GL | - | Internal | Total number of alleles in called genotypes from Genomics England germline cohort |
| AC\_GEL\_GL | - | Internal | Allele count in genotypes from Genomics England germline cohort |
| AF\_GEL\_SOM\_FFpcrfree | - | Internal | Alternate Allele Frequency in the Genomics England FFpcrfree cohort |
| AF\_GEL\_SOM\_FFnano | - | Internal | Alternate Allele Frequency in the Genomics England FFnano cohort |
| AF\_GEL\_SOM\_FFPE | - | Internal | Alternate Allele Frequency in the Genomics England FFPE cohort |
| HomopolimerIndel | - | Strelka | Indels intersecting with reference homopolymers of at least eight nucleotides |
| SegmentalDuplication | - | Strelka | Variants intersecting with [Segmental Duplications](http://hgdownload.cse.ucsc.edu/goldenPath/hg38/database/genomicSuperDups.txt.gz) |

### Genotype-level metrics (*FORMAT*)

Genotype-level metrics are kept in the ***FORMAT*** field of theÂ multi-sample VCF files. The *FORMAT* tags with descriptions are shown in the table below. Note that the source column below indicates if the TAG is generated by default by the variant caller (Strelka), has been added as part of Genomics England sequencing and interpretation pipeline (internal) or or as part of post-processing/annotation specifically for the aggregate. The SNV/indel column indicates whether the respective *FORMAT* field has been populated for SNPs, indels or both.

| FORMAT TAG | SNV/indel | Source | Description |
| --- | --- | --- | --- |
| PASS | both | Internal | filter flag:Â All internal and Strelka filters passed. Note that all samples had Repetitive Regions Variant-level flag checked for. |
| LowQuality | - | Strelka | filter flag:Â Locus has low support for variant allele, ALT=. |
| BCNoiseIndel | indel | Strelka | filter flag:Â Average fraction of filtered basecalls within 50 bases of the indel exceeds 0.3 |
| HighDepth | indel | Strelka | filter flag:Â Locus depth is greater than 3x the mean chromosome depth in the normal sample |
| LowQscore | SNV | Strelka | filter flag:Â The empirically fitted VQSR score is less than 2.75 |
| QSI\_ref | indel | Strelka | filter flag:Â NormalÂ (germline) sample is not homozygous ref or sindel Q-score < 30, ie calls with NT!=ref or QSI\_NT < 30 |
| BCNoise10Indel | indel | Internal | filter flag: flags if average fraction of filtered basecalls within 50 bases of the indel exceeds 0.1, FDP50/DP50 > 0.1 |
| PONnoise50SNV | SNV | Internal | filter flag: flags if SomaticFisherPhred is below 50, indicating somatic SNV is systematic mapping/sequencing error (applies only to SNVs that pass Strelka filters) |
| AU | SNV | Strelka | Number of 'A' alleles Used in tiers[2](#fn:1) 1,2 |
| CU | SNV | Strelka | Number of 'C' alleles Used in tiers[2](#fn:1) 1,2 |
| DP | both | Strelka | Read depth for tier1 (used+filtered) |
| DP2 | indel | Strelka | Read depth for tier2 |
| DP50 | indel | Strelka | Average tier1 read depth within 50 bases |
| FDP | SNV | Strelka | Number of basecalls filtered from original read depth for tier1 |
| FDP50 | indel | Strelka | Average tier1 number of basecalls filtered from original read depth within 50 bases |
| GU | SNV | Strelka | Number of 'G' alleles Used in tiers[2](#fn:1) 1,2 |
| SDP | SNV | Strelka | Number of reads with deletions spanning this site at tier1 |
| SUBDP | SNV | Strelka | Number of reads below tier1 mapping quality threshold aligned across this site |
| SUBDP50 | indel | Strelka | Average number of reads below tier1 mapping quality threshold aligned across sites within 50 bases |
| TAR | indel | Strelka | Reads strongly supporting alternate allele for tiers 1,2. Note that, according to [this](https://groups.google.com/g/strelka-discuss/c/Pz9EYKnE6u8), alternateÂ allele means the reference allele in addition to any other conflicting/overlapping candidate indel alleles. |
| TIR | indel | Strelka | Reads strongly supporting indel allele for tiers 1,2 |
| TOR | indel | Strelka | Other reads (weak support or insufficient indel breakpoint overlap) for tiers 1,2 |
| TU | SNV | Strelka | Number of 'T' alleles Used in tiers[2](#fn:1) 1,2 |
| GT | both | internal | Genotype, 0/1 for all called variants, i.e. any variant that has been called,Â regardlessÂ ofÂ variant allele frequency or filter flag, has GT=0/1. When a variant has **not** been called in aÂ given sample, GT=0/0Â |
| ALTMAP | SNV | Strelka | Tumor alternate allele read position MAP |
| ALTPOS | SNV | Strelka | Tumor alternate allele read position median |
| cDP | SNV | Strelka | Combined depth across samples |
| MQ | SNV | Strelka | RMS Mapping Quality |
| MQ0 | SNV | Strelka | Number of MAPQ == 0 reads covering this record |
| NT | both | Strelka | Genotype of the normal in all data tiers, as used to classify somatic variants. One of {ref,het,hom,conflict}. |
| OVERLAP | indel | Strelka | Somatic indel possibly overlaps a second indel |
| QSI | indel | Strelka | Quality score for any somatic variant, ie. for the ALT haplotype to be present at a significantly different frequency in the tumor and normal |
| QSI\_NT | indel | Strelka | Quality score reflecting the joint probability of a somatic variant and NT |
| QSS | SNV | Strelka | Quality score for any somatic snv, ie. for the ALT allele to be present at a significantly different frequency in the tumor and normal |
| QSS\_NT | SNV | Strelka | Quality score reflecting the joint probability of a somatic variant and NT |
| ReadPosRankSum | SNV | Strelka | Z-score from Wilcoxon rank sum test of Alt Vs. Ref read-position in the tumor |
| SGT | both | Strelka | Most likely somatic genotype excluding normal noise states |
| SNVSB | SNV | Strelka | Somatic SNV site strand bias |
| TQSI | indel | Strelka | Data tier used to compute QSI |
| TQSI\_NT | indel | Strelka | Data tier used to compute QSI\_NT |
| TQSS | SNV | Strelka | Data tier used to compute QSS |
| TQSS\_NT | SNV | Strelka | Data tier used to compute QSS\_NT |
| VQSR | SNV | Strelka | Recalibrated quality score expressing the phred scaled probability of the somatic call being a FP observation |
| SAMPLE\_MULTIALLELIC | SNV | Internal | Original chr:pos:ref:alt encoding for SNVs |
| SAMPLE\_VARIANT | indel | Internal | Original chr:pos:ref:alt encoding for indels |
| VAF | both | Strelka | Variant allele frequency, SNV: Â VAF = dALT / (dALT + dREF), where dALT and dREF are readÂ depth for tier 1 for ALT and REF respectively, i.e. the tier 1 counts for AU, CU, GU, or TU.[3](#fn:2) indel: VAF = TIR / (TIR + TAR), consideringÂ onlyÂ tier 1Â counts. |
| SomaticFisherPhred | SNV | Internal | Phred score of Fisher's test of somatic allele ratio vs PoN allele ratio (applies only to SNVs that pass Strelka filters) |

## Help and support

> **Note:**
>
> Please reach out via the [Genomics England Service Desk](https://www.genomicsengland.co.uk/service-desk) for any issues related to the somAgg aggregation or companion datasets, including "somAgg" in the title/description of your inquiry.

---

1. Repetitive regions have been introduced when some samples of the 100,000 Genomes Project had already been sequenced and analysed so it is not consistently applied throughout the cohort. You can find the corresponding regions in `/gel_data_resources/cancer_data_files/LINE_repeat_regions/L1P_all_LINE_RepeatMaster_SINE.bed.gz`,Â [â©](#fnref:3 "Jump back to footnote 1 in the text")
2. Strelka tier is not the Genomics England tier: the algorithm divide calls into two tiers according to level of confidence. From the paper: The first tier (tier1) is a set of input data filtration and model parameter settings with relatively stringent values, whereas the second tier (tier2) uses more permissive settings. All calls are initially made using tier1 settings, after which the variant is called again using tier2. Strelka reports the minimum of the two somatic call qualities: Q=min(Qtier1, Qtier2)Â [â©](#fnref:1 "Jump back to footnote 2 in the text")[â©](#fnref2:1 "Jump back to footnote 2 in the text")[â©](#fnref3:1 "Jump back to footnote 2 in the text")[â©](#fnref4:1 "Jump back to footnote 2 in the text")
3. Note that the way VAF is calculated for SNVs, it does not take multiallelic into account. The reason for that is to remove potential noise. However, multiallelic sites may have VAFs whose sum is larger than 1. In the most extreme case, you will have REF completely replaced by the two (or more) possible ALT and each ALT will have VAF = 1.Â [â©](#fnref:2 "Jump back to footnote 3 in the text")

January 19, 2026
