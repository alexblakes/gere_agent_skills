---
title: 'Working with the new aggregate VCFs â\x80\x93 AggV3Working with the new aggregate VCFs â\x80\x93 AggV3, March 2026 - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/aggv3_mar_26/
scraped_at: 2026-05-04T06:31:08Z
summary: "AggV3 multi-sample VCFs (Dragen 3.7.8-realigned) queried via bcftools/bedtools in CloudOS interactive sessions, covering data import/export and genotype-phenotype integration."
---

> **Archive training session:**
>
> Past training sessions may include information that is no longer true, in either the presentation or the Q&A. Please double check against the relevant documentation pages.

# Working with the new aggregate VCFs â AggV3Working with the new aggregate VCFs â AggV3, March 2026

Genomics England provide multi-sample VCFs, aggregating together variant calls for participants from the 100,000 Genomes project, NHS Genomic Medicine Service and Covid-19 data. This allows you to query genomic loci and annotation in all participants using tools such as bcftools. A new version of the aggregate, known as AggV3, will be released in 2026 based on genomes realigned using Dragen 3.7.8 and made available only in CloudOS.

This training session will introduce you to working with AggV3 using interactive sessions in the CloudOS platform. We will show you how to launch interactive sessions, including the cloud instance options available, and how to run tools in the terminal. We will use bedtools to identify the correct VCF files to work with, and bcftools to query a genomic locus for participant genotypes. To allow you to combine genotype queries in CloudOS with phenotype queries using other tools, we will look at taking data in and out of CloudOS.

## Timetable

13.30 Introduction and admin  
13.35 How were the AggV3 multisample VCFs created?  
13.50 Interactive sessions in CloudOS  
14.10 Querying AggV3 in the terminal  
14.30 Taking data in and out of CloudOS  
14.45 Getting help and questions

## Learning objectives

After this training you will know:

- Have a better understanding of the dataset and what is included
- Know how to query AggV3 in a CloudOS interactive session
- Know how to combine genotype queries of AggV3 with phenotype analysis

## Target audience

This training is aimed at researchers:

- Working with the Genomics England Research Environment
- Familiar with the command line and standard bioinformatics tools

## Date

10th March 2026

## Materials

You can access the redacted slides and video below. All sensitive data has been censored.

### Slides

[View the sides](../agg_mar_26.pdf)

### Video

[Give us feedback on this tutorial](https://surveys.genomicsengland.co.uk/s/M665LV/)

### Q&A

Q&A

Is there any information on non-coding variants, or are only coding variants being assessedmnu VEP?

Annotation with VEP has been done on a whole-genome basis. So non-coding variants will have been annotated too.

---

Do you remove or flag participants that have been sequenced more than once in different programmes ?

Weâve gone through an extensive de-duplication effort by looking at participants NHS-IDs. Based on that we attempted only leave one participant per NHS-ID within AggV3. We provide a table where each row is a participant along with a column with additional participant\_idâs if they have been recruited multiple times or if there ever were multiple samples.

We will make documentation available on this. But we tried to reduce this. Where we still had duplicate participants, these are flagged in the same table. We know of ~15 duplicates within the set of 138,399 participants.

---

Are there internal allele frequencies already (GEL AF)?

We will be generating GEL AFs based on aggV3 once we have predicted ancestries. In the first iteration of the release these will not be included.

do you an approx timeline for this? I assume one can infer overall frequencies from genotype data?

In terms of a timeline I don't have one at the moment. You will however find a cross-aggregate allele frequency value in the siteQC VCFs should that be useful for you.

No timeline provided but one of the next in line workstreams for us. We are currently wrapping up the population structure and relatedness work (expected very soon) that is required to calculate all allele frequencies per population for example.

---

I wonder if the shards are made to include full genes? Or we might end up looking at several shards to look for variant of a certain gene of interest?

We have not fully assessed this, so I cannot promise that you might find genes split over two subshards. The sharding process was done by Illumina and is roughly based on dividing the genome over the number of initial samples plus an additional factor. So itâs more computationally based rather than taking into account specific regions (besides perhaps the centromeres). But good question!

---

Is the aggregate data only available as VCF? if so, any plans for other formats (bgen,pgen)?

PGENs are available for the biallelic sites. We may be providing additional formats in the future, but the PGENs are there at least :)

