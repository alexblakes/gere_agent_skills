---
title: 'How to request software installation within the Research Environment - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/hpc_software_request/
scraped_at: 2026-05-04T06:32:37Z
---

# How to request software installation within the Research Environment

We recommend using self-installation routes such as conda and CRAN to install tools wherever possible, or bringing them in with containers. However, if this is not possible, you can request for tools to be installed. Sometimes we may not be able to install the packages you request, due to licensing restrictions or technical issues.

> **Note:**
>
> Genomics England is a company wholly owned by the Department of Health and Social Care. We have a responsibility to ensure that all Genomics England products and services are compliant with applicable legal obligations surrounding patents, copyright and licensing. Many software tools have different licensing restrictions for academic and commercial entities - this can make it difficult and confusing to determine what software tools we can enable.
>
> Genomics England Limited is a private limited company registered with Companies House, not an academic institution. This means that we do not automatically qualify for academic software licenses or offers.
>
> When requesting tools, you must provide us with accurate information about the license type, to allow quick processing of your request. Requests without sufficient information or inaccurate information may be denied.

> **Note:**
>
> We try to install and test new software requests within two weeks. This is most likely to happen if:
>
> - The requested software is covered by a recognised, permissive, [Open Source license](https://opensource.org/licenses/category) (not the same as "Cost-Free for Academic use").
> - The requested software is covered by a license that allows for academic use on any platform

> **Note:**
>
> Where we need to obtain a commercial license, we will need extra time to negotiate with the license holder.
>
> Just because code is available via an open code repository, that does not necessarily make it Open Source. Some code may appear without a license document, which means we must consider it to be under copyright. If you encounter any tools you would like to import that have no license attached to them, we suggest you reach out to the developers and encourage them to add a license.

## Process for requesting software installations within the Research Environment and HPC

### R and Python Packages

These packages are normally hosted within repositories that can be directly accessed by the underlying tool (CRAN/Bioconductor, PyPI/Conda).

We have detailed instructions on the self-install channels that are open to researchers that require these types of tools.

[Self-Installation of Python tools](../hpc_conda/)

[Self-Installation of R tools from CRAN](../r_packages/)

This is the quickest and easiest way to get software into the RE. **You** are responsible for ensuring that you have the correct license.

### Containers

It is possible to self-import more complex tools within a container. We have [Singularity](../hpc_containers/) installed on the HPC, which can be used standalone or as part of workflows. For more information on the use of containers please review the instructions on [this page](../hpc_containers/). **You** are responsible for ensuring that you have the correct license.

### All other software

For all other software, you will need to raise a software installation request ticket. We ask for information that will allow us to quickly:

- verify whether the tool already available, as sometimes the tool can be difficult to identify or contained within an enveloping module
- verify that the requested location is appropriate, either the virtual desktop (intended for exploration) or the HPC (intended for significant compute requests).
- verify that the licensing covering the tool meets the provisions of Genomics England's licensing policy
- collate the installation and testing instructions.

The flowchart below outlines the steps:

The pre-installation checks, installation process and post-installation verifications require the input of multiple members of the research support team and can take several weeks to complete.

We would only decline a request or not provide a tool if:

- The license under which the tool has been released is not compatible with Genomics England's licensing policy
- The tool has not been released under any license (copyright statements are not sufficient)
- The information provided around the tool's licensing significantly differs from the information we are able to access during our verification steps
- There are significant technical blockers hindering Genomics England's ability to ensure the tool can be installed or is reliably functional
- Functional testing has failed multiple times and we are unable to get assistance from the developer to resolve the problem

August 13, 2024
