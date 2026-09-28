---
title: 'IVA Case Interpretation, Case Portal - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/iva_case/
scraped_at: 2026-05-04T06:32:47Z
---

# IVA Case Interpretation, Case Portal

The case portal in IVA allows you to search all the variants in a 100kGP case (a rare disease family or a cancer participant), filtering by genomic features and genotypes.

You can access the case portal from the top-tab or from the central display of the screen.

## Search the portal

You can now search for your case of interest. For rare disease, a case refers to a family, comprising one proband along with their relatives whose genomes have been sequenced (usually father and mother, but it could include siblings and other relatives). For cancer, a case is a single cancer participant.

You can filter the cases by **Sample ID**, which refers to the platekey (eg LP123456-DNA\_A01), or **Proband ID**, the participant ID of the proband (eg 123456789).

## Case portal

Once you select a case from the main table of the case portal, you will see following sub-components:

- **Case info**: general information about the case and the data about the proband for who the case was created (id, sex, DOB, disorders, phenotypes).
- **Quality control**: general QC metrics (this part is under current active development) and sample stats.
- **Sample variant browser**: an interface to browse over the variants presented in the samples associated with the case.

### Quality control

**Variant stats** include aggregated information about the variants in the sample associated with the case, like the aggregated genotypes, VCF filters, depth, variant type, INDEL size, variants per chromosome, consequence type, biotype and ClinVar clinical significance.

### Sample variant browser

The sample variant browser allows you to browse over the variants presented in the samples associated with the case. The browser is similar to that available in the [Variant Browser](../iva_variant/), allowing you to apply [different filters](../iva_filter/) and view variants of interest.

The variant table displays the genotype of the proband and, for rare disease, relatives. You can also filter the variants by these genotypes, by selecting the Sample Genotypes Filter.

There, you can filter the variants based on the genotypes of the individuals included in the case. You can set custom filters, or use the drop-down to select pre-set filters based on modes of inheritance.

January 7, 2025
