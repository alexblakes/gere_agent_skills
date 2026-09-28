---
title: 'AggV3 change log and roadmap - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/aggv3_roadmap_change_log/
scraped_at: 2026-05-04T06:31:10Z
summary: "AggV3 release history, roadmap, and known bugs including VEP annotation type issue affecting `bcftools +split-vep` filtering."
---

# Upcoming

We are actively developing more data to augment AggV3. In future, we hope to release:

- Mendellian inconsistencies and UPD cases.
- Hardy-Weinberg equilibria.
- Allele frequencies per source programme and inferred assigned superpopulation.
- SiteQC FILTERs along with additional features which aid interpretation of the Genomics England siteQC metrics files.

# Change log

## 02-04-2026: Population structure, relatedness, ancestry and HQSNPs

We have released the principal components for the participants, along with inferred ancestry and relatedness assignments. These are based on overlapping High Quality SNPs derived from AggV2.

## 17-03-2026: Main release

We have released the DRAGEN 3.7.8 and AggV3 to the wider research community. The data is available through CloudOS. Please raise a ticket via our Service Desk to request access to CloudOS.

- Updates to the documentation. No changes made to the data since the Beta release.

## 23-01-2026: Beta release

We have released the DRAGEN 3.7.8 and AggV3 to a subset of researchers within the community for initial testing and feedback. Within this package the following datasets were provided:

- DRAGEN 3.7.8 variant calls (On S3 accessible through CloudOS).
- DRAGEN 3.7.8 CRAMs (On SequenceStore accessible through CloudOS).
- AggV3 (On S3 accessible through CloudOS)
  - Main delivery package provided by Illumina.
    - Multiallelic and biallelic msVCFs and PGENs.
    - Machine-Learning Recalibrated single sample gVCFs used as an input for AggV3.
  - Auxillary data produced by Genomics England.
    - **SiteQC metrics**. The primary delivery of AggV3 does not hold many site-level metrics, so Genomics England provide an additional fileset containing site-level metrics (e.g. MedianDP, MedianGQ, AB Ratio) that can be easily queried. This initial release does not contain any `FILTER`'s yet, but will be provided in a subsequent release while we analyse the findings of the current site-level metrics.
    - Sample list complete with related identifiers and sample source program amongst other aspects.
    - SampleQC metrics for each sample summarised in single table.
    - Functional annotation VCFs per subshard.

# Known bugs or features

> **Note:**
>
> We have not committed to resolving all of these bugs, but it may be useful to know about them for your analysis.

- Functional annotation. Some annotations have been defined as `Type=String` where they should be `Type=Float`. This occurs due to a limitation in VEP, which assigns all custom annotations as `Type=String` by default. This should be taken into consideration when performing filtering through `bcftools +split-vep`.

April 2, 2026
