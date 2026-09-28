---
title: 'Terminology server - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/terminology_server/
scraped_at: 2026-05-04T06:34:07Z
---

# Terminology server

An HL7 FHIR-compliant terminology server is available in the research environment. The terminology server provides programmatic access to reference data for code systems (terminologies, vocabularies, classifications, ontologies) commonly used within the research environment.

## Endpoint

**FHIR API endpoint: <https://ontoserver.aws.gel.ac/fhir>**

## Examples

The links below are example requests to the terminology server API. Click on a link to open a new tab showing the API request URL and the API response in JSON format.

### CodeSystem Lookup

- [Lookup ICD-10 code H35.6](https://ontoserver.aws.gel.ac/fhir/CodeSystem/$lookup?system=http://hl7.org/fhir/sid/icd-10&version=5.0&code=H35.6)
- [Lookup OPCS code X352](https://ontoserver.aws.gel.ac/fhir/CodeSystem/$lookup?system=http://digital.nhs.uk/opcs&version=4.8&code=X352)
- [Lookup HPO code HP:0000488](https://ontoserver.aws.gel.ac/fhir/CodeSystem/$lookup?system=http://purl.obolibrary.org/obo/hp.owl&version=20191108&code=HP:0000488)

### Valueset Expansion

- [Find ICD-10 codes where the description matches "epilepsy" (first 10 results))](https://ontoserver.aws.gel.ac/fhir/ValueSet/$expand?url=http://hl7.org/fhir/sid/icd-10/vs&version=5.0&count=10&filter=epilepsy)
- [Find all SNOMED CT concepts subsumed by General Anaesthesia Procedure (expansion of an implicit value set)](https://ontoserver.aws.gel.ac/fhir/ValueSet/$expand?url=http://snomed.info/sct/83821000000107/version/20240605?fhir_vs=isa/50697003)
- [Find SNOMED CT diseases matching "ataxia" (implicit value set with subsumption plus filter)](https://ontoserver.aws.gel.ac/fhir/ValueSet/$expand?url=http://snomed.info/sct/83821000000107/version/20240605?fhir_vs=isa/64572001&filter=ataxia)

### ConceptMap Translate

- [Lookup mapped ICD-10 concepts for SNOMED concept Ataxia (20262006)](https://ontoserver.aws.gel.ac/fhir/ConceptMap/sct-to-icd10/$translate?conceptMapVersion=2023-02-15&system=http://snomed.info/sct&code=20262006&target=http://hl7.org/fhir/sid/icd-10)
- [Lookup mapped HPO concepts for SNOMED concept Ataxia (20262006)](https://ontoserver.aws.gel.ac/fhir/ConceptMap/sct-to-hpo/$translate?conceptMapVersion=1.0.0&system=http://snomed.info/sct&code=20262006&target=http://purl.obolibrary.org/obo/hp.owl)

## Documentation

- [FHIR terminology server standard](http://hl7.org/fhir/stu3/terminology-module.html)
- [CSIRO Ontoserver FHIR API](https://ontoserver.csiro.au/docs/6/api-fhir.html)

## Available FHIR Resources

Note: the URLs in this table are used as identifiers in FHIR and don't resolve to an actual web page

### Code Systems

| Name | URL | Version |
| --- | --- | --- |
| 100,000 Genomes Project Recruited Cancer Disease Sub Types | http://genomicsengland.co.uk/recruited-cancer-disease-sub-types | 2023-03-29 |
| 100,000 Genomes Project Recruited Cancer Disease Types | http://genomicsengland.co.uk/recruited-cancer-disease-types | 2023-03-29 |
| 100,000 Genomes Project Recruited Disorders List | http://genomicsengland.co.uk/recruited-disorders | 2023-03-29 |
| Human Phenotype Ontology | http://purl.obolibrary.org/obo/hp.owl | 20191108 |
| ICD-10 | http://hl7.org/fhir/sid/icd-10 | 5.0 |
| ICD-O-3 Morphology | http://hl7.org/fhir/sid/icd-o-3-morph | 20190819 |
| ICD-O-3 Topography | http://hl7.org/fhir/sid/icd-o-3-topo | 20190819 |
| OPCS Classification of Interventions and Procedures | http://digital.nhs.uk/opcs | 4.8 |
| SNOMED CT UK Edition | http://snomed.info/sct | http://snomed.info/sct/83821000000107/version/20240605 |
| Systemic Anti-Cancer Therapy (drug group derived) | http://genomicsengland.co.uk/sact-drug-group | 2023-10-27 (100k-v17) |

### Concept Maps

| Name | ID | URL | Version |
| --- | --- | --- | --- |
| SNOMED CT UK to ICD-10 Map | sct-to-icd10 | http://digital.nhs.uk/sctuk-to-icd10 | 2023-02-15 |
| SNOMED CT to HPO Map | sct-to-hpo | http://csiro.au/sct-to-hpo | 1.0.0 |
| SNOMED CT UK to OPCS Map | sct-to-opcs | http://csiro.au/sctuk-to-opcs |  |

July 15, 2024
