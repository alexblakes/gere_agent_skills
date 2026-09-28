---
title: 'Building a cohort based on phenotypes - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/cohort_may22/
scraped_at: 2026-05-04T06:31:50Z
---

> **Archive training session:**
>
> Past training sessions may include information that is no longer true, in either the presentation or the Q&A. Please double check against the relevant documentation pages.

# Building a cohort based on phenotypes, May 2022

Building a cohort is a vital first step in many kinds of genomics studies, such as GWAS, aggregate variant testing and identifying cancer characteristics. The vast array of phenotypic data available in the Genomics England Research Environment (GEL RE), both recruited disease and electronic health records, is a great resource for cohort building and verification.

This training session will go over some of the ways you can build cohorts in the GEL RE: Participant Explorer for no code creation and the Labkey API for programmatic construction and verification. Using both methods, we will show how you can pull out the genomic file locations, or the participant identifiers to use with variant aggregation files.

During the session, we will discuss the tables in the database which contain phenotypic data, using ICD10 codes for diagnoses in the primary and secondary tables, plus other parameters such as staging and treatment in cancer, or continuous measurements in rare disease. We will also look at covariates that you may wish to consider, such as age at diagnosis, sex and ethnicity.

You are only allowed to attend this session if you are eligible for data access. This means that you are a Research Network member that has met the necessary verification checks and passed our Information Governance training course. If you do not meet these criteria by 23rd May 2022, you will be unregistered for this session.

## Timetable

14.00 Welcome and introduction  
14.05 Parameters and considerations for building a cohort  
14.15 no code cohort building with participant explorer  
14.25 Labkey tables for cohort building in cancer, rare disease and common disease  
14.35 Covariates for cohort building  
14.45 Using the Labkey API in Python and R  
14.55 Getting genomic filepaths for your cohort  
15.05 Using your cohort with aggregate VCFs and bcftools  
15.15 Questions

## Learning objectives

After this training you will know:

- Where to find phenotypic and covariate data for building cohorts in the Genomics England Research Environment
- How to create cohorts using the Participant Explorer no code interface
- How to use the Labkey API to create and verify cohorts with Python or R

## Target audience

This training is aimed at researchers:

- working with the Genomics England Research Environment
- who can programme in python and/or R (a small segment of the training is suitable for non-programmers)

## Time

May 24, 2022 02:00 PM in London

## Materials

You can access the redacted slides and video below. All sensitive data has been censored.

[Slides](../cohort_building.pdf)

[Give us feedback on this tutorial](https://www.smartsurvey.co.uk/s/2HF176/)

Q&A

If I need to look for the fastq files, bam files or the VCF files of a paticular phenotype, ectopia lentis, glaucoma, thoracic aortic aneurysm, where do I need to start my search?

Â Hi - We do not readily provide fastq, but we do indeed provide Bam/Cram/VCF's. These can be found in sequencing\_report and genome\_file\_paths\_and\_types table in Labkey.

However, you can get this from Participant Explorer too. In such case, you would have your cohort filtered on the phenotypes already where at the end you can select for the file paths which will include those references to the bam/vcf files.

Can you search with date? E.g. Tonsillectomy before diagnosis of breast/colorectal cancer.

A: Date-based queries are possible with SQL via the LabKey API in either R or Python, we are aware that some date information may require a transformation of the information to a date-type so that comparisons can be made between tables. LabKey supports many Postgres-like queries. More information in this can be found on the LabKey documentation https://www.labkey.org/Documentation/wiki-page.view?name=labkeySql We also have example scripts available within the Research EnvironmentÂ  at ~/gel\_data\_resources/example\_scripts/labkey which will include some date-based query examples

How can we locate data files (e.g. tumor BAM, somatic VCF etc) if we have Gel id for a patient sample?

A: Next to the path option from cohort browser, as Emily just showed, the easiest way to get access to cancer BAM / VCF files is through Labkey. Matching the patient sample (tumour\_sample\_platekey) in the cancer\_analysis table will have all the paths to the data files.

Is there a separate login for the participant explorer? The GEL login details which work for labkey as well, dont let me in

A: Hi! It should be the same, so in case this does not work for you, it may be best to raise a ticket with our Service Desk. We can take it from there then :)

