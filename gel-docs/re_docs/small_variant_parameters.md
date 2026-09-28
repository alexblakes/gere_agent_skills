---
title: 'Small Variant parameters - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/small_variant_parameters/
scraped_at: 2026-05-04T06:33:55Z
---

# Small variant parameters

> **Info:**
>
> On the command line, prefix **workflow parameters** with `--`, e.g., `--samplesheet samples.csv`. Prefix **Nextflow options** with `-`, e.g., `-profile hpc`.

For detailed parameter documentation on the command line use `--help`

```
WORKFLOW='/gel_data_resources/workflows/rdp_small_variant/v3.1.4'

nextflow run ${WORKFLOW} -profile hpc --help
```

For full details of a specific parameter

```
nextflow run ${WORKFLOW} -profile hpc --help gene_input
```

## Base configuration

| parameter | default |
| --- | --- |
| `gene_input` | `${projectDir}/input/gene_list.txt` |
| `samplesheet` | `null` |
| `outdir` | `'results'` |
| `publish_all` | `false` |
| `help` | `false` |
| `add_clinvar` | `true` |
| `use_loftee` | `true` |
| `config_profile_name` | `null` |
| `config_profile_description` | `null` |
| `config_profile_data_base` | `null` |

## HPC-specific parameters

- `-profile hpc`

| parameter | default |
| --- | --- |
| `config_profile_name` | `'hpc'` |
| `config_profile_description` | `'Configuration options for GEL double helix'` |
| `config_profile_data_base` | `'/gel_data_resources,/public_data_resources'` |
| `project_code` | `''` |
| `cluster_options` | `'-P '` |
| `excluded_participant_ids` | `'/gel_data_resources/workflows/input_material/shared_BRS_tools/excluded_participants/excluded_participant_ids.txt'` |
| `reference_resources.GRCh37.coord_file` | `'/public_data_resources/genes_and_regions/ensembl_genes_coordinates_105_grch37.tsv'` |
| `reference_resources.GRCh37.fasta_file` | `'/public_data_resources/reference/GRCh37/Homo_sapiens.GRCh37.75.dna.primary_assembly.fa'` |
| `reference_resources.GRCh37.vep_cache_version` | `'105'` |
| `reference_resources.GRCh37.vep_cache` | `'/public_data_resources/vep_resources/VEP_105'` |
| `reference_resources.GRCh37.vep_cache_synonyms` | `'/public_data_resources/vep_resources/VEP_105/homo_sapiens/105_GRCh37/chr_synonyms.txt'` |
| `reference_resources.GRCh37.clinvar_file` | `'/public_data_resources/clinvar/20200604/clinvar/vcf_GRCh37/clinvar_20200602.vcf.gz'` |
| `reference_resources.GRCh37.clinvar_index` | `'/public_data_resources/clinvar/20200604/clinvar/vcf_GRCh37/clinvar_20200602.vcf.gz.tbi'` |
| `reference_resources.GRCh37.loftee_human_ancestor_fa` | `'/public_data_resources/vep_resources/Build-37/human_ancestor.fa.gz'` |
| `reference_resources.GRCh37.loftee_gerp_file` | `'/public_data_resources/vep_resources/Build-37/GERP_scores.final.sorted.txt.gz'` |
| `reference_resources.GRCh37.loftee_conservation_file` | `'/public_data_resources/vep_resources/Build-37/phylocsf_gerp.sql'` |
| `reference_resources.GRCh38.coord_file` | `'/public_data_resources/genes_and_regions/ensembl_genes_coordinates_105_grch38.tsv'` |
| `reference_resources.GRCh38.fasta_file` | `'/public_data_resources/reference/GRCh38/GRCh38Decoy_no_alt.fa'` |
| `reference_resources.GRCh38.vep_cache_version` | `'105'` |
| `reference_resources.GRCh38.vep_cache` | `'/public_data_resources/vep_resources/VEP_105'` |
| `reference_resources.GRCh38.vep_cache_synonyms` | `'/public_data_resources/vep_resources/VEP_105/homo_sapiens/105_GRCh38/chr_synonyms.txt'` |
| `reference_resources.GRCh38.clinvar_file` | `'/public_data_resources/clinvar/20200604/clinvar/vcf_GRCh38/clinvar_20200602.vcf.gz'` |
| `reference_resources.GRCh38.clinvar_index` | `'/public_data_resources/clinvar/20200604/clinvar/vcf_GRCh38/clinvar_20200602.vcf.gz.tbi'` |
| `reference_resources.GRCh38.loftee_human_ancestor_fa` | `'/public_data_resources/vep_resources/Build-38/human_ancestor.fa.gz'` |
| `reference_resources.GRCh38.loftee_gerp_bigwig` | `'/public_data_resources/vep_resources/Build-38/gerp_conservation_scores.homo_sapiens.GRCh38.bw'` |
| `reference_resources.GRCh38.loftee_conservation_file` | `'/public_data_resources/vep_resources/Build-38/loftee.sql'` |

