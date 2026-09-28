---
title: 'Python packages and personal conda environments - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/hpc_conda/
scraped_at: 2026-05-04T06:32:31Z
---

# Python packages and personal conda environments

You can use conda in the RE to create your own Python environments. To install packages to your environments, you will need to use proxy paths.

> **Licensing considerations:**
>
> If you choose a self-install route you will be solely and fully responsible for acquiring any licences required for the use of and access to the relevant software package. Genomics England expect all software to be correctly licensed by the researcher where the self-installation route is employed. In no event shall Genomics England be liable to you or any third parties for any claim, damages or other liability, whether such liability arises in contract, tort (including negligence), breach of statutory duty, misrepresentation, restitution and on an indemnity basis or otherwise, arising from, out of or in connection with software self-installed by the researcher or the use or other dealings by the researcher in the software.
>
> Any links to third party software available on this User Guide are provided âas isâ without warranty of any kind, either expressed or implied, and such software is to be used at your own risk. No advice or information, whether oral or written, obtained by you from us or from this User Guide shall create any warranty in relation to the software.

## Using pre-made conda environments

!!! warning Pre-Made Conda environment in the Ubuntu desktop !!!"

```
Premade conda environments are currently only available on the HPC. Legacy HPC conda environments are available and functional in the upgraded HPC. While you should be using the HPC for intensive work, there are situations where you may want or need to work on the VDI, such as low volume exploration and the generation of proof of concept studies. For this type of work we would need to recommend that you create a personal conda environment as described bellow
```

!!! warning Pre-Made Conda environment in the Ubuntu desktop !!!"

```
Premade conda environments are currently only available on the HPC. Legacy HPC conda environments are available and functional in the upgraded HPC. While you should be using the HPC for intensive work, there are situations where you may want or need to work on the VDI, such as low volume exploration and the generation of proof of concept studies. For this type of work we would need to recommend that you create a personal conda environment as described bellow
```

[The attached file](../hpc_python.pdf) is a non-exhaustive list of Python modules and packages in each conda environment. Last updated 29 May 2020.

The preferred channel is `intel` where possible, followed by `bioconda`. Ensure that your required modules appear within the same environment wherever possible.

> **Note:**
>
> pip/pypi is known to have broken pandas in the `ipy3pypi` and `ipy3pypirev1` environments. The error you will see is `ImportError: cannot import name 'maybe_downcast_numerical'`. You should try `py3pypi` and `ipy3nopypirev1` as alternatives.

### Searching conda environments

You can query the conda packages available in the HPC using a resource available at:

- locally: `~/gel_data_resources/software_catalogues/conda_catalogue/`
- HPC: `/gel_data_resources/software_catalogues/conda_catalogue/`

#### How to use the conda package catalogue

This directory contains a database of all the python packages that have been installed within the various Anaconda and Miniconda environments contained within the HPC. You can query it using the accompanying python command line script.

#### How to use the script

1. Navigate to the containing directory:

   - `cd ~/gel_data_resources/software_catalogues/conda_catalogue` From the Research Environment
   - `cd /gel_data_resources/software_catalogues/conda_catalogue` From the HPC
2. Call the script with the name of the package you're interested in like:

   `./query_catalogue.sh name_of_package`

   The query is "greedy" and can expand a partial package name.

#### Example output

For the above queries you should see the following outputs:

For `pybedtools`:

```
|    | env_name                            | env_path                                                             | package_name   | package_version   |
|---:|:------------------------------------|:---------------------------------------------------------------------|:---------------|:------------------|
|  0 | testdriverpower                     | /resources/conda/miniconda3/envs/testdriverpower                     | pybedtools     | 0.8.2             |
|  1 | testldsc                            | /resources/conda/miniconda3/envs/testldsc                            | pybedtools     | 0.7.10            |
|  2 | ldsc                                | /resources/conda/miniconda3/envs/ldsc                                | pybedtools     | 0.7.10            |
|  3 | py2_7_12nopypirev1                  | /resources/conda/miniconda3/envs/py2_7_12nopypirev1                  | pybedtools     | 0.8.1             |
|  4 | testpy2_7_12pypi                    | /resources/conda/miniconda3/envs/testpy2_7_12pypi                    | pybedtools     | 0.8.1             |
|  5 | testpy2_7_12nopypi                  | /resources/conda/miniconda3/envs/testpy2_7_12nopypi                  | pybedtools     | 0.8.1             |
|  6 | testinterpretationallpypi           | /resources/conda/miniconda3/envs/testinterpretationallpypi           | pybedtools     | 0.7.8             |
|  7 | testinterpretationnopypi            | /resources/conda/miniconda3/envs/testinterpretationnopypi            | pybedtools     | 0.7.8             |
|  8 | ldsc3_1.0.1                         | /resources/conda/miniconda3/envs/ldsc3_1.0.1                         | pybedtools     | 0.8.0             |
|  9 | py2_7_12pypirev1                    | /resources/conda/miniconda3/envs/py2_7_12pypirev1                    | pybedtools     | 0.8.1             |
| 10 | py2_7_12pypirev1gmsrdpipeline2_1_11 | /resources/conda/miniconda3/envs/py2_7_12pypirev1gmsrdpipeline2_1_11 | pybedtools     | 0.8.0             |
| 11 | interpretationallpypirev1           | /resources/conda/miniconda3/envs/interpretationallpypirev1           | pybedtools     | 0.7.8             |
```

