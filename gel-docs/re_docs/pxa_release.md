---
title: 'Participant Explorer release notes - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/pxa_release/
scraped_at: 2026-05-04T06:33:22Z
---

# Participant Explorer release notes

## Current version

### v7.0.0 (2026-03-03)

#### New features:

- User interface refresh:
  - Updated user interface throughout the application. Core functionality remains the same.
- Usability enhancements:
  - The search button is now persistent, staying anchored at the top of the screen for easier access while scrolling.
  - A clear filter button has been added to enable single click clearing of the search form.
  - **â** Clickable information icons have been added to provide instant descriptions and context for relevant fields.
  - The Clinical Concepts section has been restructured for better visibility while maintaining all existing functionality.

#### Code migration and maintenance:

Migrated to Vue 3 for enhanced performance, better security, and improved responsive user experience.

#### Fixed defects:

- RENC-7610 Timeout error when search criteria include Affection Status "empty".
- RENC-7797 Missing genome data in search results when search criteria include Family Case Solved.

---

## Version history

### v6.1.0 / [100kGP Data release 19](../release19/) / [NHS-GMS Release 5](../gms_release5/) (2025-10-03)

#### What's new:

- NHS-GMS participants can now be searched for using *Search by Participant Details and Clinical History*
- Participants can be filtered by genome data delivery version and data source
- NHS-GMS clinical indications can be selected when searching by clinical concepts
- NHS-GMS data has been uplifted to release 5

#### Fixed defects:

- RENC-5403 'About' dialog does not include NHS-GMS version and stats.
- RENC-5931 Genome Sequence table - Some delivery dates have a time component (that is not displayed). For these, date/times after 23:00h rollover to display as the following day when the app is used during BST. The date/time is correctly rendered in the timeline.

### v6.0.0 (2025-06-18) / [100kGP Data release 19](../release19/) / [NHS-GMS Release 4](../gms_release4/)

- This is the first version that includes [NHS-GMS participants](../gms_clinical_data/) in addition to [100kGP data](../clinical_data/).
  - NHS-GMS participants are available to be looked up using the *Search by Participant ID* and *Compare Multiple Participants by ID* menu options
  - NHS-GMS participants are *not* available via the *Search by Clinical Concepts* or
    *Search by Participant Details* options.
  - This means that you cannot use Participant Explorer to *discover* NHS-GMS participants yet, but you *can* view them if you have their participant IDs.
  - Search functionality to include NHS-GMS participants will be added in a later update.
