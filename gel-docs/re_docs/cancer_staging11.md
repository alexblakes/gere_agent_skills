---
title: 'Cancer staging statistics 11 - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/cancer_staging11/
scraped_at: 2026-05-04T06:31:35Z
---

# Cancer staging statistics 11

The below statistics were taken from the **cancer\_staging\_consolidated** LabKey table from the 100kGP V11 data release. The table is built from the participant IDs and Tumour Sample Plate-key IDs from the **cancer\_analysis** table which comprises QC-passed and interpreted tumour-normal genome pairs.

### Completion as a percent of samples in the cancer\_analysis table

This table shows the rate of data completion as a percentage of the total number of distinct participants and distinct tumour sample plate-keys in the cancer\_analysis table vs the cancer\_staging\_consolidated table. Please note that this indicates the number of entries (participants or tumour sample plate-keys, respectively) for which we have stage information from one of the three input sources (cancer\_participant\_tumour, av\_tumour, sact) within 12 months of acquiring the tumour sample. No additional checks were conducted.

| # | cancer\_analysis | cancer\_staging\_consolidated | % complete |
| --- | --- | --- | --- |
| Distinct Participants | 15,233 | 12,337 | 80.99 |
| Distinct Tumour Sample Plate-keys | 16,350 | 13,101 (number of rows in cancer\_staging\_consolidated table) | 80.13 |

### Completion rates of **cancer\_staging\_consolidated** by each source of staging

This table shows the number and rate of completion of tumour\_sample plate-keys (n = **13,101**) that are linked each of the three sources of staging. Note the link must be within a year of the tumour\_clinical\_sample\_time field from the cancer\_analysis table.

| Source | Number of tumour sample plate-keys | % complete |
| --- | --- | --- |
| av\_tumour | 12,453 | 95.05 |
| cancer\_participant\_tumour | 5,840 | 44.58 |
| sact | 3,322 | 25.36 |

### Summary and Distribution of time-difference days between tumour clinical sample time and staging information

This table shows the summary statistics of the distribution of time (in days) between the tumour\_clinical\_sample\_time and the date of staging data acquisition. This is broken down by the three sources of staging.

**NB:** Note that in the below table and histogram, positive values indicate that the date of staging data acquisition is **before** the tumour\_clinical\_sample\_time. Negative values indicate that the date of staging data acquisition is **after** the tumour\_clinical\_sample\_time.

| Stat | cancer\_participant\_tumour | av\_tumour | sact |
| --- | --- | --- | --- |
| minimum | -365 | -360 | -365 |
| q1 | 0 | 18 | -69 |
| median | 16 | 39 | -49 |
| mean | 31.55 | 57.56 | -37.36 |
| q3 | 48 | 69 | -25 |
| maximum | 365 | 365 | 365 |
| NA | 7,261 | 648 | 9,779 |

### Frequency of the nearest staging source to the tumour clinical sample time for each tumour sample plate-key

The below table shows the break down of the tumour\_sample plate-keys (n = **13,101**) by the **nearest** source of staging data. For example if a tumour\_sample plate-key has both linked av\_tumour and sact staging entries, then the nearest entry to the tumour\_clinical\_sample\_time is taken.

| Staging Source | Frequency |
| --- | --- |
| cancer\_participant\_tumour | 4,679 |
| av\_tumour | 7,245 |
| sact | 1,177 |

### Frequency of breakdown by combination of data sources for each tumour sample plate-key

This table shows the frequency breakdown of the three sources of staging data across the tumour\_sample plate-keys (n = **13,101**). For example, if a tumour\_sample plate-key has only cancer\_participant\_tumour and sact data available, then these two data sources are marked as Y.

| cancer\_participant\_tumour | av\_tumour | sact | Frequency |
| --- | --- | --- | --- |
| 0 | 1 | 0 | 5,339 |
| 1 | 1 | 0 | 4,106 |
| 0 | 1 | 1 | 1,641 |
| 1 | 1 | 1 | 1,367 |
| 1 | 0 | 0 | 334 |
| 0 | 0 | 1 | 281 |
| 1 | 0 | 1 | 33 |

October 24, 2024
