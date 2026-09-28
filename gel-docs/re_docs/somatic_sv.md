---
title: 'Somatic SVs and CNVs for a specific gene - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/somatic_sv/
scraped_at: 2026-05-04T06:34:01Z
---

# Somatic SVs and CNVs for a specific gene

The **getSVCNVperGene** package retrieves tiered structural and copy number variants from genes of interest within somatic samples processed through the Genomics England Interpretation pipeline.

The newly released version 2 of **getSVCNVperGene** supports 100kGP (or main programme) data releases and now includes compatibility with NHS-GMS.

For 100kGP data release version 15 and below, the package iterates through interpreted and tiered JSON files to extract variant information directly. For newer Main Programme releases (version 16 and higher) and for NHS-GMS, the package queries a database pre-compiled from the interpreted and tiered variants without the necessity of parsing multiple JSON files.

If your research requires you to query SVs and CNVs which would not have undergone interpretation, we would recommend that you review our [Structural Variant workflow](../structural_variant/) that queries VCFs directly for any sample in the Genomics England database.

## Installing the package

You can install the package as a source tar file:

`/gel_data_resources/workflows/get_svcnv_per_gene/2.0.0/getSVCNVperGene_2.0.0.tar.gz`

Or you can use a Singuarity image with the package and its dependencies pre-installed:

`/gel_data_resources/workflows/get_svcnv_per_gene/2.0.0/getSVCNVperGene.sif`

### Installing from source

The package relies on several [third-party R packages](../r_packages/) that must be installed and loaded in the session before use.

```
library(tidyverse)
library(Rlabkey)
library(RSQLite)
```

> **Note:**
>
> If you are using a version of Rlabkey after 3.0.0, please run the command below:
>
> ```
> labkey.setWafEncoding(FALSE)
> ```

You can install the compiled package in the Research Environment using the following steps:

```
# Set default library location
.libPaths(c(.libPaths(), "/tools/aws-workspace-apps/ce/R/4.0.2"))

# Install package from source
install.packages("/gel_data_resources/workflows/get_svcnv_per_gene/2.0.0/getSVCNVperGene_2.0.0.tar.gz")

# Load package
library(getSVCNVperGene)
```

To uninstall the package, take the following steps:

```
detach("package:getSVCNVperGene", unload = TRUE)
remove.packages("getSVCNVperGene")
```

### Using the Singularity container

You can run the [containerised version](../hpc_containers/) of the package like:

```
module load singularity/4.1.1

singularity exec /gel_data_resources/workflows/get_svcnv_per_gene/2.0.0/getSVCNVperGene.sif Rscript <SCRIPT>
```

## Using the package

Using with 100kGP releases 15 and earlier

Due to a change in the tiering pipeline that occurred between data release 15 and 16 of 100kGP, the format of the output JSON files has changed. JSON files generated for release 15 and earlier differ in structure from those produced for release 16 and later. The new JSON format also applies to NHS-GMS samples. Therefore, when querying for variants from releases 15 and earlier, the package follows a different internal process and yields a different output format compared to querying for variants from release 16 and later.

The main functions of the package and their input parameters remain identical, regardless of the release being queried. However, the output format will vary. Detailed descriptions of both input and output are provided below.

> **Limited support for releases < 16:**
>
> We will not be actively supporting feature requests for functionality relating to releases prior to release 16.

There are two functions:

1. **getSV** queries structural variants.
2. **getCNV** queries copy number variants.

### Inputs

getSVgetCNV

| argument | type | default | description |
| --- | --- | --- | --- |
| gene | required | - | string argument, name of gene or a vector of gene names. E.g. gene=c('EGFR', 'MET') |
| fusionOnly | optional | FALSE | logical argument, select on SVs that result in the **fusion** **of genes**. Fusions here are defined as any SV whose breakpoints are located in the coding region of two different genes, one of them being the gene name given to the argument *gene* above. |
| diseaseType | optional | NULL | string argument, a diseases type or a vector of disease types. If given, this argument should correspond to diseases included in the `cancer_analysis` table under `disease_type` for 100K samples or `clinical_indication_full_name` for NHS-GMS. If not given, return all diseases. |
| participantID | optional | NULL | string argument, a participant ID or a vector of participant IDs. If not given, query all participants. |
| plateKey | optional | NULL | string argument, a platekey ID or a vector of platekeys; participantID and plateKey should NOT be used simultaneously. If not given, query all samples. |
| release\_version | optional | "/main-programme/main-programme\_v19\_2024-10-31" | string argument containing the filepath for the Release Programme version. E.g. "/main-programme/main-programme\_v19\_2024-10-31" for release version /main-programme/main-programme\_v19\_2024-10-31. |

The following example detects tiered structural variants in *KRAS*, *PTEN* and *BRAF* related to samples concerning breast cancer, which may result in the fusion of genes.

`getSV(gene = c("KRAS", "PTEN", "BRAF"), fusionOnly = TRUE, diseaseType = "Breast")`

By default the package will query the most recent 100kGP release. To query for variants from a different release, such as an NHS-GMS release, use the `release_version` parameter. For example, the following command retrieves all BRCA1 SVs identified in NHS-GMS cancer participants:

