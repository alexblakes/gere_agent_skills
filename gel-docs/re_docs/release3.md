---
title: 'Release V3 (30/04/2018) - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/release3/
scraped_at: 2026-05-04T06:33:42Z
---

# 100kGP Release V3 (30/04/2018)

## Quick View tables

Data views that bring together data from several LabKey tables for convenient access:

| Name of Table / Data View | Description |
| --- | --- |
| family\_members | Data for each participant with available genomes describing which family members also have available genomes and where to find the latest, quality-controlled version |
| rare\_disease\_analysis | Data for all rare disease participants including sex, ethnicity, disease recruited for, build of latest genome, QC status of latest genome, path to latest genomes and whether tiering data are available |
| cancer\_analysis | Data for all Cancer participants including sex, ethnicity, disease recruited for, build of latest genome, QC status of latest genome and path to latest genomes |

### Family members

For each Participant ID:

- Participant type (proband/relative), biological relationship to the proband, phenotypic sex, Rare Diseases family ID
- Intake status (QC failed/passed, awaiting delivery, etc.)
- Genome availability, genome build (reference genomes version 37/38), file path to genome on storage and latest genome delivery (Y/N)

### Rare Disease Analysis

For each Participant ID:

- Participant type (proband/relative), phenotypic sex, ethnic category, Rare Diseases family ID
- Normalised specific disease, tiering availability for proband (Y/N)
- Genome availability, genome build (reference genomes version 37/38), file path to genome on storage and latest genome delivery (Y/N)

### Cancer Analysis

For each Participant ID:

- Phenotypic sex, cancer disease type and subtype, ethnic category
- Sample type, intake status (QC failed/passed, awaiting delivery, etc.)
- Genome availability, genome build (reference genomes version 37/38), file path to genome on storage and latest genome delivery (Y/N)

## Common tables

Data views that are common to both the rare disease and the cancer domains. This data pertains to sample handling, genome sequencing, participant data and domain assignment.

Data Relating to Participants:

| Name of Table / Data View | Description |
| --- | --- |
| participant | Data on each individual participant in the 100,000 Genomes Project:  \* personal information (such as relatives or ethnicity)  \* points of contact with the Project (e.g. handling Genomic Medicine Centre or Trust)  \* a record of the status of their clinical review |
| sequencing\_report | For each participant in the 100,000 Genomes Project:  \* data describing the sequencing of their genome(s) and associated output, as well as the sample type that the sequence is from |
| domain\_assignment | For each participant in the 100,000 Genomes Project:  \* data describing the disease type to which they were recruited and the GECIP domain to which their genome has been assigned for the purposes of administering the publication moratorium |
| tiering | Data describing the variants identified and their pathogenicity for each participant who has been through the Genomics England interpretation pipeline |
| genome\_file\_paths\_and\_types | Data that specifies the genomic files and their folder locations for a given a participant. |

#### Participant

|  |  |
| --- | --- |
| Participant ID | Genomics England case reference (identifier for a Genomics England case, which is a family in the Rare Diseases programme and a participant in the Cancer programme) |
| Variations on Genomics England Case Programme ID | \* which programme the proband was recruited for â 1 for Cancer or 2 for Rare Diseases  \* programme consent status (âfalseâ if consent fully withdrawn or, in the case of primary findings feedback consent, if fully OR partially withdrawn) |
| Handling GMC (or its Local Delivery Partner) and GMC Trust by name and code | \* the registering GMC and Local Delivery Partner  \* the registration date (the date of reported clinical even or observation, e.g. biopsy taken) |
| Names and versions of used information sheets, consent and withdrawal form(s) | \* consent given (yes/no)  \* date of consent / withdrawal of consent (same as registration date, i.e. also refers to date of clinical event / observation)  \* whether or not participant wants additional reproductive or health-related findings  \* full / partial withdrawal (Withdrawal Option) |
| Stated gender (at time of registration) | phenotypic sex (at birth), karyotypic sex; ethnicity (as specified by participant using 16+1 categories as per 2001 census); year of birth |
| Motherâs and fatherâs ethnic category | \* in supplied enumerations or âotherâ  \* other ancestry relevant to clinical findings (e.g. Ashkenazi)  \* consanguinity |
| Type of participant | \* proband or participating relative  \* family Identifier assigned to the proband and their relatives (unique to this duo / trio within each GMC and links related participants)  \* participantâs biological relationship to the proband (e.g. full sib / father / mother / monozygous twin, etc.)  \* the total number of brothers and sisters the participant has |
| Penetrance | \* indication that the disease is not fully penetrant in this family  \* mother / father / number of brothers /sisters affected by same condition as proband |
| Participantâs medical review date and QC status | \* âpassed and suitable / not suitable for diagnostic interpretationâ \* âquery to Genomics Englandâ / QMC or âno QCâ |

