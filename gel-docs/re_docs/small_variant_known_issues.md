---
title: 'Small variant workflow known issues - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/small_variant_known_issues/
scraped_at: 2026-05-04T06:33:54Z
---

# Known issues and limitations

## Containers

### Failure to pull singularity image

Occasionally, network issues cause image pulls to timeout. If the workflow fails with a status 143 error, copy the images to your cache.

```
Pulling Singularity image (...)

Caused by:
Failed to pull singularity image
(...)
status : 143
```

Copy the required images to your singularity cache

```
cp /gel_data_resources/workflows/input_material/rdp_small_variant/containers/* $HOME/.singularity/cache/
```

## Parameters

---

### Compute resources (cpus, memory, queue)

Longer genes, or genes that contain a large number of variants, may require additional memory in the merge step. Merge resources are defined dynamically as

```
merge_queue  = { task.attempt < 2 ? 'short' : 'medium' }
merge_memory = { 16.GB + (16.GB * (task.attempt - 1)) }
merge_cpus   = { 4 + (4 * (task.attempt - 1)) }
```

You can set these on the command line, e.g., `--merge_cpus 4`. If you encounter a resource problem for a particular gene, try using a larger value on the command line, while maintaining the recommended cpu:memory ratios (1 cpu per 4GB memory HPC; 1 cpu per 6GB memory CloudOS)

> **Note:**
>
> Set any Nextflow workflow parameter on the command line with `--<parameter_name> <value>`. For a full list of defined parameters `nextflow config -flat -profile hpc main.nf | grep params. | grep --color=auto --color "="`

## Processes

---

### Normalisation and variant representation

The normalisation and left-alignment happens in 3 steps (excerpt from workflow process `second_round_merge` below)

```
bcftools merge \
    --file-list chunk.list \
    --merge both \
    | bcftools norm --fasta-ref ${reference_fasta} -m-both \
    | bcftools norm --fasta-ref ${reference_fasta} -m+both \
    | bcftools norm --fasta-ref ${reference_fasta} -m-both \
    -Ob -o ${build}_merged_normalized_1.bcf
```

The `bcftools norm -m` (or `--multiallelics`) option "split(s) multiallelic sites into biallelic records (-) or joins biallelic sites into multiallelic records (+). An optional type string can follow which controls variant types which should be split or merged together: If only SNP records should be split or merged, specify snps; if both SNPs and indels should be merged separately into two records, specify both; if SNPs and indels should be merged into a single record, specify any." The `both` option indicates "SNPs and indels should be merged separately into two records".

Running `bcftools norm -m-both` once produces duplicated variants for positions where both MNPs and SNPs are observed. Normalisation decomposes the MNP into separate SNPs that do not combine with canonical SNPs (not derived from MNPs), as they have different associated metrics (QUAL, DP, GQ, etc.). The alternative would be to have multiple entries for the same SNP, with different allele counts (AN, AC, AF).

See detailed [documentation on variant duplication](https://research-help.genomicsengland.co.uk/display/GERE/Variant+Representation#VariantRepresentation-VariantDuplication&Multi-NucleotidePolymorphisms(MNPs)). (**Note**. The documentation describes characteristics of aggV2 in which `vt` was used for the normalisation. The same considerations apply and `vt` and `bcftools norm` give identical output.)

## Output

---

### Memory allocation for VEP annotation on CloudOS

On CloudOS, the awsbatch executor copies the VEP cache (~15GB) to the compute instance for each Nextflow task (i.e. each query gene). With multiple tasks being assigned to the same compute instance, we have observed that the annotation process can complete, with all columns in the annotated variant file output, but with a "download failed" message and "cannot allocate memory" error reported in the log. We are currently exploring solutions to this issue.

> **Warning:**
>
> Check the logs to be sure the VEP annotation has run succesfully.

February 25, 2026
