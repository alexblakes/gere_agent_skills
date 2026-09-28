---
title: 'Monthly introduction sessions - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/monthly_intros/
scraped_at: 2026-05-04T06:33:02Z
---

# Monthly introduction sessions

The Genomics England Research Environment provides access to Genomics England data, including genomes, variants and phenotypic data from rare disease and cancer patients from the 100,000 Genomes project and NHS Genomic Medicine Service. Due to the sensitive nature of the data, all analyses on these data must be carried out within the Research Environment and only non-identifiable aggregate data can be exported. To enable this, a variety of tools are available within the Research Environment to segment and analyse the data.

This training session is aimed at newcomers to the Genomics England Research Environment and will introduce what is in the Research Environment, both in terms of data and tools. The basic functionality of the tools will be covered, along with how you can export data and the restrictions on doing this.

## Timetable

13.30 Welcome and introduction  
13.35 Sources and type of data in the Research Environment  
13.50 Tools in the Research Environment  
14.10 Programmatic access to Genomics England data  
14.20 Running command line tools and pipelines using our HPC cluster  
14.30 The Airlock, restricted import and export of data  
14.45 Getting help and questions

## Learning objectives

After this training you will know:

- what data can be accessed in the Genomics England Research Environment
- the functions of the Participant Explorer, LabKey, IVA and IGV
- what APIs are available for exploring the data
- the kinds of jobs you can run on the HPC cluster and when you might use it
- how to import and export data from the Genomics England Research Environment using Airlock
- how to use the documentation to learn more

## Target audience

This training is aimed at researchers new to the Genomics England Research Environment

## Dates

These sessions are heard on the third Tuesday of every month. You can sign up for future sessions:

