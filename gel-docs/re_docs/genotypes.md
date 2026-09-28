---
title: 'Finding participants by genotype - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/genotypes/
scraped_at: 2026-05-04T06:34:36Z
---

# Finding participants by genotype

These tutorial will take you through the methods you can use to find participants by genotypes, either by gene or by locus. This tutorial will help you to build lists of participant IDs or platekeys.

You can find all participants with particular variants using a no code interface in [Interactive Variant Analysis (IVA)](../iva/), or using [pre-built workflows](../workflows/) to search by genes. Using the tables in [LabKey](../labkey/) and its associated [APIs](../labkey_api/), you can find participants with variants that have been prioritised for causal likelihood by [rare disease tiering](../tiering/), [cancer tiering](../cancer_tiering/) and [Exomiser](../exomiser/). You can also use the [germline aggregate](../aggv2/) and [somatic aggregate](../somAgg/) VCF files to find participants from a particular data freeze.

## Cohort building methods

The following tutorials cover:

- [Finding participants by genotype in IVA](../iva_genotypes/)
- [Finding participants by genotype in Cohort browser in CloudOS](../cb_genotypes/)
- [Using pre-built workflows to find participants by genotypes](../workflows_genotypes/)
- [Finding participants with prioritised variants programmatically](../api_genotypes/)
- [Querying aggregate VCF files to find participants by genotypes](../aggregate_genotypes/)

## Genome assembly in finding participants by genotypes

It is vitally important to consider genome assembly when searching for participants by genotypes. The same genomic location will have different coordinates on different genome assemblies. This means any search by genomic coordinates should also specify the genome assembly, and to find all participants with a particular genotype you should repeat any searches with the remapped genome coordinates on other assemblies.

In [release 19 (31st October 2024)](../current_release/), of the 100kGP Genomes, over 80% of the rare disease genomes were aligned to GRCh38, but some were aligned to GRCh37, whereas all the cancer genomes, both germline and somatic, were aligned to GRCh38. All of the [NHS GMS](../current_gms/) genomes are aligned to GRCh38.

The following table summarises how you should consider genome assembly in the different methods of finding participants by genotype.

| Method | Genome assembly considerations |
| --- | --- |
| [Finding participants by genotype in IVA](../iva_genotypes/) | IVA includes separate programmes for variants mapped to GRCh37 and GRCh38 in rare disease. To find all participants, you should use both programmes. For searches by coordinates, you should convert them between assemblies. |
| [Using pre-built workflows to find participants by genotypes](../workflows_genotypes/) | Both workflows discussed, [the Small Variant workflow](../small_variant/) and the [Structural Variant workflow](../structural_variant/) will find participants with genomes mapped to both assemblies when you search by gene. |
| [Finding participants with prioritised variants programmatically](../api_genotypes/) | The [rare disease tiering](../tiering/) and [Exomiser](../exomiser/) tables in 100kGP contain some variants mapped to GRCh37 and some to GRCh38; this means that all queries for coordinates should include a genome assembly argument. The 100kGP [cancer tiering](../cancer_tiering/) and NHS GMS data is all mapped to GRCh38. |
| [Querying aggregate VCF files to find participants by genotypes](../aggregate_genotypes/) | The aggregate VCF files only contain variants from genomes mapped to GRCh38. |

## Exporting cohort data

All the methods for creating cohorts listed here involve pulling out identifiable participant data, such as participant IDs or platekeys. Therefore, you **cannot** export any of these tables from the RE. Cohorts created here are intended as a start point for further analyses. Any attempts to export these tables via [Airlock](../airlock/) will be rejected; you must **not** copy any of these tables by hand.

## Recorded training sessions

You can also find training sessions:

| Topic | Date recorded | Link | Notebook location in RE |
| --- | --- | --- | --- |
| Finding participants based on genotypes | 11th June 2024 | [materials](../genotypes_jun24/) | `/gel_data_resources/example_scripts/workshop_scripts/genotypes_2024` |

December 17, 2024