`getSV(gene = "BRCA1", release_version = "/nhs-gms/nhs-gms-release_v3_2024-03-18")`

| argument | type | default | description |
| --- | --- | --- | --- |
| gene | required | - | string argument, name of gene or a vector of gene names. E.g. gene=c('EGFR', 'MET') |
| gain | optional | NULL | logical argument, if TRUE selects only gains, if FALSE selects only losses, if NULL selects all |
| diseaseType | optional | NULL | string argument, a diseases type or a vector of disease types. If given, this argument should correspond to diseases included in the `cancer_analysis` table under `disease_type` for 100K samples or `clinical_indication_full_name` for NHS-GMS. If not given, return all diseases. |
| participantID | optional | NULL | string argument, a participant ID or a vector of participant IDs. If not given, query all participants. |
| plateKey | optional | NULL | string argument, a platekey ID or a vector of platekeys; participantID and plateKey should NOT be used simultaneously. If not given, query all samples. |
| release\_version | optional | "/main-programme/main-programme\_v19\_2024-10-31" | string argument containing the filepath for the Release Programme version. E.g. use "/main-programme/main-programme\_v19\_2024-10-31" for release version /main-programme/main-programme\_v19\_2024-10-31. |

The following example detects tiered copy number variants in *KRAS*, *PTEN* and *BRAF*, related to samples concerning breast cancer:

`getCNV(gene = c("KRAS", "PTEN", "BRAF"), diseaseType = "Breast")`

By default the package will query the most recent 100kGP data release. To query for variants from a different release, such as an NHS-GMS release, use the `release_version` parameter. For example, the following command retrieves all BRCA1 CNVs identified in NHS-GMS cancer participants:

`getCNV(gene = "BRCA1", release_version = "/nhs-gms/nhs-gms-release_v3_2024-03-18")`

### Outputs

The function outputs a tab-separated value file which are:

getSVgetCNV

releases > 15 and NHS-GMSreleases < 16

| column name | description |
| --- | --- |
| variant\_origin | "somatic" for all variants. |
| report\_event\_id | Unique identifier for each event. |
| chromosome | The name of the chromosome where the primary breakpoint, **bp1**, of the SV is located. For translocations, bp1 refers to the breakpoint on the chromosome with the lower number, while bp2 refers to the breakpoint on the chromosome with the higher number of the chromosomes involved in the variant. For all other SVs, bp2 does not apply. |
| start | Start position of the SV at bp1. |
| end | End position of the SV at bp1. |
| size | Size of SV in basepairs. NA for translocations. |
| cytobands | Chromosomal cytoband information. |
| SVTYPE | Type of structural variant. BND (translocation), DEL (deletion), DUP (duplication), INV (inversion), INS (insertion), as defined by Manta. |
| bp1\_txs | The Ensembl transcript ID overlapping bp1. |
| bp2\_txs | The Ensembl transcript ID overlapping bp2. Only applicable for translocations. |
| gene\_name\_bp1 | The HGNC gene name of the gene(s) overlapping bp1. |
| gene\_name\_bp2 | The HGNC gene name of the gene(s) overlapping bp2. Only applicable for translocations. |
| variant\_domain | The Domain assigned to the variant by the tiering pipeline. Can be DOMAIN1, DOMAIN2, or DOMAIN3. |
| gene | The HGNC gene symbol of gene(s) involved in the variant. |
| ensembl\_id | The Ensembl gene ID of gene(s) involved in the variant. |
| bp1\_location | A combination of the Ensembl transcript ID and gene feature overlapping bp1 in the format ENST\_feature. For example, ENST00000256078\_intron. |
| bp2\_location | A combination of the Ensembl transcript ID and gene feature overlapping bp2 in the format ENST\_feature. Only applicable for translocations. |
| secondaryChromosome | The name of the chromosome where the secondary breakpoint, **bp2**, of the SV is located. Only applicable for translocations. |
| secondaryStart | Start position of the SV at bp2. Only applicable for translocations. |
| secondaryEnd | End position of the SV at bp2. Only applicable for translocations. |
| orientation | Orientation of translocations, can be start\_start, start\_end, or end\_end. Only applicable for translocations. |
| mate | Indicates how the two chromosomes are merged at bp1. Only applicable for translocations. |
| MATEALT | Indicates how the two chromosomes are merged at bp2. Only applicable for translocations. |
| tumour\_sample\_platekey | Genomics England identifier for sequenced sample, aka platekey. |
| disease\_type | 100K: cancer type of the tumour sample, NHS-GMS: clinical indication tested for. |
| participant\_id | Genomics England identifier for participants |
| disease\_sub\_type | Subtype of tumour sample. Not applicable for NHS-GMS samples. |
| fusion\_inferred | Indicates whether a putative fusion has been identified based on whether both breakpoints involved fall into coding regions. Only applicable for translocations. |
| fusion\_outcomes | Fusion frame prediction annotation for potential gene fusions. Only available for translocations from NHS-GMS samples that have gone through versions of the interpretation pipeline that include this feature. |