#### Genome File Paths and Types

For every participant (marked by Participant ID):

- All the different file types and subtypes received from Illumina (various types of VCF, CSVs, report PDF, genotyping report, CAM, various index files â e.g. BAM index, genotyping VCF index), with respective:
- Path and full path to the file and the name of the file
- Delivery date, delivery ID and platekey (see above definitions)

#### Sequencing Report

- Participant is marked by Participant ID and has corresponding delivery ID. For each one, BAM file size (BAM size) and creation date (BAM date); date the genome was delivered (Delivery Date); version of Illumina pipeline used, i.e. v2 or v4 to process and analyse sequence data (Delivery Version); and the genome build (reference genome version 37 / 38)
- Also a sequence number, QC / intake status (passed / upload failed)
- Also sample type (CA tumour, CA germline, Rare Diseases) and platekey (Plate ID x Well ID â see those entries)

#### Domain Assignment

- Participant is marked by Participant ID and has corresponding disease type to which they were recruited (Recruited Disease Type); the GECIP domain to which the genome has been assigned (Domain); whether the participantâs data is, at dataset issue, under GECIP moratorium; and the date at which the moratorium ends
- Also has Pedigree Family ID, the Genomics England family identifier assigned to a proband and their relatives

#### Tiering

For every participant (marked by Participant ID):

- Biological relationship to the proband, phenotype to report variants for; probandâs father / mother affected (Y/N) and number of full brothers / sisters affected; penetrance
- Panel name (of gene panel used from Panel App) and panel version â can be several different ones (e.g. 9 for Intellectual Disability, including Intellectual Disability)

=> Several different rows, one per panel but values that are participant-linked (above) are the same for each

- For each variant / gene per panel (i.e. more rows): reference allele sequence and alternate allele sequence (as per vcf), chromosome and position; genotype (zygosity as per vcf e.g. alternate homozygous, heterozygous), genomic feature type (gene, transcript, regulatory region), type of consequence (e.g. missense variation, splice region variant, stop gainedâ¦) and mode of inheritance (e.g. biallelic or monoallelic paternally / maternally imprinted or x-linked bi-/monoallelic)
- Tier (1/2/3) and event justification (why the variant would be reported, e.g. Tier + effect on protein + publications + de novo / simple recessive segregation filterâ¦)
- Also the ensembl ID of the genomic features (transcript used), the variant ID in dbSNP (per variant, if applicable), other gene IDs (HGNC), a report event ID (unique for each report event, i.e. per variant, within each report) and group of variants (for each group of variants that together could explain phenotype using inheritance mode)

Each participant is also linked back to Family ID and Sample ID

Data relating to samples:

| Name of table / data view | Description |
| --- | --- |
| clinic\_sample | Data describing the taking and handling of participant samples at the Genomic Medicine Centres, i.e. in the clinic, as well as the type of samples obtained. Because of the complexities of handling and managing tumour tissues samples in a clinical setting, there are many fields that are cancer-specific. |
| clinic\_sample\_quality\_check\_result | Data describing the quality control of obtaining and handling participant samples at the Genomic Medicine Centres, i.e. in the clinic. |
| laboratory\_sample | Data describing the handling of samples at the biorepository and in preparation for sequencing, as well as the type of sample. |

#### Clinic sample

Each sample marked by Clinic Sample ID used for sample collection at GMC clinic. Can be different for different clinics but within each, this ID identifies samples at that clinic and must be unique. Linked to Participant ID.

