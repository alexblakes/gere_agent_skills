---
title: 'AVT known issues - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/avt_known_issues/
scraped_at: 2026-05-04T06:31:23Z
---

# AVT known issues

## Genome build

We recommend using input variant datasets based on genome build GRCh38 (the default, aggV2, is on GRCh38). The workflow is ***untested*** on other genome builds.

---

## Possible container issues

Due to recent issues with our infrastructure, the workflow may fail or crash while pulling one of the containers used by the individual processes, with an error message similar to the following one:

```
Pulling Singularity image docker://docker-gel-research-containers.artifactory.aws.gel.ac/python:v3.11.4.1 [cache /home/<username>/.singularity/cache/docker-gel-research-containers.artifactory.aws.gel.ac-python-v3.11.4.1.img]
ERROR ~ Error executing process > 'GEL_AVT:AGGREGATE_VARIANT_TESTING:VALIDATE_INPUT_FILES'Caused by:
  Failed to pull singularity image
  command: singularity pull  --name docker-gel-research-containers.artifactory.aws.gel.ac-python-v3.11.4.1.img.pulling.1719425547233 docker://docker-gel-research-containers.artifactory.aws.gel.ac/python:v3.11.4.1 > /dev/null
  status : 143
```

If this happens, or anyway to avoid the risk of it happening, simply follow these steps before starting your first run on the AVT workflow (this needs to be done only once for each user):

```
mkdir -p ~/.singularity/cache
cp /gel_data_resources/workflows/input_material/rdp_aggregate_variant_testing/containers/* ~/.singularity/cache/
```

We apologise for this inconvenience.

---

## Regenie and SAIGE-GENE association analysis for multiple variant "masks"

Association analysis using the three "branches" of AVT v4.2.0 can be done on several "masks", i.e. collections of variants specified by annotation labels (like "loss-of-function", "missense", etc). However, the outcome is different for the SAIGE-GENE and REGENIE branches vs the Fisher's test branch - and in the former two cases it is not the same as it was in older versions of AVT workflow.

In the case of the Fisher's test branch, the outcome is the same as it was in older versions of AVT workflow: each *individual* annotation label (provided either in the fourth column of the `region_input_file` input file in variant mode, or within the `functional_annotation_filter_masks` file in other modes) is tested for separately, and all results are provided in the output folder.

In the case of the SAIGE-GENE and REGENIE branches, the behaviour is different - and it is in line with what happens when users provide multiple "masks" of variants to recent versions those two programs directly.  
In other words, the versions of both REGENIE and SAIGE-GENE that are run in AVT v4.2.0 both allow users to specify "masks" or composed of one or more annotation labels to the programs themselves.

In AVT v4.2.0, users can specify such "masks" as input parameters, and they will be passed on as-is to REGENIE and SAIGE-GENE. Please note that in the case of SAIGE-GENE, that will be a string (parameter `saige_masks`) passed directly to SAIGE-GENE's `--annotation_in_groupTest` [option](https://saigegit.github.io/SAIGE-doc/docs/set_step2.html), while in the case of REGENIE it will be a JSON file (parameter `regenie_masks`) passed directly to REGENIE's `--mask-def` [option](https://rgcgithub.github.io/regenie/options/#gene-based-testing).

The versions of SAIGE-GENE and REGENIE used in AVT v4.2.0 allow only one annotation label per variant during testing: a consequence of this is that multiple "masks" will be appropriately tested for only if they are non-overlapping (i.e. each mask is composed of one label and labels are non-overlapping, like "intergenic" and "exonic", or masks are made up adding several labels again in such a way that each mask properly collects all relevant variants, for example "loss-of-function" and "loss-of-function + missense" if "loss-of-function" is the main label and labels all of the variants that would have both annotations).

In the workflow inputs, SAIGE-GENE and REGENIE will use variant annotations from the third column of the `region_input_file` input file in variant mode (which should be only one label per variant), or will choose the most severe label (as specified in the `mask_rank` input file) in all other modes.

This means that with AVT v4.2.0, you will need to submit multiple separate runs of the workflow if you wish to perform analysis for multiple overlapping annotation labels.

---

## SAIGE-GENE association analysis: no weights for variants

AVT v4.2.0 does ***not*** allow use of weights in variant input files as described [here](https://saigegit.github.io/SAIGE-doc/docs/set_step2.html).

---

November 29, 2024
