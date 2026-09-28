---
title: 'CloudOS data - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/cloudos_data/
scraped_at: 2026-05-04T06:31:49Z
---

# CloudOS data

You can access the 100kGP data in CloudOS. This includes the clinical data and the VCF (variant) files, but does not include the BAM/CRAM (alignment) files.

[100kGP data documentation](../data_overview/)

However CloudOS also contains COVID-19 data.

[COVID-19 data documentation](../covid_overview/)

## Summary of data availability

| Data programme | Type of data | Format | CloudOS availability | HPC availability |
| --- | --- | --- | --- | --- |
| 100kGP clinical data | [Tables](../clinical_data/) | [Labkey tables](../labkey/) tsv files [cohort browser](https://lifebit.atlassian.net/wiki/spaces/CD/pages/813106752/Build+a+cohort) |  |  |
| 100kGP rare disease | [Reads](../genomic_data/) | BAM or CRAM |  |  |
| 100kGP rare disease | [Variants](../genomic_data/) | VCF |  |  |
| 100kGP cancer germline | [Reads](../genomic_data/) | BAM or CRAM |  |  |
| 100kGP cancer germline | [Variants](../genomic_data/) | VCF |  |  |
| 100kGP cancer and rare disease germline | [Aggregate variants](../aggv2/) | VCF |  |  |
| 100kGP cancer somatic | [Reads](../genomic_data/) | BAM or CRAM |  |  |
| 100kGP cancer somatic | [Variants](../genomic_data/) | VCF |  |  |
| 100kGP cancer somatic | [Aggregate variants](../somAgg/) | VCF |  |  |
| GMS clinical data |  | [Labkey tables](../labkey/) tsv files [cohort browser](https://lifebit.atlassian.net/wiki/spaces/CD/pages/813106752/Build+a+cohort) |  |  |
| GMS rare disease | [Reads](../genomic_data/) | BAM or CRAM |  |  |
| GMS rare disease | [Variants](../genomic_data/) | VCF |  |  |
| GMS cancer germline | [Reads](../genomic_data/) | BAM or CRAM |  |  |
| GMS cancer germline | [Variants](../genomic_data/) | VCF |  |  |
| GMS cancer somatic | [Reads](../genomic_data/) | BAM or CRAM |  |  |
| GMS cancer somatic | [Variants](../genomic_data/) | VCF |  |  |
| COVID clinical data | [Tables](../covid_clinical/) | tsv files [cohort browser](https://lifebit.atlassian.net/wiki/spaces/CD/pages/813106752/Build+a+cohort) |  |  |
| COVID-19 | [Reads](../genomic_data/) | BAM or CRAM |  |  |
| COVID-19 | [Variants](../genomic_data/) | VCF |  |  |
| COVID-19 | [Aggregate variants](../covid_agg/) | VCF |  |  |

## Clinical data tables

100kGP clinical data tables can be accessed through CloudOS with [Cohort browser](https://lifebit.atlassian.net/wiki/spaces/CD/pages/813106752/Build+a+cohort) and [flat `.tsv` files](https://lifebit.atlassian.net/wiki/spaces/CD/pages/814941482/Use+a+filesystem), which you can use with [pipelines](https://lifebit.atlassian.net/wiki/spaces/CD/pages/813040367/Advanced+Analytics) or interactively with [Jupyter notebooks](https://lifebit.atlassian.net/wiki/spaces/CD/pages/813105195/Run+interactive+analysis). The tables have been renamed compared to their names in LabKey, as listed in the table below.

| LabKey table name | Cohort Browser dataset name | File name in CloudOS |
| --- | --- | --- |
| cancer\_analysis | GEL Cancer Analysis | gel\_cancer\_analysis\_100k.tsv |
| cancer\_care\_plan | GEL Cancer Care Plan | gel\_cancer\_care\_plan\_100k.tsv |
| cancer\_participant\_disease | GEL Cancer Disease | gel\_cancer\_disease\_100k.tsv |
| cancer\_invest\_imaging | GEL Cancer Imaging | gel\_cancer\_imaging\_100k.tsv |
| cancer\_invest\_sample\_pathology | GEL Cancer Pathology | gel\_cancer\_pathology\_100k.tsv |
| cancer\_risk\_factor\_cancer\_spec | GEL Cancer Risk Factor | gel\_cancer\_risk\_factor\_100k.tsv |
| cancer\_risk\_factor\_general | GEL Cancer Risk Factor general | gel\_cancer\_risk\_factor\_general\_100k.tsv |
| cancer\_specific\_pathology | GEL Cancer Specific Pathology | gel\_cancer\_specific\_pathology\_100k.tsv |
| cancer\_surgery | GEL Cancer Surgery | gel\_cancer\_surgery\_100k.tsv |
| cancer\_participant\_tumour | GEL Cancer Tumour | gel\_cancer\_tumour\_100k.tsv |
| cancer\_participant\_tumour\_meta | GEL Cancer Tumour Metastases | gel\_cancer\_tumour\_metastases\_100k.tsv |
| cancer\_invest\_circulating\_tumour | GEL Circulating Tumour Marker | gel\_circulating\_tumour\_marker\_100k.tsv |
| clinic\_sample | GEL Clinic Sample | gel\_clinic\_sample\_100k.tsv |
| clinic\_sample\_quality\_check\_re | GEL Clinic Sample QC Results | gel\_clinic\_sample\_qc\_results\_100k.tsv |
| denovo\_cohort\_information | GEL Denovo Cohort Information | gel\_denovo\_cohort\_information\_100k.tsv |
| denovo\_flagged\_variants | GEL Denovo Flagged Variants | gel\_denovo\_flagged\_variants\_100k.tsv |
| domain\_assignment | GEL Domain Assignment | gel\_domain\_assignment\_100k.tsv |
| cancer\_100K\_genomes\_realigned | GEL DRAGEN realigned 100kGP genomes | gel\_dragen\_realigned\_100k\_genomes\_100k.tsv |
| exomiser | GEL Exomiser | gel\_exomiser\_100k.tsv |
| gmc\_exit\_questionnaire | GEL Genomic Medical Centre exit questionnaire | gel\_genomic\_medical\_centre\_exit\_questionnaire\_100k.tsv |
| death\_details | GEL Genomic Medicine Centre Death Details | gel\_gmc\_death\_details\_100k.tsv |
| laboratory\_sample | GEL Laboratory Sample | gel\_laboratory\_sample\_100k.tsv |
| laboratory\_sample\_omics\_availa | GEL Laboratory Sample Omics | gel\_laboratory\_sample\_omics\_100k.tsv |
| lrs\_laboratory\_sample | GEL Long Read Sequencing Laboratory Sample | gel\_lrs\_laboratory\_sample\_100k.tsv |
| sequencing\_data | GEL Long Read Sequencing Data | gel\_lrs\_sequencing\_data\_100k.tsv |
| panels\_applied | GEL Panels Applied | gel\_panels\_applied\_100k.tsv |
| participant | GEL Participant | gel\_participant\_100k.tsv |
| linking\_table | GEL Participant ID linkage to Genome file path | GEL |
| plated\_sample | GEL Plated Sample | gel\_plated\_sample\_100k.tsv |
| rare\_disease\_analysis | GEL Rare Disease Analysis | gel\_rare\_disease\_analysis\_100k.tsv |
| aggregate\_gvcf\_sample\_stats | GEL rare disease and germline genomic variant call format sample statistics | gel\_rare\_disease\_and\_germline\_genomic\_variant\_call\_format\_sample\_statistics\_100k.tsv |
| rare\_diseases\_invest\_blood\_lab | GEL Rare Disease Blood Test Results | gel\_rare\_disease\_blood\_test\_results\_100k.tsv |
| rare\_diseases\_early\_childhood | GEL Rare Disease Childhood | gel\_rare\_disease\_childhood\_100k.tsv |
| rare\_diseases\_family | GEL Rare Disease Family | gel\_rare\_disease\_family\_100k.tsv |
| rare\_diseases\_gen\_measurement | GEL Rare Disease General Measurement | gel\_rare\_disease\_general\_measurement\_100k.tsv |
| rare\_diseases\_invest\_genetic | GEL Rare Disease Genetic Test | gel\_rare\_disease\_genetic\_test\_100k.tsv |
| rare\_diseases\_invest\_genetic\_t | GEL Rare Disease Genetic Test Result | gel\_rare\_disease\_genetic\_test\_result\_100k.tsv |
| rare\_diseases\_imaging | GEL Rare Disease Imaging | gel\_rare\_disease\_imaging\_100k.tsv |
| rare\_disease\_interpreted | GEL Rare Disease Interpreted | gel\_rare\_disease\_interpreted\_100k.tsv |
| rare\_diseases\_participant\_dise | GEL Rare Participant Disease | gel\_rare\_participant\_disease\_100k.tsv |
| rare\_diseases\_participant\_phen | GEL Rare Participant Phenotype | gel\_rare\_participant\_phenotype\_100k.tsv |
| rare\_diseases\_pedigree | GEL Rare Pedigree | gel\_rare\_pedigree\_100k.tsv |
| rare\_diseases\_pedigree\_member | GEL Rare Pedigree Member | gel\_rare\_pedigree\_member\_100k.tsv |
| sequencing\_report | GEL Sequencing Report | gel\_sequencing\_report\_100k.tsv |
| tiered\_variants\_frequency | GEL Tiered Variants Frequency | gel\_tiered\_variants\_frequency\_100k.tsv |
| tiering\_data | GEL Tiering Data | gel\_tiering\_data\_100k.tsv |
| av\_imd | NCRAS Cancer Index of Multiple Deprivation | ncras\_cancer\_index\_of\_multiple\_deprivation\_100k.tsv |
| av\_patient | NCRAS Cancer Patient | ncras\_cancer\_patient\_100k.tsv |
| av\_rtd | NCRAS Cancer Route to Diagnosis | ncras\_cancer\_route\_to\_diagnosis\_100k.tsv |
| av\_treatment | NCRAS Cancer Treatment | ncras\_cancer\_treatment\_100k.tsv |
| av\_tumour | NCRAS Cancer Tumour | ncras\_cancer\_tumour\_100k.tsv |
| cwt | NCRAS Cancer Waiting Times | ncras\_cancer\_waiting\_times\_100k.tsv |
| ncras\_did | NCRAS Diagnostic Imaging Metadata | ncras\_diagnostic\_imaging\_metadata\_100k.tsv |
| lucada\_2013 | NCRAS Lung Cancer Dataset 2013 | ncras\_lung\_cancer\_dataset\_2013\_100k.tsv |
| lucada\_2014 | NCRAS Lung Cancer Dataset 2014 | ncras\_lung\_cancer\_dataset\_2014\_100k.tsv |
| rtds | NCRAS Radiotherapy | ncras\_radiotherapy\_100k.tsv |
| sact | NCRAS Systemic Anti Cancer Therapy (curated) | ncras\_systemic\_anti\_cancer\_therapy\_curated\_100k.tsv |
| cancer\_register\_nhsd | NHS D Cancer Registry | nhs\_d\_cancer\_registry\_100k.tsv |
| cen | NHS D Cohort Event Notification | nhs\_d\_cohort\_event\_notification\_100k.tsv |
| did\_bridge | NHS D Diagnostic Imaging Linkage | nhs\_d\_diagnostic\_imaging\_linkage\_100k.tsv |
| did | NHS D Diagnostic Imaging Metadata | nhs\_d\_diagnostic\_imaging\_metadata\_100k.tsv |
| ecds | NHS D Emergency Care dataset | nhs\_d\_emergency\_care\_dataset\_100k.tsv |
| hes\_ae | NHS D Hospital Episodes Statistics Accident and Emergency | nhs\_d\_hospital\_episodes\_statistics\_accident\_and\_emergency\_100k.tsv |
| hes\_apc | NHS D Hospital Episodes Statistics Admitted Patient Care | nhs\_d\_hospital\_episodes\_statistics\_admitted\_patient\_care\_100k.tsv |
| hes\_cc | NHS D Hospital Episodes Statistics Critical Care | nhs\_d\_hospital\_episodes\_statistics\_critical\_care\_100k.tsv |
| hes\_op | NHS D Hospital Episodes Statistics Outpatient | nhs\_d\_hospital\_episodes\_statistics\_outpatient\_100k.tsv |
| mhldds\_episode | NHS D Mental Health Learning and Disability Data Set Episodes | nhs\_d\_mental\_health\_learning\_and\_disability\_data\_set\_episodes\_100k.tsv |
| mhldds\_event | NHS D Mental Health Learning and Disability Data Set Events | nhs\_d\_mental\_health\_learning\_and\_disability\_data\_set\_events\_100k.tsv |
| mhldds\_record | NHS D Mental Health Learning and Disability Data Set Records | nhs\_d\_mental\_health\_learning\_and\_disability\_data\_set\_records\_100k.tsv |
| mh\_bridge | NHS D Mental Health Linkage | nhs\_d\_mental\_health\_linkage\_100k.tsv |
| mhmd\_v4\_episode | NHS D Mental Health Minimum Dataset Episodes | nhs\_d\_mental\_health\_minimum\_dataset\_episodes\_100k.tsv |
| mhmd\_v4\_event | NHS D Mental Health Minimum Dataset Events | nhs\_d\_mental\_health\_minimum\_dataset\_events\_100k.tsv |
| mhmd\_v4\_record | NHS D Mental Health Minimum Dataset Records | nhs\_d\_mental\_health\_minimum\_dataset\_records\_100k.tsv |
| proms | NHS D Patient Related Outcome Measures | nhs\_d\_patient\_related\_outcome\_measures\_100k.tsv |
| ons | Office of National Statistics Mortality | office\_of\_national\_statistics\_mortality\_100k.tsv |
| mortality | Office of National Statistics Mortality | office\_of\_national\_statistics\_mortality\_100k.tsv |
| cancer\_staging\_consolidated | GEL Cancer Tumour Linkage | phe\_gel\_cancer\_tumour\_linkage\_100k.tsv |
| breast\_specific\_dataset\_pilot | GEL Curated Cancer Breast | phe\_gel\_curated\_cancer\_breast\_100k.tsv |
| colorectal\_specific\_dataset\_pi | GEL Curated Cancer Colorectal | phe\_gel\_curated\_cancer\_colorectal\_100k.tsv |
| glioma\_specific\_dataset\_pilot | PGEL Curated Cancer Glioma | phe\_gel\_curated\_cancer\_glioma\_100k.tsv |
| renal\_specific\_dataset\_pilot | GEL Curated Cancer Renal | phe\_gel\_curated\_cancer\_renal\_100k.tsv |
| sact\_uncurated | Systemic Anti Cancer Therapy (un curated) | phe\_systemic\_anti\_cancer\_therapy\_un\_curated\_100k.tsv |

March 26, 2026
