---
title: 'Interpretation Request (Rare Disease) - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/interpretation_request/
scraped_at: 2026-05-04T06:32:43Z
---

# Interpretation request (rare disease)

Following rare disease tiering, an [*Interpretation Request*](https://gelreportmodels.genomicsengland.co.uk/html_schemas/Gel_BioInf_Models/2.1.0/InterpretationRequestRD.html#/schema/Gel_BioInf_Models.InterpretationRequestsRD) is sent from Genomics England to the relevant Clinical Interpretation Partners in JSON format. The Interpretation Request contains all of the information needed to display and clinically annotate the case.

The following information can be found within the Interpretation Request JSON file:

- Family pedigree and other family history
- Analysis panels and versions
- Specific disorder
- Tiered variants and tiering version
- HPO terms
- Workspace (NHS Genomic Laboratory Hub or LDP site code)
- Gene panel coverage
- Disease penetrance
- Variant classification

## Location

Interpretation Requests for rare disease are in JSON format can be found under the file path: `/gel_data_resources/main_programme/interpretation_request_rd`

In this location, Interpretation Requests are categorised by genome build, 100kGP release date, and labelled by family ID.

March 26, 2026
