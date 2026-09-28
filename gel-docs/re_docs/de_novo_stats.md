---
title: 'De novo data cohort statistics - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/de_novo_stats/
scraped_at: 2026-05-04T06:32:02Z
---

# De novo data cohort statistics

## Trio breakdown

The table below shows the number of families, trios (including nested trios), families with nested trios, and participants within the DNV dataset for the 100kGP V9 Data Release for the GRCh37 and GRCh38 cohorts, as well as the combined cohort. As shown, the minority of families contain nested trios.Â

| Cohort Total | GRCh37 | GRCh38 | Total |
| --- | --- | --- | --- |
| Number of families (total) | 1,762 | 10,847 | 12,609 |
| Number of trios | 1,921 | 12,028 | 13,949 |
| Number of familiesÂ  (from row 1) with nested trios | 151 | 1,134 | 1,285 |
| Number of participants (total, across all families) | 5,447 | 33,732 | 39,179 |

> **Note:**
>
> Please note there are there 11 families that exist on both the GRCh37 and GRCh38 cohorts. Please take this into account when filtering the LabKey tables (use the column: *assembly*).

## DNV breakdown

### Number of DNVs per trio

The table below shows the distribution per trio of Mendelian inconsistencies, *base\_filter* pass, and *stringent\_filter* pass variants for the GRCh37, GRCh38, and combined cohorts. As is shown below, there is a small handful of trios that lie outside of the expected distribution (high rates of *stringent\_filter* pass DNVs for example).Â It was found that 12 families did not have any *base\_filter*Â or *stringent\_filter* pass variants on chromosomes (1:22, X, M) in the GRCh38 cohort.Â 

| >Metric / Cohort | Mendelian inconsistencies GRCh37 | Mendelian inconsistencies GRCh38 | Mendelian inconsistencies Combined | base\_filter pass DNVs GRCh37 | base\_filter pass DNVs GRCh38 | base\_filter pass DNVs Combined | stringent\_filter\_pass DNVs GRCh37 | stringent\_filter\_pass DNVs GRCh38 | stringent\_filter\_pass DNVs Combined |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| **Minimum** | 3,603 | 28 | 28 | 706 | 0 | 0 | 32 | 0 | 0 |
| **1st Quartile** | 5,057 | 5,461 | 5,397 | 1,170 | 771 | 790 | 59 | 61 | 61 |
| **Median** | 5,523 | 5,999 | 5,927 | 1,339 | 916 | 988 | 69 | 71 | 71 |
| **Mean** | 5,753 | 6,248 | 6,177 | 1,377 | 981 | 1,036 | 70 | 72 | 72 |
| **3rd Quartile** | 6,045 | 6,547 | 6,501 | 1,538 | 1,186 | 1,245 | 79 | 81 | 81 |
| **Maximum** | 92,836 | 93,689 | 93,689 | 11,514 | 10,319 | 11,514 | 441 | 1,489 | 1,489 |

\*Â Note that trios derived from families containing nested trios are not counted in the Mendelian inconsistencies.Â

#### Total Mendelian inconsistencies per trio

The below plot shows the distribution of total Mendelian inconsistencies per trio (trios derived from families containing nested trios are excluded) per cohort.Â

Values outside four standard deviations from the mean are not included in the plot.Â

#### Total *base\_filter* pass DNVs per trio

The below plot shows the distribution of total *base\_filter* pass variants per trio (all trios included). A bimodal distribution was observed (left panel) which upon further inspection was shown to be driven by the distribution ofÂ *base\_filter* pass variants for males on the X-chromosome (middle-panel; showing the combined cohort). Additionally, it was observed that on average, more variants pass the base\_filter in the GRCh37 cohort than the GRCh38 cohort (right panel; showing the combined cohort).Â

Values outside four standard deviations from the mean are excluded in the plot.Â

#### Total *stringent\_filter* pass DNVs per trio

The below plot shows the distribution of total *stringent\_filter* pass variants per trio (all trios included). After applying the *stringent\_filter* (which includes flagging of problematic genomic regions; such as simple repeats and segmental duplications), a normal distribution of DNVs per trio was observed - centred around a mean of 72 and median of 71Â *stringent\_filter* pass DNVs per trio across both cohorts.Â Â Â

Values outside four standard deviations from the mean are not included in the plot.Â

### Dropout rate per *stringent\_filter*

The plot below shows the percentage of base\_filter pass variants that fail each of individual stringent filters.Â

### Distribution of stringent\_filter pass DNVs by chromosome

The plot below shows the distribution of stringent\_filter pass DNVs across chromosomes.Â

October 24, 2024
