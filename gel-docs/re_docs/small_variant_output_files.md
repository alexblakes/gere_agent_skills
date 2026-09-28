---
title: 'Small Variant output files - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/small_variant_output_files/
scraped_at: 2026-05-04T06:33:54Z
---

# Small Variant output files

The workflow will create the following in the directory you launch the pipeline from.

```
results/         # main output (default --outdir)
logs/            # LSF stdout and stderr, and the Nextflow log
```

Intermediate output is written to the working directory, on HPC `/re_scratch/$USER` (default `-work-dir`)

For each query gene and build, the main output is an annotated list of variants, and a multi-sample VCF file and index.

```
GENOMEBUILD_HGNCSYMBOL_ENSEMBLID_annotated_variants.tsv
GENOMEBUILD_HGNCSYMBOL_ENSEMBLID_left_norm_tagged.vcf.gz
GENOMEBUILD_HGNCSYMBOL_ENSEMBLID_left_norm_tagged.vcf.gz.tbi
```

When `--publish_all true`, the output of every process is written to a folder with process name, within results/ (default `--outdir`).

### Additional INFO tags

Additional `bcftools` INFO tags are computed with the plugin [`fill-tags`](https://samtools.github.io/bcftools/howtos/plugin.fill-tags.html). These per variant tags are derived from the merged single-sample VCF and combined with the VEP annotation output in the final annotated variant file.

| ID | Description | Meaning |
| --- | --- | --- |
| AN | Total number of alleles in called genotypes |  |
| AC | Allele count in genotypes |  |
| NS | Number of samples with data | The number of samples which have been included for a particular variant, and is equal to the number of samples with any variant at the given chromosomal position |
| AC\_Hom | Allele counts in homozygous genotypes | The number of alleles for the given variant counted from the genotypes listed in the multi-sample VCF |
| AC\_Het | Allele counts in heterozygous genotypes |  |
| AC\_Hemi | Allele counts in hemizygous genotypes |  |
| MAF | Frequency of the second most common allele |  |

### Annotated variant file columns

- **\*\_variant** columns are `bcftools` output
- **\*\_annotation** columns are `VEP` annotation output
- **\*\_sample** columns derived from filtering on bi-allelic genotype

| Name | Description |
| --- | --- |
| CHROM\_variant | chromosome |
| POS\_variant | position |
| ID\_variant | identifier |
| REF\_variant | reference base(s) |
| ALT\_variant | alternate base(s) |
| (...) | `bcftools +fill-tags` columns described above |
| DUP\_variant |  |
| (...) | [VEP annotation output](https://www.ensembl.org/info/docs/tools/vep/vep_formats.html#output) |
| Het\_samples | samples from output VCF selected with `bcftools -i 'GT="het"'` |
| Hom\_samples | samples from output VCF selected with `bcftools -i 'GT="AA"'` |
| Hemi\_samples | samples from output VCF selected with `bcftools -i 'GT="A"'` |

February 25, 2026
