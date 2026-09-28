---
title: 'De novo data FAQs - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/de_novo_faqs/
scraped_at: 2026-05-04T06:32:01Z
---

# De novo data FAQs

## What version of the Platypus bayesiandenovofilter.py script was used?

Â The commit version used for the [PlatypusÂ bayesiandenovofilter.py](https://github.com/andyrimmer/Platypus/blob/master/extensions/DeNovo/bayesianDeNovoFilter.py) python script:Â 414ca566f8b2269d0caae726b21f87e03783ca1a (latest at time of analysis).

## How does the DNV annotation strategyÂ here differ from how DNVs are tiered in Genomics England Rare Disease Interpretation Pipeline?

Â There are slight differences in how DNVs are tiered in the InterpretationÂ Pipeline (see theÂ [Rare Disease Results Guide](../further_reading/)), which are summarisedÂ here:Â

- Maximum fraction of reads supporting the alternate allele in a parent is 3%
- Minimum fraction of reads supporting the alternate allele in child is 10%
- At least two reads must support the alternate allele in the child
- The posterior probability that the variant is de novo exceeds 50%

This may lead to discrepancies in the tiered variants observed in the *tiering\_data* LabKey table. Note that the gene panels applied to the family will determine the tier.Â

## How were variants genomically annotated in the DNV dataset?

Â All variants in the annotated multi-sample VCFs were genomically annotated using Ensembl [Variant Effect Predictor](https://www.ensembl.org/info/docs/tools/vep/index.html) (VEP) version 98. A FASTA file per genome assembly was provided to allow for HGVS annotations. Variants were annotated using the \_--everythingÂ \_flag. An additional custom VCF from Clinvar (version 20191105) was used for detailed Clinvar annotation.Â

## Why is there no genomic annotation of variants in the LabKey table denovo\_flagged\_variants?

Â There is no genomic annotation in theÂ *denovo\_flagged\_variants* LabKey table because variant annotation leads to large amount of row duplication in tables. This is because each variant is annotated against every transcript of the effect gene. Therefore a single variant will be represented on many rows (perhaps more than 10). As theÂ *denovo\_flagged\_variants* table is already large, it would not have been feasible to do. The full, comprehensive annotation can be found in the annotated multi-sample VCFs as described as queried by using the example scrips in the Code Book.Â

## Why isn't my family of interest included in the DNV dataset?

Â This is likely to be because at the time of generating the dataset, the family had not yet successfully run through the Rare Disease Interpretation Pipeline. Only families that have run through the pipeline are considered for DNV analysis as these families have passed the relevant genomic vs reported checks (including Mendelian inconsistencies, identity by descent, reported vs genetic sex checks). The DNV dataset will be updated to include these families when they have run through the pipeline.Â

## Why is my putative de novo variant not in the single sample VCF file for my sample of interest?

Â It is key to remember that the variants in this dataset are called by the Platypus Variant caller and not theÂ Starling small variant caller by Illumina. The genomes in the folder /genomes/by\_date/... are called by the Illumina Starling variant caller which may explain why certain variants are not identical between callers.Â We plan to make available all of the multi-sample Platypus VCFs joint-called by family in the Research Environment as soon as possible.Â

## Why do we not have Bayes Factors available for certain variants of multiplex families?

Â Please see the description below explaining why the Bayes Factor is nullified for a subset of variants found in families containing nested trios. These variants are flagged using the *multidenovo\_filter*.Â

## Why do I see a warning from bcftools about the GL field?

Â You can ignore the warning below, it has no effect on the query. It is a carry over from the original Platypus variant calls.Â

`[W::bcf_hdr_check_sanity] GL should be declared as Number=G`

## How do I know the order of the samples in the multi-sample VCF?

Â The samples in the multi-sample VCF are not always in the same order (i.e. not standardised in the order of Father, Mother, Offspring). The two files shown below show the order of the samples within the VCFs:

```
/gel_data_resources/main_programme/denovo_variant_dataset/GRCh37/20200326/vcf_order/sample_order_in_vcf_grch37.tsv
/gel_data_resources/main_programme/denovo_variant_dataset/GRCh38/20200326/vcf_order/sample_order_in_vcf_grch38.tsv
```

These tell you the VCF filename, the sample IDs in each VCF, the pedigree (offspring, mother, father), and the position of the sample in the VCF (1, 2, 3, n).

You can use these files alongside bcftools to reorder the VCFs before you do any processing, such as as example for a single VCF below:

`bcftools view -s $(grep 00003-RTD_10028.denovo.reheader.vcf.gz ../vcf_order/sample_order_in_vcf_grch38.tsv | sort -k3 | cut -f 2 | paste -sd ",") 00003-RTD_10028.denovo.reheader.vcf.gz`

This will rearrange the VCF so that the samples are always ordered by Father, Mother, Offspring. Remember that for families with nested trios this is slightly more complicated â as they have multiple offspring.

## Variant representation in families with nested trios and the *multidenovo\_filter*

Â For families containing nested trios, theÂ [PlatypusÂ bayesiandenovofilter.py](https://github.com/andyrimmer/Platypus/blob/master/extensions/DeNovo/bayesianDeNovoFilter.py)Â writes a separate line for eachÂ Mendelian inconsistency *per trio.* Therefore, duplicate variant lines exist in the original output VCF from theÂ [bayesiandenovofilter.py](https://github.com/andyrimmer/Platypus/blob/master/extensions/DeNovo/bayesianDeNovoFilter.py)Â script if the same Mendelian inconsistency is identified in more than one trio. This causes issues for the Bayes Factor as this is written to the INFO filed of the VCF which is associated with the ***variant*** and not the ***sample***. Due to this, it is not possible to attribute the correct Bayes Factor value in the INFO field to the correct sample in the FORMAT field.

For these duplicate lines - caused by an identicalÂ Mendelian inconsistency identified within more than one trio of the same family - we nullify the Bayes Factor value within the INFO field ("."). This is so that the Bayes Factor is not associated with the incorrect sample. These variants are also flagged with theÂ *multidenovo\_filter* in the INFO field (0: multidenovo; 1: not multidenovo). In the annotated multi-sample VCFs, we also remove redundant duplicate variant lines that are written by theÂ [bayesiandenovofilter.py](https://github.com/andyrimmer/Platypus/blob/master/extensions/DeNovo/bayesianDeNovoFilter.py)Â script.Â

Note that simple trio families are not affected by this complication.Â

The Bayes Factor for the families with nested trios can be manually calculated easily using the log in theÂ [PlatypusÂ bayesiandenovofilter.py](https://github.com/andyrimmer/Platypus/blob/master/extensions/DeNovo/bayesianDeNovoFilter.py)Â scriptÂ ([lines 474-497](https://github.com/andyrimmer/Platypus/blob/master/extensions/DeNovo/bayesianDeNovoFilter.py#L474-L497)) which uses the GL field from the FORMAT attribute (Genotype log10-likelihoods for AA,AB and BB genotypes, where A = reference allele and B = alternative allele). As stated, the Bayes Factor is not used as a filter in the DNV dataset.Â

## Recoding of genotypes on the X-chromosome

Â In the original Platypus multi-sample VCF called by family (**Step 3**), variants on the X-chromosome are called as diploid (0/0, 0/1, 1,1) across the entire chromosome - regardless of if the variant is in the PAR or non-PAR. The [bayesianDeNovoFilter.py](http://platypus%20bayesiandenovofilter.py/) python script then recodes these genotypes as haploid (0, 1) if:

- the variant is on the X-chromosome (either PAR or non-PAR)
- the sample is male (offspring or father)
- the genotype log10-likelihood for the BB genotype (1/1) is greater than the genotype log10-likelihood for the AA genotype (0/0).

This logic can can be seen in [lines 187-213](https://github.com/andyrimmer/Platypus/blob/master/extensions/DeNovo/bayesianDeNovoFilter.py#L187-L213).Â If these criteria are met, then the variant is translated from diploid (0/1, 1,1) to haploid (1). If these criteria are not met, the variant is translated in from diploid (0/1, 1,1) to haploid (0). Note that the PARs are not differentiated in the [bayesianDeNovoFilter.py](https://github.com/andyrimmer/Platypus/blob/master/extensions/DeNovo/bayesianDeNovoFilter.p) python script (PARs for males on the X-chromosome should be diploid). Genotypes are only recoded for males on the X-chromosome. This explains the logic used in the *zygosity\_filter* for males on the X-chromosome in the PAR and non-PAR.

## Pseudo-autosomal region

Â TheÂ [PlatypusÂ bayesiandenovofilter.py](https://github.com/andyrimmer/Platypus/blob/master/extensions/DeNovo/bayesianDeNovoFilter.py)Â script is not fully configured to discriminate variants in the PAR and non-PAR. In the script, the ploidy is set in [lines 47-69](https://github.com/andyrimmer/Platypus/blob/master/extensions/DeNovo/bayesianDeNovoFilter.py#L47-L69). As is shown, for males on the X-chromosome, all variants are treated as haploid. Please consider this when attempting to analyse variants on the X-chromosome PARs for males.Â

October 24, 2024