When you create a list in Participant Explorer, can you get the platekeys in addition to the participant IDs?

A: Yes! At the very end where Emily was exporting the .csv, there is an option to include platekey and/or path etc.

Is there a list somewhere of all the different clinical concepts that we could choose to search on, from the drop-down menu?

A: Hi Helen,

If you want more clinical information specific to the data release, then you can look at the documentation on this link: https://research-help.genomicsengland.co.uk/display/GERE/Main+Programme+Data+Releases

The current data release is v14. The data dictionary whithin this release will list all available clinical information for GEL participants.

If you just a starter, then you can search for ICD10 terms on this website https://icd.who.int/browse10/2010/en.

What is the correct way to get diagnosis date in participant explorer? Specifically for cancer?

Hi Arnav,

You can find dates in the Labkey tables. Diagnosis date is available on the table av\_tumour within the column âÃÃºDiagnosisdatebestâÃÃ¹ or from the cancer\_staging\_consolidated in the column âÃÃºDiagnosis DateâÃÃ¹. The latter is specific to cancer participants. If there is more than one entry per participant it could be that this person had a recurrence or metastasis, so each entry would correspond to an event.

Hi Arnav,

Unfortunately there is no way to export the diagnosis date on the cohort at scale in the cohort browser. As Ronnie eluded, using the labkey API is more suited for that.

It is possible to look at diagnosis dates on an individual participant basis in the cohort browser by clicking on the participant tab. Scrolling down should give you the encounters which shows diagnosis date for each condition selected.

Thanks

I was verifying the "av\_tum\_date\_difference" in cancer\_analysis table, for participants with multiple av\_tumour entries. Can I take a diagnosis date as "tumou\_clinical\_sample\_time" + "av\_tum\_date\_difference" as an estimate?

Hi Arnav,

If you are looking for the best estimate on diagnosis I would suggest using the diagnosisdatebest column in av\_tumour. If the information there is missing you could find the ICD10 code of diagnosis in the hospital statistics.

Ah apologies, I missed the point. The sql script Emily showed matching ER/PR status to samples contained a small check based on the diagnosis dates to match the samples to the correct av\_tumour entry.

Thank you so much!

Sorry I may have missed this - can you search using specific gene IDs

A: The interactive variant analysis (IVA) allows to query for specific gene IDs, as well as consequence types or variant types.

If I want to calculate the age distribution at the time of recruitment for a specific endpoint, which is the age I should take into account for this calculation?

A: Hi,

You can calculate the age at diagnosis, which for rare diseases is Diagnosis Date from the rare\_diseases\_participant\_disease table minus the year of birth from the participant table. For cancer analysis, you can retrieve the Diagnosis Date from the cancer\_staging\_consolidated table and the year of birth from the participant table.

What about relatedness - are calculating this? And consanguinity level?

the participant table contains a column which includes this information in categorical form

Some relatedness is available. Regarding consanguinity, we do not readily make this data available (mostly due to ethical reasoning). However, most genome deliveries will come with an .ROH file.

Furthermore, the participant, rare\_diseases\_pedigree\_member, rare\_disease\_analysis, and rare\_disease\_interpreted in LabKey will have family relationship included too (but is not genetically verified)

When looking at date and age in participant disease tables, why is age of onset sometimes negative and is there a distinction between the -999 and normalised -1 values?

A: Hi Sam, in case the age is -999 or -1 it relates to prenatal disorders. Our Data Dictionary should also mention this, so I would highly recommend you to have a look there too in case you are doubting about other tables/columns and what they mean :)

See: https://research-help.genomicsengland.co.uk/pages/viewpage.action?pageId=66846734&preview=/66846734/66846788/Data%20Dictionary%20Main%20Programme%20v14.xlsx

Is it possible to check how many individuals have been diagnosed with a specific monogenic condition? So the number of individuals per gene/condition?

This type of query will be easier to perform within the IVA Variant Browser. The number of returned records will be provided as a summary but you will also be able to download the resulting list for downstream analysis

Thank you!

Could you please clarify how we should open the Rstudio? Did you mention that we should not open the one in the desktop? Thank you.

The Research Environment supports multiple versions of the R language, we always recommend using the command line to select the correct version of the language before launching RStudio

