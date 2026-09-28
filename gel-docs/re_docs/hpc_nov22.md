---
title: 'Using the HPC to run jobs, November 2022 - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/hpc_nov22/
scraped_at: 2026-05-04T06:32:35Z
---

> **Archive training session:**
>
> Past training sessions may include information that is no longer true, in either the presentation or the Q&A. Please double check against the relevant documentation pages.

# Using the HPC to run jobs, November 2022

The Genomics England Research Environment provides access to a High Performance Cluster (HPC) where you can access our genomic and clinical data and run large-scale analyses on these, using pre-installed bioinformatics tools, your own code and imported tools and software. This training introduces the HPC, including the compute and the queues available. We will show you how to access the available tools, including interactive coding tools, via the HPC, and how to run jobs using them. We will also cover bringing in tools and software from outside of the RE.

This training will be taught by our experts, including our HPC squad who create and maintain the cluster, and our bioinformaticians, who develop, install and work with the tools and workflows on the HPC.

## Timetable

14.00 Welcome and introduction  
14.05 What is the High Performance Cluster?  
14.20 Why use the HPC?  
14.25: Queues and nodes available on the HPC  
14.35: How to create and monitor jobs on the HPC  
14.45: Tools and software available and how to load them  
14.55: Interactive coding tools  
15.05: Bringing in your own tools and software  
15.15 Questions

## Learning objectives

After this training you will be able to:

- Access the Genomics England Research Environment HPC
- Work with the available software to submit jobs to the different queues
- Create and work with your own software on the HPC

## Target audience

This training is aimed at researchers:

- working with the Genomics England Research Environment
- comfortable working on the command line
- who can programme in python and/or R

## Time

November 22, 2022 02:00 PM in London

## Materials

You can access the redacted slides and video below. All sensitive data has been censored.

[Slides](../hpc_slides.pdf)

[Give us feedback on this tutorial](https://www.smartsurvey.co.uk/s/JRI80U/)

Q&A

Do we need to be on the âvirtual desktopâ to SSH on the HPC, or can we do it from our local environment (i.e., our own Terminal)?

No, not for people outside of GEL. You can only access our HPC from the Research Environment desktop. (We can cheat and use a VPN to get there directly, but not outside of GEL)

---

How do you bring the clip board up?

Can you see the little black tab with a white downwards arrow at the top of Alexâs screen? Click that and it slides down. If you canât see it, Iâll interrupt Alex and get him to show you again.

The important thing with the clipboard is that you can use your usual keyboard shortcut to paste into it, but from it you have to use the RE shortcuts. For me, on a Mac, I can Apple+V into it, then I have to select again and Ctrl+C to copy out.

It is quite small! Not the easiest to spot.

Ah yes I see. Thank you. Very useful.

---

Can we use conda/mamba environments on the GEL research environment?

Just as Alex gets to the slide! If anything he says here isnât clear, let us know.

Thanks! My timing regarding my question was a bit unfortunate. Still can we use mamba to build our own environements?

Just conda. No mamba

Thank you for the clarification.

[Docs on conda](../hpc_conda/)

---

You mentioned about installing software on HPC, how about R packages?

Yes, Ken is going to talk about this in about four slidesâ time

[Docs here](../r/)

Sorry, that was four slides plus a demo. I could only see the slides.

---

How much storage is available for each user?

Thereâs no definite amount, but if someone is using more than their fair share we will get in touch.

We donât have to do this very often, so thereâs definitely enough for most use-cases

---

Whether the analysis results (e.g. summary statistics) can be derived?

You can create whatever scripts and pipelines you like within the Research Environments, generating the files you need. To get anything out of the RE you need to use the Airlock, [docs here](../airlock/)

Thanks a lot

---

Will you be also sending us the above attachments with the recording, please? (as I have to leave the training early)

Yes, we will create a page in the docs with all the slides, the video and the Q&A, and send it out to you

[Hereâs a previous example](../medical_history_september22/)

---

I guess if we generate plots through terminal it will not show us a preview of it on the right hand side, correct? as there is no screen attached to it?

Correct - you wonât get plotting previews in Rstudio when running on the HPC. Itâs best to output your plot to a file and open it with separate software

thank you!

---

Can we use .libPaths() at the start of the session to establish a location to install and load packages instead of including the lib parameter in each call?

That should work for you yes

Thanks!

Thanks a lot

---

Are there GPU nodes available on the HPC?

there is one, it is not open to all, you will have to open a service desk ticket requesting access. this is out of scope of todays session but it is in the user guide

[mentioned here](../hpc/)

Thank you

---

Is there a charge for users?

If youâre in academia or a clinical setting, you can join a GECIP domain. This is free and there are no charges.

If youâre in industry, then your company will need to set up a partnership. Costs are dependent on the size of the company. More information here: https://www.genomicsengland.co.uk/research/partnerships

October 7, 2025
