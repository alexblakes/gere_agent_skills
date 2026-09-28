---
title: 'Participant Explorer FAQs - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/pxa_faqs/
scraped_at: 2026-05-04T06:33:20Z
---

# Participant Explorer FAQs

## General

### Is there any help documentation?

Â Yes. The documentation is located [here](../pxa/). The documentation can also be reached from the application, via the menu in the toolbar. Furthermore, there is a page with more technical details concerning the [data in the Participant Explorer](../pxa_data/).

## Code systems browser

### Â What exactly do you mean by "Code System"?

Â "Code system" is a catch-all term for terminologies, classifications, nomenclatures and ontologies, and is also core resource type within the FHIR standard for health data exchange. A code system can be described as a structured set of codes and associated terms for representing concepts in the real world. Code systems can include additional properties for each concept. The structure of a code system typically includes a specialisation hierarchy, but can include other relationship types as well.

### Â Can you add a code system that is not currently included in the code system browser?

Â We aim to include all code systems that may be useful for working with our dataset. If you think we are missing one, please raise a request with the Service Desk.

## Search participants

### Â The result of my search query is different from what I expected (too many or too few matching participants). What can be the reason?

Â If the number of participants that match your search criteria is different from what you expected:

- The code system(s) used in your search criteria may be different from the code system(s) used in the data set. See which code system to use for tips.
- Ensure that "include descendants" and "include mapped concepts" are enabled or disabled as applicable.
- Make sure the logic of the search criteria is what you expect (see the questions about Has Any Of / Does NOT Have Any Of and evaluation of And/Or).

If none of these solve the issue, please raise a ticket with the Service Desk.

### Â Why is the list of encounters empty on the participant details page?

Â If you use the "Does NOT Have Any Of" option in your search criteria, the result includes participants that do NOT have a match for any of the selected codes, therefore the match details do not show any matching conditions, observations, procedures or drugs .

You can untick "Only show encounters matching the search criteria" to see all other encounters.

### Â Why does the search result include codes that I did not select?

By default, all descendant codes of the selected codes are included in the search. This behaviour can be disabled by moving the slider on "include descendant concepts".

### Â How do I know which code systems to use when searching?!

Â The following strategies may be helpful when selecting codes for your search:

Strategy 1: Know which code system is being used for the data you are interested in. This requires a good familiarity with the source data. See the [relevant section in the help page](../pxa_data/) for an overview. Example: when searching for rare disease participant phenotypes, you can use the HPO code system.

Strategy 2: Use the "include mapped concepts" feature, to select codes from one code system (e.g. SNOMED CT), and automatically include mapped codes from other code systems in the search.

Strategy 3: Select relevant codes from as many code systems as possible. The "Has Any Of" logic will match participants that have at least one of the specified codes (or descendant codes), so you can add as many alternatives as you like.

### Â What exactly is the meaning of "Has Any Of" and "Does NOT Have Any Of"?

Â The "Has Any Of / Does NOT Have Any Of" selection controls how the selected codes are used when searching for participants:

- Has Any Of: selects participants for which a condition, observation, procedure and/or drug exists with one or more of the specified codes (or descendant codes)
- Does NOT Have Any Of: selects participants for which a condition, observation, procedure and/or drug with one or more of the specified codes (or descendant codes) does not exist (this is the same as applying a logical NOT operator, i.e. the inverse of Has Any Of)

### Â What is the purpose of "Filter by Clinical Concept"?

Â The term lookup can return a large number of matching terms. "Filter by Clinical Concept" can be used to limit the results of the term search, and make it easier to find the term you are looking for. The filter only affects the term lookup and not the participant search result.

### Â What is the purpose of "Filter by Code Set"?

Â The term lookup returns matching terms from all code systems that are used in the data set. If you know which code set you are looking for, "Filter by Code Set" can be used to limit the scope of the term lookup to a single code set, thus making it easier to select the codes that you are looking for. "Filter by Code Set" does not affect the participant search result directly.

### Â How does the "Search concepts" lookup work?

Â The concept lookup has the following features:

- Multiple-prefix matching. For example, the search string "card abn" will match terms containing a word that starts with "card" plus a word that starts with "abn". Word order is not significant and the matching is case-insensitive.
- Codes, terms and synonyms are included in the search. For example, the lookup result for "renal disease" will include the SNOMED concept "Kidney Disease".
- Code sets included in the search can be restricted by the "Filter by Clinical Concept" selection and the "Filter By Code Set" selection. By default, all known code sets are included (technically speaking, the lookup is based on value sets. Value sets define sub sets of code systems)
- Ranking of lookup results is done by a scoring algorithm provided by Ontoserver. Only the top 50 matches are displayed.

