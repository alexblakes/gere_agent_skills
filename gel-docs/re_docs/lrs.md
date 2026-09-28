---
title: 'Long-read genomic data - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/lrs/
scraped_at: 2026-05-04T06:34:42Z
---

# Long-read genomic data

Genomics England, in partnership with the Sanger Institute and Pacific Biosciences amongst others, has been assessing the advantages of long-reads sequencing technologies over Illumina short-reads whole genome sequencing. To this end, we have employed both Oxford Nanopore Technologies and Pacific Biosciences methodologies.

Upon availability of the data and/or expiration of potential embargoes we aim to provide researchers access to this data.

A separate section has been made available in LabKey as of 100kGP Data Release v17 containing various tables related to long read sequencing data.

## Datasets available

| Dataset | Technology | Project | Type | Summary | Participant count | Data types | Data location | Tables |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| [ONT rare disease SGP](../rd_sgp_ont/) | Oxford Nanopore | 100kGP | Rare disease | ONT data set for the Scottish Genomes Partnership project | 73 | Regular BAMs SV family VCFs Aggregate SV VCF | `/gel_data_resources/LRS_cohort_genomes/Rare_Disease/SGP2_LRS/` | LabKey `rare_disease_ont_sgp` |
| [ONT rare disease pilot](../rd_ont/) | Oxford Nanopore | 100kGP | Rare disease | First ONT data set with structural variant calls | 315 | Regular BAMs Structural variants | `/gel_data_resources/LRS_cohort_genomes/Rare_Disease/` | LabKey `rare_disease_ont_cohorts` |
| [ONT cancer pilot](../cancer_ont/) | Oxford Nanopore | 100kGP | Cancer | First ONT data set generated for 100kGP cancer participants and first data set with methylation calls | 100 | Regular BAMs Methyl BAMs | `/gel_data_resources/LRS_cohort_genomes/cohort_CML` | LabKey `cancer_ont_cohorts` |
| [PacBio rare disease pilot](../pacbio_pilot/) | PacBio | 100kGP | Rare disease | Example dataset to demonstrate the utility of PacBio's HiFi technology | 91 | Small variants Structural variants | `/gel_data_resources/LRS_genomes/WGS_PacBio` | LabKey `rare_disease_pacbio_pilot` |
| [ONT pilot](../ont_pilot/) | Oxford Nanopore | 100kGP | Rare disease | First ONT data set generated for 100kGP participants | 47 | Raw sequencing data (FAST5) FASTQ Regular BAMs | `/gel_data_resources/LRS_genomes/WGS_ONT/` | LabKey `lrs_laboratory_sample` and `lrs_sequencing_data` |
| [ONT COVID-19](../covid_ont/) | Oxford Nanopore | COVID-19 |  | Mild and severely affected COVID-19 participants | 191 | Structural variants HLA genotyping | CloudOS `GEL genomes > covid-19 > oxford_nanopore` | `linking_table_covid_ont.tsv` |

## Help and support

Please reach out via the [Genomics England Service Desk](https://www.genomicsengland.co.uk/service-desk) for any issues related to the LRS datasets and tables, including "LRS" in the title/description of your inquiry.

March 26, 2026
