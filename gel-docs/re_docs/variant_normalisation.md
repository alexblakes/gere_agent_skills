---
title: 'AggV2 variant normalisation and representation - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/variant_normalisation/
scraped_at: 2026-05-04T06:34:11Z
---

# AggV2 variant normalisation and representation

Variants in AggV2 were normalised to decompose multiallelic variants, make them parsimonious and left-align indels. We used [vt](https://genome.sph.umich.edu/wiki/Vt)Â (version 0.57721) for this.

## Normalisation procedure

Normalisation consists of:

1. Decomposition
2. Parsimony
3. Left alignment
4. Decomposition of bi-allelic block substitutions (MNPs)

### Decomposition

In the raw VCF output of gVCF genotyper, variants with three or more observed alleles are represented as multiallelic. **WeÂ decompose all multiallelic variants**, so that each variant in aggV2 is represented in its bi-allelic format.Â

- *Multi-allelic:*Â where a single variant containsÂ *three*Â or more observed alleles, counting the reference as one, therefore allowing for two or more variant alleles (heterozygous genotype example: 1/2)
- *Bi-allelic:*Â where a variant containsÂ *two*Â observed alleles, counting the reference as one, and therefore allowing for one variant allele (heterozygous genotypes are always: 0/1)

In variants that are decomposed,Â the INFO field is populated with theÂ ***OLD\_MULTIALLELIC***Â tag which captures the original multiallelic representation of the allele.Â

> **Decomposition example:**
>
> Input:
>
> ```
> chr1 12345678 . T A,G . .
> ```
>
> Decomposed multiallelic variants:
>
> ```
> chr1 12345678 . T A . . OLD_MULTIALLELIC=chr1:12345678:T/A/G
> chr1 12345678 . T G . . OLD_MULTIALLELIC=chr1:12345678:T/A/G
> ```

### Parsimony

A variant is parsimonious if it is represented in as few nucleotides as possible without an allele of length 0.

This step reduces the length of any variants to be parsimonious, while keeping the actual nucleotide change the same.

> **Parsimony example:**
>
> Input:
>
> ```
> chr1 12345678 . TAAA TAA . .
> ```
>
> Parsimonious variant:
>
> ```
> chr1 12345678 . TA T . .
> ```

### Left alignment

A variant is left aligned if it is no longer possible to shift its position to the left while keeping the length of all its alleles constant.

This step shifts all variants to the left.

> **Left aligned example:**
>
> Input:
>
> ```
> chr1 12345678 . AAAA A . .
> ```
>
> Left aligned variant:
>
> ```
> chr1 12345670 . TAAA T . .
> ```

### Decomposition of bi-allelic block substitutions (MNPs)

This step decomposes bi-allelic block substitutions (MNPs - Multi-Nucleotide Polymorphisms) into its constituent SNPs.Â

- *SNP:*Â The reference and alternate sequences are of length 1 and the base nucleotide is different from one another.
- *MNP:*Â The reference and alternate sequences are of the same length and have to be greater than 1 and all nucleotides in the sequences differ from one anotherÂ

SNPs derived from the decomposition of MNPs are flagged with theÂ ***OLD\_CLUMPED***Â tag in the INFO fieldÂ which captures the original MNP representation of the variant.Â

> **Decomposition example:**
>
> Input:
>
> ```
> chr1 12345678 . TA CG . .
> ```
>
> Decomposed biallelic blocks:
>
> ```
> chr1 12345678 . T C . . OLD_CLUMPED=chr1:12345678:TA/CG
> chr1 12345679 . A G . . OLD_CLUMPED=chr1:12345678:TA/CG
> ```

### Code

The code below shows the normalisation procedure applied to each VCF output chunk from the aggregation by gvcf genotyper.Â

```
vt decompose -s ${input} | # Decomposition
vt normalize -n -w 10000 -r ${reference} - | # Parsimony and left alignment
vt decompose_blocksub - # Decomposition of bi-allelic block substitutions
```

## Variant representation

There is no exact solution to variant normalisation and decomposition.Â Many downstream tools rely on variants being represented in their bi-allelic format. Bi-allelic representation also allows forÂ easier allelic comparisons between call sets.Â You should be aware, however, of the implications the decomposition has in handling multiallelic variants, asÂ **partial genotypes** (*e.g.*Â "./0", "./1")Â are generated.Â From vt:Â *Information is generally lost after vertically decomposing a variant, so care should be taken in interpreting the resultant values.*

### Partial genotypes

The normalisation procedure applied by vt decomposes all multiallelic variants into their bi-allelic representations.

Definitions:

- *Multi-allelic:*Â where a single variant contains *three* or more observed alleles, counting the reference as one, therefore allowing for two or more variant alleles (heterozygous genotype example: `1/2`)
- *Bi-allelic:*Â where a variant contains *two* observed alleles, counting the reference as one, and therefore allowing for one variant allele (heterozygous genotypes are always: `0/1`)

Many downstream tools rely on variants being represented in their bi-allelic format. Bi-allelic representation also allows forÂ easier allelic comparisons between call sets.Â

From vt:Â *Information is generally lost after vertically decomposing a variant, so care should be taken in interpreting the resultant values.*

#### The OLD\_MULTIALLELIC INFO tag

Multi-allelic variants that have been decomposed into their bi-allelic representations are identified by theÂ `OLD_MULTIALLELIC` tag in the `INFO` field of aggV2.Â

#### Worked example

Below is a worked example of how multiallelic variants are represented in their bi-allelic format:Â

##### Pre-decomposed (multiallelic representation)

| CHROM | POS | ID | REF | ALT | QUAL | FILTER | INFO | FORMAT | SAMPLE 1 | SAMPLE 2 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| chr1 | 3759889 | . | TA | TAA,TAAA,T | . | PASS | . | GT | `1/2` | `0/0` |

There are four alleles of this variant (including the REF allele). Sample 1 has genotype `1/2` (TAA, TAAA). Sample 2 has genotype `0/0` (TA, TA).

##### Post-decomposition (bi-allelic representation)

| CHROM | POS | ID | REF | ALT | QUAL | FILTER | INFO | FORMAT | SAMPLE 1 | SAMPLE 2 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| chr1 | 3759889 | . | TA | TAA | . | PASS | OLD\_MULTIALLELIC=1:3759889:TA/TAA/TAAA/T | GT | `1/.` | `0/0` |
| chr1 | 3759889 | . | TA | TAAA | . | PASS | OLD\_MULTIALLELIC=1:3759889:TA/TAA/TAAA/T | GT | `./1` | `0/0` |
| chr1 | 3759889 | . | TA | T | . | PASS | OLD\_MULTIALLELIC=1:3759889:TA/TAA/TAAA/T | GT | `./.` | `0/0` |

- The three ALT alleles have been decomposed into three separate lines; where each line represents one of the ALT alleles against the same REF allele.Â
- The `INFO` field is populated with the `OLD_MULTIALLELIC` tag which captures the original multiallelic representation of the allele.
- Partial genotypes are generated for Sample 1 for this variant - who has genotypeÂ TAA, TAAA. This is because:
  - For the first bi-allelic variant (TA, TAA), Sample 1 has the TAA ALT allele but not the TA REF allele (no information present for this allele) - so is therefore represented by the partial genotype: `1/.`
  - For the second bi-allelic variant (TA, TAAA), Sample 1 has the TAAA ALT allele but not the TA REF allele (no information present for this allele) - so is therefore represented by the partial genotype: `./1`
  - For the third bi-allelic variant (TA, T), Sample 1 has **neither** the T ALT allele nor the TA REF allele (no information present for these alleles) - so is therefore represented by the partial genotype: `./.`
- Partial genotypes are not represented for Sample 2 for this variant - who has genotype TA, TA. This is because:
  - For all bi-allelic variants, Sample 2 is homozygous for the TA REF allele - so is always represented by the full genotype: `0/0`

#### FORMAT field inheritance

The per-sample FORMAT tags (for example: `GT`- genotype, `GQ` - genotype quality, `DP` - depth, `AD` - allelic depth, `PL` - genotype likelihoods) are also vertically decomposed and follow two rules:

1. The `GQ` and `DP` tags are always identical for a given genotype when the variant is decomposed
2. The `AD` and `PL` tags are always representative of the two specific alleles per bi-allelic variant

This is shown in the examples below showing a single sample:Â

##### Example 1: he sample is homozygous for the C REF allele for theÂ chr18:7311133:C/A/T variant

- The sample genotype will always be `0/0` for all bi-allelic representations of this variant
- The `GQ` and `DP` tags are identicalÂ for all bi-allelicÂ representations of this variant
- The `AD` and `PL` tagsÂ are identicalÂ for all bi-allelicÂ representations of this variant as no information is lost after decomposition

| Chrom | Pos | Ref | Alt | OLD\_MULTIALLELIC | GT | FT | GQ | GQX | DP | DPF | AD | PL |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| chr18 | 7311133 | C | A | chr18:7311133:C/A/T | 0/0 | . | 56 | . | 27 | 0 | 27,0 | 0,255,255 |
| chr18 | 7311133 | C | T | chr18:7311133:C/A/T | 0/0 | . | 56 | . | 27 | 0 | 27,0 | 0,255,255 |

##### Example 2: the sample is heterozygous (T/C) for theÂ chr18:7365195:T/C/G variant

- The sample genotype is `0/1` for the T/C bi-allelic variant but partial (`0/.`) for the T/G bi-allelic variant as no information is present for the G allele
- The `GQ` and `DP` tags are identicalÂ for all bi-allelicÂ representations of this variant
- The `AD` and `PL` tags are representative of theÂ two specific alleles per bi-allelic variant (no depth in AD for the G allele, and PL set to 255 for the T/G and G/G genotypes)

| Chrom | Pos | Ref | Alt | OLD\_MULTIALLELIC | GT | FT | GQ | GQX | DP | DPF | AD | PL |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| chr18 | 7365195 | T | C | chr18:7365195:T/C/G | 0/1 | PASS | 200 | 46 | 31 | 3 | 14,17 | 232,0,197 |
| chr18 | 7365195 | T | G | chr18:7365195:T/C/G | 0/. | PASS | 200 | 46 | 31 | 3 | 14,0 | 232,255,255 |

##### Example 3: the sample is homozygous (A/A) for the chr18:7403330:G/A/C variant

- The sample genotype is `1/1` for the G/A bi-allelic variant but partial (`./.`) for the G/C bi-allelic variant as no information is present for the G or C allele
- The `GQ` and `DP` tags are identicalÂ for all bi-allelicÂ representations of this variant
- The `AD` and `PL` tags are representative of theÂ two specific alleles per bi-allelic variant (no depth in AD for the G pr C allele, and PL set to 255 for the G/C and C/C genotypes)

| Chrom | Pos | Ref | Alt | OLD\_MULTIALLELIC | GT | FT | GQ | GQX | DP | DPF | AD | PL |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| chr18 | 7403330 | G | A | chr18:7403330:G/A/C | 1/1 | PASS | 30 | 17 | 11 | 0 | 0,11 | 218,33,0 |
| chr18 | 7403330 | G | C | chr18:7403330:G/A/C | ./. | PASS | 30 | 17 | 11 | 0 | 0,0 | 218,255,255 |

#### Summary

- Bi-allelic variants derived from the same multiallelic variant are identified by theÂ `OLD_MULTIALLELIC` tag in the INFO field. The tag is present in all bi-allelic representations of the respective multiallelic variant.
- Vertical decomposition results in partial genotypes:
  - `0/0` sample genotypes will always be decomposed to `0/0` for remaining bi-allelic variants of the sameÂ `OLD_MULTIALLELIC` tag
  - `0/1` sample genotypes will always be decomposed to `0/.` for remaining bi-allelic variants of the sameÂ `OLD_MULTIALLELIC` tag
  - `1/1` sample genotypes will always be decomposed to `./.` for remaining bi-allelic variants of the sameÂ `OLD_MULTIALLELIC` tag
- The `GQ` and `DP` tags are always identical for a given genotype when the variant is decomposed; whereas theÂ `AD` and `PL` tags are always representative of the two specific alleles per bi-allelic variant

If deemed absolutely necessary, you mayÂ want to post-process the partial genotypes like `1/`. to the best guess genotype based on the PL values andÂ recompute fields that involves alleles after decomposition.Â

### Variant duplication andÂ multi-nucleotide polymorphisms (MNPs)

A duplicated variant is a variant line with the same CHROM, POS, REF, and ALT that is represented more than once in aggV2. It was estimated that approximatelyÂ **0.02%**Â of the variants in the dataset are formed of duplicated variants.

There is no exact solution to this issue and it is important to handle duplicated variants with care as their allele frequencies might be affected.Â

Duplications arise from the decomposition of MNPs (Multi-Nucleotide Polymorphisms) into their constitutive SNP (Single-Nucleotide Polymorphisms) representations by vt (vt *decompose\_blocksub*). This step is carried out *post*-aggregation.Â

SNPs derived from the decomposition of MNPs **do not** combine/merge with canonical SNPs (not derived from MNPs). This is what causes the duplication of lines.Â A single variant many be duplicated many times if the MNP is long and there are many canonical SNP variants.Â

**Definitions**

*SNP:* The reference and alternate sequences are of length 1 and the base nucleotide is different from one another.

*MNP:* The reference and alternate sequences are of the same length and have to be greater than 1 and all nucleotides in the sequences differ from one anotherÂ

#### The OLD\_CLUMPED INFO tag

SNPs derived from the decomposition of MNPs are flagged with theÂ `OLD_CLUMPED` tag in the INFO field.Â

#### Worked example

**Pre-decomposed MNP for a single sample:**

| CHROM | POS | ID | REF | ALT | QUAL | FILTER | INFO | FORMAT | SAMPLE 1 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 20 | 763837 | . | CA | TG | . | PASS | AC=1;AN=2 | GT | 0/1 |

**Decomposed MNP for a single-sample:**

The CA > TG MNP has been decomposed into its constitutive SNPs: C > T and A > G.

The INFO filed has been populated with theÂ `OLD_CLUMPED` tag - which keeps track of the original MNP that was decomposed.Â

| CHROM | POS | ID | REF | ALT | QUAL | FILTER | INFO | FORMAT | SAMPLE 1 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 20 | 763837 | . | C | T | . | PASS | AC=1;AN=2;OLD\_CLUMPED=20:763837:CA/TG | GT | 0/1 |
| 20 | 763838 | . | A | G | . | PASS | AC=1;AN=2;OLD\_CLUMPED=20:763837:CA/TG | GT | 0/1 |

**Pre-decomposed MNP in multi-sample:**

Sample 1 is heterozygous for the CA > TG MNP.Â   
Sample 2 is heterozygous for the A > G SNP.Â

| Chromosomes | POS | ID | REF | ALT | QUAL | FILTER | INFO | FORMAT | SAMPLE 1 | SAMPLE 2 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 20 | 763837 | . | CA | TG | . | PASS | AC=1;AN=4 | GT | 0/1 | 0/0 |
| 20 | 763837 | . | A | G | . | PASS | AC=1;AN=4 | GT | 0/0 | 0/1 |

\*\*Decomposed MNP in muli-sample:Â \*\*

The CA > TG MNP in Sample 1 has been decomposed into its constitutive SNPs: C > T and A > G.Â The INFO filed has been populated with theÂ `OLD_CLUMPED` tag - which keeps track of the original MNP that was decomposed.Â

No change occurs to the A > G SNP for Sample 2.Â

SNPs derived from the decomposition of MNPs **do not** combine/merge with canonical SNPs (not derived from MNPs).

Therefore a duplicated variant (identical CHROM, POS, REF, ALT) is created for the A > G SNP.Â

These can be differentiatedÂ using theÂ `OLD_CLUMPED` `INFO` tag, as this is populated when an MNP is decomposed, but is empty (`.`) for canonical SNPs.Â

| CHROM | POS | ID | REF | ALT | QUAL | FILTER | INFO | FORMAT | SAMPLE 1 | SAMPLE 2 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 20 | 763837 | . | C | T | . | PASS | AC=1;AN=4;OLD\_CLUMPED=20:763837:CA/TG | GT | 0/1 | 0/0 |
| 20 | 763838 | . | A | G | . | PASS | AC=1;AN=4;OLD\_CLUMPED=20:763837:CA/TG | GT | 0/1 | 0/0 |
| 20 | 763838 | . | A | G | . | PASS | AC=1;AN=2 | GT | 0/1 | 0/1 |

#### Identifying unique variants

As mentioned, only ~0.02%Â of the variants in the dataset are duplicated (identical CHROM, POS, REF, ALT).Â

All variants are completely unique however if the following fields are concatenated per variant:Â

CHROM, POS, REF, ALT, INFO/OLD\_MULTIALLELIC, INFO/OLD\_CLUMPED

### Variants with allele count of 0

There are a few instances of variants in aggV2 that have an allele count (AC) of zero. There are two reasons as to why this is observed:

1. Participants that withdraw from the programme are removed from the dataset *post*-aggregation. Though their genotypes are removed, their variants are kept, so to avoid confusion of variantÂ lines that may contain partial genotypes. Such variants will have an AC of 0, as the AC is calculated *post*-removal of withdrawn participants.Â
2. In the single sample gVCFs, certain variants are 'forced-genotyped' meaning that a variant call is made even if no variant exists - i.e. the sample genotype will not be in a REF BLOCK but be coded as `0/0`. Forced-genotype variants are preserved in aggV2. Therefore if all samples are `0/0` for a particular forced-genotyped variant, then the AC of that variant will be 0.Â

### Maximum alternate alleles per variant

In the gVCF aggregation process by gvcf genotyper, multiallelic variants with more than **50** alternate alleles are discarded and not included in aggV2.Â

### Variants within deletions

For autosomal variants, the majority of samples will have diploid genotypes (e.g. `0/1`). However, some samples will have haploid (hemizygous-like) calls (e.g. 1) for certain variants. Such haploid calls indicate that the respective sample-genotype identified on one chromosome is locatedÂ *within* a deletion identified on the other chromosome for the same sample.Â

These haploid calls are **not** produced as part of the aggregation procedure, but are seen in the single-sample gVCFs.

#### Worked example

In the single-sample gVCF, we have identified the following variant where the genotype is represented as haploid ALT call:

| CHROM | POS | REF | ALT | GT | Description |
| --- | --- | --- | --- | --- | --- |
| chr1 | 2118756 | A | T | **1** | Haploid ALT genotype identified |

On closer inspection in the single-sample gVCF, we see that there is a heterozygous call (`0/1`) for a 2 bp deletion (TGA > T) 2bp upstream of the variant (from bases 2118755 - 2118756). Therefore, the A > T SNP above is represented as haploid, because it is located *within* a known deletion on the other chromosome.Â

Please note that reference calls spanning that deletion are also haploid (the G reference call).

| CHROM | POS | REF | ALT | GT | Description |
| --- | --- | --- | --- | --- | --- |
| chr1 | 2118754 | TGA | T | `0/1` | 2bp deletion of bases GA from positionÂ 2118755 - 2118756. Called as heterozygous (diploid).Â |
| chr1 | 2118755 | G | . | `0` | We know the G base in position 2118755 is deleted on one chromosome, but on the other it is REF - therefore the hemizygous genotype 0 is called (haploid). |
| chr1 | 2118756 | A | T | `1` | We know the A in position 2118756 is deleted on one chromosome, but on the other it is ALT - therefore a hemizygous genotype 1 is called (haploid). |

In aggV2, the haploid call for that sample-genotype is carried over as haploid from the single sample gVCF.

## Help and support

> **Note:**
>
> Please reach out via the [Genomics England Service Desk](https://www.genomicsengland.co.uk/service-desk) for any issues related to the aggV2 aggregation or companion datasets, including "aggV2" in the title/description of your inquiry.

January 19, 2026