In case it helps, here is our user guide page with additional information: https://research-help.genomicsengland.co.uk/display/GERE/R%2C+RStudio%2C+and+R+libraries#R,RStudio,andRlibraries-SelectingaversionofRtouse

Where are the notes for the cohort builder on R stored?

A: Hi,

You can find the scripts for this workshop in /gel\_data\_resources/example\_scripts/workshop\_scripts/cohort\_building\_20220524

In this folder, there are scripts for R and Python.

Could you please give as the field name for the HER2 for breast cancer? Thank you for giving as the example of ER and PR biomarkers.

A: Breast cancer ER/PR/HER2 status is available in the NCRAS av\_tumour table. The column names would be er\_status, pr\_status, her2\_status.

Thank you! I have now loaded the correct version of R and the required libraries.

Could tell us what is the correct version of R please (will same me time!)?

We're happy to hear that!

As for the "correct version", we have multiple available but we recommend R/4.0.2 (module load R/4.0.2) as this version of R has the most packages readily installed.

Having said that, if you want to use R on the HPC, you will need to load this version with "module load lang/R/4.0.2-foss-2019b" :)

Is there any documentation on the .netrc thing/ how to use the HPC in GEL? Didn't quite get that bit.

A: Hi,

There is details information on how to set up your .netrc in this page: https://research-help.genomicsengland.co.uk/display/GERE/R%2C+RStudio%2C+and+R+libraries

You also find more information on using Helix on this section of the documentation: https://research-help.genomicsengland.co.uk/display/GERE/4.+In-Depth+Guide+to+HPC+Usage

I may have missed this, apologies, but how do we open the cohort\_building\_training.ipynb in Jupiter? Mine does not open in Jupiter by default. I can open with LibreOffice, but it does not look as nice. Thanks

A: the best way of interacting with the a Jupyter notebook will be to launch a Jypyter session. the commands are listed on this page:

https://research-help.genomicsengland.co.uk/display/GERE/Jupyter+Notebooks+and+Lab

When I run my R script in the terminal, it asks me for more memory space. Is there a way to request more space when running R codes in terminal?

A: Hi! You may want to make use of our HPC as you can set the memory to your liking/requirements. Please find more documentation on the HPC here: https://research-help.genomicsengland.co.uk/display/GERE/4.a+Accessing+the+HPC

While multiple versions of R are available on the HPC too, I do recommend R/4.0.2 as well on the HPC.

If you work with the phenotype data the other way around, i.e. not building a cohort as you are explaning today, but rather starting with extracting variants and getting a list of participants with those variants and going from there to the phenotypes.

To work with this, I have previously loaded the different tables into R with the LabKey API, and have linked my participant ID/platekey ID from the variant tables to the phenotype tables to combine the info.

Is there a better way to do this?

live answered

Great, thanks Emily

Hi

This is specific to CNV, files. I have noticed some participants are run through the DRAGEN2.0 pipeline and have relevant VCF files. However for these patients the "cnv\_tiering\_json" have different kinds of JSON files.

Is the cnv\_tiering\_json made from these DRAGEN2.0 VCF files?

This may require a ticket to answer correctly, but if my memory serves me right the answer is yes, as long as they are part of the same delivery\_id. However, please do feel free to raise a ticket so we can check with the cancer analysis team to get this verified!

Thanks again! This session has been helpful!

Is R or python substantially faster?

Performance between these two APIs is comparable. We have found in internal testing that python is more resource-efficient though

python is generally faster than R, but there are some specific functions in R that are very fast. It depends on your use case mostly.

Labkey has many, many tables (often with duplicate information).Â  How can we determine which is mostÂ  up-to-date (ie is there a table summarizing table content) ?

Hi Paul,

I agree it may sometimes feel overwhelming, but you can find more details on the structure of these tables via the data dictionary on the main release. The documentation is available here: https://research-help.genomicsengland.co.uk/display/GERE/Main+Programme+Data+Releases

The current version is v14 and the data dictionary is at the bottom of that page (itâÃÃ´s an Excel file).

thanks for the link, the content looks informative

I see that Bioconductor is promoted in your docs. Can CRAN and devtools packages also be installed. Also is pip supported?

