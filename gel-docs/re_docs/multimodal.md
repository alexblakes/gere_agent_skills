---
title: 'Multimodal data - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/multimodal/
scraped_at: 2026-05-04T06:33:02Z
---

# Multimodal data

We have available images for a subset of cancer participants in 100kGP. These include pathology images of solid cancers, diagnostic biopsy or associated excision specimens.

## Image availability

This table summarises the images available for each cancer type. Image data is available for a total of 7,330 participants, approximately 40% of the 100kGP cancer cohort.

> **Note:**
>
> Some participants are counted against multiple diseases

| Cancer type | Pathology data available - participants | Pathology data available - slides |
| --- | --- | --- |
| ADULT\_GLIOMA | 261 | 1735 |
| BLADDER | 127 | 905 |
| BREAST | 1412 | 24209 |
| CARCINOMA\_OF\_UNKNOWN\_PRIMARY | 51 | 1107 |
| CHILDHOOD | 65 | 1166 |
| COLORECTAL | 1391 | 30434 |
| ENDOCRINE | <5 | 90 |
| ENDOMETRIAL\_CARCINOMA | 593 | 15746 |
| HAEMONC | 27 | 373 |
| HEPATOPANCREATOBILIARY | 83 | 1507 |
| LUNG | 823 | 13055 |
| MALIGNANT\_MELANOMA | 153 | 3048 |
| NASOPHARYNGEAL | <5 | 83 |
| ORAL\_OROPHARYNGEAL | 124 | 3152 |
| OVARIAN | 344 | 10926 |
| PROSTATE | 332 | 8460 |
| RENAL | 654 | 10737 |
| SARCOMA | 762 | 9457 |
| TESTICULAR\_GERM\_CELL\_TUMOURS | 25 | 399 |
| UPPER\_GASTROINTESTINAL | 86 | 2204 |
| OTHER | <5 | 16 |
| Total | 7330 | 138905 |

## How to find the images

To find the images, you will need to use the the linkage file, which links the file locations to the participant IDs. You can query this programmatically with your [cancer cohort](../cancer_cohorts/) to fetch the file locations.

### Linkage file

The linkage file can be found at: `/mnt/pathology-images/pathology_gelid_linkage.csv`

| Column | Description |
| --- | --- |
| `Address` | s3:// address to the file, can be used in AWS to refer to the file |
| `Prefix` | The prefix component of the address coming after the bucket reference but without the filename, e.g. aspera/npic/Data Transfer/Bath/QCd Slides |
| `Name` | The filename, typically in the format `NPIC_nnnnnnnn_nnnnnn.svs`, where the 8-digit number is the NPIC ID and the 6-digit number a hash |
| `Extension` | .svs for Aperio slides used for Pathology |
| Last modified | The time last modified of the slide file, should roughly correspond to the upload time via Aspera, albeit with delays and security checks |
| `Size` | The size of the file object in bytes |
| `NPIC ID` | The 8-digit identifier used for the image by NPIC and on manifests (when available) |
| `participant_id` | The GEL participant ID corresponding to the image |
| `Slide Identifier` | The label on the slide, e.g. 'A5'. |
| `Special Stains` | Judgement by NPIC on whether the slide is H&E or contains special stains or immunohistochemistry. This is incomplete and comes in a variety of formats. |
| `use_this` | True for images which should be used, False for superceded duplicate images |

### Query the linkage table in the desktop

You can query the linkage table programmatically. Follow our tutorial for building a [cancer cohort](../cancer_cohorts/) using the LabKey API to identify a list of relevant participant IDs. For the purposes of the following code, we'll call this list `participant_ids`.

RPython

```
linkage <- read.csv('/mnt/pathology-images/pathology_gelid_linkage.csv')
filtered_linkage <- linkage[linkage$use_this==True, & linkage$participant_id %in% participant_ids,]
filtered_linkage$local_location = gsub('s3://907999473992-pathimages-consent/', '/mnt/pathology-images/', linkage$Address)
cat(as.list(filtered_linkage$local_location))
```

