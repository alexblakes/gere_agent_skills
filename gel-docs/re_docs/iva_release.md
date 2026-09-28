---
title: 'IVA release notes - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/iva_release/
scraped_at: 2026-05-04T06:32:51Z
---

# IVA release notes

## v3.2.2 (2025-06-10)

The currrent version comprises v3.2 and 100kGP data release v16 (minus withdrawn participants up to release v19)

#### Features

- Filter variants by variant ID
- Filter variants by cohort alternate allele frequencies

## v2.12.3-1 (2025-01-10)

#### Features

- Filters **History**: provides a history of recent queries in Variant Browser and Case Portal. The history resets when moving to a different tool within IVA. We recommend using *Save filter* for longer term retention.
- Pedigree diagram in the Case Interpreter Case Info page.
- Variant Browser filtering by up to three sample platekeys. This will find variants in any of the samples using OR logic.
- Additional gnomAD exomes allele frequencies.
- Updated Case search page in the Case Interpreter. The filters have moved to a panel on the left, with only search by Proband ID (participant ID) and Sample ID (platekey) available.
- Features and filters not available for use with current dataset removed from interface where possible.
- Individual cases can now be launched in case interpreter from case portal in a new tab
- Genome Browser view added to the Variant Browser and Case Interpreter Variant Browser.
- Many minor interface changes.

---

#### Bugfixes

- Red **TypeError** pop-up boxes on the Variant Browser have been resolved and no longer appear. These were as a result of trying to look up GO and HPO terms, however these were never linked to the genes in the underlying database, which caused the errors.
- Variant browser can successfully process more complex queries.
- Error when reloading Saved filters in Sample Browser, Individual Browser, Family Browser, Disease Panel Browser has been resolved.
- Error when loading "last page" of search results in Case Portal and Sample Browser has been resolved.

October 13, 2025