## CloudOS-specific parameters

- `-profile cloudos`

| parameter | default |
| --- | --- |
| `config_profile_name` | `'cloudos'` |
| `config_profile_description` | `'Configuration options for LifeBit CloudOS'` |
| `config_profile_data_base` | `'s3://512426816668-gel-data-resources,s3://512426816668-public-data-resources,s3://512426816668-genomes,s3://gel-lifebit-featured-datasets'` |
| `reference_resources.GRCh37.coord_file` | `'s3://512426816668-public-data-resources/genes_and_regions/ensembl_genes_coordinates_105_grch37.tsv'` |
| `reference_resources.GRCh37.fasta_file` | `'s3://512426816668-genomes/reference/illumina_nsv2/Homo_sapiens.GRCh37.75.dna.primary_assembly.fa'` |
| `reference_resources.GRCh37.vep_cache_version` | `'105'` |
| `reference_resources.GRCh37.vep_cache` | `'s3://gel-lifebit-featured-datasets/containers/vep/vep_cache_GRCh37_v105'` |
| `reference_resources.GRCh37.vep_cache_synonyms` | `'s3://gel-lifebit-featured-datasets/containers/vep/vep_cache_GRCh37_v105/homo_sapiens/105_GRCh37/chr_synonyms.txt'` |
| `reference_resources.GRCh37.clinvar_file` | `'s3://512426816668-public-data-resources/clinvar/20200604/clinvar/vcf_GRCh37/clinvar_20200602.vcf.gz'` |
| `reference_resources.GRCh37.clinvar_index` | `'s3://512426816668-public-data-resources/clinvar/20200604/clinvar/vcf_GRCh37/clinvar_20200602.vcf.gz.tbi'` |
| `reference_resources.GRCh37.loftee_human_ancestor_fa` | `'s3://512426816668-public-data-resources/vep_resources/LOFTEE/Build-37/human_ancestor.fa.gz'` |
| `reference_resources.GRCh37.loftee_gerp_file` | `'s3://512426816668-public-data-resources/vep_resources/LOFTEE/Build-37/GERP_scores.final.sorted.txt.gz'` |
| `reference_resources.GRCh37.loftee_conservation_file` | `'s3://512426816668-public-data-resources/vep_resources/LOFTEE/Build-37/phylocsf_gerp.sql'` |
| `reference_resources.GRCh38.coord_file` | `'s3://512426816668-public-data-resources/genes_and_regions/ensembl_genes_coordinates_105_grch38.tsv'` |
| `reference_resources.GRCh38.fasta_file` | `'s3://512426816668-genomes/reference/illumina_nsv4/GRCh38Decoy_no_alt.fa'` |
| `reference_resources.GRCh38.vep_cache_version` | `'105'` |
| `reference_resources.GRCh38.vep_cache` | `'s3://gel-lifebit-featured-datasets/containers/vep/vep_cache_GRCh38_v105'` |
| `reference_resources.GRCh38.vep_cache_synonyms` | `'s3://gel-lifebit-featured-datasets/containers/vep/vep_cache_GRCh38_v105/homo_sapiens/105_GRCh38/chr_synonyms.txt'` |
| `reference_resources.GRCh38.clinvar_file` | `'s3://512426816668-public-data-resources/clinvar/20200604/clinvar/vcf_GRCh38/clinvar_20200602.vcf.gz'` |
| `reference_resources.GRCh38.clinvar_index` | `'s3://512426816668-public-data-resources/clinvar/20200604/clinvar/vcf_GRCh38/clinvar_20200602.vcf.gz.tbi'` |
| `reference_resources.GRCh38.loftee_human_ancestor_fa` | `'s3://512426816668-public-data-resources/vep_resources/LOFTEE/Build-38/human_ancestor.fa.gz'` |
| `reference_resources.GRCh38.loftee_gerp_bigwig` | `'s3://512426816668-public-data-resources/vep_resources/LOFTEE/Build-38/gerp_conservation_scores.homo_sapiens.GRCh38.bw'` |
| `reference_resources.GRCh38.loftee_conservation_file` | `'s3://512426816668-public-data-resources/vep_resources/LOFTEE/Build-38/loftee.sql'` |
| `lb_bcftools_container` | `'docker-quay-io.artifactory.aws.gel.ac/kenhanscombe/bcftools:1.17'` |
| `lb_vep_container` | `'docker-quay-io.artifactory.aws.gel.ac/lifebitai/brs_tools_genevariantworkflow-vep:105.2'` |
| `excluded_participant_ids` | `'s3://512426816668-gel-data-resources/brs-workflows/input_material/shared_BRS_tools/excluded_participants/excluded_participant_ids.txt'` |

July 8, 2025
