---
title: 'Where and how to access de novo data - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/de_novo_data_where/
scraped_at: 2026-05-04T06:32:01Z
---

# Where and how to access de novo data

The DNV dataset are presented in two formats: two LabKey tables and annotated multi-samples VCFs per familyÂ on the file-system.Â

> **General use of DNV dataset:**
>
> We recommend to use DNVs that pass theÂ `stringent_filter` for general analysis as these are more likely to represent true DNVs.

## LabKey tables

There are two LabKey tables containing the DNV dataset:Â `denovo_cohort_information` and `denovo_flagged_variants`. These can be accessed from the [LabKey](../labkey/) Desktop application and found within theÂ 100kGP folder for release 9 and onwards.Â The full column schema and column definitions can be found in the [100kGP Data Dictionary](../current_release/).Â

### `denovo_cohort_information` LabKey table

This table contains the cohort meta-data for every participant within the DNV dataset. Each row comprises a unique participantÂ per genomeÂ assembly (there are a very small number of families that exist on both the GRCh37 and GRCh38 cohorts). The columns detail the information used to perform Rare Disease Interpretation by Genomics England such as the: `trio_id`, `family_id`, `plate_key`, `participant_id`, `relationship_to_offspring`,Â `pedigree_id`, `sex`, `affection_status` (relative to the recruited disease of the proband), and `assembly`.Â

> **The trio\_id:**
>
> The trio\_id column is a unique identifier for each trio within a the DNV dataset. It is composed of **three** parts and follows the format: `familyid_interpretationid.trionumber`. For example:Â `080690_10002.2`.
>
> 1. The `familyid` is the unique identifier per family
> 2. The `interpretationid` is the unique identifier for each Rare Disease Interpretation run
> 3. The `trionumber` is a numeric identifier for each trio within a family. For families consisting of a single trio, this will always be .1, for multiplex families with more than one trio, this will be: .1, .2, .3, etc).Â  |

The additional columns in the `denovo_cohort_information` LabKey table are defined as below:Â

| Column | Description |
| --- | --- |
| `is_multiplex family` | Flags whether the family contains nested trios. 0: the family is a simple trio; 1: the family contains nested trios (more than one trio). |
| `vcf_path_flagged_denovo` | The path to the annotated multi-sample VCF byÂ family on the file-system. This VCF contains the flagged DNVs.Â |
| `base_filter_total` | The total number of distinct variants that pass the base\_filter (for offspring only - is blank for mother and father). |
| `stringent_filter_total` | The total number of distinct variants that pass the stringent\_filter (for offspring only - is blank for mother and father). |

> **Path to annotated multi-sample VCFs:**
>
> The file-paths to the annotated multi-sample VCFs (in the column `vcf_path_flagged_denovo`) represent the path on the HPC environment. If you need to access these files on the Desktop environment, please add the `~` suffix, such as `~/gel_data_resources/..`.

### denovo\_flagged\_variants LabKey table

This table comprises all putative DNVs that pass the `base_filter` per trio. Each row comprises a unique variant per trio per assembly. The variant-level information is found in the columns: `chrom`, `position`, `reference`, `alternate`.Â The `trio_id`, `family_id`, and `assembly` columns are included so that it is possible to join this table onto theÂ `denovo_cohort_information` table (which contains the cohort meta-data). Â

> **DNVs in the denovo\_flagged\_variants LabKey table:**
>
> Due to size restrictions, only variants that pass the `base_filter`Â per trio are included in the LabKey tableÂ `denovo_flagged_variants`. For all Mendelian inconsistencies per trio with flagged DNVs, please use the annotated multi-sample VCFs.

> **Updated stringent filters:**
>
> Following data release version 9, a fix was implemented to the problematic genomic regions flags of the de novo dataset due to a bug in the annotations of segmental duplication, simple repeat, and patch filters from UCSC. This was fixed in the LabKey tables but is not reflected in the annotated VCFs. The flags in the Labkey tables `denovo_flagged_variants` and `denovo_cohort_information` are correct, while the issue still remains in the annotated VCFs as they have not been updated.

All columns ending with the suffix `filter`Â contain the flags (coded as 0 or 1) indicating whether or not the variant within the trio has **failed (0)** or **passed (1)** the respective filter. Please see the above section for the list of filters as their pass criteria.Â

The genotypes for all members of the trio are included in columnsÂ `offspring_gt`, `mother_gt`, `father_gt`. The remaining columns contain the VCF FORMAT attributes (such as depth, genotype quality, genotype likelihood) from each sample within the trio. Again, the full column schema and column definitions can be found in the [100kGP data dictionary](../current_release/).Â

