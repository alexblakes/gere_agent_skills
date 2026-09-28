---
title: 'Aggv2 phased data (provided by University of Oxford) - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/ox_aggv2/
scraped_at: 2026-05-04T06:33:05Z
---

# Aggv2 phased data (provided by University of Oxford)

We have phased data for aggV2 kindly provided by Sinan Shi from the University of Oxford. The phased dataset was generated as part of project [RR91](https://research.genomicsengland.co.uk/research-registry/browse/Browsetheresearchregistrypublic/?id=d29cd3c9-78d5-ea11-a813-000d3a7ed588) and it was used as a reference panel for the imputation of the UK Biobank dataset.

## Using the phased dataset

> **Note:**
>
> AggV2 contains information on participants who have since withdrawn consent from research. **You cannot use them in any new analyses**. It is **extremely** important to remove these samples from your analyses and only use samples included in the latest data release.
>
> The list of samples for the consented participants can be found in the `aggregate_gvcf_sample_stats` table in [LabKey](../labkey/), for the latest data release, or in the current samples file, located in `/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/docs/`.
>
> To filter the aggregate to these samples, all bcftools commands should include the flag `-S /gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/docs/<nameofcurrentfile>`.
>
> Submit a ticket to the [Genomics England Service desk](https://www.genomicsengland.co.uk/service-desk) if you are unsure of how to filter the dataset for any other use.

## Data location

The data is provided in two directories within `/gel_data_resources/`:

`/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/phased_data/allele_frequencies/ /gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/phased_data/genotypes/`

### Files included

| Files | Directory | Information |
| --- | --- | --- |
| `phased_panel_chr[..].vcf.gz` | `/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/phased_data/genotypes/` | multi-sample VCF files containing phased genotypes for all samples in aggV2. Files provided per chromosome (with index files). |
| `af.phased_panel_chr[..].vcf.gz` | `/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/phased_data/allele_frequencies/` | VCF files containing allele frequencies for the final, phased reference panel in the INFO field (INFO/AF). AC and AN are also available. Files provided per chromosome (with index files). |

## Data description

The data provided consists of 78,195 individuals consistent with the aggV2 data. The data contains over 342 million small variants (SNPs and short indels) across chromosomes 1-22 of the aggV2 dataset.

The following variant quality control filters were applied in two batches. The filters in the second column (batch 1) were applied across all sites, and then the lenient filtering on the right allowed for the inclusion of ~1M additional common variants (batch 2). The two sets were phased separately and then merged into the final reference panel.

| Metric | Filter applied - all sites (batch 1) | Filter applied - sites with AF>0.001 (batch 2) |
| --- | --- | --- |
| Genotype quality (GQ) and depth (DP) | individual genotypes with GQ<15 or DP<10 were masked as missing | Same as for sites with AF<=0.001 |
| Missingness | After application of the GQ and DP filter above, all sites that had a missing rate **>5%** were removed. Half-missing genotypes were considered as missing for this filter. | After application of the GQ and DP filter above, all sites that had a missing rate **>25%** were removed. Half-missing genotypes were considered as missing for this filter. |
| Allele Balance (for het calls) | ABhet was calculated for each het genotype as AD\_REF/(AD\_REF+AD\_ALT), where AD\_REF and AD\_ALT are the allele depths (AD) for REF and ALT genotypes respectively. Then the number of het calls per variant where 0.25<ABhet<0.75 were marked as PASS. Finally, sites where <75% of the het calls were PASS were removed. | Same as for sites with AF<=0.001 |
| Mendelian inconsistencies | Sites with more than **3** Mendelian inconsistencies among all duo and trio families for sites with allele frequency <0.001, and 7 Mendelian inconsistencies for sites with allele frequency >=0.001 were removed. | Sites with more than **250** Mendelian inconsistencies among all duo and trio families were removed. |
| Deviations from Hardy-Weinberg Equilibrium (HWE) | Sites where the HWE p-value was **< 1e-5** in self-reported white British individuals were removed | Same as for sites with AF<=0.001 |
| Comparison with gnomAD allele frequencies | Sites that showed discrepancies in the allele frequencies (AF) between the Genomics England and the gnomAD dataset (v3.1.1), as indicated by a Fisher's exact test with a p-value of **1e-10**, were removed. AFs compared were across the whole aggregate cohort and without accounting ancestry and relatedness | Sites that showed discrepancies in the allele frequencies (AF) between the Genomics England and the gnomAD dataset (v3.1.1), as indicated by a Fisher's exact test with a p-value of **1e-20**, were removed. AFs compared were across the whole aggregate cohort and without accounting ancestry and relatedness |
| Unrelated singletons | Singletons that did not occur in families were removed |  |

Please see the [attached accompanying document](../UK_Biobank_imputation_using_a_Genomics_England_reference_panel.pdf) for more information on the filter applied for Mendelian inconsistencies and for a comparison between the variants in the phased dataset and these in the HRC and TopMed reference panels.

## Phasing pipeline

Haplotype phasing was carried out using SHAPEIT4.2.2, employing a multi-stage strategy. In the first stage, [makeScaffold](https://github.com/odelaneau/makeScaffold) was used to determine the phase of as many genotypes in each duo and trio as possible. The vast majority of genotypes were phased using this process, with a small number of genotypes whose phase is ambiguous due to heterozygosity or missingness patterns being phased using SHAPEIT4.2.2.

To phase the unrelated samples, a phased scaffold of common variants was created, and then the remaining variants were phased onto this scaffold. The scaffold contained phased common variants with a minor allele frequency of 0.01, using the phased related samples as the reference panel. The remaining rarer variants were then phased onto the scaffold in chunks containing around 300,000 sites with 30,000 sites on each side as buffer. The phased duo/trio dataset was used as a reference panel in this step. The chunks were merged and concatenated using bcftools.

More more information on the process please see the attached document.

### Phasing accuracy

In order to assess the quality of the phased reference panel, the authors phased the parents of mother-father-child trios from the 1000 Genomes Project using the Genomics England phased dataset as reference. Phasing accuracy was measured using switch error rate, which is the ratio of the number of possible switches required to obtain the true haplotype phase and the inferred one and the number of heterozygote calls minus 1. The accuracy check was carried out on 589 trio families from diverse ethnic backgrounds. The mean switch error rate was 0.18%, 0.33%, 0.31% and 0.73% for individuals of European, African, South Asian and East Asian ancestry, respectively. More information can be found in the attached document.

## Help and support

Please reach out via the [Genomics England Service Desk](../help/) for any queries concerning the phased data of aggV2. We will be able to relay these questions to our colleagues at the University of Oxford or answer these ourselves depending on the type of query.

October 24, 2024
