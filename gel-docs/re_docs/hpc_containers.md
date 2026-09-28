---
title: 'Importing software with containers - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/hpc_containers/
scraped_at: 2026-05-04T06:34:40Z
---

# Importing software with containers

> **Licensing considerations:**
>
> Please note if you choose a self-install route you will be solely and fully responsible for acquiring any licences required for the use of and access to the relevant software package. Genomics England expect all software to be correctly licensed by the researcher where the self-installation route is employed. In no event shall Genomics England be liable to you or any third parties for any claim, damages or other liability, whether such liability arises in contract, tort (including negligence), breach of statutory duty, misrepresentation, restitution and on an indemnity basis or otherwise, arising from, out of or in connection with software self-installed by the researcher or the use or other dealings by the researcher in the software.
>
> Any links to third party software available on this User Guide are provided âas isâ without warranty of any kind, either expressed or implied, and such software is to be used at your own risk. No advice or information, whether oral or written, obtained by you from us or from this User Guide shall create any warranty in relation to the software.

Containers allow you to work with software, where all dependencies are packaged up for you. You can use containers to bring software into the Research Environment.

> **Note:**
>
> Containers are for bringing in **software** to the RE, not data.

There are a number of different tools for creating and working with containers, the most well-known being [Docker](https://www.docker.com/) and [Singularity](https://sylabs.io/). In the RE, we provide Singularity on the HPC, as this allows you to work with containers without requiring root access. Singularity allows you to use containers in Singularity and Docker format.

## Importing containers in the RE

The only repositories you can use to import containers to the RE are [docker hub](https://hub.docker.com/) and [quay.io](https://quay.io/). These must be [rerouted via artifactory](../containers_step_by_step/#4-pull-the-container) for security reasons.

To use containers on the Genomics England HPC, follow the steps below:

1. Identify the container you want to import
2. Launch a job on the HPC
3. Load Singularity
4. Pull the container
5. Mount files to the container
6. Run the container

[Detailed step-by-step guide](../containers_step_by_step/)

## Terminology

| Term | Meaning |
| --- | --- |
| container | contains a packaged application, along with its dependencies, and information on what processes it runs when launched |
| image | A copy of a container that has been pulled to your machine or environment |
| Docker | A tool for creating and using containers. Docker is not installed on the RE but you can use containers created with Docker in the RE. |
| Singularity | A tool for creating and using containers, which is available in the RE. |
| repository | An online resource where people can deposit containers. You can use these to access existing containers, and to put you own containers for access in the RE. |
| [dockerhub](https://hub.docker.com/) | A repository for docker containers. |
| [quay.io](https://quay.io/) | A repository for containers. |
| artifactory | A repository used by Genomics England to re-route containers, instead of pulling them directly from dockerhub and quay.io, ensuring that containers can only be pulled in and not pushed out. |
| pull | Fetch an image of a container from a remote repository |
| run | Run the main function of the software in the container |
| exec | Carry out other functions using the software in the container |
| mount/bind | Use your local files with the container. Mount and bind are used interchangeably. |

## Building your own containers

We recommend [this tutorial](https://www.docker.com/101-tutorial/) from Docker on how to build containers and make them accessible through docker hub.

## Caching

Whenever you create an image with Singularity within the HPC, the files are automatically cached. The cached files are located in `/home/<username>/.singularity/`. However, it could be that you are submitting and creating an image via a compute node in an interactive session. In that case the caching will output the file there which may potentially flood the compute node's memory. You can redirect this location by setting the environment variable `SINGULARITY_CACHEDIR`.

For example, we recommend placing the environment variable in your `.bashrc` script as follows `SINGULARITY_CACHEDIR="/re_gecip/my_GECIP_/username/singularity_cache/"`.

To view your current cache you can use the command `singularity cache list` and `singularity cache list --all` to view all the individual blobs that have been pulled.

To clean up your cache you can use the command: `singularity cache clean`

February 13, 2025
