---
title: 'IVA filter reference - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/iva_filter/
scraped_at: 2026-05-04T06:32:49Z
---

# IVA filter reference

Each browser in IVA presents you with a range of filters that you can combine together in queries. You can save these with an alias for future reference/use.

The following is a list of filters available for each browser:

## Variant browser

| Category | Filter | Type | Description |
| --- | --- | --- | --- |
| **SAMPLE AND COHORT** | ***Sample Filter*** | Platekey | Filter the variants with the alternative allele in a sample. You can add up to three platekeys, this will apply OR logic. |
|  | ***Cohort Alternate Stats*** | Operator (pick-list) and number | Filter the variants based on alternative allele frequency within each study. |
| **GENOMIC** | ***Variant ID*** | Comma-separated list of `chr:position:ref:alt` | Filter variants by one or more variant IDs |
|  | ***Genomic Location*** | Number (`chr:position`) | Filter variants by chromosome/region |
|  | ***Feature IDs*** | Text - autocomplete | Filter variants by SNP and Gene IDs |
|  | ***Gene Biotype*** | Pick list with filter | Retrieve variants within genes of a precise biotype |
|  | ***Variant Type*** | Pick-list | Filter variants of selected type. |
| **CONSEQUENCE TYPE** | ***Select SO terms*** *Add terms from a preset configuration:* | Pick-list (Sequence Ontology terms) | Filter by preset groups of consequence types (Loss of Function, Protein Truncating, Protein Altering, Coding Sequence, etc.) |
|  | ***Or select terms manually:*** | Pick-list (Sequence Ontology terms) | Filter by user-defined consequence types |
| **POPULATION FREQUENCY** | ***Select Population\_Frequency*** | Operator (pick list) and number (text), one for each population study | Filter by alternate allele frequency in population studies. |
| **CLINICAL** | ***Disease Panels*** | Pick list with filter | Filter by genes, genomic locations in pre-configured panels. Additional options to intersect multiple panels, and filter within the panel for Feature type, Mode of Inheritance, Confidence and Role in cancer |
|  | ***Clinical Annotation*** | Choose ClinVar or COSMIC and significance in that database | Filter by ClinVar or COSMIC significance. |
|  | ***Full Text Search on HPO, ClinVAR, protein domains or keywords. Some OMIM and Orphanet IDSs are also supported.*** | Free text | Filter by various annotations. |
| **DELETERIOUSNESS** | ***Protein Substitution Score***  \* SIFT  \* Polyphen | Pick list plus Operator (pick list) and number (text), one for each score (SIFT and Polyphen) | **SIFT score:** Options are either to select a Tolerated/Deleterious qualitative score or to provide a quantitative impact value. SIFT scores <0.05 are considered deleterious. **Polyphen:** Options are either a Benign/probably damaging qualitative score or to provide a quantitative impact value. Polyphen scores can be considered Benign (<0.15), Possibly damaging (0.15-0.85) or Damaging (>0.85) |
| **CONSERVATION** | ***Conservation Score***  \* Phylop  \* PhastCons  \* GERP | Pick list plus Operator (pick list) and number (text), one for each score Phylop, PhastCons and GERP) | **PhyloP:** measure evolutionary conservation at individual alignment sites; they are useful to evaluate signatures of selection at particular nucleotide or classes of nucleotide (e.g., third codon positions, or first positions of miRNA target sites). Positive scores (max 3.0) mean conserved positions and negative scores (min -14.0) indicate positive selection. **PhastCons** estimates the probability that each nucleotide belongs to a conserved element, based on the multiple alignment. They represent probabilities of negative selection and range between 0 (non-conserved) and 1 (highly conserved). **Genomic Evolutionary Rate Profiling (GERP)** estimate the level of conservation of positions. Scores â¥ 2 indicate evolutionary constraint to and â¥ 3 indicate purifying selection. |

March 26, 2026