---

will there be files for structural variants too?

Not in an aggregated format. The Dragen 3.7.8 sample level data will have SV VCFs per sample along with family-joint-called CNV VCFs.

---

Will shards and subshard numbers/IDs be consistent when the aggregate is updated?

Yes shard and subshards will remain consistent even when new samples are added.

---

Is there cancer analysis for cancer samples (annotation of somatic mutations, SVs etc) like the one for AggV2?

Cancer somatic samples are not in scope for this type of release. Here we focus on having realigned all the germline genomes (including germline genomes of cancer cases) with Dragen 3.7.8, and providing an aggregate for those germline genomes.

So the existing cancer analysis for 100kGP should still apply to AggV3 samples? However the NHS samples re-aligned here don't have cancer analysis?

If I understand correctly, the cancer analysis for 100kGP should still apply to AggV3 as they use the same samples? The samples that don't have cancer analysis are the NHS samples re-aligned here?

Thanks, so when we talk about cancer cases, we generally mean germline+somatic genomes. In this dataset, we focus only on the germline samples, which includes germline samples from those cancer cases. The cancer germline genomes from both the 100kGP and NHS-GMS are included in this dataset.

---

can you elaborate on pricing in cloudOS, what is included for free and how to top-up?

live answered

---

the current workflows designed for AggV2 are very useful. will they be adapted for AggV3?

Yes adapting our workflows to make them compatible with aggV3 is indeed on our roadmap but I have no definite timelines for now.

I assume you refer to the AVT or GWAS workflows. If so, yes, we have doing some work to adapt these to AggV3 (starting with AVT) but I cannot provide a clear timeline on this unfortunately.

---

Actually, I don't know if this intentionnal but the page is accessible with the url

This was intentional for the time being for our beta-testers. Kind of out of view but still reachable. Sharp eye though!

Weâll update them over the week and reorganise a few bits.

---

Whai is the max size of the file that can be exported from the cloudOS to RE?

I believe itâs <1GB. But note that it downloads directly into your REâs âDownloadsâ folder. So the storage for your RE is not going to be sufficient for big files anyway. Best to use this functionality for export reasons or small files.

what if I need to annotate huge set of variants and process them in RE?

We would generally recommend processing these further in CloudOS. If there is data missing in CloudOS you can either upload them into CloudOS yourself or by raising a ticket if the data is too large. It will essentially be a case-by-case basis.

But a list of variants shouldnât be too big to export into the RE in my experience (depending on whether thereâs additional information).

---

Will we still be charged for interactive sessions after we suspend it (e.g. storage of data, packages etc)?

live answered

---

Is it necessary to install packages in each session?

You can install packages and save the session set-up as a snapshot that can be used again.

In my experience only the first time in a session. Like within Rstudio. If you then run a new Rstudio as part of another project youâd have the install them again. But itâs all quite quick and efficient (an improvement to the RE itself). But afterwards you should be able to just load the packages.

---

Would it be reasonable to mount the root directory or one of the higher level ones? To be able to access everything without iteratively mounting?

live answered

---

If I am not wrong, the AC,AN and AF between bialelic\_genotype shards will be the same as the SiteQC one, right?

Yes thats correct. There is no INFO field for AC and AN in the biallelic genotype VCFs though. The only available value is AF which is calculated across all samples including the GIAB samples.

Apologies, there will be a slight difference in AFs between the siteQC VCF and the biallelic VCF because the AF in the biallelic VCF is calculated across all samples including the GIAB samples, whereas the AF in the siteQC VCF was calculated based on GEL samples only.

---

