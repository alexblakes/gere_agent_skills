---
title: 'Variant Effect Predictor (VEP) container - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/vep_archive/
scraped_at: 2026-05-04T06:34:13Z
---

# VEP containers for older releases

We no longer provide support for running older versions of VEP. The recommended method for running VEP on our systems is the VEP execution script introduced for VEP v112 and later. Instructions for using this workflow are available on the page [Variant Effect Predictor (VEP)](../vep/).

For users who need to run earlier VEP versions, we provide pre-built Singularity container images (`.sif`). These containers include the corresponding VEP version and most commonly used plugins. While these images remain available, they are not actively supported.

The available VEP container images are listed below:

| VEP version | Path to .sif file |
| --- | --- |
| 99 | `/gel_data_resources/example_scripts/annotate_variants_with_vep/unsupported_versions/99/vep_99.sif` |
| 105 | `/gel_data_resources/example_scripts/annotate_variants_with_vep/unsupported_versions/105/vep_105.sif` |
| 106 | `/gel_data_resources/example_scripts/annotate_variants_with_vep/unsupported_versions/106/vep_106.sif` |
| 109 | `/gel_data_resources/example_scripts/annotate_variants_with_vep/unsupported_versions/109/vep_109.sif` |
| 111 GRCh37 | `/gel_data_resources/example_scripts/annotate_variants_with_vep/unsupported_versions/111/vep_loftee_b37.sif` |
| 111 GRCh38 | `/gel_data_resources/example_scripts/annotate_variants_with_vep/unsupported_versions/111/vep_loftee_b38.sif` |

March 9, 2026
