---
title: 'Working with Python in the Research Environment, April 2025 - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/python_apr_25/
scraped_at: 2026-05-04T06:33:24Z
---

> **Archive training session:**
>
> Past training sessions may include information that is no longer true, in either the presentation or the Q&A. Please double check against the relevant documentation pages.

# Working with Python in the Research Environment, April 2025

Python is a powerful programming language with numerous libraries for biological data analysis and visualisation. Within the Genomics England Research Environment, you have access to many versions of Python and associated packages, along with Jupyter Lab for interactive analysis. There are a number of pre-built conda environments you can use, and you can build your own. The High Performance Cluster allows you to run analyses with significant compute.

In this training session, you will learn how to work in Jupyter in the Research Environment, to run your python scripts on the HPC, which may be different to how you are used to working outside the Research Environment. You will learn how to see details and contents of pre-built conda environments, and learn how to build your own using the limited channels that have been enabled in the Research Environment. You will also learn how to access clinical data with python.

## Timetable

13.30 Welcome and introduction  
13.35 Pre-built conda environments in the Research Environment  
13.45 Create conda environments in the Research Environment
13.55 Working with Jupyter on the HPC  
14.15 Working with Python in interactive sessions in CloudOS  
14.30 Query clinical data with python
14.45 Getting help and questions

## Learning objectives

After this training you will know:

- How to use Jupyter notebooks on the High Performance Cluster
- How to use pre-built conda environments in the Research Environment and build your own
- How to query Genomics England clinical data with Python

## Target audience

This training is aimed at researchers who:

- Are working in the Genomics England Research Environment
- Can programme in Python

## Date

8th April 2025

## Materials

You can access the redacted slides and video below. All sensitive data has been censored.

### Slides

[Download the slides](../python_april_25.pdf)

### Video

### Code

You can find the Jupyter notebook used inside the RE in:
`/gel_data_resources/example_scripts/workshop_scripts/working_with_python_2025`

[Give us feedback on this tutorial](https://surveys.genomicsengland.co.uk/s/FARO5T/)

### Q&A

Q&A

Apologies for arriving late, please could you share a reminder to the paths of existing conda environments?

the catalogue can be found here:
/gel\_data\_resources/software\_catalogues/conda\_catalogue

to activate the base environment you will need to:
source /resources/conda/miniconda3/bin/activate

---

is mamba available to speed up packages installation?

We havenât inplemented support for Mamba in the Research Environment but this is being looked at.

---

how do I know how much memory my job needs?

thank you for your question. Memory selection is dependent on the analysis and size of the data you are running. For example tools like PLINK2 for association testing will need more memory than running an R script for clinical analysis

---

When performing the bsub for Jupyter on HPC we didnât cover host selection (or pricing) that is coming up for the interactive Jupyter notebooks - does the inter queue not cost anything?

The HPC currently does not have a billable component and is covered as part of your access agreement to the Research Environment. For academic customers this will be at no cost, for discovery forum members this will be part of the access agreement negotiated.

Please bear in mind that these conditions are subject to change. Any change to the approach used by Genomics England will be communicated ahead of time.

For interactive Jupyter sessions on the Double Helix HPC you will need to use jobs submitted to the `inter` interactive queue. Host selection will be handled by the scheduler.

---

Is there a capability where my memory allocation is calculated by the selection of what im trying to do i.e. clinical analysis? just so it saves me the hassle of manually setting compute

Unfortunately not. It is a case ot trial and error. We recommend setting a stout and sterr for your jobs so that you can see the amount of memory you actually used for future reference. Thereâs a guide here: https://re-docs.genomicsengland.co.uk/hpc\_memory/

---

can you use labkey on cloud OS

live answered

October 7, 2025