A: bioconductor and CRAN are accessible within R devtools unfortunately are not. For python use we are able to provide a facility to create private conda environments within the HPC (https://research-help.genomicsengland.co.uk/display/GERE/Personal+Conda+Environments)

When we download a search results output table, and save it >> where does it get saved to? Do we have our own working folders within the RE? Are these backed up?

It went into my "hwarren > downloads" folder

would others see these files in the mounted folders? or private to us?

The /home folder in the RE is private to you only. This however only has 10Gb of storage.

Within a GECIP there is shared storage in /re\_gecip// Depending on how you provide permissions to your folder, it will be open to the specific GECIP, or just yourself.

For new members of GECIP is there a user guide on how to first access all of the data?

I believe Emily is working on "new-starter" documentation, but otherwise I would refer you to the current User Guide as a first: https://research-help.genomicsengland.co.uk/display/GERE/Research+Environment+User+Guide :)

not sure where to find the codes that were shown to us during the training. Could you please clarify this for me? I have logged in the Genomics England.

A: Hi,

If you want to use the Desktop environment, please go to Applications > File Manager and then navigate to this folder (/gel\_data\_resources/example\_scripts/workshop\_scripts/cohort\_building\_20220524). In this folder, there are scripts for R and Python.

what are some of the features/varaibles in the participant table? for example, age is one variable, gender..etc. Could you tell us more about that?

A: Detailed information on any table can be found in the Data Dictionary. So that may help/answer your question!

Please see: https://research-help.genomicsengland.co.uk/pages/viewpage.action?pageId=66846734#Releasev14(27/01/2022)-MainProgrammeReleaseNotev14andDataDictionaryFiles There will be a spreadsheet that you can download and browse through containing all descriptions of all columns.Â

It seems to log us out very frequently - is there a way to increase the time-out, to prevent this happening so often?

live answered

but, like you, I lost my search result that I was half-way through...

do we have to Lower Super Output Area (LSOA) field? Thank you

A: Hi - LSOA would be available from secondary data (NHSE). the did table in labkey has got an ic-lsoa field.

I have a question about the gmc\_exit\_questionnaire in Labkey- how often are cases updated as solved? Are these updated as with data freezes? Also, if a research group submits a diagnosis and that is confirmed by GEL (but say that was not detected by GEL when the data was analysed in the first inatsnce), would that be updated on Labkey?

Hi! This is indeed updated with each data freeze. The gap time can be 3-5 months. Usually 2'ish months before a Data Release a freeze happens, but if a case is solved just that day after it will only be included in the subsequent release, hence 5'ish months based on a release ~3 times a year.

Regarding your second question, if it is formally included in the GMCs report, it should be picked up indeed. I am unsure how often this happens but I see Ana Lisa providing more context :)

Thank you, Roel

Hi! For researcher-identified potential diagnoses (identified in the RE or through internal work), these are triaged by the clinical team and returned to the NHS for review and re-issue of the diagnostic report as appropriate. The updated outcomes data would then be part of a future data release in the RE. There is a lag currently with reporting in the NHS and the clinical labs are veru busy.

Does GEL store any RNAseq or proteomics data?

A: Only very little so far, but we will likely be expanding on this in this year. So keep an eye out for our Data Releases! :)

Will the two-factor authentication page supersede the conventional logon approach?

A: live answered

Are you able to share all the Q&A in a file with us afterwards please, along with the recorded webinar video, etc?

A: live answered

What is the system for contacting the clinician who has been responsible for recruiting the patient to discuss further and consent for further researchÂ  or publication?

Hi! There is a form for contacting clinicians (currently within the Airlock section of the RE) - and reporting potential diagnoses where appropriate. It's a joint form - we review internally and contact the referring clinician. The researcher submitting the form receives a notification when we have written to the clinician. Please do submit requests and we are happy to discuss if you need more info / it's a more complex request.

Thanks, and lovely to be in contact with you after 15 years, hope all is well!

wILL YOU share recording please. I wasn't able to attend the session

A: yes, we will be sending out the redacted recording after the session

When looking at the HES data, it was not clear if you were searching for primary or secondary diagnoses. Was this specified?

A: ALL diagnoses are in HES, both primary and secondary.

January 29, 2026
