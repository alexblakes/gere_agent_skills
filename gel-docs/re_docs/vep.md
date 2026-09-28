---
title: 'Variant Effect Predictor (VEP) - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/vep/
scraped_at: 2026-05-04T06:34:52Z
---

# Variant Effect Predictor (VEP)

VEP is a tool provided by Ensembl for functional annotation of variant consequences on genes. We currently provide a script to run versions 112, 113.3 and 115.2 of VEP, including the most used plugins.

## Description

The [Variant Effect Predictor (VEP)](https://www.ensembl.org/info/docs/tools/vep/index.html) is a comprehensive annotation source created by the Ensembl project and relies on their database to provide annotation data for variants. We have provided a simple script that will allow you to use the VEP to annotate variants in the RE.

> **Commercial usage:**
>
> If you are an industry Research Network member, there are some restrictions on the plugins and VEP options you are allowed to use.
>
> Genomics England imposes no restrictions on access to, or use of, the data provided and the software used to analyse and present it.
>
> Some of the data and software included in the distribution may be subject to third-party constraints. You are solely responsible for establishing the nature of and complying with any such restrictions.

## Files

The scripts and example input file for running VEP can be found at:

`/gel_data_resources/example_scripts/annotate_variants_with_vep/115.2/`

The directory includes the following files:

- `vep.sh` - a script that constructs the VEP command and takes care of job submission to LSF. **This file does not need to be copied or edited**.
- `example_input.csv` - an example input file outlining the expected format.
- `template_submit.sh` - a template shell script that includes an example command for running VEP via `vep.sh`. You should copy this script to your [working directory](../home_directory/) and modify it as required for your use case.

## Instructions

### Input

You need to create an input file. This is a simple csv file with the columns `ID` and `VCF`, which should include an identifier for the sample and the [file location of the VCF](../genomic_data/). The identifier can be a `participant_id`, a `platekey` or any other identifier you choose to use; this will be used to identify the output files.

> **Example input file:**
>
> ```
> ID,VCF
> sample1,/path/to/vcf_for_sample1.vcf
> sample2,/path/to/vcf_for_sample2.vcf.gz
> ```

All VCFs in your input should be mapped to the same genome assembly. If you want to annotate some VCFs mapped to GRCh37 and GRCh38, you should put them into separate input files and run the script twice.

### Usage

First, navigate to your [working directory](../home_directory/), copy the `template_submit.sh` script to your working directory, and create your input file.

You will then need to set the parameters at the top of the `template_submit.sh` file:

- `RESULTS_FOLDER` - the path to the output directory where you want your results to be written to
- `PROJECT_CODE` - your [LSF project code](../lsf_codes/)
- `INPUT_FILE` - the path to your input file

The `template_submit.sh` script provides an example command for running `vep.sh` which can be used as-is or can be modified for your needs.

> **template\_submit.sh:**
>
> ```
> #!/bin/bash
>
> ## Parameters for you to populate 
> RESULTS_FOLDER=""
> PROJECT_CODE=""
> INPUT_FILE=""
>
> ## Further environment setup. No need to change this.
> mkdir -p ${RESULTS_FOLDER}
>
> ## Script which will be submitted to the HPC. This command is provided as an example and can be adjusted to suit your needs. 
> /gel_data_resources/example_scripts/annotate_variants_with_vep/115.2/vep.sh \
>     -i ${INPUT_FILE} \
>     -c ${PROJECT_CODE} \
>     -g GRCh38 \
>     -v 115.2 \
>     -p '--plugin dbNSFP,/public_data_resources/dbNSFP/dbNSFP4.7/4.7/dbNSFP4.7c/dbNSFP4.7c_grch38.gz,/public_data_resources/vep_resources/VEP_plugins/dbNSFP_replacement_logic,ALL --plugin LoF,loftee_path:/opt/vep/.vep/Plugins/loftee_GRCh38,human_ancestor_fa:/public_data_resources/vep_resources/LOFTEE/Build-38/human_ancestor.fa.gz,gerp_bigwig:/public_data_resources/vep_resources/LOFTEE/Build-38/gerp_conservation_scores.homo_sapiens.GRCh38.bw,conservation_file:/public_data_resources/vep_resources/LOFTEE/Build-38/loftee.sql --plugin SpliceAI,snv=/public_data_resources/SpliceAI/Predicting_splicing_from_primary_sequence-66029966/genome_scores_v1.3/spliceai_scores.raw.snv.hg38.vcf.gz,indel=/public_data_resources/SpliceAI/Predicting_splicing_from_primary_sequence-66029966/genome_scores_v1.3/spliceai_scores.raw.indel.hg38.vcf.gz --plugin CADD,/public_data_resources/CADD/v1.7/GRCh38/whole_genome_SNVs.tsv.gz --plugin mutfunc,db=/public_data_resources/ensembl-data/mutfuc_db/mutfunc_data.db' \
>     -d '--custom /public_data_resources/clinvar/20240627/vcf_GRCh38/clinvar.vcf.gz,ClinVar,vcf,exact,0,CLNDN,CLNDNINCL,CLNDISDB,CLNDISDBINCL,CLNHGVS,CLNREVSTAT,CLNSIG,CLNSIGCONF,CLNSIGINCL,CLNVC,CLNVCSO,CLNVI --custom /public_data_resources/vep_resources/Build-38/gerp_conservation_scores.homo_sapiens.GRCh38.bw,GERP,bigwig --custom /public_data_resources/phylop100way/hg38.phyloP100way.bw,PhyloP,bigwig --custom /public_data_resources/TOPMed/allele_frequencies/bravo-dbsnp-all.vcf.gz,topmedg,vcf,exact,0,AF,SVM' \
>     -s '--variant_class --sift b --gene_phenotype --regulatory --numbers --hgvs --protein --symbol --ccds --uniprot --tsl --appris --canonical --mane --biotype --domains --check_existing --af --max_af --af_1kg --af_gnomade --af_gnomadg --pubmed' \
>     -o ${RESULTS_FOLDER} \
>     -q medium \
>     -n 2 \
>     -m 8G
> ```

To run the `template_submit.sh` script simply run the following command in your working directory:

```
bash template_submit.sh
```

## Getting help

The `vep.sh` script includes help, which you can access with:

`/gel_data_resources/example_scripts/annotate_variants_with_vep/115.2/vep.sh -h`

contents of `/gel_data_resources/example_scripts/annotate_variants_with_vep/115.2/vep.sh -h`

```
-i </path/to/input/file>
-c <One of: re_gecip_cancer_breast re_gecip_cancer_childhood re_gecip_cancer_colorectal re_gecip_cancer_glioma re_gecip_cancer_haem re_gecip_cancer_head_neck re_gecip_cancer_lung re_gecip_cancer_melanoma re_gecip_cancer_neuroendocrine re_gecip_cancer_ovarian re_gecip_cancer_pan re_gecip_cancer_prostate re_gecip_cancer_renal_cell re_gecip_cancer_sarcoma re_gecip_cancer_testicular re_gecip_cancer_unknown_primary re_gecip_cancer_upper_gi re_gecip_cardiovascular re_gecip_endocrine_and_metabolism re_gecip_enhanced_interpretation re_gecip_ethics_social_science re_gecip_functional_crosscutting re_gecip_functional_effects re_gecip_haem_disorders re_gecip_health_economics re_gecip_health_records re_gecip_hearing_and_sight re_gecip_immune re_gecip_inherited_cancer_predisposition re_gecip_machine_learning re_gecip_musculoskeletal re_gecip_neurology re_gecip_paediatrics re_gecip_population_genomics re_gecip_renal re_gecip_respiratory re_gecip_skin re_gecip_stratified_medicine re_df_abbvie_1 re_df_alexion re_df_alnylam re_df_astellas re_df_astrazeneca re_df_bayer re_df_berg_health re_df_biogen re_df_biomarin re_df_bioxplor re_df_bms re_df_cellworks re_df_commercial re_df_congenica re_df_daiichi re_df_dnastack re_df_genomics_plc re_df_gsk re_df_helomics re_df_hummingbird_bio re_df_illumina re_df_integral re_df_ionis re_df_iqvia re_df_lifebit re_df_macusoft re_df_merck re_df_msd re_df_myneo re_df_my_personal_therapeutics re_df_novartis re_df_ONT re_df_pangea re_df_qiagen re_df_rhythm re_df_roche re_df_roche_dw_collaboration re_df_serinusbio re_df_servier re_df_silence_therapeutics re_df_sysmex re_df_takeda re_df_the_hyve re_df_ucb bio Bio>
-g <GRCh37 or GRCh38>
-v <One of: 112 113.3 115.2>
-f </path/to/fasta/file> (Default: /public_data_resources/reference/GRCh37/Homo_sapiens.GRCh37.75.dna.primary_assembly.fa or /public_data_resources/reference/GRCh38/GRCh38Decoy_no_alt.fa)
-o </path/to/output/directory> (Default: . [current working directory])
-p <'--plugin plugin1,/path/to/plugin1/file --plugin plugin2 --plugin plugin3,/path/to/plugin3/file'>
-d <'--custom /path/to/custom/data1,option1,option2,option3 --custom /path/to/custom/data2,option1,option2'>
-s <'--vep-parameter1 option1 --vep-parameter2'>
-n <cpu-number> (Default: 4)
-m <memory-in-gb.GB or memory-in-mb> (Default: 16.GB)
-q <One of: short medium long> (Default: medium)
-h displays verbose help message
```

Run the script with `/gel_data_resources/example_scripts/annotate_variants_with_vep/115.2/vep.sh` followed by the parameters. Some parameters are required and some are optional.

### Required parameters

| Parameter | Description | Example |
| --- | --- | --- |
| `-i` | The file path for your input file | `-i vep_input_file.csv` |
| `-c` | Your [project code](../lsf_codes/) for HPC submission | `-c re_gecip_cancer_breast` |
| `-g` | The genome build you are annotating against. This should match the VCFs you are working with. If you are using VCFs from both GRCh37 and GRCh38, you should run the script twice. | `-g GRCh38` or `-g GRCh37` |
| `-v` | The version of the VEP you want to run. Currently the script only works with version 112, 113.3, and 115.2. | `-v 115.2` |

There are no defaults for the required parameters, you must include a value for them.

### Optional parameters

You can include any of the following parameters. Some of these have default values, which will set automatically if you do not include them.

| Parameter | Description | Example | Default |
| --- | --- | --- | --- |
| `-f` | The [fasta file](https://www.ensembl.org/info/docs/tools/vep/script/vep_options.html#opt_fasta) you want to use as a reference. | `-f /public_data_resources/reference/GRCh38/GRCh38Decoy_no_alt.fa` | If you set the genome build as `-g GRCh38` this will default to `-f /public_data_resources/reference/GRCh38/GRCh38Decoy_no_alt.fa` If you set the genome build to `-g GRCh37` it will default to `-f /public_data_resources/reference/GRCh37/Homo_sapiens.GRCh37.75.dna.primary_assembly.fa` |
| `-o` | The folder you want to write your output to. | `-o my_results_folder` | The current working directory. |
| `-s` | VEP options. Check the [Ensembl documentation](https://www.ensembl.org/info/docs/tools/vep/script/vep_options.html) for available options. All options should be included within quote marks after the `-s` tag. | `-s '--hgvs --protein'` | No further options added. |
| `-p` | Any [plugins](https://www.ensembl.org/info/docs/tools/vep/script/vep_plugins.html) you wish to use with the VEP. All plugins should be included inside one set of quote marks, with each [plugin preceded with `--plugin`](https://www.ensembl.org/info/docs/tools/vep/script/vep_options.html#opt_plugin). | `-p '--plugin CADD,/public_data_resources/CADD/v1.7/GRCh38/whole_genome_SNVs.tsv.gz --plugin mutfunc,db=/public_data_resources/ensembl-data/mutfuc_db/mutfunc_data.db'` | No plugins included |
| `-d` | [Custom annotation](https://www.ensembl.org/info/docs/tools/vep/script/vep_custom.html) to include. All custom annotations should be included inside one set of quote marks, with each custom annotation preceded with `--custom`. | `-d '--custom /public_data_resources/phylop100way/hg38.phyloP100way.bw,PhyloP,bigwig --custom /public_data_resources/TOPMed/allele_frequencies/bravo-dbsnp-all.vcf.gz,topmedg,vcf,exact,0,AF,SVM'` | No custom options included. |
| `-n` | The [number of nodes](../hpc_memory/) on the HPC to use. This will automatically set the appropriate [`--forks`](https://www.ensembl.org/info/docs/tools/vep/script/vep_other.html#faster) in the VEP command, so you do not need to use this option. | `-n 1` | `-n 2` |
| `-m` | The [amount of memory](../hpc_memory/) to request on the HPC. | `-m 1000` | `-m 8000` |
| `-q` | The [queue to run your job on](../hpc_queues/). | `-q short` | `-q medium` |

## Output

The output will be written to your specified `-o` location or your current working directory, with files and folders labelled according to your input ID. The output format will depend on your VEP specifications and is described in the [VEP documentation](https://www.ensembl.org/info/docs/tools/vep/vep_formats.html#output).

Your output will also include a folder called `logs`, which contains the logs of your job. Each of these are in timestamp labelled folders.

March 11, 2026