### Â What are the rules governing the order of AND and OR operator evaluation?

Â AND is applied before OR.

For example, a search query that looks like this:

```
Match Any A  
AND Match None B  
OR  Match Any C  
AND Match Any D
```

is evaluated as:

```
( Match Any A   
AND  Match None B )   
OR ( Match Any C  
AND  Match Any D )
```

### Â What is the purpose of the "include descendants" option?

Â When enabled, the search will expand to include all descendants codes of the codes you selected. This allows searching for a concept without the need to explicitly include all its specialisations.

### Â What is the purpose of the "include mapped concepts" option?

Â When enabled, the application will use mappings to automatically add codes from other code systems to your search criteria. Please see the next answer for the sources of the mappings.

The mapped codes are often equivalent to or narrower than the codes you selected, but not always. Please see [Advanced Search Options - Include Mapped Concepts](../pxa_search/) in the help documentation for more information.

Mapped concepts are displayed in green in the search criteria and in the match details. Concept maps are currently available between SNOMED CT and ICD-10, OPCS-4 and HPO. It is not currently possible to un-select some of the mapped concepts in your search criteria; it is all-or-nothing.

### Â Â What is the source of the concept maps?

Â SNOMED CT to ICD-10: [NHS England](https://digital.nhs.uk/services/terminology-and-classifications/)

SNOMED CT to OPCS-4: [NHS England](https://digital.nhs.uk/services/terminology-and-classifications/)

SNOMED CT to HPO: [CSIRO](https://www.csiro.au/)

### Â Which version of the 100,000 Genomes Project and NHS-GMS data release was used for the participant data?

Â The data release versions are displayed in the About information, accessible via the toolbar menu.

### Â I am familiar with the 100,000 Genomes Project or NHS-GMS data release model in Labkey. How do participant conditions, observations, procedures and drugs correspond to tables and columns in Labkey?

Â The help documentation includes a section that describes the [mapping](../pxa_data/) of 100kGP and NHS-GMS tables and columns to the conditions, observations, procedures and drugs that can be searched using the Terminology Toolset.

Furthermore, when browsing participant search results, external link icons are available that redirect to the corresponding source table in Labkey (Labkey login may be required).

### Â Why can I select codes that do not exist in the 100,000 Genomes Project or NHS-GMS dataset?

Â There are two reasons:

1. Queries that include non-existing codes may still yield results, when using the "include descendants" and/or "include mapped concepts" features.
2. A negative search result may be meaningful in some cases (confirmation that our data set does not contain a certain code).

At the same time, we are aware that in many cases it would be helpful to restrict the term lookup to the subset of codes that exist in our data set (plus all their parent codes). We intend to add this option in a future release.

### Â Is it possible to search for negative phenotypes (phenotypes recorded as "not present")?

Â No, a search with HPO terms only matches observations with a positive result. We intend to add support for observations with negative results in the future. Note that by using "Does NOT Have Any Of", it is possible to search for participants that do not have a positive observation.

### Â What exactly is the meaning of "We're sorry, your query could not be processed because one or more of the search terms are too wide (too many descendants)"?

Â By default, a search will include all descendant codes of the selected codes. High-level concepts, such as "Clinical Finding" in SNOMED CT, can have a large number of descendants. For technical reasons, the application can not execute searches that involve more than 10,000 descendants.

### Â Why does the TSV export contain multiple rows per participant?

Â When a selected column has multiple values for the same participant, multiple rows are generated for that participant. A separate row will be generated for each nested group of values, with repeating values in the other columns.

For example: when including *Specific Rare Disease*, the TSV will have two rows for participants that are recruited for two rare diseases, rather than a single comma-separated value. Another example: when including *Code*, the TSV will have a separate row for each different code that matched the search criteria for each participant.

Columns in the "Participant" category only have a single value. Columns in any of the other categories can potentially have multiple values for the same participant.

### Â What is the *Source Code* column for when downloading results?

Â *Source Code* refers to the exact form in which the code occurred in the source data. This can include interpunction or other characters that were ignored by the matching logic.

October 2, 2025
