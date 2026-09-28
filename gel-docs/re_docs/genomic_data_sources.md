---
title: 'Genomic data sources - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/genomic_data_sources/
scraped_at: 2026-05-04T06:32:13Z
---

# Genomic data sources

> **Legend:**
>
> all  
>  somatic  
>  cancer  
>  cancer analysis germline  
>  germline  
>  rare disease analysis germline

## Primary delivery (single sample only)

All files can be found in the `/genomes/by_date` folder. You can find paths to specific files using the Labkey table `genome_file_types_and_paths` and filtering by the `file_type` and/or `file_sub_type`.

|  |  | 100kGP NSv2 (Illumina) | 100kGP NSv4 (Illumina + GEL) | 100kGP DRAGEN (GEL realigned cancer programme) | NHS GMS DRAGEN (GEL) |
| --- | --- | --- | --- | --- | --- |
| Reference genome |  | GRCh37 | GRCh38 (Decoy, no alt) | GRCh38 (DeAlt\_HLA) | GRCh38 (DeAlt\_HLA) |
|  |  |  |  |  |  |
| Alignment | Aligner | ISAAC | ISAAC | DRAGEN 3.2.22 | DRAGEN 3.2.22 |
|  | BAM |  |  |  |  |
|  | CRAM |  |  |  |  |
|  |  |  |  |  |  |
| Small variants | germline VCF |  |  |  |  |
|  | somatic VCF |  |  |  |  |
|  | gVCF (germline) |  |  |  |  |
|  |  |  |  |  |  |
| Structural and Copy Number Variation | SV VCFs |  |  |  |  |
|  | CNV VCFs |  |  |  |  |
|  | SV and CNV in a single VCF |  |  |  |  |

## Supporting genomic files (i.e. annotated or multi-sample)

All files can be found in the `/gel_data_resources` folder.

|  |  | 100kGP NSv2 (Illumina) | 100kGP NSv4 (Illumina + GEL) | 100kGP DRAGEN (GEL realigned cancer programme) | NHS GMS DRAGEN (GEL) |
| --- | --- | --- | --- | --- | --- |
| Joint-called VCFs | joint-called VCF[1](#fn:1) |  |  |  |  |
|  | joint-called gVCF[1](#fn:1) |  |  |  |  |
|  | SV diploid (joint-called) |  |  |  |  |
|  |  |  |  |  |  |
| Cancer interpretation related | cancer small variants annotated |  |  |  |  |
|  | germline small variants VCF |  |  |  |  |
|  | somatic small variants VCF (cancer programme) |  |  |  |  |

---

1. For NsVx deliveries, joint-calling was done with Platypus. Otherwise DRAGEN was used for joint-calling.Â [â©](#fnref:1 "Jump back to footnote 1 in the text")[â©](#fnref2:1 "Jump back to footnote 1 in the text")

April 7, 2026
