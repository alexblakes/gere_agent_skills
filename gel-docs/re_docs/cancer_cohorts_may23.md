---
title: 'Building cancer cohorts and survival analysis, May 2023 - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/cancer_cohorts_may23/
scraped_at: 2026-05-04T06:31:31Z
---

> **Archive training session:**
>
> Past training sessions may include information that is no longer true, in either the presentation or the Q&A. Please double check against the relevant documentation pages.

# Building cancer cohorts and survival analysis, May 2023

Building a cohort is a vital first step in many kinds of genomics studies, such as GWAS, survival analysis and identifying cancer characteristics. The vast array of phenotypic data available in the Genomics England Research Environment (GEL RE), both recruited disease and electronic health records, is a great resource for cohort building and verification.

This training session will go over some of the ways you can build cohorts in the GEL RE: Participant Explorer for no code creation and the Labkey API for programmatic construction and verification. Using both methods, we will show how you can pull out the genomic file locations, or the participant identifiers to use with variant aggregation files. We will also look at how to pull out the relevant data for survival analysis, and run this on cohorts.

You are only allowed to attend this session if you are eligible for data access. This means that you are a Research Network member that has met the necessary verification checks and passed our Information Governance training course. If you do not meet this criterion by 22nd May 2023, you will be unregistered for this session.

## Timetable

13.30 Introduction and admin  
13.35 Parameters and considerations for building a cohort  
13.45 no code cohort building with participant explorer  
13.55 Labkey tables for cohort building in cancer  
14.05 Using the Labkey API in Python and R  
14.15 Survival analysis for cancer cohorts  
14.25 Getting genomic filepaths for your cohort  
14.35 Using your cohort with aggregate VCFs and bcftools  
14.45 Getting help and questions

## Learning objectives

After this training you will know:

- Where to find phenotypic and covariate data for building cohorts in the Genomics England Research Environment
- How to create cohorts using the Participant Explorer no code interface
- How to use the Labkey API to create and verify cohorts with Python or R

## Target audience

This training is aimed at researchers:

- working with the Genomics England Research Environment
- working in cancer genomics
- who can programme in python and/or R (a small segment of the training is suitable for non-programmers)

## Date

23rd May 2023

## Materials

You can access the redacted slides and video below. All sensitive data has been censored.

### Slides

### Video

### Optional exercises

These practice exercises will allow you to try out what you've learned. Feel free to have a go in your own time.

Coding

These exercises are also written into the Jupyter and R notebooks, along with sample code that is a possible answer.

1. Build a cohort of all participants recruited to Genomics England with Colorectal cancer, and verify this diagnosis by checking the secondary NHS England data for the relevant ICD10 code, C18.
2. Pull out the Duke's stage for the participants in your cohort.
3. Identify participants in this cohort who have been treated with Bevacizumab.
4. Find the age at which the participants were diagnosed and segregate the group into those diagnosed at 69 and under, or 70 and over.
5. (Python only) Carry out survival analysis, comparing the two groups diagnosed at different ages.
6. Get the filepaths of the germline BAM files from the original analysis and CRAM files from the DRAGEN realignment for all participants.

No code

1. Using Participant Explorer, build a cohort of participants recruited to Genomics England with Colorectal cancer, who also have the relevant ICD10 code, C18, in their medical records.
2. View the medical history of some of the participants in the cohort and note their Duke's stage and any chemotherapy drugs they've been treated with.
3. Export a table of the cohort including the participants' year of birth, platekey and genome file paths.

