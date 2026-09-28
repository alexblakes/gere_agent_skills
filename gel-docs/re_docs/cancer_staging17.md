---
title: 'Cancer staging statistics 17 - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/cancer_staging17/
scraped_at: 2026-05-04T06:31:39Z
---

# Cancer staging statistics 17

The below statistics were taken from the **cancer\_staging\_consolidated** LabKey table from the 100kGP V17 data release. The table is built from the participant IDs and Tumour Sample Plate-key IDs from the **cancer\_analysis** table which comprises QC-passed and interpreted tumour-normal genome pairs.

### Completion as a percent of samples in the cancer\_analysis table

This table shows the rate of data completion as a percentage of the total number of distinct participants and distinct tumour sample plate-keys in the cancer\_analysis table vs the cancer\_staging\_consolidated table. Please note that this indicates the number of entries (participants or tumour sample plate-keys, respectively) for which we have stage information from one of the three input sources (cancer\_participant\_tumour, av\_tumour, sact) within 12 months of acquiring the tumour sample. No additional checks were conducted.

| # | cancer\_analysis | cancer\_staging\_consolidated | % complete |
| --- | --- | --- | --- |
| Distinct Participants | 15,207 | 12,622 | 83 |
| Distinct Tumour Sample Plate-keys | 16,322 | 13,446 (number of rows in cancer\_staging\_consolidated table) | 82.38 |

### Completion rates of cancer\_staging\_consolidated by each source of staging

This table shows the number and rate of completion of tumour\_sample plate-keys (n = **13,446**) that are linked each of the three sources of staging. Note the link must be within a year of the tumour\_clinical\_sample\_time field from the cancer\_analysis table.

| Source | Number of tumour sample plate-keys | % complete |
| --- | --- | --- |
| av\_tumour | 12,835 | 95.46 |
| cancer\_participant\_tumour | 5,831 | 43.37 |
| sact | 3,523 | 26.20 |

### Summary and Distribution of time-difference days between tumour clinical sample time and staging information

This table shows the summary statistics of the distribution of time (in days) between the tumour\_clinical\_sample\_time and the date of staging data acquisition. This is broken down by the three sources of staging.

**NB:** Note that in the below table and histogram, positive values indicate that the date of staging data acquisition is **before** the tumour\_clinical\_sample\_time. Negative values indicate that the date of staging data acquisition is **after** the tumour\_clinical\_sample\_time.

| Stat | cancer\_participant\_tumour | av\_tumour | sact |
| --- | --- | --- | --- |
| minimum | -365 | -360 | -365 |
| q1 | 0 | 17 | -70 |
| median | 16 | 39 | -49 |
| mean | 31.64 | 57.57 | -39.23 |
| q3 | 48 | 70 | -23 |
| maximum | 365 | 365 | 365 |
| NA | 7,615 | 611 | 9,923 |

The below histograms show the same data but as a frequency distribution.

### Frequency of the nearest staging source to the tumour clinical sample time for each tumour sample plate-key

The below table shows the break down of the tumour\_sample plate-keys (n = **13,446**) by the **nearest** source of staging data. For example if a tumour\_sample plate-key has both linked av\_tumour and sact staging entries, then the nearest entry to the tumour\_clinical\_sample\_time is taken.

| Staging Source | Frequency |
| --- | --- |
| cancer\_participant\_tumour | 4,652 |
| av\_tumour | 7,516 |
| sact | 1,278 |

### Frequency of breakdown by combination of data sources for each tumour sample plate-key

This table shows the frequency breakdown of the three sources of staging data across the tumour\_sample plate-keys (n = **13,446**). For example, if a tumour\_sample plate-key has only cancer\_participant\_tumour and sact data available, then these two data sources are marked as Y.

| cancer\_participant\_tumour | av\_tumour | sact | Frequency |
| --- | --- | --- | --- |
| 0 | 1 | 0 | 5,519 |
| 1 | 1 | 0 | 4,142 |
| 0 | 1 | 1 | 1,748 |
| 1 | 1 | 1 | 1,390 |
| 1 | 0 | 0 | 312 |
| 0 | 0 | 1 | 262 |
| 1 | 0 | 1 | 37 |

October 24, 2024
