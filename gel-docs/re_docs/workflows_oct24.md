---
title: 'What tools and workflows should I use to fulfil an overall goal?, October 2024 - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/workflows_oct24/
scraped_at: 2026-05-04T06:34:19Z
---

> **Archive training session:**
>
> Past training sessions may include information that is no longer true, in either the presentation or the Q&A. Please double check against the relevant documentation pages.

# What tools and workflows should I use to fulfil an overall goal?, October 2024

It can be hard to get started with a research project in the RE, with an abundance of data and tools available. In this training session we will look at some of the major use-cases in research and the steps involved in carrying these out, both at a large and small scale. Instead of going into deep detail on these paths, we will point you to tutorials and documentation to get you going with the different steps of the process.

The use cases weâll be looking at are:

- I'm interested in a phenotype and I want to know what variants are related
- I'm interested in a gene and I want to know what phenotypes are related
- I want to find a diagnosis for patients who didn't get one through primary clinical interpretation

For many of these use-cases, we will point you towards resources to carry out these projects at a large scale, using programmatic and command-line resources, and at a small scale using point-and-click tools. Bear in mind that is not always feasible to do this kind of research at both scales.

## Timetable

13.30 Introduction and admin  
13.35 Identifying variants associated with a phenotype  
13.50 Identifying phenotypes associated with a gene   
14.20 Finding diagnoses for patients who didnât get one through primary clinical interpretation  
14.35 Getting help and questions

## Learning objectives

After this training you will know:

- The main steps involved in common use-cases in the RE
- How to access training materials and navigate the documentation

## Target audience

This training is aimed at researchers:

- working with the Genomics England Research Environment
- who are looking for a start point for their research project goals
- Either programmers or non-programmers

## Date

8th October 2024

## Materials

You can access the redacted slides and video below. All sensitive data has been censored. You can access and copy code from the Jupyter and R notebooks used in the training at:

`/gel_data_resources/example_scripts/workshop_scripts/workflows_2024`

### Slides

[Download the slides](../workflows_2024.pdf)

### Video

[Give us feedback on this tutorial](https://surveys.genomicsengland.co.uk/s/OL4NHD/)

### Q&A

Q&A

Is there an automated way to map these coded values for variables to human readable values. i.e. sex == 0 becomes sex == âfemaleâ

Hi James, thanks for the question. Is this referring to the phenofiles shown? If so, this binary coded representation of sex is required for compatibility for tools that run GWAS and other variant association analyses. If you are extracting data from LabKey, Participant Explorer or Cohort Browser you can indeed keep the values in human readable format.

---

hi when I try access cloudos it sends a magic token to my email which i cant access on aws- how do you overcome this?

live answered

---

Hi,

Thank you for the excellent course! I have a question about submitting job scripts to an HPC system. What is the correct way to submit a job script if it takes input data? For example, how can I submit something like bsub < jobscript.sh input1?

Thnak you

Hey Iman, the RE docs cover this extensively so would highly recommend you have a look over the following pages: https://re-docs.genomicsengland.co.uk/hpc\_jobs/

Just as a follow up, from what Iâm understanding your question seems to relate to passing arguments to a shell script from the command line, less so HPC submission itself - so a quick search online for that might also offer some clarity into your specific application :-) (For example https://unix.stackexchange.com/questions/31414/how-can-i-pass-a-command-line-argument-into-a-shell-script)

An alternative would be to change the variable inputs wthin the actual jobscript.sh - and if you need it to run with multiple values you can do for loops etc.

So your submission script (submission\_script.sh) would look something like this:

```
#!/bin/bash  

# Include your job submission details as #BSUB headers
#BSUB -q <your_queue>  
#BSUB -P <yourProject>  
#BSUB -o <path_to/job.%J.out>  
#BSUB -e <path_to/job.%J.err>  
#BSUB -J <jobName>  
#BSUB -R "rusage[mem=1000] span[hosts=1]"  
#BSUB -M <max_memory_in_MB>
#BSUB -n <number_of_cores>  
#BSUB -cwd <"your_dir">  

# Set your temp directory as the re_scratch folder
export TMPDIR=/re_scratch/re_gecip/<your_GECIP>/<your_username>  
export TMPDIR=/re_scratch/re_discovery_forum/<your_discovery_forum_folder>/<your_username>

# Load any required modules from the HPC
module load <moduleName>  

# The actual script you want to run
jobscript.sh input1
```

And you would then submit submission\_script.sh as:

bsub < submission\_script.sh

---

I registered for the in-person training on 20th November but haven't had any confirmation; should I assume I have a place, or not?

live answered

October 7, 2025
