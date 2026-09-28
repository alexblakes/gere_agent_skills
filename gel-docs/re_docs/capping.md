---
title: 'Desktop RAM limits - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/capping/
scraped_at: 2026-05-04T06:31:43Z
---

# Desktop RAM limits

You are allocated 8 GB of RAM per user/RE session. Therefore we recommend that you only use the local environment for "lightweight" research or exploratory work, and the HPC for "heavyweight" batch research.

## How will this impact my session?

Capping at 8 GB of memory should not impact most work. However, R and Rstudio place a substantial drain on the memory usage. You may find such queries run slowly, or may crash. We recommend running such queries on the HPC.

## Will this also affect my HPC usage?

No, not all. We recommend working on the HPC wherever possible.

## Can I monitor the memory usage myself?

You can see the top five applications that are using the most memory with the following command:

``` ps -o pid,user,%``<span class="c-mrkdwn__highlight">mem``,%cpu,command ax | sort -b -k3 -r | head -n 6 ```

The output provides a snapshot of its current memory usage in the form of a percentage of 12GB.

## Managing memory usage in R

When using R you can manage your memory usage by:

1. Remove any unused large objects with `rm(<object_name>)`
2. After object removal, run `gc()`

Removing an object in R will not actually free the memory that it used. Therefore running the gc() command in R will (largely) return the memory to the system.

March 26, 2026