[Give us feedback on this tutorial](https://www.smartsurvey.co.uk/s/FPMADY/)

### Q&A

Q&A

How many patients have risk factor data?

Hi Mariana,

Do you mean genetic or phenotypical risk factors?

Genetic polygenic risk scores have been calculated by genomics PLC. These have been made available in for the main-programme under the table: genomicsplc\_prs\_values.

The brevity of these scores is limited to bowel, breast, ovarian and prostate cancer.

On the phenotypical risk factors we have data on age and sex, but smoking status is unfortunately absent.

I hope that answers your question!

---

Is the participant explorer only available to certain users? Should the username and password be the same one I used for Labkey? Asking as I'm not able to log in to participant explorer. Thanks.

Hi,

The participant explorer is accessible from inside the research environment. You are correct, access is through the same credentials you use for Labkey. However, just to confirm that everything is synchronised, the credentials should also be the same you use to access the environment.

If something is not quite right, please open a service desk ticket and our colleagues will have a look for you.

Best regards,
Ronnie

---

Is there any family history (of cancer) data for those recruited under the rare disease programme?

Hi Leigh,

Thatâs a great question. There is no explicit information, but we can retrieve this information through a few different ways.

Youâll notice that in labkey there is a table called cancer\_registry. Some of these records overlap with RD participants, so you can infer from the ICD10 codes a history of cancer.

In a similar fashion, you can look at the hospital episode statistics (hes) with ICD10 codes associated with some cancer types. The hes tables are in Labkey under the heading Secondary Data > NHSE > ae, apc or op.

I hope this can give you some direction on how to interrogate the data.

Best regards,
Ronnie

---

Does the 'sact\_tumour\_pseudo\_id' column in the cancer staging consolidated table contain the same ids as the 'anon\_tumour\_id' column in the sact table?

With data release 17 NCRAS swapped from tumour\_pseudo\_id to a new anon\_tumour\_id.

I believe, to accomodate generation of the cancer\_staging\_consolidated (while maintaining backwards compatibility of the various data sources that go into the table) both are currently in the cancer\_staging\_consolidated table.

Give me a few minutes to confirm this though!

After taking a look at the script assembeling the cancer\_staging\_consolidated I can confirm the sact\_tumour\_pseudo\_id and anon\_tumour\_id are the same in both SACT and the cancer\_staging\_consolidated table

---

Anon\_tumour\_id is a great addition! Is this available for clinical and genomic data?

live answered

---

Hi, I'm wondering how easy it is to obtain progression-free survival data for patients, as opposed to overall survival? I suppose the main piece of information I would need is the date of the patients' first relapse or progression after their initial diagnosis. Would this be in the timeline-type plot in patient explorer, and would this be difficult to extract the raw data from?

Hi Ryan,

This is a tricky question. Our best estimate is for overall survival, as cancer specific progression is not available in the secondary data.

There is one way to infer progression by looking at the treatment cycles in the sact table. You would have to reconstruct the treatment timeline and look for when the treatment cycle was redesigned.

Best regards,
Ronnie

---

Does the partcipant explorer automatically search the latest data

Hi John,

Yes, participant explorer automatically uses the latest data release for any queries.

---

Is there a documentation that explains what each code or value is for example what is 'igc1' for figo in the staging table.

Hi,

You can find more information on how the data is organised through this link: https://re-docs.genomicsengland.co.uk/current\_release/

The av\_tumour table in specific is provided by NCRAS and you can see more details here: https://www.gov.uk/guidance/national-cancer-registration-and-analysis-service-ncras

I hope this gives you the tools to interrogate the data.

Best regards,
Ronnie

---

This is MySQL query format or some other SQL format query. sometimes there are different commands depending on the SQL environment

Hi Anubrata,

It requires the labkey SQL dialect, which is very similar to MySQL. Details on the format can be found here:
https://www.labkey.org/Documentation/wiki-page.view?name=labkeysql

A colleague names it a deviation from Postgres (should that detail matter).

---

Just to confirm, every time you have sample time > diagnosis it is a different tumour?

Hi Mariana,

Not always, sometimes a recurrence of a primary tumour can end up in our data as a ânewâdiagnosis.

In other cases, where a diagnosis date is not clearly defined you can run into issues with linking the sample time/ diagnosis dates. I would reccommend using the cancer\_registry diagnosis dates as a ground truth and supplementing this with other tables to supplement.

We are talking about edge cases here, so generally the above rule leads to accurate matching of sample, primary and secondary data.

---

Are these notebooks available anywhere?

Hi Mariana,

Indeed, they will be shared after the session.

---

How/where are they going to be shared?

Hi,

You can find all our training sessions in the Genomics England Research Environment User Guide. The training session page is available here: https://re-docs.genomicsengland.co.uk/upcoming/

Feel free to watch some of the other tutorials as well!

Best regards,
Ronnie

---

Is the code available too?

the notebooks will be shared after the session - you can run these using the HPC to compute by using jupyter lab.

https://re-docs.genomicsengland.co.uk/hpc\_jupyter/

---

Emily, can you show again how do I get to data\_dictionary from the RE\_docs? Sorry, I blinked!

Hi,

You can find a link to the data dictionar at the top of this page: https://re-docs.genomicsengland.co.uk/current\_release/

Best regards,
Ronnie

---

Hi, how to know the different categories in a given column of data, for e.g the classes of ethnicity in that column?

Depending on the language you are using there are methods of describing / viewing your data.

For instance python has:
DataFrame[âethnicityâ].value\_counts() which will show you the different classes and how often they occur in the data.

R has got the table() or count() [plyr] functions to achieve something similar.

---

As a more generic question, if a more precise age is required (maybe as part of a study looking at early onset stuff), how would we go about requesting that extra bit of information?

Hi,

Iâm not sure if I fully understand your question. Emily explained how to identify the diagnosis date and then work out the age that the participant was when diagnosed with the given condition.

So, this is a general pattern, youâd have to stratify the diagnosis age based on the threshold most approriate for the early onset being investigated.

If you want to give me a bit more detail, Iâm happy to try to give a more complete answer.

Best regards,
Ronnie

---

Hi Chris,
what i meant was whether it is possible to know the classes before downloading the table and uploading it in Jupyter or R?

Thank you for clarifying Anubrata,

Labkey has actually got quite decent data visualisation options. Iâd reccommend opening up the table of interest.

Under the table title you have three buttons [grid view | charts/reports | export | print]

The charts/reports can be used to quickly create a pie or bar chart of specific columns.

Perfect for data exploration!

---

Is this Python package available in the public domain (e.g., PyPI, Anaconda, etc.) or local just to the RE?

Initially this will just be available within the RE - as most of the functions / information require labkey and access to the underlying data to function.

---

Is it possible that the ICD-10 codes are recorded incorrectly? I'm cross-checking ICD-10 codes from the WHO website and searching for C509, C500 and can't find any. Could find C50.0, C50.9, C50.3 though.

Hi,

Well spotted!

Most ICD10 codes stored in Labkey will not have the dot that splits the level 1 from the level 2 ICD10 code. Therefore, when checking this information do not include the dot.

Best regards,
Ronnie

---

How can we calculate the RECIST responses of the cancer patients? Or is there a better way to categorize the responses of the cancer patients in the main cancer programme?

This is something that we are still grappeling with ourselves. NCRAS does give some level of info on response in the secondary data but its not very complete.

We are working on methods to infer responses from the participants clinical path. keep an eye out for the python package to include functions related to this in the near future.

Currently we suggest taking overall survival on a treatment or infer response from treatment paths by taking time from start of treatment to early treatment changes (or going into palliative care).

---

Naive question: can you also obtain the participant\_id from the vcf files?

Hi Ignacio,

Itâs easier if you work from the opposite direction. If you build your cohort from Labkey data, then youâll be able to retrieve the paths for VCF files.

Keep in mind that these files are identified by the platekey ids.

Best regards,
Ronie

---

Thanks so much! when will the scripts / notebooks and videos be released?

/gel\_data\_resources/example\_scripts/workshop\_scripts/cancer\_cohort\_20230523

---

are the scripts only accessible via the research environment?

live answered

---

is there a reason why python is recommended for the survival analysis?

live answered

January 29, 2026