For each sample:

|  |  |
| --- | --- |
| clinic ID (ODS code) to mark clinic that took it | \* codes for the GMC (and its Local Delivery Partner) / GMC Trust  \* date and time for sample taken  \* reason no sample was sent (sample not taken, tumour ineligible, cellularity < 40% neoplastic cells, insufficient tumour post neoadjuvant, insufficient DNA, no cancer diagnosis, FFPE not well fixed / processed; necrosis > 20%, other)  only reason for not blood is that no tumour was sent or germline successfully sequenced previously, as blood should go together with tumour |
| Tumour ID | \* unique to each tumour even from same patient  \* tumour content |
| Cancer type and subtype | \* pre-invasive in situ elements (if present)  \* any other previous cancer treatment  \* diagnostic codes for the cancer in structured clinical vocabulary â ICD03 or Snomed CT (clinical terms) / RT (precursor) |
| Size and type of tumour sampled for sequencing (primary, recurrent, metastatic recurrent at same site, metastatic) | \* tissue source of sample (e.g. different types of biopsy, resection, bone marrow aspirate)  \* topographical tumour site (ICD or Snomed) |
| Excision margin | \* by how far margin was clear of tumour, or unknown  \* macro-dissection for enrichment (yes / no) and comments |
| Descriptors of the sample, e.g. fixation date / time start and end (with comments) | \* number of biopsies / cores / blocks / scrolls / sections  \* gauge of biopsy / core diameter / scroll or section thickness  \* snap freezing time and date / time in formalin / fixing time (processing schedule â e.g. overnight, rapid run, etc.)  \* type of fixative (for pre-processing) and prolonged sample storage method; tumour sample type for FFPE that DNA was extracted from |
| Whether Genomics England QCs passed | \* the GMC (or its LDP) that did the QC, the laboratory used for sample processing (as with the Laboratory Sample table)  \* date and time when clinical QC test results were received by Genomics England |

#### Clinic Sample Quality Check Result

For each clinical sample (also linked to Participant ID):

- Type of QC test and corresponding value of test result (can be several â e.g. tumour content â medium; cellularity â medium; % necrosis â 0; Qubit â 30; Nanodrop OD 260/280 â 1.9; summary QC â pass)
- Can go to laboratory sample table to check for product type or QCs, then to QC table

#### Laboratory Sample

Data describing the handling of samples at the biorepository and in preparation for sequencing, as well as the type of sample.

For each sample:

