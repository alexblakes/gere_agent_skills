---
title: 'Using Rocker containers in R - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/containers_rocker/
scraped_at: 2026-05-04T06:31:50Z
---

# Using Rocker containers in R

If you need to use a package in R or a version of R that is not available in the RE, we recommend using containers. If you need to create your own containers, we suggest using containers from the [Rocker project](https://rocker-project.org) as base images to build your container.

Here we provide some general instructions for building containers with Rocker.

## 1. Choose a base Rocker image

The Rocker project hosts a [variety of images](https://rocker-project.org/images/versioned/r-ver.html) that you can use as your base. Select the base image that most closely matches the version of R that you need for your work, and which contains the majority of the tools that you will need. For example, if you are using `tidyverse` it is best to use the `rocker/tidyverse` image, rather than starting with `rocker/r-base` and installing `tidyverse`.

> **Note:**
>
> We recommend explicitly specifying a version so that you can use it time and again if you need to rebuild your container. This will ensure that your container will work in a reproducible manner.

## 2. Create a Dockerfile

The Dockerfile is the recipe for your container. Each line in the file is a step to install the packages that you need from the command line. Below is an example Dockerfile that will install a list of packages from an accompanying `install-packages.R` file that is located in the same directory as the Dockerfile. This example includes some best-practice steps:

- building the container as root
- install system dependencies
- installing the packages
- switching to a non-root user

```
FROM rocker/r-ver:4.2.3

# install system libraries needed by R packages
USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
    libxml2-dev libssl-dev libcurl4-openssl-dev build-essential \
    && rm -rf /var/lib/apt/lists/*

# use Rocker helper to install CRAN/Bioconductor packages
COPY install-packages.R /tmp/install-packages.R
RUN Rscript /tmp/install-packages.R \
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

# create working user (if image doesn't already have one)
RUN useradd -m ruser
USER ruser
WORKDIR /home/ruser
```

The second important file that you will need will be the `install-packages.R` file such as the one provided below.

```
# For CRAN Packages
pkg_list <- c("CNVreg", "bvarsv" . "vcfR", "BiocManager")
install.packages(pkg_list, lib=<Path/to/R/libary>)

# For Bioconductor packages
bioc_pkgs <- c("GenomicRanges", "biomaRt")
BiocManager::install(bioc_pkgs)
```

These two files work together to create the container that you will need for your work. It is important to take the following guidance into account:

> **Top tip:**
>
> Containers should be as small as possible:
> - only install system libraries you need
> - consider using the [pak](https://rocker-project.org/use/extending.html) tool to identify system requirements for the packages that you need
> - pin the package verions within your `install-packages.R` file to ensure that the same versions are used with every rebuild and every environment (or packrat/renv lockfile).

## 3. Build your container and test locally

To test locally, you will need a container building tool (such as Docker or Podman) installed. Because the RE has no direct connections to the internet it is not possible to perform the build and test process within the RE.

To build your container navigate to the directory containg your Dockerfile and `install-packages.R` files and run the build process followed by a basic test.

```
# using Docker
docker build -t <user>/<image_name>:<version_number>

docker run --rm -it <user>/<image_name>:<version_number> Rscript -e 'packageVersion("dplyr")'

# using Podman
podman build -t <user>/<image_name>:<version_number>

podman run --rm -it <user>/<image_name>:<version_number> Rscript -e 'packageVersion("dplyr")'
```

## 4. Recommentations for Hardening the container for use in the RE

As the RE is a secure emvironment it is everyone's responsibility to ensure that tools used comply with the most up to date security recommendations. As such please consider the following points when building your containers.

- Remove build artifacts such as the apt cache or /tmp directories to reduce size and attack surface.
- Ensure that a non-root user is present in the container and that by default the container will be run as this unprovoledged user
- limit the installation of unrequired tools, remove these from the container after packages or system dependencies are installed
- Pin base image tag and R / package versions.

## 5. Scan and review vulnerabilities (recommended workflow)

Use a scanning tool to find and help eliminate vulnerabilities, such as Docker Scout or Trivy.

Using Trivy as an example, check the build image for vulnerabilities:

```
trivy image --severity HIGH,CRITICAL --format json --output results.json <user>/<image_name>:<version_number>
```

The resulting report will contain HIGH and CRITICAL vulnerabilites that must be closed. Check the `results.json` file.digest and SBOM to learn more about the vulnerabilities and how to close them.

## 6. Image hosting services

You can host your container on Dockerhub or quay.io, as these have been authorised for import into the RE. You will need to make your images public to allow import.

Log into the service and push the image:

```
# Tag image
docker tag <user>/<image_name>:<version_number> quay.io/<user>/<image_name>:<version_number>

# Push image to repository
docker push quay.io/<user>/<image_name>:<version_number>
```

## Using containers in the RE

To use your container please follow the [guide](../containers_step_by_step/) provided elsewere in this documentation.

January 19, 2026
