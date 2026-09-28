---
title: 'Using GEL data for publications and reports, October 2025 - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/pub_oct25/
scraped_at: 2026-05-04T06:33:13Z
---

> **Archive training session:**
>
> Past training sessions may include information that is no longer true, in either the presentation or the Q&A. Please double check against the relevant documentation pages.

# Using GEL data for publications and reports, October 2025

Our participantsâ privacy is absolutely paramount, which is why we heavily restrict export of data from the Research Environment (RE). In this training session, we will look at what you are and are not allowed to export, and how you can ensure your exports are compliant. We will look at the tools available in the RE for compiling and composing your data. We will cover using the Airlock tool for export.

Where publications or theses require supporting evidence that is potentially identifiable, we will look at how you can enable access to this supporting data for reviewers or examiners without exporting it from the RE.

## Timetable

13.30 Introduction and admin  
13.35 Rules for data export from the RE  
13.45 How to ensure your exports are compliant with rules  
14.00 Working with LibreOffice in the RE  
14.15 Using the Airlock  
14.20 Sharing data with reviewers and examiners within the RE  
14:45 Getting help and questions

## Learning objectives

After this training you will know:

- what you can and canât export from the RE
- how to compile your data for export
- how to export data using the Airlock

## Target audience

This training is aimed at researchers:

- working with the Genomics England Research Environment
- hoping to publish a paper, report, dissertation or thesis, or deliver a poster or presentation using Genomics England data

## Date

14th October 2025

## Materials

You can access the redacted slides and video below. All sensitive data has been censored.

### Slides

[Download the slides](../publications_2025.pdf)

### Video

[Give us feedback on this tutorial](https://surveys.genomicsengland.co.uk/s/XTQ8V8/)

### Q&A

Q&A

can we ask for our scripts to be exported outside?

Yes, researchers regularly request to export scripts! Please ensure that scripts requested for export do not contain participant or sample IDs, and in general it's best to not have any data included in scripts included for export (though we understand that some data like counts may be in the comments , and if otherwise safe for export we will approve still, it's just more convenient to have data in dedicated files rather than scattered throguhout comments in scripts)

---

can import my own model and use GE data as input?

You are very welcome to import trained ML models, and once they are inside the RE you are welcome to use the model to generate research insight s directly, or to use GE data as a testing set to test the model performance. You are then very welcome to request these outputs for export: research results will be reviewed according to the usual rules, model performance statistics should usually be safe for export so those I imagine would always be approved for export (but there may be some edge cases). HOWEVER under our current ruleset you cannot export trained ML models from the RE: you are welcome to train a model on GE data inside the RE if you wish to, but the model will be stuck inside the RE and will not be possible to export unless and until we revise the rules. You can read the full details of our current rules around ML work here: https://re-docs.genomicsengland.co.uk/airlock\_ml/ . PLease note that we are still revieiwng these rules and exploring options to potentially enable trained ML model exports in future, though we cannot guarantee that this will ever be possible

Oh also to note, for trained model import we will ask the importer to please take responsibility for ensuring that all of the data used to train the model is data that you had valid approval to use (valid license if licensed data etc) and that is safe to host inside the RE

---

If the manuscript is under review, and i donât know who is the reviewer, how can I let them to access the RE during reviewing.

To add to Emily's answer, the Airlock team are very happy to be put in contact with the journal to arrange access for a reviewer without compromising anonymity to the author of the manuscript

---

I had a few questions about the upload of containers within the RE. I saw that we have to use Singularity containers.

We are working on a way to convert our dockercontainers into singularity.

Given that Singularity images are immutable, if we need to tweak/fix an image, would we need to re-upload a new image and go through another Airlock approval?

live answered

Yep, but if we have some root accesses or internet package downloads within docker containers ?

live answered

And if so : Do you support âincrementalâ review of container updates (i.e. minor differences from an already approved container), to reduce burden of full review for the Airlock team?

live answered

---

I am sorry I missed most of the talk and you might have discussed this. I just wonder how much GMS data we can use in building cohort. Can we use phenotype and solved genetic results from GMS cohort in our publication of a cohort of patients from 100 KGP

live answered

---

Last Monday, I requested the export of a file for further analysis and received the first response email within a day. However, I haven't received any follow-up communication since then. Could you advise me on how to proceed with this situation?

As a general rule the best thing to do is contact airlock-info@genomicsengland.co.uk if you haven't received a response to an Airlock request. As noted live this specific request was approved, I can see, so you would have been sent an approval message via Jira SD which includes details on how to actually access the file(s). Please let me know if you didn't receive that message (feel free to email airlock-info@genomicsengland.co.uk after this call to follow up, thank you!)

---

For some clinical collaboration requests, we get no response. How could we make sure to get a response from the referring clinician?

live answered

Or can we go ahead for publication if no response ever received from the clinician?

No, absolutely not

---

Another question about the genomic data accessible for partciipants wihtin 100K Genome Project !

What are the kind of "raw" VCF files (I mean without any interpretation info) we have access to ? I saw some VCFs interpreted by something called "platypus"

live answered

---

Many thanks for the answers !

I also have another one about files we upload to the RE. Is there any good pratice to store those data wihtin the RE (I mean something like a folder shared with the HPC) .
I believe we can store them in our specific (for our project) discovery\_forum subfolder ? IS there any good practices ?

Many thanks for the answers !
Any also huge thanks to the Airlock team !

live answered

October 15, 2025