For `bedtools`:

```
|    | env_name                            | env_path                                                             | package_name   | package_version   |
|---:|:------------------------------------|:---------------------------------------------------------------------|:---------------|:------------------|
|  0 | testdriverpower                     | /resources/conda/miniconda3/envs/testdriverpower                     | bedtools       | 2.30.0            |
|  1 | testdriverpower                     | /resources/conda/miniconda3/envs/testdriverpower                     | pybedtools     | 0.8.2             |
|  2 | testidpcorepy3_6_5                  | /resources/conda/miniconda3/envs/testidpcorepy3_6_5                  | bedtools       | 2.26.0            |
|  3 | testldsc                            | /resources/conda/miniconda3/envs/testldsc                            | bedtools       | 2.29.2            |
|  4 | testldsc                            | /resources/conda/miniconda3/envs/testldsc                            | pybedtools     | 0.7.10            |
|  5 | ldsc                                | /resources/conda/miniconda3/envs/ldsc                                | bedtools       | 2.29.2            |
|  6 | ldsc                                | /resources/conda/miniconda3/envs/ldsc                                | pybedtools     | 0.7.10            |
|  7 | bedtools_2.27.1                     | /resources/conda/miniconda3/envs/bedtools_2.27.1                     | bedtools       | 2.27.1            |
|  8 | py2_7_12nopypirev1                  | /resources/conda/miniconda3/envs/py2_7_12nopypirev1                  | bedtools       | 2.29.2            |
|  9 | py2_7_12nopypirev1                  | /resources/conda/miniconda3/envs/py2_7_12nopypirev1                  | pybedtools     | 0.8.1             |
| 10 | testpy2_7_12pypi                    | /resources/conda/miniconda3/envs/testpy2_7_12pypi                    | bedtools       | 2.29.2            |
| 11 | testpy2_7_12pypi                    | /resources/conda/miniconda3/envs/testpy2_7_12pypi                    | pybedtools     | 0.8.1             |
| 12 | testpy2_7_12nopypi                  | /resources/conda/miniconda3/envs/testpy2_7_12nopypi                  | bedtools       | 2.29.2            |
| 13 | testpy2_7_12nopypi                  | /resources/conda/miniconda3/envs/testpy2_7_12nopypi                  | pybedtools     | 0.8.1             |
| 14 | testinterpretationallpypi           | /resources/conda/miniconda3/envs/testinterpretationallpypi           | pybedtools     | 0.7.8             |
| 15 | testinterpretationnopypi            | /resources/conda/miniconda3/envs/testinterpretationnopypi            | pybedtools     | 0.7.8             |
| 16 | ldsc3_1.0.1                         | /resources/conda/miniconda3/envs/ldsc3_1.0.1                         | bedtools       | 2.30.0            |
| 17 | ldsc3_1.0.1                         | /resources/conda/miniconda3/envs/ldsc3_1.0.1                         | pybedtools     | 0.8.0             |
| 18 | py2_7_12pypirev1                    | /resources/conda/miniconda3/envs/py2_7_12pypirev1                    | bedtools       | 2.29.2            |
| 19 | py2_7_12pypirev1                    | /resources/conda/miniconda3/envs/py2_7_12pypirev1                    | pybedtools     | 0.8.1             |
| 20 | py2_7_12pypirev1gmsrdpipeline2_1_11 | /resources/conda/miniconda3/envs/py2_7_12pypirev1gmsrdpipeline2_1_11 | bedtools       | 2.29.2            |
| 21 | py2_7_12pypirev1gmsrdpipeline2_1_11 | /resources/conda/miniconda3/envs/py2_7_12pypirev1gmsrdpipeline2_1_11 | pybedtools     | 0.8.0             |
| 22 | idpcorepy3_6_5rev1                  | /resources/conda/miniconda3/envs/idpcorepy3_6_5rev1                  | bedtools       | 2.26.0            |
| 23 | interpretationallpypirev1           | /resources/conda/miniconda3/envs/interpretationallpypirev1           | pybedtools     | 0.7.8             |
| 24 | testpy2_7_12pypi                    | /resources/conda/miniconda3/envs/testpy2_7_12pypi                    | bedtools       | 2.29.2            |
```

