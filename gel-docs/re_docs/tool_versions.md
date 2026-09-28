---
title: 'Application data versions - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/tool_versions/
scraped_at: 2026-05-04T06:34:09Z
---

# Application data versions

Many of the applications in the RE do not access the data directly, but instead have their own local data stores. This means that there is sometimes a delay in when the data accessed by the applications is updated and there may be differences in the data you can see from different sources.

This table shows the current data version that an RE application or data product is using and when this was last updated:

| Application / data product | 100kGP data version | 100kGP data date | NHS-GMS data version | NHS GMS data date | COVID-19 data version[1](#fn:1) |
| --- | --- | --- | --- | --- | --- |
| [LabKey](../labkey/) | v19 | Oct 2024 | v5 | Aug 2025 | - |
| [The genomes folder](../genomic_data/) | v19 | Oct 2024 | v5 | Aug 2025 | - |
| [Participant Explorer](../pxa_data/) | v19 | Jan 2025 | v5 | Oct 2025 | - |
| Aggregated variant calls ([100kGP](../aggv2/))/[COVID-19](../covid_agg/) | v10[2](#fn:2) | Sep 2020 | - |  | v4.2[2](#fn:2) |
| [Somatic aggregated variant calls](../somAgg/) | v12[2](#fn:2) | Sep 2021 | - |  | - |
| [IVA/OpenCGA](../iva/) | v16[3](#fn:5) | Feb 2023 | - |  | v5[4](#fn:3) |
| [CloudOS S3](../cloudos_data/) | v18 | Apr 2024 | - |  | v7 |
| [CloudOS Cohort browser](../cloudos_data/) | v17[5](#fn:4) |  | - |  | v5[5](#fn:4) |
| CloudOS OMOP | v16 |  | - |  | - |

---

1. Only available in CloudOSÂ [â©](#fnref:1 "Jump back to footnote 1 in the text")
2. Participants from later releases will not be part of these aggregates, however we do provide lists of consented individuals based on current releases in order for researchers to work with this data.Â [â©](#fnref:2 "Jump back to footnote 2 in the text")[â©](#fnref2:2 "Jump back to footnote 2 in the text")[â©](#fnref3:2 "Jump back to footnote 2 in the text")
3. Minus withdrawn participants up to data release v19Â [â©](#fnref:5 "Jump back to footnote 3 in the text")
4. COVID-19 data in OpenCGA can only be accessed via the CloudOS Cohort browser. ISARIC, PHOSP and VITT cohorts are not included in OpenCGA. 89.6% of samples in CloudOS are in OpenCGA and at least 79.8% of samples in OpenCGA are in CloudOS with concordant vcf files.Â [â©](#fnref:3 "Jump back to footnote 4 in the text")
5. Structured/Clinical data version. For variant data versions in CloudOS Cohort browser, see IVA/OpenCGAÂ [â©](#fnref:4 "Jump back to footnote 5 in the text")[â©](#fnref2:4 "Jump back to footnote 5 in the text")

October 13, 2025