is there an efficient way/pipeline to query all reasonably rare variants in a reasonably big bed-file (eg 50k of 250bp over the genome)? Can it be limited to a subset of the participants (NHS GMS for example)?

We donât have a ready-made pipeline for this, but have been thinking about something similar to the small variant workflow where you can query the aggregate with some basic inputs and the workflow doing the rest for you.

So conceptually, yes you can build this but we recommend writing a Nextflow pipeline for this type of work. CloudOS works very well with a Nextflow framework.

For development purposes we have a mini-aggregate containing only the 7 GIAB samples. This can help you develop the workflow to your liking in a cost-effective way before running it on the whole aggregate.

Hope this kind of answers your question, but let us know if you want some clarification!

I have a pipeline for this in GEL RE but I do not see how can it be smoothly transferred to the CloudOS

Is it a Nextflow pipeline (or something similar) or a collection of âlooseâ bash/r/python scripts?

it is a collection of scripts - rather preparation R script and two batch HPC jobs

I see, CloudOS does have functionality for bash/HPC like job submissions, but Iâm not too familiar with that. Possibly a question for Lifebit (CloudOS providers). The Rscript should be quite easily transferrable into CloudOS.

Having said that, if you want to learn more about Nextflow, this could be a good opportunity. You can essentially develop/write the pipeline locally, push the pipeline to Gitlab, and nearly instantly submit that pipeline through CloudOS. Because you can connect your gitlab account to your workspace, and submit pipelines from private repoâs.

Emily is currently addressing the HPC-like job submissions :)

---

Is there any way to mount via command line?

No there isn't. It has to be done via point and click.

I agree that it would be useful to have a fully programmatic way to access everything

---

Which version of the gnomAD database did you use for aggv3?

Version 4.1.

---

Are SVs available for all AggV3 participants ?

Yes, SV VCFs are available for all AggV3 participants. As well as joint-called CNVs for their respective families.

This is part of the Dragen 3.7.8 single sample delivery datasets

---

Thanks! Are there any pros and cons if I use any of them? What should be the best practice here?

Pros and cons between using the Nextflow/Cromwell and Bash/container options?

In either case, it will depend on your use-case, and comfort of using either option. Learning to build with pipeline frameworks tends to be quite a transferrable skill within the world of Cloud compute at least.

Bash/container tends to be okâish for single task type of compute. If it gets more complex, you might be better off with Nextflow or Cromwell in the end.

---

Is snakemake working as well ?

Unfortunately is not available in cloudOS.

All right! I have a full week to switch to nextflow then :)

seqeraâs AI tool is quite useful to help you move forward with this. I am saying this on a personal title, not as a recommendation by us as an organisation.

It has two options 1) asking it as a chatbot, 2) asking it to write a full pipeline based on your specifications.

and 3) it can be used as a vscode plugin (on your local machine) :)

---

can you avoid using graphic interface in cloudOS? like explore and access files, submit jobs etc? I assume no, right?

I believe Lifebit provide a python package that allows you to submit batch jobs via the command line. But this must be used in an interactive session in CloudOS so it isn't possible to completely avoid the GUI

Due to the cloud-based nature of CloudOS itâs not really possible to recreate a HPC way of working fully

is the plan to fully move to cloudOS at some point later?

We will be moving to **a** cloud-based platform. It my be CloudOS or it may be another platform - either way it will have a similar way of working.

---

no, whicb AC, AN and AF to use..

We lost context with regard to this question, but feel free to raise a ticket to get more info :)

---

addtionaly, in the nextflow script, if I want to run multiple genes at once which would access multiple s3 files, whats the best way to make it work? is it necessary to attach the s3 files in the parameters section?

You can provide a simple input list as a single parameter which would contain multiple paths. But this is more about thinking about workflow logic etc. Just donât forget adding the paths to the index when you do make a new input sheet.

---

for cloudOS support can I contact helpdesk or there is specific support cloudOS?

live answered

March 11, 2026
