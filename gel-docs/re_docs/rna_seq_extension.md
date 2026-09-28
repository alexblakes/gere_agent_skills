---
title: 'Transcriptomics data - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/rna_seq_extension/
scraped_at: 2026-05-04T06:33:48Z
---

# Transcriptomics data - 100kGP Extension

The extension consists of a further 2,294 samples from 2,286 probands:

- Three of these probands overlap with the [pilot project](../rna_seq_pilot/)
- For a further eight probands, two samples are provided in this cohort

## Data available in the Genomics England Research Environment

### DRAGEN output

The data delivered by Illumina from running the DRAGEN RNA Pipeline is available in `/gel_data_resources` with individual deliveries subdivided by delivery dates (see example delivery below). You can generate lists of file paths of interest through the `transcriptome_file_paths_and_types` LabKey table by filtering for specific file type and participants.

Primary folder: `/gel_data_resources/RNASeq_data/Rare_Disease/`

**For each sample** the following output files are available:

```
/gel_data_resources/RNASeq_data/Rare_Disease/DELIVERY_DATE/DELIVERY_ID/
âââ RNA_PLATEKEY
    âââ fastqs
    â   âââ RNA_PLATEKEY_SNN_L001_R1_001.fastq.gz
    â   âââ RNA_PLATEKEY_SNN_L001_R2_001.fastq.gz
    â   âââ ..
    â   âââ ..
    â   âââ RNA_PLATEKEY_SNN_L00N_R1_001.fastq.gz
    â   âââ RNA_PLATEKEY_SNN_L00N_R2_001.fastq.gz
    âââ RNA_PLATEKEY.bam
    âââ RNA_PLATEKEY.bam.bai
    âââ RNA_PLATEKEY.bam.md5sum
    âââ RNA_PLATEKEY.Chimeric.out.junction
    âââ RNA_PLATEKEY.fusion_candidates.features.csv
    âââ RNA_PLATEKEY.fusion_candidates.filter_info
    âââ RNA_PLATEKEY.fusion_candidates.final
    âââ RNA_PLATEKEY.fusion_candidates.preliminary
    âââ RNA_PLATEKEY.fusion_candidates.vcf.gz
    âââ RNA_PLATEKEY.fusion_candidates.vcf.gz.md5sum
    âââ RNA_PLATEKEY.fusion_candidates.vcf.gz.tbi
    âââ RNA_PLATEKEY.fusion_metrics.csv
    âââ RNA_PLATEKEY.hard-filtered.vcf.gz
    âââ RNA_PLATEKEY.hard-filtered.vcf.gz.md5sum
    âââ RNA_PLATEKEY.hard-filtered.vcf.gz.tbi
    âââ RNA_PLATEKEY.insert-stats.tab
    âââ RNA_PLATEKEY.mapping_metrics.csv
    âââ RNA_PLATEKEY.metrics.json
    âââ RNA_PLATEKEY.quant.eq_classes.txt
    âââ RNA_PLATEKEY.quant.genes.sf
    âââ RNA_PLATEKEY.quant_metrics.csv
    âââ RNA_PLATEKEY.quant.sf
    âââ RNA_PLATEKEY.quant.transcript_coverage.txt
    âââ RNA_PLATEKEY.quant.transcript_fragment_lengths.txt
    âââ RNA_PLATEKEY.SJ.out.tab
    âââ RNA_PLATEKEY.SJ.saturation.txt
    âââ RNA_PLATEKEY.stats.json
    âââ RNA_PLATEKEY.time_metrics.csv
    âââ RNA_PLATEKEY.trimmer_metrics.csv
    âââ RNA_PLATEKEY.unfiltered.SJ.out.tab
    âââ RNA_PLATEKEY.vcf.gz
    âââ RNA_PLATEKEY.vcf.gz.md5sum
    âââ RNA_PLATEKEY.vcf.gz.tbi
    âââ RNA_PLATEKEY.vc_hethom_ratio_metrics.csv
    âââ RNA_PLATEKEY.vc_metrics.csv
    âââ RNA_PLATEKEY.wgs_contig_mean_cov.csv
    âââ RNA_PLATEKEY.wgs_coverage_metrics.csv
    âââ RNA_PLATEKEY.wgs_fine_hist.csv
    âââ RNA_PLATEKEY.wgs_hist.csv
    âââ RNA_PLATEKEY.wgs_overall_mean_cov.csv
    âââ md5sum.txt
```

You can find indications on the content of these files at the Illumina DRAGEN pipeline documentation pages:

- [DRAGEN 4.2 RNA pipeline Outputs page](https://support-docs.illumina.com/SW/dragen_v42/Content/SW/DRAGEN/TPipelineOut_fDG.htm)
- [DRAGEN 4.2 RNA pipeline Gene fusion page](https://support-docs.illumina.com/SW/dragen_v42/Content/SW/DRAGEN/TPipelineOut_fDG.htm)
- [DRAGEN 4.2 RNA pipeline Gene Expression quantification page](https://support-docs.illumina.com/SW/dragen_v42/Content/SW/DRAGEN/GeneExpressionQuantification.htm)
- Other pages in the same menu within the [DRAGEN 4.2 DNA pipeline section](https://support-docs.illumina.com/SW/dragen_v42/Content/SW/DRAGEN/GPipelineIntro_fDG.htm) including various metrics pages such as [the QC pages](https://support-docs.illumina.com/SW/dragen_v42/Content/SW/DRAGEN/QCMetricsCoverageReports.htm)

### RNA-Seq QC output

We ran the sample-level RNA sequencing data through an internally developed pipeline, generating quality control metrics across the entire cohort. Evaluation included examining raw read quality, alignment quality, and whole genome DNA-RNA sample matching. Some sample-level output files from the below tools have been aggregated into simple tsv files which have been aggregated together (see below) to allow comparison across the full dataset.

The table below outlines the software employed by the pipeline for generating QC metrics and which output files fed into the aggregated files. FastQC, RNA-SeQC2, RSeQC were used to generate generic quality metrics, whereas Somalier was used to assess the relatedness between WGS and RNASeq data to ensure RNASeq samples matched the expected WGS data.

| Tool | Version | Original output file types |
| --- | --- | --- |
| [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) | 0.12.1 | `summary.txt` |
| [RNA-SeQC 2](https://github.com/getzlab/rnaseqc) | 2.4.2 | `*.bam.metrics.tsv` |
| [RSeQC](https://rseqc.sourceforge.net/) | 5.0.1 | `*.geneBodyCoverage.txt` |
| [Somalier](https://github.com/brentp/somalier) | 0.2.18 | `*.pairs.tsv` `*.samples.tsv` |

Sample-level and aggregated QC files output by the pipeline can be accessed at:

`/gel_data_resources/RNASeq_data/qc_results/main_programme_100kGP/rare_disease_transcriptomics_extension_dataset/`

## Help and support

Please reach out via the [Genomics England Service Desk](https://www.genomicsengland.co.uk/service-desk) for any issues related to the RNA-Seq datasets and tables, including "RNASeq" in the title/description of your inquiry.

January 29, 2026
