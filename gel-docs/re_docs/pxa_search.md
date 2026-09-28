---
title: 'Search for participants - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/pxa_search/
scraped_at: 2026-05-04T06:33:23Z
---

Fgenom---
title: Search for participants
tags:
- tools
- no code
- 100kGP
- NHS GMS

---

# Search for participants

Select Search Participants in the toolbar to view the participant search menu with the following options:

- Search by Participant ID
- Compare Multiple Participants by ID
- Search by Participant Details and Clinical History

After selecting an option a set of tabs will become visible, which can be used to navigate between editing the search criteria and different ways to view or download the results. You can switch between the different search options using the icons on the left-hand side in the search criteria tab. Note that doing this will clear any existing search criteria and results.

## Search by participant ID

If you already know the participant ID of the participant you want to view, you can choose to search by participant ID.

Choosing this option enables the Result, Participant and Download tabs.

Enter the full participant ID and hit Enter or click Search.

If the ID is valid, the participant information will be retrieved and displayed in the [Participant tab](../pxa_participant/).

## Compare multiple participants by ID

Use this option to compare up to 12 participant medical history timelines or up to 20 cancer patient journeys.

Choosing this option will enable the Result, Compare, Participant and Download tabs.

Enter up to 20 participant IDs in the search field, separated by commas. Click search or hit Enter to search.

The participants selected for comparison can be reviewed in the [Result tab](../pxa_results/), which shows key details of the participants that match the provided IDs and they appear checked by default.

If one or more participant IDs were not found, a warning message will be visible below the list. To go back and correct the list of participant IDs, click on the Search Criteria tab. You can also choose to ignore the warning and continue with the comparison.

If at least one participant is listed the compare tab is enabled and you may select [one of the comparison views](../pxa_compare/).

> **Note:**
>
> The compare medical histories function is limited to 32000 timeline data points. If the selected participants exceed this threshold, a dialogue box will appear which lets you unselect one or more participants in order to lower the number of data points below the threshold. To aid in this, the dialogue box displays key participant details as well as the number of data points for each participant.

## Video tutorial: how to search with participant IDs

## Search by Participant Details and Clinical History

### General Notes