The output will detail:

- the name of the environment, you will be able to access this via the `conda activate {env_name}` command.
- the environment path, which can be used within a script to ensure that submitted scripts use the correct interpreter.
- the name of the package, as the queries are "greedy" this may contain packages that contain the name you are searching for.
- the version of the package installed within the designated conda/miniconda environment.

The `README.md` file within the database directory will contain a copy of these instructions for ease of use. -->

## Create your own conda environments

You can also create and manage your own conda environments. For security reasons, we have restricted the channels you can access to:

- main (anaconda)
- conda-forge
- bioconda
- r

**We will not be expanding this list.**

You will need to route package requests via a proxy mirror for conda requests and PyPi pip installation requests. Worked examples are shown below.

### Required file

You can copy the configuration file from `/gel_data_resources/example_config_files/Double_Helix/.condarc` using the command to your $HOME location:

`cp /gel_data_resources/example_config_files/Double_Helix/.condarc ~/.`

This must be in your $HOME location on the HPC in order for conda to be able to route your requests correctly.

### Process

We would initially recommend creating your base environment and building on top of this with a series of installs.

If you wish to use a YAML definition file for an environment that you have created externally please bear in mind the changes that you will need to make to the channels so that the process can complete.

As you will not have write access to the default install location within the HPC, you will need to ensure that you use the --prefix flag to specify the install location.

Please refer to the [conda documentation](https://docs.conda.io/projects/conda/en/4.6.0/_downloads/52a95608c49671267e40c689e0bc00ca/conda-cheatsheet.pdf) for guided steps.

### conda

For conda to be able to use the channel aliases you will need a copy of the `.condarc` file mentioned above.

Once you have this file you will be able to create your environment with the command:

`conda create python==<version_number> --prefix /path/to/env/location`

Once created you will need to use the env path in order to activate it:

```
source /resources/conda/miniconda3/bin/activate
conda activate /path/to/env/location
```

> **Note:**
>
> Do not forget to activate miniconda.

To install additional packages you will need to ensure that you have the correct aliases for each channel:

`conda install -c conda-virtual <package_1> -c conda-main <package_2> -c conda-conda-forge <package_3> -c conda-bioconda <pacakge_4> -c (conda-r <package_5>)`
These commands should work in the same way as you would expect when run outside of the Research Environment.

### Creating conda environment from a YAML definition file

It is possible to create and bulk-install packages in a few simple steps. This can be useful to quickly recreate a working conda environment from outside of the Research Environment or to use packages and versions that are the same as a collaborator's. Due to the way access to the package repostories is mediated there are some minor changes that need to be made to the process you would follow outside of the Research Environment.

You can export the definition file with the command:

`conda env export > <environment_name>.yml`

You will then need to edit the file to:
- remove the build hashes from the packages, as mentioned above we have only configured canonical channels and these may not have the same hashes
- ensure that the channel names are the same as listed in the `.condarc`:
- conda-main for anaconda
- conda-conda-forge for conda-forge
- conda-bioconda for bioconda
- conda-r for r
- move any PyPI packages to a requirements.txt file

once these changes have been made, you will be able to create the environment with the command:

`conda env create -f <env_name>.yml -p /path/to/personal/conda_envs/env_name`

Once the conda environment has been created and activated you will be able to install the PyPI packages with the command:

`pip install -r requirements.txt --index-url https://artifactory.aws.gel.ac/artifactory/api/pypi/pypi/simple`

### pip

Once you have an active conda environment you will have the option to install packages hosted by PyPI. To ensure that pip is able to access the correct proxy path you will need to use the `--index-url` flag with the path to the proxy:

`pip install <package_name> --index-url https://artifactory.aws.gel.ac/artifactory/api/pypi/pypi/simple`

March 30, 2026