|  |  |
| --- | --- |
| Unique lab sample identifier (2D barcode on tube for dispatch from the lab to the biorepository) | \* laboratory ID (could be any laboratory used for any type or stage of sample processing usually a GMC laboratory but could be a blood extraction facility for QC data)  \* GMC (or its Local Delivery Partner) and GMC Trust associated with the sample  \* Participant ID  \* Genomics England plate ID (sent from biorepository to Illumina) and plate well ID (well identifier / location of sample on the plate distributed from biorepository for sequencing to Illumina)  \* plate key (plate ID x well ID = unique ID for a processed well)  \* GMC rack ID and rack well (barcode on the rack containing sample dispatched from GMC and position on the rack (A-H x 1-12); consignment dispatch date (when sample was dispatched to biorepository) and whether and when sample was received at biorepository |
| Sample source | \* for bioinformatics interpretation, cancer sample type â blood, saliva, tissue, tumour, bone marrow, fibroblast  \* whether sample is tumour, germline or âomics; sample type / type description (specific enumerations, e.g. for tumour FF or FFPE  \* for omics RNA blood or for germline constitutional DNA / DNA blood germline)  \* whether sample is from DNA or âomics source (âis DNA sample typeâ)  \* the sample product (blood, DNA, plasma, serum, ctDNA plasma) and sample preparation method (EDTA, FF, FFPE, LIHEP, STRECK, PAXGENE, etc. i.e. Genomics England protocols used for sample handling and processing) |
| Laboratory method | Genomics England protocol used for sample handling / processing |
| Laboratory sample volume (in the laboratory sample tubes as dispatched) | volume of sample leaving biorepository to sequencer after processing |
| DNA amount (sample yield / concentration) | \* biorepository status of DNA quantity (green / red)  \* biorepository DNA concentration (final concentration sent to Illumina post biorepository processing)  \* biorepository degradation of DNA  \* sample quality (% of DNA that is >23kb length) and DNA Integrity value  \* DNA extraction protocol(for tumour sample FFPE, must distinguish between different ones) |
| Sex of the participant associated with the sample | \* sample concentration  \* QC status (passed / not passed sequencerâs criteria)  \* concentration and purity of FFPE samples (delta QC)  \* all as provided by Illumina |
| Delta QC biorepository | \* biorepository QC status (overall result from QC testing â pass / fail) \* biorepository purity of sample measure (OD 260)  \* all as provided by biorepository |
| Genomics England dates and times | for receiving of QC test results file from biorepository, Sample Metadata File from GMC and test results file from Illumina |

### Rare Disease tables

Rare Disease data are presented at the level of Rare Disease families (families of probands), Rare Disease pedigrees and participants. Participants are individuals who have consented to be a part of the project with the expectation that a sample of their DNA will be obtained and their genome sequenced. Pedigree members are extended members of the probandâs family, which will include some participants as well as a number of other individuals who will have no contact with the project, have not consented, but for whom a small amount of data are recorded to allow a full picture of the probandâs extended family to be gathered.

All Rare Disease tables are prefixed by âRare\_diseases\_â at the beginning of the table name.

Data at the Level of Rare Disease Families:

| Name of Table / Data View | Description |
| --- | --- |
| rare\_diseases\_family | Data describing the families of rare disease probands participating in the 100,000 Genomes Project. It includes the family group type, the status of the familyâs pre-interpretation clinical review and the settings that were chosen for the interpretation pipeline at the clinical review. |

#### Rare Diseases Family

Each family tagged by locally-allocated identifier assigned to a proband and their relatives. Should be unique to this duo / trio within a GMC and is the mechanism for linking patients.

For each family:

|  |  |
| --- | --- |
| The family group type | \* trio / duo with mother and / or father  \* singleton |
| Family clinical review QC status codes and description | \* whether family has a) passed medical review and then b) deemed suitable for diagnostic interpretation  \* GMC (or its LDP) at which the medical review happened and date and time of the participant medical review |
| Monogenic likelihood | outdated setting because as per eligibility criteria, all families should like have monogenic disease basis |
| Non-penetrance suspected | condition is known to be non-penetrant or pedigree shows potential non-penetrance (if yes, bioinformatics pipeline runs in incomplete penetrance mode rather than complete penetrance mode) â only after this is signalled at medical review |

Data at the Level of Rare Diseases Pedigrees:

| Name of Table / Data View | Description |
| --- | --- |
| rare\_diseases\_pedigree | Data describing the Rare Disease participants, linking pedigrees to probands and their family members. |
| rare\_diseases\_pedigree\_member | Data describing the Rare Disease pedigree members, similar to the data about each individual participant in the COMMON data view. It includes some additional data, such as the age of onset of predominant clinical features; data on links to other family members; as well as data collected only for Phenotypes. |

#### Rare Diseases Pedigree

