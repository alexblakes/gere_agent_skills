---
title: 'Finding participants based on genotypes - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/genotypes_july22/
scraped_at: 2026-05-04T06:32:13Z
---

> **Archive training session:**
>
> Past training sessions may include information that is no longer true, in either the presentation or the Q&A. Please double check against the relevant documentation pages.

# Finding participants based on genotypes, July 2022

For many analyses, you may be starting with a (list of) gene(s) and you want to find all participants with variants in that/those gene(s). Or maybe you have variant loci and you want to get all participants with homo- or heterozygous alternative alleles at these loci.

In this training session, we will look at both no code tools for finding variants and command line tools on the high-performance cluster (HPC), including using GEL-provided workflows.

We will have a look at the Labkey tiering tables that provide all variants that are considered to be plausibly pathogenic, and learn how to filter these by genes or loci. We will use the Integrated Variant Analysis tool (IVA) to search for variants by genes or loci, plus other parameters such as proband and parental genotypes, consequences and population frequencies. For each of these variants, we can pull out the participants with these variants. The training will also cover how you can use APIs to fetch the same data programmatically.

We will also use the Gene-Variant workflow and SV/CNV workflow that allow us to identify all variants (short and structural, respectively) in a list of genes, pulling out the platekeys of participants with these variants. To find individuals with variants at particular loci, we will use bcftools with the aggregated VCF files on the HPC.

You are only allowed to attend this session if you are eligible for data access. This means that you are a Research Network member that has met the necessary verification checks and passed our Information Governance training course. If you do not meet these criteria by 18th July 2022, you will be unregistered for this session.

## Timetable

14.00 Welcome and introduction  
14.05 LabKey tables of variant genotypes  
14.15 Finding genotypes with IVA  
14.30 The Gene-Variant and SV/CNV workflows  
14.45 Aggregated variant files  
15.00 Using bcftools on the HPC  
15.15 Questions

## Learning objectives

After this training you will be able to:

- Know which LabKey tables which contain tiered variant data
- Use the IVA Variant Browser to filter variants.
- Differentiate between the the Gene-Variant and SV/CNV workflows and know when to use them.
- Understand the contents of the aggregated variant files: AggV2 and SomAgg.
- Run pipelines and tools on the GEL HPC.

## Target audience

This training is aimed at researchers:

- working with the Genomics England Research Environment
- working with genetic and genomic variation data
- who can work on the command line to run tools and scripts

## Time

July 19, 2022 02:00 PM in London

## Materials

You can access the redacted slides and video below. All sensitive data has been censored.

[Slides](../genotypes.pdf)