> **Note:**
>
> Results may include participants with genome data which varies in version and reference genome. We recommend treating these separately in downstream genomic analysis based on the delivery version.
>
> When exporting data, you may need to further filter the exported data to a single genome build or delivery version for analysis, outside of Participant Explorer.
>
> Please also visit the [genomic data FAQs](../genomic_data/#genomic-data-faqs) for more information on our genomic data.

When no values are selected for a field, no filtering is applied to that field and all values may be included in the result.

Sub-sections for Data Source, Participant Details and Clinical Concepts search criteria can be collapsed by clicking in the corresponding headers in the UI. Click on the  icon in each header to see additional information for each of the fields.

### Data Source

| Field | Description |
| --- | --- |
| Genome Build and Delivery Version | The reference genome build and genome data delivery versions available for the participant |
| 100kGP | Selects participants who were recruited to the 100,000 Genomes Project |
| NHS-GMS | Selects participants who have been referred for genomic testing through the NHS Genomic Medicine Service |

### Participant Details

| Field | Description |
| --- | --- |
| Disease Category | The disease category the participant was referred for: cancer or rare diseases. |
| Year of Birth Range | The slider sets a minimum and maximum value for year of birth. The numerical values at each end can be fine-tuned using the arrows. |
| Stated Gender and/or Phenotypic sex | Selected options will match in either of the following data fields: Phenotypic sex classification at birth or Stated Gender of the participant. 'Empty' matches where no information is available in one of the fields. The two fields are separated in the participant view page and in exported data, but can be searched together to work around the lack of phenotypic sex information for many participants. |
| Life Status | Deceased or Alive, based on ONS mortality and referral data. Participants are indicated "Alive" if there is no death reported in the ONS mortality or referral data at the time of the data release. |
| Ethnic Category | "Not Known" and "Not Stated" are values provided at registration. "empty" corresponds to no value provided. |

#### Rare Diseases Category Specific

The following fields are only applicable to participants with a referral in the rare disease category (the "empty" option matches participants for which the information is not available, including participants with cancer referrals only).

| Field | Description |
| --- | --- |
| Proband/Relative | Whether the participant was tested as proband or relative in a referral. |
| Affection Status | Indicates whether the participant is affected by the clinical indication for a referral. |
| Family Members Tested | In NHS-GMS data this is the number of family members who have been tested in the same referral. 100kGP data uses family types, e.g. singleton, duo with mother or father, trio with mother and father. Both value ranges must be used when searching across data sources. |
| Family Case Solved | The "family case solved" status from a referral outcome/exit questionnaire |

### Clinical Concepts

Specify any combination of conditions, observations, procedures, body site(s) and cancer drug treatments to search for matching participants.

You can search by adding and removing concepts. Your query consists of one or more rows, each with one or more concepts.

#### Search logic

You can set "Has Any Of" / "Does NOT Have Any Of" logic within a row. "Has Any Of" matches participants for which at least one of the selected concepts is found in their clinical history. "Does NOT Have Any Of" matches participants for which none of the selected concepts are found in their clinical history. This is equivalent to a logical "NOT" operator; any participant that is not matched by "Has Any Of", will be matched by "Does NOT Have Any Of" using the same set of concepts, and vice versa.

You can use "AND" / "OR" logic between rows, allowing you to build up complex queries.

#### Searching for concepts

Search for concepts by typing part of a code or description into the "Search Concepts" box. This will search all the [coding systems](../pxa_data/#code-systems-overview-using-the-right-codes) used in Participant Explorer for that code or phrase, and display a list of codes that match your search.

Select relevant the code(s) from the drop-down. The selected code(s) will appear above the search in blue. You can also "include all", which will add up to 1000 concepts from your search.

By default, Participant Explorer will return matching codes from all coding systems, however you can restrict this to a high-level clinical concept, namely "Condition", "Observation", "Procedure", "Body Site" or "Drug".
You can also select a specific code system from the "Filter By Code Set" dropdown.

> **Searching with the right codes:**
>
> To find participants, codes in the search criteria must be from the same code system as the codes in the participant data. For example, diagnoses in NHS Hospital Episode Statistics (HES) data, which are coded using ICD-10, can only be found by including ICD-10 codes in the search terms, whereas Diagnoses in the Emergency Care dataset (ECDS), which are coded using SNOMED CT, can only be found by including SNOMED CT terms. See [Data in Participant Explorer](../pxa_data/) for more information on which code systems are used in which data sets.

#### Include descendant concepts (Subsumption)

By default, descendants of the selected terms are automatically included when searching. This means that you don't need to separately select child terms of the terms you've already selected.

For example, if you select ICD-10 "C25 - Malignant neoplasm of Pancreas", you don't need to select C25.1, C25.2, etc., because these will automatically be included in the search.

You can switch off "Include descendant concepts" using the slider at the bottom.

> **Important notes about descendant concepts:**
>
> - For SNOMED CT and HPO terms descendant concepts are obtained from formally defined subsumption graphs. Searching with high-level terms, which can have thousands of descendants, may slow down the search. Participant Explorer allows searching with up to 10,000 descendant codes.
> - ICD-10, ICD-O-3 (topography), OPCS and 100kGP rare diseases code systems provide hierachies which, though not formally defined as subsumption hierarchies, are interpreted as such by Participant Explorer. This includes chapters and code blocks. For example, adding "ICD1O | A00-A09: Intestinal infectious diseases" to the search terms will automically search for all codes within the A00-A09 code-block, if "Include descendant concepts" is enabled.
> - Descendant concepts are not available for code systems without a defined hierarchy, including GMS clinical indications, 100kGP cancer types and subtypes, ICD-O-3 (morphology) and SACT.

#### Include mapped concepts

Select "Include mapped concepts" to automatically add mapped concepts from other code systems to the search criteria. For example, if you select a SNOMED CT concept, the search can automatically include ICD-10 terms that have the same meaning as the SNOMED CT concept in the search, thus potentially finding more participants.

You will see mapped concepts appear above the search in green, along with a count of the mapped concepts found.

If you have used the "Include all" option to include a selection of multiple concepts, mapped concepts for concepts in the selection are represented by a single item. To see which concepts are included, move the mouse pointer over this item.

> **Important notes about mapped concepts::**
>
> - SNOMED CT to ICD-10 and SNOMED CT to OPCS-4 mappings are provided by NHS England. SNOMED CT to HPO mappings are provided by CSIRO.
> - Equivalence of concepts from different code systems is a challenging subject and is context-dependent. Mapped concepts are not always equivalent to the concepts you selected. In some cases, mapped concepts may be wider than the one you selected. To give an example, SNOMED CT concept "5619004: Bardet-Biedl syndrome" currently maps to ICD-10 classification "Q878 Other specified congenital malformation syndromes, not elsewhere classified". We recommend that you review the mapped concepts carefully before executing your search.
> - Mappings are available from SNOMED CT to ICD-10, OPCS-4 and HPO. We do not currently provide mappings for the rare diseases and cancer types in the 100,000 Genomes Project.

#### Adding more rows

Add more rows using the "Add Another Search Term" button. For each additional row, you can specify whether the row is an additional (AND), or alternative (OR) condition.

Precedence rule: first AND, then OR. For example, "Match A AND Match B OR Match C" is evaluated as "(Match A AND Match B) OR (Match C)".

You can modify existing rows using the edit icon at the end of each row, or by clicking anywhere on the row. To remove a row completely, click the bin icon in the top-right of the search term.

## Video tutorial: how to build a cohort with clinical concepts and participant details

## Search results

Any search that retrieves multiple participants will take you to a [search results page](../pxa_results/)

January 19, 2026