- Pedigree-Family ID (Genomics England family, identifier assigned to the proband and their relatives (this is the Proband Participant ID) and Pedigree Proband Participant ID (Genomics England participant identifier)
- As for Common Participant table data for: consanguinity (population / relationship), ethnicity, karyotypic / phenotypic sex, biological relationship to proband, year of birth, ancestries

#### Rare Diseases Pedigree Member

For each Rare Diseases pedigree member (marked by Pedigree Member ID, enabling Genomics England identification of family relationships between pedigree members):

- Member ID of mother and father (to reconstruct pedigree); adopted status (into or out of family) and whether contact lost with family; alive / deceased / aborted / stillborn / miscarriage status; whether member is the proband (true / false); affection status (affected / unaffected / uncertain); also link to member ID (to identify family relationship between pedigree members) and Genomics England Super Family ID for the family
- Age of onset of predominant features (or neonatal), age at / date of death
- Which twin group a member of (if applicable), whether monozygotic (if twin)
- Data collected for Phenotips: Reason for childlessness, gestational age, hereditary status of individual without children, whether family has been clinically evaluated, node number

Data at the Level of Rare Disease Participants.

| Name of Table / Data View | Description |
| --- | --- |
| rare\_diseases\_participant\_disease | Data describing the Rare Disease participantsâ rare diseases. This is as for pedigree\_member\_diseases\_level\_data, with the addition of a date of diagnosis |
| rare\_diseases\_participant\_phenotype | Data describing the Rare Disease participantsâ phenotypes. For each Rare Disease participant in the 100,000 Genomes Project, there are data about whether a phenotypic abnormality as defined by an HPO term is present and what the HPO term is, as well as the age of onset, the severity of manifestation, the spatial pattern in the body and whether it is progressive or not. |

#### Rare Diseases Participant Disease

For each Participant ID:

- Disease group and sub-group (for the Genomics England Rare Diseases list); and normalised terms for those
- Age of onset
- Diagnosis date

#### Rare Diseases Participant Phenotype

For each Participant ID:

- Whether an HPO-defined phenotypic abnormality is present and its HPO term (and the HPO version number)
- Age of onset, progressive / non-progressive status and severity of manifestation (ranging from âborderlineâ to âprofoundâ in five steps
- Spatial pattern in body and laterality

### Cancer tables

Cancer data are presented for either the patient level cancer diagnosis or âdisease typeâ or the tumour specific sample details of participants in the Cancer arm of the 100,000 Genomes Project. All Cancer tables are prefixed by âCancer\_participant\_â at the beginning of the table name.

Data Relating to Cancer Participants:

| Name of Table / Data View | Description |
| --- | --- |
| cancer\_participant\_disease | For each cancer participant in the 100,000 Genomes Project:  \* this table includes data about their cancer disease type and subtype. |
| cancer\_participant\_tumour | For each cancer participantâs tumour in the 100,000 Genomes Project:  \* this table contains data that characterises the tumour, e.g. staging and grading  \* morphology and location  \* recurrence at time of enrolment  \* the basis of diagnosis. |
| cancer\_participant\_tumour\_metastatic\_site | For each cancer participant in the 100,000 Genomes Project: \* this table contains the site of their metastatic disease in the body (if applicable) at diagnosis. |

#### Cancer Participant Disease

For each Cancer participant (marked by Participant ID):

- Cancer disease type (breast, sarcoma, etc.) and subtype (e.g. ductal / lobular breast or Myxofibrosarcoma)

#### Cancer Participant Tumour

For every tumour:

|  |  |
| --- | --- |
| Tumour ID (as in other tables) and Participant ID |  |
| Diagnosis ICD codes | \* ICD or Snomed CT / RT codes for the morphology of the diagnosed cancer and the topographical site of the tumour (and Snomed version used)  \* number of lesions radiologically determined (liver / upper GI); tumour laterality (for cancer relating to paired organs)  \* portal invasion (whether portal vein affected) |
| Basis of diagnosis | e.g. certain clinical / histology tests â see NHS Dictionary  \* Grading (I-IV) and staging (TNM and Integrated TNM version or separately of no integrated TNM supplied)  \* staging for particular cancers:  \* Dukeâs stage for colon cancer  \* AJCC for skin cancer  \* extranodal metastases â notes liver / brain / neck / lung involvement for testicular cancer, plus sub-stages for lung metastases  \* testicular cancer state anatomical groupings  \* pancreatic cancer clinical staging to indicate resectability  \* International Neoblastoma Risk Group  \* BCLC stage-based on anatomic and non-anatomic factors  \* Child-Pugh score for liver  *FIGO  \* alongside classifications versions for these* Recurrence indicator (whether recurrence has been recorded that requires new care plan)  \* whether TACE was previously carried out |

#### Cancer Participant Tumour Metastatic Site

For each Cancer participant (marked by Participant ID) and tumour (marked by cancer participant tumour SK):

- The site of the metastatic disease, if any, at diagnosis, including âmultipleâ and âunknownâ

October 7, 2025