[Give us feedback on this tutorial](https://www.smartsurvey.co.uk/s/PQ0FLG/)

Q&A

This training video will be uploaded to Research Environment User Guide confluence page, correct?

Will this talk be available off line or recorded for later reference?

HI Jose, Thank you for joining us. Indeed, this session will be recorded and available later with any of our participants information removed.

---

Do we have a full list for all installed/avaiable bioinformatic tools on the GEL research environment?

Hi Schicheng Guo,

That's a good question. You can find the list of available tools directly in the HPC system with the following command: module avail or module spider `tool-name`

You can also see a more user friendly list, albeit smaller in the research guide:
https://research-help.genomicsengland.co.uk/display/GERE/Software+Available+on+the+HPC#SoftwareAvailableontheHPC-ListofServiceModulesavailableintheHelixHPC

module avail will list all modules in Helix whereas module spider will search for a pattern, such as `tool-name` in this example.

---

Seriously pathetic question - I missed 2-factor authentication and cannot get on to RE - nor can I figure out who to contact to sort myself out. Can you point me to help?

[Service Desk](https://jiraservicedesk.extge.co.uk/plugins/servlet/desk) should be able to help you out with that.

thank you!

---

Is there any reason that we keep both GRCh37 and GRCh38 in the project for rare diseases?

There are a significant number (~10,000) samples in the Rare Diseases project that are aligned against GRCh37. We have a long term want to realign these files (plus all the GRCh38 files) using our new bioinformatics pipeline, which would use DRAGEN aligner and DRAGEN variant caller. However, this is still in the very early stage, and cant give any firm timelines.

---

Do we have "loss of function" and "gain of function" in the annotation file?

Hi Shicheng, thank you for your question.

If you are referincing to the tables shown by Emily (`exomiser` and `tiering data`) with annotation file:
the former does not carry any annotation such as loss or gain of function. The tiering data does have the `consequence_type` field which will have cellbase consequence types annotation.

Gain of function mutations are unfortunately not readily available as annotation.

Does that adress your question?

Yes. Thanks Christian!!

Additionally, we have VEP available as a container to run within our research environment, should you require further annotation:

https://research-help.genomicsengland.co.uk/display/GERE/VEP+105+container

---

Are you able to use tiering and exomiser outside of the research environment?

Hi,

These tables are present on LabKey and therefore these are only available within the research environment. These tables have participant identifiable information and cannot be made available elsewhere.

However, exomiser is a standalone program that you can run yourself, if you were so inclined https://github.com/exomiser/Exomiser

Are we allowed to apply to export the tiering information with file transfering?

Hi Shicheng,

Exporting data out of the research environment goes through a process called airlock. You can find more information on this page: https://research-help.genomicsengland.co.uk/display/GERE/5.+The+Airlock

As a rule of thumb, if you have identifiable participant information, then it is unlikely that the request will be approved. However, requests are evaluated on a case-by-case basis. The page above provides more information on which information can be exported.

You would not be allowed to export raw results from the tiering table

---

How does this differ from the Gene-Variant Workflow?

Answered live

---

Hello, I have tried to use the API to query the LabKey but I get an error: User does not have permission to perform this operation. I do not understand what I am doing wrong. Any ideas? Thank you!

Ah, this is an issue that comes up occasionally. Have you set up a .netrc file as Emily mentioned earlier? Detials to do so can be found here: https://research-help.genomicsengland.co.uk/display/GERE/Using+the+LabKey+API

Additionally, this needs to be created both on the desktop environment and also the HPC environment.

If you have done all this and it is still not working, please raise a service desk ticket (occasionally this issue comes up even when everything is configured correctly on your side).

---

Using the tiering data for your query, will you be able to identify all potentially relevant variants, also in candidate genes? Or is it better to use aggv2 dataset then?

Hi Laura,

Thank you for your participation. The aggV2 and the gene variant workflow will return all possible candidate variants whereas the tiering and exomiser tables will have some association to a pathology. Therefore, if you are in discovery mode, you might want to use the workflows.

---

Hi, would you recommend which of R or python is better for this?

As Emily says, the only advantage of python over R is that you can extend the query timeout, just in case the wuery that you are writing required a lot of processing on the DB side

---

in IVA can you filter for homozygous variants?

Answered live

---

Do I remember correctly that previously not all participants were included in IVA? And that this changed and is the case now?

IVA currently has all participants up to release 14, due to some issues involved in transitioning from 13 -> 14. Note that IVA contains data from the platypus VCFs for rare disease (relevant for interpretation) which are slightly different to the NSV4 gVCFs from Illumina that are available on the HPC. Emily may also touch on this later.

---

Will we cover compound heterozygous carrier identification in this training?

Answered live

---

IVA seems to have a lot of powerful options for filtering, I have found I get a lot of variable errors when applying filters, particularly at busier times of day - is this due to the system 'timing out' when load is too high, or am I just using it incorrectly?

There are some transient issues that occur with IVA that usually result in timeout errors. They are pretty hard to track down, and often impact the system for <20 minutes. These are very annoying though, and we always try to increase reliability for all our tools.

Thank you, so presumably it is best to wait and re-run the filter set if the errors are odd? I am sometimes unsure if I am getting a true '0 variants with these filters' vs an error, is there a good way to tell between these?

Yes, best to wait and re-run. There's not a great way to tell the difference, except of course if you get returned a timeout error.

---

Using phenotype to search this variant section does not seem to search for within the actual participant samples. Is there a way to do this? For example, searching pulmonary arterial hypertension returns genes known to be associated with the disease, but does not return only participants that have pulmonary arterial hypertension.

IVA only holds variant information, and does not contain any phenotypic information (if I recall correctly). For a nice interface for a phenotypic search, I would recommend using the Participant Explorer.

---

What is the difference between the data in IVA compared to tiering and exomiser data in LabKey?

Hi Bushra, good question!

IVA will allow you to query any variation of interest, while tiering and exomiser data in labkey are limited to variants rolling out of our rare disease primary findings, these are selected to aid the NHS GMC.

Variants in the tiering\_data and handeled by exomiser will be present in IVA, but not always the other way around.

Some resources:
IVA: https://research-help.genomicsengland.co.uk/pages/viewpage.action?pageId=45024271
rare disease tiering: https://research-help.genomicsengland.co.uk/pages/viewpage.action?pageId=38046769
Exomiser: https://research-help.genomicsengland.co.uk/pages/viewpage.action?pageId=38046618

Hi Bushra,

Something else to keep in mind is that IVA is on data release v14 whereas the tiering and exomiser data are available on the most recent data release (currently v15).

---

Where can we find our login to HPC?

You can find that information here: https://research-help.genomicsengland.co.uk/display/GERE/4.a+Accessing+the+HPC

---

I am trying to run GWAS Nextflow pipeline in HPC using SAIGE. Anyway, I get an error: --vcflist: command not found and --phenoCOl: command not found. Do you have any suggestion what might be wrong?

A command not found error would make me think that a line continuation character is broken within the workflow. I'd need to look at the run to make sure, have you got a service desk ticket describing the issue?

No, I have not raised a ticket to the service desk yet. I was trying to find the error myself. Thank you for the suggestion. I will check better the workflow.

---

I am curious if some interesting workflow has not been developed in RE yet, is there any possibility that GEL bioinformatic team will working on it? or how GEL bioinformatics team handle new workflow request? Thanks.

Hi Shichen,

We are always looking to further our offering for workflows.

If you have any suggestions or request the best way to get our bioinformatics team to get involved is through opening a ticket at the service desk.

Often existing workflows, if containerized, can be made available after a vetting procedure.

---

These workflows are very nice. I recently used the Gene workflow successfully and it's a much appreciated addition to the available workflows that you are providing. Is there any way that the job can be submitted to use a specific cohort only, thus saving processing time!?

For the gene variant workflow, there is an update in progress that lets the user supply a list of input VCF files, instead of using all available VCF files in labkey. This would let you run on a specific cohort of interest.

Additionally, if your entire cohort of interest is present in aggV2, then I would recommend using that, along with the associated annotation files.

Thanks. The update will be much appreciated, especially for the SVCNV workflow.

---

Will there be a pipeline written on Word to add to the workshop video on how to extract vcf files with an specific phenotype?

Hi Jose,

These common use cases are described in the research guide. You can follow the guide alongside the video.

You can find the code books here:
https://research-help.genomicsengland.co.uk/display/GERE/7.+Analysis+Scripts+and+Workflows
and
https://research-help.genomicsengland.co.uk/display/GERE/Genomics+England+Data

You might also want to look at our previous workshop that guide users on how to buidl a cohort based on a phenotype.

---

I want to confirm do we have joint calling VCF file for 100,000 samples? Do we have pgen or plink format file for 100,000 samples. Thanks

We do have PGEN and BGEN versions of the aggV2 files. The BGEN ones are per chunk only, and the PGEN ones are per chunk and per chromosome.

They are available at /gel\_data\_resources/main\_programme/aggregation/aggregate\_gVCF\_strelka/aggV2/genomic\_data/ bgen\_masked or pgen

We additionally have a phased version of the data available that was created by a GECIP member from Oxford, located at /gel\_data\_resources/main\_programme/aggregation/aggregate\_gVCF\_strelka/aggV2/phased\_data (VCF format only)

---

Two questions:

- do the workflows previously discussed not include any functional annotations?
- for the SVCNV workflow, how was it definied that a SV/CNV overlaps with a gene? even if one bp overlaps, or does a specific part / entire gene needs to overlap with the SV/CNV?

Hi Laura, thank you for your questions.

Could you elaborate on which workflows you mean when reffering to? (all our -including a functional annotation- workflows are available here: https://research-help.genomicsengland.co.uk/display/GERE/Workflows)

Regarding SVCNV: the output will contain summary counts at differing levels of overlap:

- n.total: total patients with a variant on the gene
- p.total: percent of cohort with a variant on the gene
- n.exon: n patients with a variant affecting at least 1 whole exon of the gene
- p.exon: percent of cohort with a variant affecting at least 1 whole exon of the gene
- n.overlap: n patients with a variant affecting 70% or more of the gene length
- p.overlap: percent of cohort with a variant affecting 70% or more of the gene length

To add to Christian's answer, the gene variant workflow performs annotation on the fly using VEP, and outputs the annotation information as well.

---

Is there a pedigree file available corresponding to aggV2 please?

There is no pedigree file that we have made available, but you can use the labkey table aggregate\_gvcf\_sample\_stats, which lists all the participants and their relationships

Thanks - I will look into that. Perhaps it is someting to consider as .PED files are a standard input for many family-based analyses. Thanks

---

Im so confused what command to use in the HPC to tell it where your files are etc. I know how to do it in the RE, but can't figure it out on the HPC

to change directories while on the HPC, you can use the command cd (e.g. cd /re\_gecip/cancer\_colorectal). To list files in the folder that you are currently in, use the command ls. I hope that helps.

so to access the gel data resources and your folder, you could do eg

cd /re\_gecip/username ? or cd/re\_gecip/gel\_data\_resources/workflows/BRS\_tools\_geneVariantWorkflow/v1.7/

Am I on the right lines? Apologies, I've tried a few times but with limited success

Correct, keep in mind you cannot be in two directories at the same time. (unless you open up two instances of the hpc)

Excellent, thank you

cd = change directory (move your screen to the directory)

ls = long listing (list all the files in the direcotry you are currently in)

pwd = print working directory (show the path / location of the current directory)

The second example you have put is not quite correct, it would be cd /gel\_data\_resources.

I recommend that you run the command ls / which will show you all the base level folders that you can access. There will be at least /genomes, /re\_gecip, /gel\_data\_resources, /public\_data\_resources

This is really useful thank you

I'm just confused how I copy and paste the gel data resourses into my own folder in the HPC. I cant seem to find my own folder in HPC...

I've ls th folders in gel data resources now, one step further than I have got before!

---

Are the pgen files only for the GRCh38 build rare variants?

Yes, they are only GRCh38, and only for the aggV2 dataset.

January 29, 2026
