---
title: 'Oxford Nanopore Long-read sequencing pilot - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/ont_pilot/
scraped_at: 2026-05-04T06:33:04Z
---

# Oxford Nanopore Long-read sequencing pilot

This describes an early pilot of long-read Oxford Nanopore data made available in the RE. Genomics England, in partnership with the Sanger Institute, has been assessing the advantages of long-reads sequencing technologies over short-reads whole genome sequencing. The dataset consists of human genomes from a subset of 100,000 Genomes Project participants sequenced with Oxford Nanopore long reads.

## Sequencing protocol

Germline DNA from a subset of 100,000 Genome Project participants was depleted of low molecular weight DNA (<10 Kb) before library preparation. Libraries for ONT sequencing were prepared with the protocol indicated in the `library_prep` field of the `lrs_laboratory_sample` table in LabKey. Data were acquired with the PromethION Beta for 42-60hrs. Full details of the protocol can be found here: [v1\_protocol\_ONT\_LSK109.pdf](../v1_protocol_ONT_LSK109.pdf) and additional information about the samples and the sequencing is available in the `lrs_laboratory_sample` LabKey table.

## Data processing

Base calling was performed on sequencer using Guppy (versions 3.05-3.2.10) in high accuracy mode. Fastq files were aligned to `GCA_000001405.15_GRCh38_no_alt_analysis_set.fa` (available in the RE as `/public_data_resources/reference/GRCh38/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna`) with minimap2 (version 2.17). FAST5 (raw output from the ONT sequencer in a HDF5 format), FASTQ and BAM files are provided for use and their location can be found in the `lrs_sequencing_data` LabKey table.

March 26, 2026