| column name | description |
| --- | --- |
| query | Gene name queried for |
| plate | Genomics England identifier for sequenced sample, aka platekey |
| participant\_id | Genomics England identifier for participants |
| disease\_type | Tumour type |
| disease\_sub\_type | Tumour sub-type |
| type | SV type, BND (translocation), DEL (deletion), DUP (duplication), INV (inversion), INS (insertion), as defined by Manta |
| gene\_name\_bp1 | If breakpoint 1 (bp1) falls in a coding region, this fields has the gene name of the corresponding coding region. If bp1 falls in a non-coding region, this fields says 'empty' |
| gene\_name\_bp2 | If breakpoint 2 (bp2) falls in a coding region, this fields has the gene name of the corresponding coding region. If bp2 falls in a non-coding region, this fields says 'empty' |
| coordinates\_bp1 | Coordinates of bp1 in the chr:start:end. Bp1 is defined as the bp that occurs on the chromosome with lowest number between the two chromosomes involved in the SV. If both bp's are on the same chromosome, bp1 is the one with the lowest position |
| coordinates\_bp2 | Coordinates of bp2 in the chr:start:end. Bp2 is defined as the bp that occurs on the chromosome with highest number between the two chromosomes involved in the SV. If both bp's are on the same chromosome, bp2 is the one with the highest position |
| gene\_txs\_bp1 | Additional annotation for gene on bp1, if any |
| gene\_txs\_bp2 | Additional annotation for gene on bp2, if any |
| size | Size of SV in basepairs. NA for translocations |
| tier | Here, tier represents the level of actionability of the gene involved in the SV. Tier1 means actionable, i.e. genes for which some therapy exists. Tier2 potentially actionable, i.e. other oncogenes. Tier3 are all other genes |
| mate | Information for translocation, that indicates how the two chromosomes are merged. NA for other SV types |
| additionalTextualVariantAnnotations | Additional information |
| actions | Information about actionability, if any |
| cytobands | Chromosomal cytoband information |

releases > 15 and NHS-GMSreleases < 16

The function outputs a tab-separated value file which are:

| column name | description |
| --- | --- |
| variant\_origin | "somatic" for all variants. |
| report\_event\_id | Unique identifier for each event. |
| chromosome | Chromosome harbouring the CNV. |
| start | Start position of CNV. |
| end | End position of CNV. |
| size | Size of CNV in basepairs. |
| numberOfCopies | Copy number of CNV. |
| cytobands | Chromosomal cytoband information. |
| SVTYPE | Type of structural variant. Can by CNV or LOH. |
| gene\_name\_bp1 | NA for all CNVs. |
| gene\_name\_bp2 | NA for all CNVs. |
| variant\_domain | The Domain assigned to the variant by the tiering pipeline. Can be DOMAIN1, DOMAIN2, or DOMAIN3. |
| gene | The HGNC gene symbol of gene(s) involved in the variant. |
| ensembl\_id | The Ensembl gene ID of gene(s) involved in the variant. |
| bp1\_location | NA for all CNVs. |
| bp2\_location | NA for all CNVs. |
| tumour\_sample\_platekey | Genomics England identifier for sequenced sample, aka platekey. |
| disease\_type | 100K: cancer type of the tumour sample, NHS-GMS: clinical indication tested for. |
| participant\_id | Genomics England identifier for participants. |
| disease\_sub\_type | Subtype of tumour sample. Not applicable for NHS-GMS samples. |

> **OmittedNHS-GMSsamples:**
>
> CNVs from two NHS-GMS participants will not be included in the results from getCNV. These results were omitted from the underlying database due to inconsistent formatting of their tiered CNV JSON files. If you wish to retrieve tiered CNVs from these participants please refer to their JSONs directly. Further information on these omitted participants can be found at `/gel_data_resources/workflows/get_svcnv_per_gene/omitted_samples/omitted_samples_v1.tsv`.

| column name | description |
| --- | --- |
| query | Gene name queried for |
| plate | Genomics England identifier for sequenced sample, aka platekey |
| participant\_id | Genomics England identifier for participants |
| disease\_type | Tumour type |
| disease\_sub\_type | Tumour sub-type |
| tier | Here, tier represents the level of actionability of the genes involved in the CNV. Tier1 means actionable, i.e. genes for which some therapy exists. Tier2 potentially actionable, i.e. other oncogenes. Tier3 are all other genes, although not included |
| coordinates | CNV coordinates in the format: chr:start-end |
| cn | copy number of the region indicated in coordinates. Note that cn = 2 corresponds to LOH |
| type | 'CNV' is the old annotation, indicating cn is different from what is expected. 'GAIN' cn > 2, 'LOSS' cn < 2, 'LOH' cn = 2 |
| genes | annotation |
| cytobands | Chromosomal cytoband information |
| size | Size of SV in basepairs. NA for translocations |

## Help and support

Please reach out via the [Genomics England Service Desk](https://re-docs.genomicsengland.co.uk/help/) for any issues related to running this script, including "somatic-tiered-SVCNV-package" in the title/description of your inquiry.

March 17, 2025
