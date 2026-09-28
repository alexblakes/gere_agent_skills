---
title: 'Importing data and tools into the Research Environment - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/import/
scraped_at: 2026-05-04T06:32:40Z
---

# Importing data and tools into the Research Environment

For data security reasons, you cannot simply copy files into the RE. If you want to work with your own tools and data within the RE, there are a few ways to do this:

- copy/ paste
- Airlock
- containers

## copy/ paste

You can copy short snippets into the RE.

> **Note:**
>
> We recommend using the mouse to right-click and paste, rather than keyboard shortcuts.

## Airlock

The Airlock is our method of importing and exporting data to/from the RE, requiring approval from our Airlock committee. Read our documentation on [using Airlock](../airlock_tool/) for how to do this.

Here are the guidelines of what can be imported with Airlock:

| Can be imported with permission | Cannot be imported | Requires discussion with Airlock Committee |
| --- | --- | --- |
| Essentially anything relevant to a researcher's project, that Genomics England has the legal right to host inside the RE, and that is not already present inside the RE. Some types of data may require additional agreements from the researcher or a special intake procedure (eg sensitive data on an external cohort, additional data on existing participants) | Data that Genomics England does not have the legal right to host inside the RE | Only very unusual import requests are likely to be referred to Committee |
| For data about specific cohorts where Genomics England has special legal agreements regarding who can access the data, the data can be imported but the Airlock team will need to work with internal software engineers to ensure that the permissioning is correct before making the files available | Data that is already publicly available inside the RE, since the requester will be directed to use the existing public resource instead |  |

## containers

Singularity is installed on the HPC, allowing you to work with containers. Read our documentation on [using containers](../hpc_containers/) for more help with this.

August 13, 2024
