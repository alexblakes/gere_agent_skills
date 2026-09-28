---
title: 'AggV2 functional annotation - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/functional_annotation/
scraped_at: 2026-05-04T06:32:07Z
---

# AggV2 functional annotation

VEP-annotated aggV2 files are available, showing the variant consequences of all variants called in the aggV2 dataset.

The full functional annotation data can be found at:
`/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/functional_annotation`.

The functional annotation data is split into 1371 chunks.

The output format of the functional annotation files is compressed VCFs (`vcf.gz`). The `CHROM`, `POS`, `REF`, `ALT`, `FILTER` and `INFO` fields from the genomic data are preserved for the functional annotation, but genotypes are dropped.

## VEP versions

There are several versions of the AggV2 functional annotation files. These represent different versions of VEP and corresponding Ensembl annotation, not changes in the aggregation itself.

The latest version available is VEP 109.

## Plugins and annotation sources

The following [VEP plugins](https://www.ensembl.org/info/docs/tools/vep/script/vep_plugins.html) were used in annotation:

- GREEN-VARAN
- CADD v1.6
- REVEL
- UTRannotator
- Clinpred
- NMD
- SpliceAI
- SpliceRegion
- MTR
- dbNSFPP
- LOFTEE
- Clinvar
- MitoTIP
- gnomAD - included the following fields (with gnomADg\_ prefix): AF, AF\_afr, AF\_mid, AF\_amr, AF\_asj, AF\_eas, AF\_sas, AF\_fin, AF\_nfe, AF\_oth, AF\_ami, AF\_XY, AF\_XX, faf95\_sas, faf99\_sas, faf95\_eas, faf99\_eas, faf95\_amr, faf99\_amr, faf95\_afr, faf99\_afr, faf95, faf99, faf95\_nfe, faf99\_nfe
- Genomics England allele frequencies - With the following fields: AC\_whole\_cohort, AN\_whole\_cohort, AF\_whole\_cohort, AC\_cancer\_all, AN\_cancer\_all, AF\_cancer\_all, AC\_rd\_all, AN\_rd\_all, AF\_rd\_all, AC\_rd\_probands, AN\_rd\_probands, AF\_rd\_probands, AC\_afr, AN\_afr, AF\_afr, AC\_eas, AN\_eas, AF\_eas, AC\_eur, AN\_eur, AF\_eur, AC\_sas, AN\_sas, AF\_sas, AC\_unrelated\_cohort, AN\_unrelated\_cohort, AF\_unrelated\_cohort, AC\_cancer\_unrel, AN\_cancer\_unrel, AF\_cancer\_unrel

The following plugins have been purposely excluded for technical, governance or data reasons:

- MMSplice - This plugin would reliably crash on some problem variants.
- SVoverlaps - Due to the lack of a aggregated set of GRCh38 structural variants.
- Funmotifs - Due to a lack of GRCh38 resources.
- M-CAP - The plugin only works for GRCh37.
- LD - Due to speed concerns. We recommend calculating LD outside of VEP.
- NearestGene - This is unable to be run in offline mode.

### Extracting VEP annotation information

Annotated information for variants are written to the INFO/CSQ field, with a '|' field separator. To extract this information programmatically, we recommend using bcftools +split-vep as follows:

```
#List available VEP annotation fields to be queried
bcftools +split-vep test/split-vep.vcf -l | head

0   Allele
1   Consequence
2   IMPACT
3   SYMBOL
4   Gene
5   Feature_type
6   Feature
7   BIOTYPE
8   EXON
9   INTRON

#Example to extract CHROM, POS, and Consequence information
bcftools +split-vep test/split-vep.vcf -f '%CHROM:%POS %Consequence\n'
```

For more information on VEP, please see the Ensembl VEP documentation page and the split-vep documentation.

## Help and support

> **Note:**
>
> Please reach out via the [Genomics England Service Desk](https://www.genomicsengland.co.uk/service-desk) for any issues related to the aggV2 aggregation or companion datasets, including "aggV2" in the title/description of your inquiry.

October 24, 2024