```
import pandas as pd
linkage = pd.read_csv('/mnt/pathology-images/pathology_gelid_linkage.csv')
filtered_linkage = linkage.loc[linkage['participant_id'].isin(participant_ids) & linkage['use_this'] == True]
filtered_linkage['local_location'] = filtered_linkage['Address'].str.replace('s3://907999473992-pathimages-consent/', '/mnt/pathology-images/')
print(filtered_linkage['local_location'].values.tolist())
```

You can now copy the list to use with QuPath.

### Viewing the images with QuPath

You can load [QuPath](https://qupath.readthedocs.io/en/latest/docs/tutorials/index.html) in order to view the images. QuPath is not available on the desktop, you will need to load it via the command line, using the following commands:

```
curl  https://artifactory.aws.gel.ac/artifactory/qupath/releases/download/v0.5.1/QuPath-v0.5.1-Linux.tar.xz --output qupath.tar.xz
tar xf qupath.tar.xz
cd QuPath-v0.5.1-Linux/
cd QuPath/
cd bin
chmod u+x QuPath
./QuPath
```

This will launch QuPath. You can load your image list to view and annotate. For more information on using QuPath, check out their [documentation](https://qupath.readthedocs.io/en/latest/docs/tutorials/index.html).

## Query the linkage table in the CloudOS

You can also access the s3 bucket directly in [CloudOS](../cloudos/). To access in an [interactive session](https://lifebit.atlassian.net/wiki/spaces/CD/pages/813105195/Run+interactive+analysis) you will need to [link the full s3 bucket](https://lifebit.atlassian.net/wiki/spaces/CD/pages/2189033473/Add+or+view+data+from+within+a+running+Jupyter+session#2.-Link-folder-by-S3-link) to the session. Use the bucket:

`s3://907999473992-pathimages-consent/`

Open a Jupyter notebook or RStudio notebook to access and query the linkage file. The following code queries the linkage file using a list of participant IDs called `participant_ids` and pulls out the file locations of the images where you've mounted them in your interactive session.

RPython

```
linkage <- read.csv('/mnt/file-systems/907999473992-pathimages-consent/pathology_gelid_linkage.csv')
filtered_linkage <- linkage[linkage$use_this==True, & linkage$participant_id %in% participant_ids,]
filtered_linkage$local_location = gsub('s3://907999473992-pathimages-consent/', '/mnt/file-systems/', linkage$Address)
cat(as.list(filtered_linkage$local_location))
```

```
import pandas as pd
linkage = pd.read_csv('/mnt/file-systems/907999473992-pathimages-consent/pathology_gelid_linkage.csv')
filtered_linkage = linkage.loc[linkage['participant_id'].isin(participant_ids) & linkage['use_this'] == True]
filtered_linkage['local_location'] = filtered_linkage['Address'].str.replace('s3://907999473992-pathimages-consent/', '/mnt/file-systems/')
print(filtered_linkage['local_location'].values.tolist())
```

You cannot launch the visual interface for QuPath in CloudOS, however it is possible to use QuPath from the command line within an interactive session. For example, following code launches QuPath and converts an image file to tiff.

```
curl  https://artifactory.aws.gel.ac/artifactory/qupath/releases/download/v0.5.1/QuPath-v0.5.1-Linux.tar.xz --output qupath.tar.xz
tar xf qupath.tar.xz
cd QuPath-v0.5.1-Linux/
cd QuPath/
cd bin
chmod u+x QuPath
./QuPath convert-ome "/mnt/file-systems/consent/<image_file_location>.svs" test.tiff
```

> **Note:**
>
> This takes 2.5 hours to convert the 2.7 GB SVS slide to a 1.2 https://ome-model.readthedocs.io/en/stable/ome-tiff/ format.

You can use your preferred command line or python tools for machine learning analysis of the images, either within an [interactive session](https://lifebit.atlassian.net/wiki/spaces/CD/pages/813105195/Run+interactive+analysis) or as part of a [batch job workflow](https://lifebit.atlassian.net/wiki/spaces/CD/pages/813040367/Advanced+Analytics) in CloudOS.

## Pathology investigations and reports

A pathology investigation corresponds to a single surgical event where a mix of tissues may be extracted from a patient, to create a pathology case of multiple slides, which may lead to one or more pathology reports. In general we have one pathology case per participant, but some have more, and these contain a number of slides. We attempted to retrieve the pathology case corresponding to the extraction of tissue for the sequencing exercise (the cancer participants have somatic genome from the tumour) but this is not guaranteed.

> **Note:**
>
> Different hospitals may create different formats for identifiers and reports, and these may have different interpretations.

Pathology reports can also be found within the RE. Use the `pathology_reports` table in LabKey to identify the file locations for participants.

> **Note:**
>
> Pathology reports are heavily redacted reports to ensure participant anonymity, which may limit their usefulness. We are working on new versions of these which will be less heavily redacted, but still maintain anonymity.

Pathology reports are a longitudinal dataset. We have pathology reports associated with cancer for the participant, which may be associated with other cancers, predate the 100K investigation or cover follow-up investigations. We have tried to estimate the 'most relevant' pathology reports to the 100K investigation but this is approximate.

## Limitations of the dataset

#### Limited labelling

- 'Index slides' associated with GEL sequencing are often unlabelled
- Only slide identifiers and some stain data is available, and this is incomplete and comes in a variety of different formats
- In some situations the slides for one participant contain multiple pathology cases which may be temporally separate, this is not documented
- Tumour labels are not available in general

#### Limited completeness

- Cases are not complete and this is not clearly documented
- Only around 40-50% of the 100K Cancer cohort is covered.

### Implications and examples/workarounds

Genomics England sources pathology images from national repositories. As such, the metadata we can provide is limited to what is available from the originating organisations, and may vary in completeness and format. You will need to consider in detail the steps necessary for your research project to succeed and may need to use additional supporting data to get the most out of the slides.

We strongly welcome discussion of how to effectively use the data and are happy to share our experiences and learn how you are working with the data - please reach out via the [Service Desk](https://jiraservicedesk.extge.co.uk/plugins/servlet/desk)!

> **Sample collection date:**
>
> You wish to find the date of the sample collection in order to understand it in the context of the treatment timeline.
>
> As the metadata is not available with the slides, you may make the correct assumption that the case was requested that corresponded to the pathology event where the sample for sequencing was collected, and use the collection date from `cancer_analysis`. Where there are multiple sampling events or if the slides for the participant are discovered to involve multiple cases, you will need to make judgements on whether the data is close enough or the participants will need to be removed from the cohort.

> **Identifying tumour slides:**
>
> You wish to test a method which will generate useful data items but only for tumour slides.
>
> There is limited metadata, and a number of approaches to this. Due to variation in data format and quality between hospitals and cases clinical review is strongly recommended. For colorectal slides we have been able to use machine learning to create tumour labels due to labelling of some tumour slides by pathologists. For other cohorts you may need to do your own labelling, but we would be keen to discuss if we could generalise our machine learning approaches to, for instance, enable you to label a few hundred or thousand slides and for that work to be generalised across the cohort.
>
> If a corresponding pathology report can be found for the investigation (which may involve fuzzy linkage by participant ID and investigation date) then the block key in the pathology report may help identify which slides are tumour slides, using the slide label metadata provided with the slides.

> **Identifying a single slide per participant:**
>
> You wish to test a method but this has been developed to expect one slide per participant (e.g. using data from The Cancer Genome Atlas).
>
> It may be possible to use block keys from the pathology reports to identify a most representative slide, but it is strongly recommended that you involve pathologist expertise to identify ideal slides. Experience has shown that cohorts of hundreds of participants can be reviewed within hours by appropriate experts. The largest disease group cohort has around 1,400 participants with slides.

## Frequently asked questions

Are PD-L1 whole slide images (WSIs) available for 28-8, SP263, and 22C3 assays?

PD-L1âstained WSIs are available, but the specific assay used (28-8, SP263, or 22C3) is not identifiable. In other words, you will know that the slide represents a PD-L1 immunohistochemistry stain, but information about the exact assay version is not provided.

Do you provide antibody or staining protocols?

No. We do not collect antibody and staining protocols, as these vary widely across hospitals in the UK.

Are matched FFPE and frozen slides available for the same tumour that was sequenced?

No. We do not have matched FFPE and frozen slides from the same tumour sample.

Is a pathologistâs interpretation available for the slides?

Yes. We are collecting the original written pathology reports corresponding to the glass slides from which WSIs were created.

Do you have both biopsy and surgical (excision) slides?

Mostly excision (surgical) slides are available, but some biopsies are included. Pathologists can quantify the proportions if you have one in your team.

From how many hospitals is the data collected?

The dataset comes from over 39 NHS hospitals across the UK, providing diverse representation.

Are special stains included?

Yes. We collect H&E, immunohistochemistry (IHC), and other special stains. Special staining protocols are not standardised in the UK and depend on the reporting pathologist.

What does 'index slide' mean?

The index slide is the H&E slide that best corresponds to the Whole Genome Sequencing (WGS) sample. It is hard at the moment to identify index slides.

What other slides are included?

Alongside the index slide, we include additional H&Es, IHCs, and (in some cases) other special stains. Some slides contain normal tissue, and other slides can be a mix of tumour or normal tissue.

What kind of tissue is represented on the slides?

Slides are taken from surgical resections and may include:

- Tumour blocks
- Resection margins
- Lymph nodes
- Other tissue blocks sampled as part of routine diagnostics

How are the FFPE slides processed?

The FFPE slides are routine diagnostic slides processed in local pathology labs, after the initial research tissue was sent to Genomics England. In some cases, the pathology report may reference if the FFPE block was sampled from the same area as the sequenced tissue, but this is not consistent, so index slides are harder to identify.

What scanner and magnification were used?

Slides are scanned at 40x magnification on an Aperio Leica Biosystems GT450 DX (v1.0.1).

Can I compare scans across different machines?

Yes. Some colorectal slides have been rescanned on other scanner providers to allow comparison of machine impact on ML performance. These rescanned images are available in the storage bucket, but have not yet been fully documented. For guidance, please contact the Service Desk.

The following scanners were used for replication scanning:

Roche DP200 (TIF)  
Roche DP600 (TIF)  
Glissando 20SL (SVS)  
S360MD (NPDI)  
S60 v2 MD (NDPI)

Are pathology slides labelled, and with which structures?

Yes, for colorectal cancer specifically. This labelling work for this cancer type was done as a pilot with the National Pathology Imaging Co-operative (NPIC), with potential for expansion to other cancer types in future.

Our collaborators at NPIC labelled 300 colorectal cases (roughly 8K slides) with the labels described below. We can make that available. All labels were reviewed by a clinical pathologist.

The labels include:

- Index slide â clearly indicated (or flagged if missing).
- Normal (non-cancer) slides â labelled as normal.
- Tumour slides â labelled as tumour (includes metastasis in lymph nodes if present).
- Representative slide â indicated
- Lymph nodes (LN) â labelled when present, with comments if metastasis is observed.
- Circumscribed tumour area â annotated for one slide per case.
- Normal background tissue â labelled.
- Stain type (H&E, IHC, special stains) â clearly indicated.

This labelled cohort was then used to develop machine learning-based tumour/no-tumour labels. We've labelled the entire colorectal cohort as either 'tumour' or 'no tumour', which could be released. Contact us if you wish to use this data or the labelling pipeline.

Can I label slides themselves, and share my work?

Yes. You are welcome to label slides using QuPath, which can be used in the research environment using the instructions above. We also encourage you to share your labelled datasets and labelling protocols with the research community within the RE. If you would like to do this, please get in touch with the Service Desk.

February 6, 2026
