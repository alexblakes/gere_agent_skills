---
title: 'Access to VIVO Biobank samples for NGRL participants with paediatric cancers - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/vivo/
scraped_at: 2026-05-04T06:34:14Z
---

# Access to VIVO Biobank samples for NGRL participants with paediatric cancers

[VIVO Biobank](https://vivobiobank.org/) is a leading UK research resource dedicated to storing samples and data of cancers affecting children and young people. The VIVOâGenomics England linkage provides a secure, patient-level connection between tumour WGS data in the National Genomic Research Library (NGRL) and biospecimen records held by VIVO Biobank. These data enable cohort discovery and feasibility assessment for studies seeking to combine genomic data from Genomics England with biospecimens or additional clinical data available via VIVO Biobank.

> **Note:**
>
> Linkage is performed at the patient level and does not constitute a direct sample-to-sample match. As such, the presence of a patient match does not guarantee that the same biological sample that was used for WGS is available through VIVO Biobank. You should carefully review confidence classifications and sample metadata (for example collection date, diagnosis, tissue type, storage medium) and engage with VIVO Biobank where clarification is required to ensure the suitability of linked records for their intended research purpose.

We identified 717 matched patients in 100,000 Genomes Project release 19 or NHS Genomic Medicine Service (NHS GMS) release 5.

The linking table has three columns

- A `RE_gel_id`, these IDs are listed as `participant_id` in the clinical data tables.
- A `MATCH_ID`, shared identifier for both datasets.
- A `confidence` designation (high `HC` or medium `MC`)

You can find the linkage file at: `/gel_data_resources/cancer_data_files/VIVO_biobank_matching/GEL_VIVO_matching_190326.csv`

You can [apply to VIVO Biobank](https://vivobiobank.org/researchers/applying) for samples and/or data.

## Methodology

The following patient-level identifiers were used for matching patients:

- NHS number
- Patient initials
- Date of birth
- Sex

These identifiers were used solely for linkage and were processed in accordance with information governance and data protection requirements. All patient identifiers used for matching were encrypted using hashing prior to linkage. This ensured that no identifiable personal information was exchanged or directly exposed during the matching process.

The linkage process did not use sample-level information (such as sample IDs, collection dates, or tissue details), nor did it attempt to reconcile individual sample records between datasets.

Each identified patient match was assigned a `MATCH_ID` and a corresponding confidence classification. Two confidence categories are used:

- High Confidence (`HC`): it includes a matching NHS number between Genomics England and VIVO Biobank records.
- Medium Confidence (`MC`): an NHS number is absent from the VIVO Biobank record, but the individual matches on patient initials, date of birth and sex.

Some participants were recruited through multiple VIVO sites with slightly different data records (for example different name spellings) and therefore some `RE_gel_id`s can match to more than one `MATCH_ID`s. Also, `MC` matches rely on non-unique identifiers and therefore carry a high risk of ambiguity and can match to multiple `MATCH_ID`s. In such cases, we recommend you work directly with VIVO Biobank to determine which record is most appropriate for your specific research use case.

Some participants were enrolled in multiple Genomics England programmes, where WGS data were generated through both the 100,000 Genomes Project and the GMS. As a result, a single patient may have multiple `RE_gel_id`s that map to the same `MATCH_ID`.

## Participants summary

We have compared encrypted data for 1072 GMS participants and 533 100,000 Genomes participants who were under 26 years old at the time of diagnosis, or had a paediatric diagnosis, with encrypted records for 28,923 participants from the VIVO Biobank. The ability to match samples was limited due to the missing data for a significant number of VIVO participants. Some participants missing NHS number might not have been matched due to the spelling differences in their records.

The majority of NGRL participants under 26 years old had haematological tumour diagnosis. The composition of clinical indications for participants with matching VIVO record follows the same distribution and is dominated by haematological tumours, paediatric ALL in particular, but also covers a range of solid and neurological tumours.

May 1, 2026
