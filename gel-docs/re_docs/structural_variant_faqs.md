---
title: 'Structural variant workflow appendix - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/structural_variant_faqs/
scraped_at: 2026-05-04T06:34:01Z
---

# Structural variant workflow appendix

## CNV calls on sex chromosomes

Canvas CNV calls use Illumina-derived sex chromosome karyotype. In rare cases, we have found these to be inconsistent with GEL-derived coverage-based sex chromosome karyotype. When the sex chromosome karyotype is inconsistent, CNV calls on sex chromosomes will be wrong. Illumina-derived sex chromosome karyotype (`vcf_karyotype_sex`) and GEL-derived sex chromosome karyotype (`rd_inferred_sex_karyotype`, `ca_inferred_sex_karyotype`) are included in **/gel\_data\_resources/workflows/rdp\_structural\_variant/rr17\_sex\_karyotype.tsv** for all cancer and rare disease germline, V2 and V4, GRCh37 and GRCh38 participants.

A conservative approach to CNV results on sex chromosomes would be to use only GRCh38 participants with both Illumina-derived and GEL-derived, concordant sex chromosome karyotype. About 7% of GRCh38 genomes are either missing or discordant. We do not have information on Illumina-derived sex chromosome karyotype for GRCh37 genomes.

Expand to show SQL query used to derive sample included in rr17\_sex\_karyotype.tsv

```
SELECT DISTINCT
    g.platekey,
    g.type,
    g.file_path,
    g.genome_build,
    g.delivery_date,
    g.delivery_id,
    p.participant_id,
    p.programme_consent_status,
    p.participant_phenotypic_sex AS phenotypic_sex,
    r.inferred_sex_karyotype AS rd_inferred_sex_karyotype,
    c.karyotype_sex AS ca_inferred_sex_karyotype
FROM
    genome_file_paths_and_types g
INNER JOIN
    participant p ON p.participant_id = g.participant_id
        AND g.type IN ('cancer germline','rare disease germline')
        AND g.genome_build IN ('GRCh37','GRCh38')
        AND g.file_sub_type = 'Structural VCF'
        AND g.delivery_version IN ('V2','V4')
    AND LOWER(p.programme_consent_status) = 'consenting'
INNER JOIN
    (
        SELECT
            participant_id,
            MAX(CAST(delivery_date AS DATE)) AS last_delivery
        FROM genome_file_paths_and_types
        GROUP BY participant_id
    ) latest_files
    ON CAST(g.delivery_date AS DATE) = latest_files.last_delivery
LEFT JOIN
    rare_disease_analysis r ON p.participant_id = r.participant_id
LEFT JOIN
    cancer_analysis c ON p.participant_id = c.participant_id;
```

March 26, 2026
