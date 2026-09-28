---
title: 'Small Variant input files - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/small_variant_input_files/
scraped_at: 2026-05-04T06:33:53Z
---

# Small Variant input files

## Gene input file

- parameter: `--gene_input`
- default: `${projectDir}/input/gene_list.txt`

A text file with no header, that includes a one-per-line list of genes (HGNC symbols or Ensembl IDs).

genes.txt

```
BRCA1
ENSG00000227518
TNF
```

> **Info:**
>
> 1. The maximum number of genes per query is ten. If you need to query more than ten genes, please run the workflow with multiple smaller gene sets. For a large set of genes, consider using aggV2 (see [aggV2 Code Book::Functional Annotation Queries](../aggv2_functional_annotation_queries/)).
> 2. Query genes in the input list that are not found in BioMart reference data are written to <*build*>\_genes\_not\_found.txt.

## Samplesheet file

- parameter: `--samplesheet`
- default: `null`
- by default, i.e., if no samplesheet file is provided, a LabKey query is run to select 1000KGP rare disease and cancer germline participants for both GRCh37 and GRCh38

A comma-separated value (CSV) file with a header, and columns: `participant_id`, `platekey`, `genome_build`, `file_path`, `delivery_version`, `file_sub_type`, `type`

samplesheet.csv

```
participant_id,platekey,genome_build,file_path,delivery_version,file_sub_type,type
SAMPLE2,PLATEKEY2,GRCh37,s3://path_to_sample_file/SAMPLE2_GRCh37.vcf.gz,V4,Standard VCF,rare disease germline
SAMPLE2,PLATEKEY2,GRCh38,s3://path_to_sample_file/SAMPLE2_GRCh38.vcf.gz,V4,Standard VCF,rare disease germline
SAMPLE3,PLATEKEY3,GRCh37,s3://path_to_sample_file/SAMPLE3_GRCh37.vcf.gz,V4,Standard VCF,rare disease germline
SAMPLE3,PLATEKEY3,GRCh38,s3://path_to_sample_file/SAMPLE3_GRCh38.vcf.gz,V4,Standard VCF,rare disease germline
SAMPLE4,PLATEKEY4,GRCh37,s3://path_to_sample_file/SAMPLE4_GRCh37.vcf.gz,V4,Standard VCF,rare disease germline
SAMPLE4,PLATEKEY4,GRCh38,s3://path_to_sample_file/SAMPLE4_GRCh38.vcf.gz,V4,Standard VCF,rare disease germline
SAMPLE5,PLATEKEY5,GRCh37,s3://path_to_sample_file/SAMPLE5_GRCh37.vcf.gz,V4,Standard VCF,rare disease germline
SAMPLE5,PLATEKEY5,GRCh38,s3://path_to_sample_file/SAMPLE5_GRCh38.vcf.gz,V4,Standard VCF,rare disease germline
SAMPLE6,PLATEKEY6,GRCh37,s3://path_to_sample_file/SAMPLE6_GRCh37.vcf.gz,V4,Standard VCF,rare disease germline
SAMPLE6,PLATEKEY6,GRCh38,s3://path_to_sample_file/SAMPLE6_GRCh38.vcf.gz,V4,Standard VCF,rare disease germline
SAMPLE7,PLATEKEY7,GRCh37,s3://path_to_sample_file/SAMPLE7_GRCh37.vcf.gz,V4,Standard VCF,rare disease germline
SAMPLE7,PLATEKEY7,GRCh38,s3://path_to_sample_file/SAMPLE7_GRCh38.vcf.gz,V4,Standard VCF,rare disease germline
```

> **Samplesheet considerations:**
>
> - use the latest [GEL data release](../release_overview/)
> - use a minimum sample size of four particpants (for each genome build included)
> - use the latest `delivery_date`
> - use either `delivery_version` Illumina (`V2` and/or `V4`), or DRAGEN (`DRAGEN_Pipeline2.0`)
> - use only germline genomes

For reference, below is the default SQL query made to LabKey on HPC

LabKey query

```
SELECT
    g.participant_id,
    g.platekey,
    g.genome_build,
    g.file_path
FROM
    genome_file_paths_and_types AS g
INNER JOIN
    participant AS p ON p.participant_id = g.participant_id
WHERE type IN ('rare disease germline', 'cancer germline')
AND g.participant_id NOT IN ({','.join(excluded_participants)})
AND genome_build = '{genome_build}'
AND file_sub_type = 'Standard VCF'
AND normalised_consent_form != 'cohort-tracerx'
AND g.delivery_version != 'DRAGEN_Pipeline2.0'
AND NOT EXISTS (
    SELECT 1 FROM genome_file_paths_and_types AS g_newer
    WHERE g_newer.participant_id = g.participant_id
    AND g_newer.type = g.type
    AND g_newer.genome_build = g.genome_build
    AND g_newer.file_sub_type = g.file_sub_type
    AND g_newer.delivery_date > g.delivery_date
    AND g_newer.delivery_version != 'DRAGEN_Pipeline2.0'
```

January 29, 2026