| Date | Details and registration |
| --- | --- |
| 19th May | [register](https://www.genomicsengland.co.uk/events/research-environment-training-session-introduction-to-the-research-environment-may-2026) |

## Materials

You can access the redacted slides and video below. All sensitive data has been censored.

### Slides

[Slides](../intro_slides.pdf)

### Video

[Give us feedback on this tutorial](https://surveys.genomicsengland.co.uk/s/6CBC40/)

Q&A

### 21/4/2026

For the cancer samples, do they tend to be taken pre-treatment or post? I assume it is specified

The sampling time will vary by participant. Generally this will be a sampling for diagnistic purposes and not for treatment evaluation prurposes. The treatment information provided to Genomics England by the NHS will be post diagnosis

---

Sorry might have missed this, but do you have survival data for patients?

We have mortality data, however, this is not incomplete. Participants that are in the mortality table can be confirmed to be deceased but those not listed cannot be confirmed as still alive.

---

within the vcf files, sex and mitochondiral chromosones are present too?

VCF data will contain variants in all mappable parts of the human genome, this includes ChrX, ChrY and mtDNA. You should be aware that the PAR regions may not be fully mapped to the relevant chromosome

---

Is there a page which describes the standard cancer pipelines that have been run? In terms of analyses and programs run i.e. GATK â¦

You will find released technical infromation on the following page:
https://re-docs.genomicsengland.co.uk/further\_reading/

I believe that you will find the following helpful:
https://re-docs.genomicsengland.co.uk/illumina\_cancer.pdf
https://re-docs.genomicsengland.co.uk/cancer\_analysis\_5\_2.pdf
https://re-docs.genomicsengland.co.uk/cancer\_tech\_1\_11.pdf

---

is this regard, can you share a documentation link where I can read about about the available vcf files and relavent data. Thanks.

Please review the documentation provided in my previous reply as these should be helpful.

---

In terms of Python, does your installation come with key packages (e.g. scikit-learn, numpy, pandas etc) already installed? Or do we need to bring in our own Python installation in a container?

The Research Environment has the ability to access PyPI and a limited number of Conda channels. We recommend researchers build and maintain their own conda environments as this will reduce the friction to your research work.

For more information please review the following page:
https://re-docs.genomicsengland.co.uk/hpc\_conda/

Tghe above being said if you have a container with all the requirements you need installed, this can be imported. Please erview the following for instructions:
https://re-docs.genomicsengland.co.uk/containers\_step\_by\_step/

---

what usually tells you it's time to move from the interface into Python/api based analysis rather than staying in the UI?

The API will provide the ability to make more complex queries of the LabKey database in a more efficient manner, pulling large tables into your working environment and combining/filtering these outside of the database will slow your research down and is more error prone.

---

How much storage does each user get?

The $HOME directory is limited to 10Gb, this should be used mainly for configuration files. There are Mounted locations that should be used.

/re\_gecip or /discovery\_forum should be used for files that need to be shared or be longer lived. Temporary files should be sent to /re\_scratch.

---

how can I find my project IDs?

The LSF project ID will be connected to the work that you are doing, this can be found from the following list:
https://re-docs.genomicsengland.co.uk/lsf\_codes/

For a specific ID you can review your project submission in the Research Registry

---

do you have your own HPC? or is it provided by Amazon or by an academic institution with that resource as Queen Mary University of London?

The HPC is a fixed resource that is managed by Genomics England.

---

when should I use CloudOS and when should I use HPC?

CloudOS will contain some specific datasets that have high resource requirements for working with, such as AggV3 or the COVID dataset.

For development work and some phenotypic work I would recommend starting this in the HPC before migrating your efforts to CloudOS

---

also what should never be done interactively in CloudOS?

Interactive sessions are by their nature limited and will not be suited to largescale work, whether this is in the HPC or CloudOS.

I would recommend getting comfortable with the CloudOS interface with smaller explaoratory projects before launching into larger projects that will eat up time and resources for pottentially minimal gain.

---

what are the most common reasons exports get rejected?

using participants tha have withdrawn at the time of start of the project. Be sure that you have checked the consent status of the participants at the start of your study

---

what kind of mistakes?

I belive that Emily has answered this.

---

How does it work with intermediary results? Say I have some pipeline that produces a data matrix with samples x derived features, and I want to run some different analysis on that output - would I be able to run the first part, produce that intermediary output, then run my analysis on the second part as separate jobs? Or do I have to run the whole thing as one pipeline?

You can run more than one pipeline on the data, these will need to be run within the Research Environment.

---

How do we get access to out approved research project in re\_gcip? My supervirosr requested which projects (folders) I need access to but this has not worked as it says I donât have access

please raise a service desk ticket for this type of issue as my colleagues there will be in a better position to provide assistance

---

Are data outputs shareable between different people on a project? e.g. if someone else on the research project has produced an output that I want to use, is there a way for us to share that between us, or do I have to run it myself?

Results are shareable within the Research Environment, this is the main goal for which the /re\_gecip or /discovery\_forum directories where set up.

---

Apologies if this has somewhat already been answered, but are aggregated results/contingency tables normally fine for Airlock, as long as there are no counts < 5?

Ideally the data that you are looking to export should be in a form that is needed for publication or presentation at a meeting, preliminary results that require additional work should be futher analysed within the Research Environment.

---

thanks Emily. One last question, when is a container the right choice rather than just using the existing environment?

live answered

### 17/3/2026

Will we have access to these slides?

The training slides will be available on the Training section of the RE documentation site:
https://re-docs.genomicsengland.co.uk/upcoming/

---

I have a question about a text editor like BBEdit. Can we request it? and is there RNA-seq data for the tumour like gene expression level for cancer? I am a registered member, but cannot locate RNA-seq for cancer , thanks

Text editors exist within the RE. We will support a limited number of tools and will generally not provide additional tools if a tool exists that provides the same functionality. This is to ensure that we able to support the tools that we can provide as fully as possible.

With regard to the specific tool, I do not know off the top of my head which editors we have outside of VScode.

---

could we have the ppt slides afterwards? :)

The training slides will be available on the Training section of the RE documentation site:
https://re-docs.genomicsengland.co.uk/upcoming/

---

Is there any RNA-seq for tumour and gene expression in GeL? thanks

There is a limited ammount of RNA-Seq data available, currently it is limited to the Rare Diseases cohort in the 100K GP

---

Is there any RNA-seq for tumour and gene expression in GeL? thanks

Many thanks

---

I am new. I have downloaded AWS. I have entered the code, put my GEL id and password. when I enter the authenticator app code from google authenticator, there is an authentication failed message. Is there anything I am doing wrong

For these types of issues I would recommend you reach out to our colleagues on the Service Desk as they will be able to provide more bespoke assistance, and verify if your attempts have locked the account temporarily

---

is there a possibility to acces RE without AWS? My institution does not allow me to download this

Currently the only option wil be to use the app. We will be updating the Operating system in the comming weeks which will make the RE compatible with the browser client. Please register for announcements and look out for the launch of this update.

---

will the recording of this session be shared after?

Previous sessions have been recorded and are available on the Training section of the RE documentation site:
https://re-docs.genomicsengland.co.uk/upcoming/

please look for the Introduction to the RE sections of the menu

---

The research project takes 30 days to approve before one can use airlock?

You can do some preliminary review of the data in the RE before registering a project, however, you will be expected to have defined a project and submitted it for approval. Once it is approved we feel that it would take at least 30 days to complete the work. At which point you will be able to submit an export request that can be assessed.

Prior to this timescale the Airlock comittee will not assess the request.

---

for variants vcf, should we go the latest version and folder like Labkey youâve mentioened? is it same data as IVA?

live answered

---

do you offer 1-1 or small group training?

live answered

---

Do you have genomes for healthy individuals?

live answered

### 20/1/2026

---

What is difference between bam and cram file?

live answered

---

Apologies if I missed. Can we access this data? Or R scripts?

live answered

---

Hi, sorry if it is a daft question. I only received access last week. How do we access Research platform to use labkey and participant explorer.

[https://re-docs.genomicsengland.co.uk/access/](../access/)

---

---

Can I access internet while doing analysis in RE?

live answered

---

---

The training sessions are in person or online?

live answered

---

### 16/12/2025

---

How long does it take for a project to get approval? What is the approval process?

live answered

---

Thank you for this comprehensive training session. I do not currently have a project, but I would like to register.

<https://www.genomicsengland.co.uk/join-us>

---

Does each research project receive a set amount of nodes, and do you have to pay for more nodes in the HPC?

live answered

---

I have a project of germ cells sequencing data to be analized

live answered

---

would you have an eta on when the charging may change?

live answered

---

### 21/10/2025

---

do well separate permissions to access 100K genomes and NHs GMS data? Thank you

live answered

---

in case we want to re-align the fastq files with our own reference sequence, can it be done?

live answered

---

Are the available VCFs germline or somatic variant called?

live answered

---

Would Labkey only contain information on participants with tiered variants or all participants?

live answered

---

Are pro bands just for individuals with rare disease or cancer too?

live answered

---

Are germline samples sequenced for blood cancers too? If yes, what tissue source is used?

Germline samples from blood cancer participants are mostly from saliva. You can also check the `cancer_analysis` table for all participants, which includes the source of the germline sample.

---

are there GMS data in IVA for rare diseases or it just the 100k ?

live answered

---

Is there a way to query for variants in a certain gene and link to phenotypic data?

live answered

---

Are all variants available through IVA or only small variants? Asking this because documentation says: "Interactive Variant Analysis (IVA) a variant store. It allows you to access and filter all SMALL VARIANTS found in 100kGP participants."

live answered

---

can you please have that as a message when the login node starts, as a reminder? that this is the login node

live answered

---

How can I get help setting up login with OKta.

https://jiraservicedesk.extge.co.uk/plugins/servlet/desk

---

do you know the right extention to import a modle to RE ? or the right way to import a model. trained model on different data

You are very welcome to import trained ML models, and once they are inside the RE you are welcome to use the model to generate research insight s directly, or to use GE data as a testing set to test the model performance. You are then very welcome to request these outputs for export: research results will be reviewed according to the usual rules, model performance statistics should usually be safe for export so those I imagine would always be approved for export (but there may be some edge cases). HOWEVER under our current ruleset you cannot export trained ML models from the RE: you are welcome to train a model on GE data inside the RE if you wish to, but the model will be stuck inside the RE and will not be possible to export unless and until we revise the rules. You can read the full details of our current rules around ML work here: https://re-docs.genomicsengland.co.uk/airlock\_ml/ . PLease note that we are still revieiwng these rules and exploring options to potentially enable trained ML model exports in future, though we cannot guarantee that this will ever be possible

Oh also to note, for trained model import we will ask the importer to please take responsibility for ensuring that all of the data used to train the model is data that you had valid approval to use (valid license if licensed data etc) and that is safe to host inside the RE

---

Would the structural variant workflow work also for expansion hunter output variants (ie repeat variants)?

https://re-docs.genomicsengland.co.uk/structural\_variant/

---

Do you have a limit to the size of data to import?

5GB

### 16/09/2025

---

What is the approved/easiest/fastest way to get in touch with the referring clinician of a case of interest, say after a search through IVA?

[https://re-docs.genomicsengland.co.uk/cri/index.md](../cri/)

### 19/08/2025

---

I read that the the Genomics Pathology Imaging Collection (GPIC) initiative would add pathology data to the 100,000 genome projects - is this available yet?

Hi Katherine,

Anonymised pathology reports for nearly 16,000 participants are available since release 16 and the file paths can be found on the pathology\_reports table. However, I believe you may be referring to another data set. I know our multi-modal team are working on expanding the pathology reports offering but I have not heard about exact timelines for them to become available.

I hope this helps.

---

Mhmm yes I think it was whole slide images - it was announced in this Nature Medicine correspondence from 2022.

https://www.nature.com/articles/s41591-022-01798-z

I sent digitalimaging@genomicsengland.co.uk an email per the article, but they havenât replied.

Iâve reached out to the team internally, Iâll let you know if I hear from them before the training ends

---

---

I have completed the IG training and I have tried everything, I still canât log into the RE. User desk said I have access but still canât get in. Would it be possible to speak to a âhumanâ who can help me through the steps?

Thanks

Iâm sorry to hear that. Can you paste here your Service Desk ticket so that we can follow it up?

Have you followed all steps described on this page? https://re-docs.genomicsengland.co.uk/access/

---

### 20/05/2025

---

are GPUs available in the HPC?

We do not have GPU nodes within the HPC, there are some limited GPU options within the CloudOS platform but this is out of scope for this training. Please raise a support ticket for more information.

---

How does the RE handle collaboration within a research group? If I have a student who registers for access and is approved, would she have access to my files on the HPC?

There are number of ways to provide access to files that you generate, there are standard `chmod` permissions allocation but we also have implemented ACLs on the HPC filesystem (documentation is upcomming) for finer grain access control.

---

For import or export from hpc, are we not allowed to use scp command?

No, these commands will not work, they may also get flagged to security as attempts to circumvent our data protection policies and may result in loss of access to the Research Environment.

If you are thinking of copying data from the VDI to the HPC, it is not necessary to use these tools as the HPCâs filesystem is also mounted on the VDI.

---

For job submissions, is it better to bsub from an interactive session or can i submit from main node?

It doesnât make a difference but better partice is to submit it from the login node

---

### 15/04/2025

---

If I import data of patients I have already to analyse together with that of fewer than 5 patients in the GEL research environmnet, can that be used? Or do there have to be >5 participants from GEL data alone?

Great question! You can put in a request to import data via Airlock and analyse this. However in reports output from this analysis, you will have to refer to â<5 participantsâ when discussing data on Genomics England.

---

Hi, Thanks for the meeting.
Are variants shown in IVA already filtered? Against MAF or something?

What is in IVA (100k only or NHS GMS as well)?

I am not able to search for genomic locations â is there a trick to it?

live answered

---

I have seen the following for some participants under additional comments for family:

âThis case was closed by Genomics England on behalf of North Thames as per deviation ticket XXX.â What does this mean?

Hello! There is an answer to this question here: https://re-docs.genomicsengland.co.uk/exit\_questionnaire/ . Essentially, this means that the GMCs have reviewed the case without closing it (e.g. because they could not conclude the case based on the information provided, but there are many reasons for this).

---

Hi,
Thank you for this session! I completed the Information Governance course this morning and have read/signed the documents advised in the initial welcome email but can't seem to actually access the RE. Am I missing something?

live answered

---

Will IVA include NHS GMS at some point please?

live answered

---

Hi! This session was really helpful! I have completed the Governance course last week and in the training website my name is different as It is different on the certificate as well, I have raised an issue in the service desk but havent heard back from them, What can be done?

can you send me your ticket ID - Iâll chase up

---

### 18/03/2025

---

Is one able to look within 100K Genomes and GMS data at all rare variants in a prespecified gene with a rapid query (i.e. what gnomAD allows in its user interface) e.g. all rare variants in BRCA2?

It isnât currently possible to query both with the same query call, but the functions to do both are very simple to parametrise and run concurrently, you will be able to combine the results outside of LabKey

This is for LabKey, which is he same source-data that Participant Explorer uses

---

is age avaliable?

live answered

---

ello, all working with CPUs or can we also use GPUs?

GPUs are not available within the Double Helix HPC, there are some GPU resources available within CloudOS

---

Will it be possible to receive a recording of the webinar or a PDF of the presentation?

There is a recording of what is essentially the same presentation on this page:
https://re-docs.genomicsengland.co.uk/upcoming/#past-training-sessions

---

Can we have the recording of this session

live answered

### 18/02/2025

---

Is the AWS RE VM and HPC free for researchers?

live answered

---

is there a link to the pre-build workflows/scripts?

You can find the GEL developed scripts and workflows at: https://re-docs.genomicsengland.co.uk/workflows/

---

Since healthy participants are not recruited to the project, what would you suggest in selecting controls for a case-control gwas? Any link/thoughts will be appreciated.

Hi Patrick, thanks for the question.

There are a few ways you can approach this problemâ¦ One option is to consider unaffected siblings/parents, who can be recruited alongside the proband. Another is to build control cohorts using exclusion criteria: e.g. Iâm interest in a rare disease affecting the lungs, so I select controls who do not have lung-related phenotypes or lung cancer (but could be affected by unrelated other rare diseases).

I hope that makes sense, but the best approach is probably different depending on the research project.

---

Im interested in cancer drug resistance.
Are there post-treatment cancer samples? Would you find these with NCRAS or Participant explorer?

thanks!

Hi Matt. Treatment information will be captured in the cancer related clinical data in LabKey. Youâre correct that Participant explorer can be powerful for looking at identifying post-treatment participants as it produces clinical timelines. If you get stuckfeel free to raise a tickt with our service desk

---

is it possible to import a .sqlite database into RE ? will this kind of request be accepted ?

live answered

---

Do you need to be part of a group as an academic researcher or can you do an analysis on your own just involving people in your institution?

live answered

---

Thanks Alex. I havenât tried GE RE yet. how can i find unaffected sibling/parents and where can i find the summary info?

Proband status will be captured in the relevant LabKey tables - off the top of my head I think itâs in the âparticipantâ table. Iâm not sure what you mean by summary info - you can find rare disease terms in the ârare diseaseâ related tables, and ICD10/HPO terms in the HES data tables. I hope this help :)

As always, feel free to reach out to our support bioinformaticians via the Service Desk where they can spend more time on your specific queries

---

when publishing, is there a review process by GEL?

live answered

---

Do you know who normally signs the agreement within universities?

live answered

---

### 21/01/2025

---

I have a technical Question - I am trying to gain access to Genomics England but have encountered two issues. First, after completing the Governance Training and receiving my certificate, the website has not updated to reflect my completion. Despite refreshing the page and retaking the quiz multiple times, the issue persists. Additionally, I am unable to log a support ticket as my credentials are not being accepted, and I keep receiving a "wrong password" message even though I am entering the correct password.

<https://research.genomicsengland.co.uk/SignIn?returnUrl=%2Fresearch-registry%2Fbrowse%2F>

[research-network@genomicsengland.co.uk](mailto:research-network@genomicsengland.co.uk)

---

I have a question regarding genomic files. I have established my cohort using participant explorer and downloaded that table with all the file paths to the participants genomic data and their corresponding ID. I would like to compile all the vcf files onto one folder on my RE, is there a way to do this? I have around 300 participants in my study so I would like to use BCFmerge in bcftools and run my analysis on the HPC. hope that makes sense!

You may also want to look at using the aggregates for this type of work as the aggregation, allele frequency calculations and functional annotations have been previously geneated. Filtering the aggV2 for your samples of interest will most likely save you a significant amout of time.

---

Question regarding participant explorer, when I copy paste the file path of the genome data from participant explorer into file system, it cannot locate the file, am I doing something wrong?

the paths may be slightly different between the desktop and the HPC.

HPC paths are âabsoluteâ, whereas desktop paths are relative to ${HOME}.

Please raise a service desk ticket if you are still experiencing issues.

---

Does either Labkey or Participant explorer allow you to search by genetic variant e.g SNP ID?

live answered

---

Does the participant explorer help in identifying new genes in patients with a specific disease?

some tables will have variant information but the majority of tables will provide you with secondary data on the participant and pathways for raw data files (VCFs)

---

so the data is pseudonymised, but anonymised to GEL?

live answered

---

who sits on Airlock committee?

The airlock committee is comprised of GEL staff with a broad range of experience and knowledge, this will include both bioinformaticians and policy experts.

---

should there be NHS representation if NHS info being fed in?

The information provided to the Research Environment by the NHS has been both consented and sanitised for research use prior to inclusion.

Contact with the NHS is possible if needed via the Clinical Research Interface (CRI) team.

---

Since I'm focusing on a specific area, such as a rare disease cohort for my research project, would it be possible to access help sessions from previous years? I am unable to wait until 10/6, for example.

<https://re-docs.genomicsengland.co.uk/upcoming/>
<https://re-docs.genomicsengland.co.uk/rd_cohorts/>

---

Please could you post the link for the past training sessions? Thank you!

<https://re-docs.genomicsengland.co.uk/upcoming/#past-training-sessions>

April 22, 2026