> **Bayes factor:**
>
> The `denovo_flagged_variants` LabKey table contains the column `bayes_factor`. This is the output from theÂ [PlatypusÂ bayesiandenovofilter.py](https://github.com/andyrimmer/Platypus/blob/master/extensions/DeNovo/bayesianDeNovoFilter.py) python script. We decided *not* to include this metric as a filter criteria in the DNV annotation pipeline in this release. Users can use the Bayes Factor, although it is only available for non-duplicated variants from single (non multiplex) trio families. For such variants, it is not possible to attribute the Bayes Factor (coded in the `INFO` field) to the correct variant ~ sample combination.

### Querying the LabKey tables

The two LabKey tables can be queried for families and DNVs of interest using either the [LabKey graphical interface](../labkey/) (desktop application) or the [LabKey APIs](../labkey_api/). The Code Book section below shows examples of how to query the DNV dataset in LabKey. Note that the variants in theÂ `denovo_flagged_variants` table does not include genomic annotation by Ensembl VEP as this causes large amount of row duplication (due to each variant having annotations per transcript).Â

> **Flags in LabKey Table:**
>
> For all filter columns within the LabKey table,Â `denovo_flagged_variants`, a value of **0** indicates that the filter criteria has not been met (**FAIL**) and a value of 1 means thatÂ the filter criteria has been met (**PASS**).

## Annotated multi-sample VCFs

The output of theÂ DNV annotation pipeline is an annotated multi-sample VCF per `family`Â containing all Mendelian inconsistencies with putative DNVs flagged in the FORMAT column and genomic annotation in the INFO column ([**Step 5** in the DNV pipeline](../de_novo_data/#rare-disease-interpretation-pipeline)).Â

The annotated multisample VCFs can be found in the filesystem separated by genome assembly under the folders:Â

- `/gel_data_resources/main_programme/denovo_variant_dataset/GRCh37/20200326/flagged_vcf/`
- `/gel_data_resources/main_programme/denovo_variant_dataset/GRCh38/20200326/flagged_vcf/`

The files themselves are named by family\_id and interpretation\_id with the suffixÂ `.denovo.reheader.vcf.gz` (for example:Â `00004-RTD_10001.denovo.reheader.vcf.gz`).

These paths correspond to the file-paths on the HPC environment.Â If you need to access these files on the Desktop environment, please add the `~` suffix, such as `~/gel_data_resources/..`.

Use the LabKey tableÂ `denovo_cohort_information` to associate the annotated multi-sample VCF file-path (under the column `vcf_path_flagged_denovo`) with a particular `trio_id`.Â

### Querying the annotated multi-sample VCFs

The annotated multi-sample VCFs by family (containing all Mendelian inconsistencies) have the FORMAT column populated with the results of the DNV annotation pipeline under the `DE_NOVO_FLAG` attribute as shown below.Â

`##FORMAT=<ID=DE_NOVO_FLAG,Number=.,Type=String,Description="Flag from the Genomics England De Novo Flagging Pipeline">`

There is a certain order to how this field is populated:

- If a variant fails any `base_filters`, it is marked as `base_fail` without the annotation of the subsequent `stringent_filters`.
- If the variant passes the `base_filter` but fails a `stringent_filter`, it is marked with a list of the `stringent_filters` that fail.Â
- If the variant passes all `base_filters` and all `stringent_filters`, it is marked with `DENOVO`.

Note that only the offspring will have the flags populated in their `DE_NOVO_FLAG FORMAT` fields. The mother and father are set to missing `.` for this attribute.Â

> **Use the Code Book:**
>
> Please use the Code Book section for example scripts on how to query the annotated multi-sample VCFs. We recommend using the command line tool,Â [bcftools](https://samtools.github.io/bcftools/bcftools.html), to interrogate the annotated multi-sample VCFs.

| Flag in `FORMAT DE_NOVO_FLAG` column | Description |
| --- | --- |
| `base_fail` | The variant fails aÂ `base_filter`Â and/or a `global_filter` (PASS variants onÂ chromosomes: 1-22, X, M). The exact `base_filter` that fails can be found in the LabKey table:Â \_denovo\_flagged\_variants` or queried from the VCF FORMAT attributes (we wanted to limit the number of flags in the FORMAT column).Â |
| `altreadparent;` `abratio;` `proximity;` `segmentalduplication;` `simplerepeat;` `patch` | These flags indicate variants that pass the `base_filter` but fail one or more of theÂ `stringent_filters`. Note that variants have to pass the `base_filter` in order to be considered for the `stringent_filter`. The particular `stringent_filter`(s) that fail are listed using a semi-colon separator. For example if a variant fails just theÂ `altreadparent`, the FORMAT format will be marked asÂ `altreadparent`. If a variant fails theÂ `altreadparent` **and** theÂ `abratio` filter,Â the FORMAT format will be marked asÂ `altreadparent;abratio`. |
| `DENOVO` | The variant passes theÂ `base_filter`Â **and** `stringent_filter`.Â |

> **Annotated multi-sampleVCFflagging:**
>
> To create the annotated multi-sample VCFs (**Step 5**), all original FILTER field values from the Platypus joint-calling step (**Step 3**) are stripped and replaced with the flags from the DNV annotation pipeline.Â  |

We adopt an inclusive approach for researchers to analyse DNVs by `flagging`Â likely DNVs and generally not `filtering` any variants out. If necessary, you can make use of the additional attributes within the annotated multi-sample VCF to perform custom filtering. Please see the Code Book below for example on how to do this. Below are a list of important attributes one can make use of:Â

| VCF Field | Attribute | Description | Used in filter |
| --- | --- | --- | --- |
| `FILTER` | `FILTER` | The FILTER column of the annotated multi-sample VCF has not been modified from the original Platypus VCF. As only PASS variants are included in theÂ annotated multi-sample VCF from the [PlatypusÂ bayesiandenovofilter.py](https://github.com/andyrimmer/Platypus/blob/master/extensions/DeNovo/bayesianDeNovoFilter.py)Â script, the values in the FILTER field will always be set to 'PASS'. | Not used. |
| `FORMAT` | `GT` | Un-phased genotypes. | `zygosity_filter.` |
| `FORMAT` | `NR` | Number of reads covering variant location in this sample. | `mindepth_filter,Â maxdepth_filter,Â abratio_filter.` |
| `FORMAT` | `NV` | Number of reads containing variant in this sample. | `altreadparent_filter,Â abratio_filter.` |
| `FORMAT` | `GL` | Genotype log10-likelihoods for AA,AB and BB genotypes, where A = ref and B = variant. | Used to calculate Bayes Factor. |
| `FORMAT` | `GQ` | Genotype quality as phred score. | Not used in filters.Â |
| `FORMAT` | `GOF` | Goodness of fit value. | Not used in filters.Â |
| `INFO` | `bayesFactor` | Bayes Factor for the de novo model calculated by the [PlatypusÂ bayesiandenovofilter.py](https://github.com/andyrimmer/Platypus/blob/master/extensions/DeNovo/bayesianDeNovoFilter.py) python script. | Not used in filters.Â |
| `INFO` | `multidenovo_filter` | Flag of the the `multidenovo` filter. This is only applicable for multiplex families containing nested trios as described above.Â Â | Not used in filters. 0: multidenovo; 1: not multidenovo |

### Adjusting for updated stringent filters

Previously there was a bug in the annotations of **segmental duplication**, **simple repeat**, and **patch** filters from UCSC. As a result, we implemented a fix to these problematic regions.

This fix has only been carried out on the LabKey tables but is not reflected in the annotated VCFs. If you're working with the VCFs, we suggest two approaches:

1. Only use the LabKey tables `denovo_flagged_variants` and `denovo_cohort_information` to filter for candidate DNVs. If you need additional genomic annotation such as VEP (which is in the annotated VCFs), then you can look up the variant(s) manually in the VCFs to pull out the annotation.
2. Alternatively, use the annotated VCFs but be careful when filtering using the DE\_NOVO\_FLAG FORMAT field. For candidate DNVs, use bcftools to **exclude** any variants that fail the DE\_NOVO\_FLAG `base_filter` as well as variants that contain the strings: `altreadparent` OR `abratio` OR `proximity` in the DE\_NOVO\_FLAG field. The variants that remain will be candidate DNVs but will not be filtered for the problematic genomic regions flags: **segmental duplication**, **simple repeat**, and **patch**. From here the remaining variants can be manually crosschecked against the `denovo_flagged_variants` Labkey table or intersected with a genomic regions BED file to check if they are in problematic regions. The corrected problematic region files used to update the Labkey tables can be found at the following location:

`/gel_data_resources/main_programme/denovo_variant_dataset/LabKey_V9/`

October 24, 2024