- Participant Explorer now uses the [FHIR ServiceRequest](../pxa_data/#conceptual-data-model) concept to model the participant registration (100kGP) and referral (NHS-GMS) events.
- The following known defects have been logged:
- RENC-5403 'About' dialog does not include NHS-GMS version and stats.
- RENC-5404 Timeline - clicking the NHS-GMS Referral data point does not filter the Labkey table by referral ID on data.
- RENC-5405 Timeline - clicking the data point does not open the Labkey table for Genome Sample Collection data points.
- RENC-5536 Timeline - Overlapping data points hide identically named data/dates. For two encounters of the same code on the same date results in only one being visible on the timeline. Both are visible in the encounters table.
- RENC-5590 Download - For NHS-GMS participants with both Rare Disease and Cancer referrals, the Family Case solved value for the Rare Disease referral may appear in the Cancer row. Cancer referrals never have Family Case solved values.
- RENC-5871 Timelines and Encounters table - NHS-GMS Tumour table data with only year values are not available (no day/month in Labkey).
- RENC-5931 Genome Sequence table - Some delivery dates have a time component (that is not displayed). For these, date/times after 23:00h rollover to display as the following day when the app is used during BST. The date/time is correctly rendered in the timeline.

---

### Data release 19 (2025-01-28)

Participant data refresh with main programme data release 19.

---

### v5.6.1 (2024-08-22)

Maintenance release; no changes to data or functionality.

### v5.6.0 (2024-06-04)

#### Features

- Added the capability to search for participants that have had Cancer Drug treatments using SACT data (Clinical Concept search).
- Data points showing the searched for Cancer Drugs are now highlighted in the single participant timeline and appear in the matched
  criteria in the encounters table. Furthermore, the matching drugs can be downloaded from the Download Search Results page.

---

### Data release 18 (2024-04-15)

Participant data refresh with main programme data release 18.

> **Note:**
>
> Due to an issue with the completeness of data in the radiotherapy dataset in data release 18, some diagnoses and procedures from this dataset are not visible in Participant Explorer. For more information, please refer to [the data release 18 release notes](../release18/) and the RTDS table in LabKey, if necessary.

---

### v5.5.0 (2023-10-26)

#### Features

- Event codes in the medical history timeline can be ordered by code, first or last occurrence (for single participants) and frequency (for multiple participants)
- Data points in the medical history timeline can be clicked to view the corresponding source table rows in Labkey.
- Cancer patient journeys can be aligned based on multiple diagnosis codes.

#### Bugfixes

- RENC-203 An error message is briefly visible when searching for multiple participant IDs
- RENC-227 Cancer patient journey hides participants when searching with multiple diagnosis code and using the default alignment.

---

### Data release 17 (2023-07-27)

Participant data refresh with main programme data release 17.

---

### v5.4.0 (2023-07-27)

#### Features

- SNOMED-CT UK Edition code system and maps updated to version 2022-12-21
- Improved lookup of cancer disease types from the 100,000 Genomes Project
- Rare diseases from the 100,000 Genomes Project in medical history timelines now support code grouping

#### Bugfixes

- RPDS-2013 Unable to search for certain ICD-10 codes and some ICD-10 descriptions do not match the official version
- RPDS-5401 Accented characters in ICD-10 descriptions are not displayed correctly
- RPDS-6006 No results for some recruited diseases when searching by concept

---

### v5.3.0 (2023-04-04)

#### Features

- Cancer staging data added to all timelines and download functions (Source: NCRAS AV Tumour, SACT and 100,000 Genomes Project data sets)
- Source table names added to medical history and patient journey timelines and download functions

#### Bugfixes

- RPDS-5451 Help link points to the old RE user guide
- RPDS-5194 Download error when including the Sample Date column
- RPDS-5193 Invalid download column selection after changing the search criteria

---

### Data release 16 (2022-11-03)

Participant data refresh with main programme data release 16.

---

### v5.2.0 (2022-10-06)

#### Features

- New columns available for download under "Condition/Observation/Procedure (matching the search criteria)" on the Download tab:
  - Event Date: the date of the condition, observation or procedure
  - Encounter Type: the type of encounter during which the condition, observation or procedure occurred (inpatient, emergency, etc.)
  - Source Table: the source from which the condition, observation or procedure information was obtained

#### Bugfixes

- RPDS-2375 Download result is frozen after session expired
- RPDS-2380 Participant ID not found after session expired
- RPDS-4038 Login failure message is not visible
- RPDS-4320 Download error when including family case report columns
- RPDS-4347 Unexpected HPO code grouping in the medical history timeline
- RPDS-4565 Unexpected empty search term when searching by clinical concept
- RPDS-4567 "No matches found" displayed before a search is complete

---

### v5.1.0 (2022-08-04)

#### Features

- Download all data points from the single participant medical history timeline
- Download all data points from the medical history and cancer patient journey comparison timelines
- Download format changed to tab-separated (tsv) instead of comma-separated values.
- Improved usability of the search interface

---

### Data release 15 (2022-07-07)

Refreshed participant data with main programme data release 15, including the following new data:

- Cancer diagnoses and morphology codes from the cancer\_register\_nhsd data set

---

### v5.0.0 (2022-03-31)

#### Features

- Cancer patient journey comparison plot
- Additional cancer-related data visible on medical history timelines:
  - drug groups (sact)
  - treatments (av\_treatment)
  - histology (av\_tumour and cancer\_analysis)
- Select participants to compare from any search result

#### Bugfixes

- RPDS-3861 Use specific event date instead of registration date for events other than registration from Genomics England registration data
- RPDS-3639 Use decision-to-treat date instead of administration date for diagnoses and morphology from SACT

---

### Data release 14 (2022-02-17)

Refreshed participant data with main programme data release 14, including the following new data:

- Primary and secondary diagnoses from the Mental Health Learning Disabilities data set
- Data from the Mental Health Services data set:
  - previous, provisional, primary and secondary diagnoses
  - care activity findings and observations

---

### v4.1.0 (2021-12-21)

#### Features

- New search options for all participants:
  - year of birth
  - phenotypic sex
  - life status
  - ethnic category
  - genome build
  - programme
- New search options for rare disease programme participants:
  - proband/relative
  - affection status
  - family group type
  - family case solved status
- Usability enhancements to searching by clinical concept

---

### Data release 13 (2021-11-11)

Refreshed participant data with main programme data release 13

---

### v4.0.0 (2021-10-14)

#### Features

- Compare multiple participants: view the combined medical history timeline of up to 12 participants
- Group clinical codes on the timeline based on subsumption

---

### v3.3.0 (2021-06-03)

#### Features

- Added case solved status and additional comments for rare disease participants

#### Bugfixes

- RPDS-1923 Field label inconsistencies

---

### Data release 12 (2021-06-03)

Refreshed participant data with main programme data release 12

---

### v3.2.1 (2021-05-19)

#### Bugfixes

- RPDS-1925 Code search is not working; ICD10 code lookup is not working
- RPDS-1492 ICD10 codes with 4 digits (e.g. J96.00) have a wrong parent code
- RPDS-1882 Redirect to login after session expiry does not work

---

### v3.2.0 (2021-04-13)

#### Features

- Added diagnoses and treatments from the NHSE Emergency Care data set (SNOMED CT codes)
- Timeline control: view by participant age
- Timeline control: filter by text
- Timeline control: filter by code first letter

#### Bugfixes

- RPDS-1505 Body site codes are not displayed on the timeline
- RPDS-1480 Missing source links for encounters without codes
- RPDS-1482 Source link for Chemotherapy encounters (to the SACT table) does not work

---

### Data release 11 (2021-02-11)

Refreshed participant data with main programme data release 11

---

### v3.1.0 (2020-12-08)

#### Features

- Participant view: added "Genome Sequence" table with information from the sequence report table in the data release: delivery date, plate key, delivery id, genome build, path, type, delivery version and sample collection date
- Timeline: added sample collection date
- Download search results: addition of columns from the genome sequence table

---

### Data release 10 (2020-10-19)

Refreshed participant data with main programme data release 10

---

### v3.0.1 (2020-10-19)

#### Bugfixes

- RPV-177 Medical history timeline is limited to 1000 events
- RPV-182 Link to Help documentation is broken

---

### v3.0.0 (2020-07-31)

#### Features

- The application is renamed to Participant Explorer (previously Terminology Toolset)
- Search by Participant ID
- Participant View including medical history timelines

---

March 3, 2026
