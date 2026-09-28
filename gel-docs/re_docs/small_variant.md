---
title: 'Small Variant workflow - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/small_variant/
scraped_at: 2026-05-04T06:34:47Z
---

# Small Variant workflow

[pipeline version: v3.1.4](../small_variant_changelog/)

The **Small Variant** workflow finds variants within a list of genes. It outputs these into tsv files containing variants, variant consequences and the participants with alternative alleles at these loci.

> **Germline genomes only:**
>
> The Small Variant workflow is intended for use on germline genomes only.

Given a list of participant VCFs and a list of query genes, the workflow aggregates the VCFs into a single multi-sample VCF file keeping only variants within query genes, and annotates the variants. The default annotations include functional consequences, allele frequencies, disease associations, and pubmed citations. All included annotations are listed in the [Design](#design) section. You can use the workflow to answer common queries like [âWhich participants have rare, missense variants in my gene(s) of interest?â](../gene_to_phenotype/)

The workflow is written in [Nextflow DSL2](https://www.nextflow.io/docs/latest/index.html) and uses containerised [Python 3](https://docs.python.org/3/) (and the [Python API for LabKey](https://github.com/LabKey/labkey-api-python)), [bcftools](https://samtools.github.io/bcftools/bcftools.html), and [VEP](https://www.ensembl.org/info/docs/tools/vep/index.html)

> **Sample selection:**
>
> On HPC, if no samplesheet is provided, the workflow performs a LabKey query to retrieve all germline rare disease and cancer participants, for both Illumina V2 (GRCh37) and Illumina V4 (GRCh38). This retrieves that largest sample called by a single tool. To use DRAGEN (GRCh38), set parameter `--dragen true` (default `false`). On CloudOS, a samplesheet is required. The minimum sample size for each delivery version (genome build) included is four participants.

## Usage

1. copy the LSF submission script `/gel_data_resources/workflows/rdp_small_variant/v3.1.4/submit.bsub` to your `re_gecip` or `discovery_forum` folder

   - `cd` into your working folder
   - `cp /gel_data_resources/workflows/rdp_small_variant/v3.1.4/submit.bsub .`
2. create your gene and (optional) samplesheet [input files](../small_variant_input_files/)
3. update the submission script:
   - insert your [LSF Project Code](../lsf_codes/):
     - `#BSUB -P <PROJECT_CODE> # line 3`
     - `PROJECT_CODE='<PROJECT_CODE>' # line 9`
   - set your input files as parameters:
     - `--gene_input # line 41`
     - `--samplesheet` (optional, if using a custom sample subset)
4. run the workflow, `bsub < submit.bsub`

submit.bsub

```
#!/bin/bash

#BSUB -P <project_code>
#BSUB -q inter
#BSUB -J smlv
#BSUB -o logs/%J_rdp_small_variant.stdout
#BSUB -e logs/%J_rdp_small_variant.stderr

PROJECT_CODE='<PROJECT_CODE>'
SCRATCH="/re_scratch/${USER}"
VERSION='v3.1.4'
WORKFLOW_PARENT_DIR='/gel_data_resources/workflows/rdp_small_variant'
WORKFLOW="${WORKFLOW_PARENT_DIR}/${VERSION}"

# Warning message to use latest version
LATEST_VERSION=$(find $WORKFLOW_PARENT_DIR -maxdepth 1 -type d -not -name '.*' -printf '%f\n' | sort | tail -n 1)
CURRENT_VERSION=$(basename $WORKFLOW)
if [[ "$LATEST_VERSION" != "$CURRENT_VERSION" ]]; then
    echo "WARNING: Small Variant $LATEST_VERSION is available. You are using $CURRENT_VERSION."
    echo "Please use $LATEST_VERSION and refer to the RE documentation for updated features."
fi

# Error message for missing SCRATCH
if [ ! -d "${SCRATCH}" ]; then
    echo "ERROR: Directory ${SCRATCH} does not exist. Create a scratch folder in /re_scratch/re_gecip/<domain>/<user_folder>, or /re_scratch/discovery_forum/<domain>/<user_folder>, and update the line SCRATCH=\"/re_scratch/${USER}\" in your submission script to point to the new scratch folder. Please raise a Service Desk ticket if you have any trouble creating a scratch folder."
    exit 1
fi

LSF_JOB_ID=${LSB_JOBID:-default}
export NXF_LOG_FILE="logs/${LSF_JOB_ID}_rdp_small_variant.log"
export NXF_SINGULARITY_CACHEDIR="${HOME}/.singularity/cache"

module purge
module load singularity/4.1.1 nextflow/24.04.2-with-plugins

mkdir -p logs

nextflow run "${WORKFLOW}/main.nf" \
    --project_code "${PROJECT_CODE}" \
    --labkey_project_name "main-programme/main-programme_v19_2024-10-31" \
    --gene_input "${WORKFLOW}/input/gene_list.txt" \
    --publish_all false \
    --outdir "results" \
    -work-dir "${SCRATCH}" \
    -profile hpc \
    -ansi-log false \
    -resume
```

> **Default parameters:**
>
> The default `--gene-input` argument is a file which includes three genes (*BRCA1*, *TNF*, ENSG00000227518). The `--samplesheet` parameter is `null` and a LabKey query returns rare disease and cancer germline samples for both Illumina V2 (GRCh37) and Illumina V4 (GRCh38). Results are written to the `results/` subdirectory (change with `--outdir`). All workflow processes are run with containers and images are cached in your default singularity cache, `$HOME/.singularity/cache`.
>
> To change workflow parameters, edit your copy of the submission script. See [Parameters](../small_variant_parameters/) for additional details on querying and setting workflow parameters. See [Input files](../small_variant_input_files/) for input file formats.

### Tutorial video

## Design

Here are the connected processes of the workflow as a directed acyclic graph (DAG).

The steps are:

- Validate input arguments (`VALIDATE_ARGS`)
- Get coordinates for query genes (`FETCH_COORDS`)
- Get sample VCF list (`FETCH_SAMPLES`)
- Merge single-sample VCFs by chunk, selecting query genes regions (`FIRST_ROUND_MERGE`)
- Merge and norm to multi-sample VCF (`SECOND_ROUND_MERGE`)
- Compute and fill VCF INFO tags (`FILL_TAGS`)
- VEP-annotate variants (`VEP_ANNOTATE`)
- Combine +fill-tags computed INFO tags and VEP annotation (`COMBINE_ANNOTATIONS`)
- Write containerised tool version software\_versions.yml (`DUMP_VERSIONS`)

`FILL_TAGS` INFO tags

Computed using `bcftools` plugin `+fill-tags`:

- `AN` Total number of alleles in called genotypes
- `AC` Allele count in genotypes
- `AC_Hom` Allele counts in homozygous genotypes
- `AC_Het` Allele counts in heterozygous genotypes
- `AC_Hemi` Allele counts in hemizygous genotypes
- `NS` Number of samples with data
- `MAF` Minor Allele frequency

`VEP_ANNOTATE` annotations

VEP annotations and custom ClinVar and plugin LOFTEE fields added (See [Running VEP](https://www.ensembl.org/info/docs/tools/vep/script/vep_options.html) for a detailed description of options and annotations):

- `sift b` predicts whether an amino acid substitution affects protein function based on sequence homology and the physical properties of amino acids (both prediction term and score)
- `ccds` adds the Consensus Coding Sequence (CCDS) transcript identifer (where available) to the output
- `uniprot` adds best match accessions for translated protein products from three UniProt-related databases (SWISSPROT, TREMBL and UniParc)
- `hgvs` adds Human Genome Variation Society (HGVS) nomenclature based on Ensembl stable identifiers. Both coding and protein sequence names are added where appropriate
- `symbol` adds the gene symbol (e.g. HGNC) (where available)
- `numbers` adds affected exon and intron numbering
- `domains` adds names of overlapping protein domains
- `regulatory` looks for overlaps with regulatory regions
- `canonical` adds a flag indicating if the transcript is the canonical transcript for the gene
- `protein` adds the Ensembl protein identifier to the output where appropriate
- `biotype` adds the biotype of the transcript or regulatory feature
- `tsl` adds the transcript support level for this transcript
- `appris` adds the APPRIS isoform annotation for this transcript
- `gene_phenotype` indicates if the overlapped gene is associated with a phenotype, disease or trait
- `af` adds the global allele frequency (AF) from 1000 Genomes Phase 3 data for any known co-located variant
- `af_1kg` adds allele frequency from continental populations (AFR,AMR,EAS,EUR,SAS) of 1000 Genomes Phase 3
- `af_gnomad` includes allele frequency from Genome Aggregation Database (gnomAD) exome populations
- `af_gnomadg` include allele frequency from Genome Aggregation Database (gnomAD) genome populations
- `max_af` reports the highest allele frequency observed in any population from 1000 genomes, ESP or gnomAD
- `pubmed` reports Pubmed IDs for publications that cite existing variant
- `variant_class` outputs the Sequence Ontology variant class
- `mane` adds a flag indicating if the transcript is the MANE Select or MANE Plus Clinical transcript for the gene

VEP `--custom` [ClinVar](https://www.ncbi.nlm.nih.gov/clinvar/intro/) fields: CLNDN, CLNDNINCL, CLNDISDB, CLNDISDBINCL, CLNHGVS, CLNREVSTAT, CLNSIG, CLNSIGCONF, CLNSIGINCL, CLNVC, CLNVCSO, CLNVI

VEP `--plugin` [LOFTEE (Loss-Of-Function Transcript Effect Estimator)](https://github.com/konradjk/loftee) fields assess low- and high-confidence, stop-gained, splice site disrupting, and frameshift variants

## Nextflow documentation

For Nextflow command line documentation use `nextflow help`, and `nextflow <command> -help` for help on a particular command. To print the workflow configuration use `nextflow config -profile <profile>` - configurable parameters have a `params.` prefix. See [Parameters](../small_variant_parameters/) for use on the command line. See also [Nextflow documentation](https://www.nextflow.io/docs/latest/index.html) and [Nextflow training](https://training.seqera.io).

April 21, 2026
