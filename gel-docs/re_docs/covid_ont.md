---
title: 'ONT COVID-19 - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/covid_ont/
scraped_at: 2026-05-04T06:31:57Z
---

# ONT COVID-19

We sequenced a subset of the Covid-19 cohort using Oxford Nanopore technology (ONT).

We have a total of 191 participants with ONT data, split in the following way:

- 99 Covid-19 mild participants
- 92 Covid-19 severe participants

The data are found in s3 buckets accessible from [CloudOS](../cloudos/) located under `GEL genomes > covid-19 > oxford_nanopore`. The table `linking_table_covid_ont.tsv` provides the file paths to the data and a link to the `participant_id`.

For each participant you can see:

- BAM file
- Structural variant VCF
- HLA genotyping files

## Data generation

Basecalling was performed with guppy version 4.0.11+f1071ce using the high accuracy model.

A brief description of the analysis workflow:

- Reads with an average base quality score â¥ 7 were merged with FastQC.
- Reads were aligned to GRCh38 with minimap v2.10-r761 (parameters: `--secondary=no -x map-ont --MD`).
- NanoPlot v1.32.1 was used to produce QC reports on basecall sequencing summary and aligned reads.
- Aligned read coverage was assessed with mosdepth v0.2.6.
- Structural variants were called with Sniffles v1.0.11 with the following parameters: `--min_support 3 --minmapping_qual 20 --min_seq_size 1000 --report_read_strands --genotype --cluster`.
- HLA genotyping was conducted with HLA-LA v1.01.

March 26, 2026
