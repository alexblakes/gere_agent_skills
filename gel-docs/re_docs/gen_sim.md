---
title: 'Genetic similarity to worldwide populations (ancestry) in the UK Biobank - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/gen_sim/
scraped_at: 2026-05-04T06:32:08Z
---

# Genetic similarity to worldwide populations (ancestry) in the UK Biobank

We calculate genome-wide genetic similarity to worldwide populations (also known as "genetic ancestry", "inferred ancestry", "ethnicity" or "race"; these terms all have [slightly different meanings](https://europepmc.org/article/MED/36119389) and our preferred term is "genetic similarity"). This can help you to assign participants to groups for further studies. These data are available in flatfiles in the RE. We also provide details on how these similarity data were calculated.

Genetic similarity to worldwide populations was calculated for the [100kGP release 17](../current_release/) and [NHS GMS release 2](../current_gms/). They were compared to reference groups curated using an extended dataset including the [UK Biobank](https://www.ukbiobank.ac.uk/) following the methodology outlined in [Prive *et al* 2022 (a)](https://europepmc.org/article/MED/35604078). These data are provided as part of the Genomics England [Diverse Data initiative](https://www.genomicsengland.co.uk/initiatives/diverse-data).

## Use cases

It can be useful to know genetic similarity to worldwide populations for:

- [Genome Wide Association Studies (GWAS)](../gwas/) where independently analysing genetically homogeneous groups of participants may be a methodological requirement.
- Comparative or meta-analyses across groups of participants, labelling these participants with where in the world people genetically similar to them are from.

## File locations

You can find the results on these analyses in the RE at:

| File and descriptions | File path |
| --- | --- |
| 100,000 Genomes Project (10kGP release 17) | `/gel_data_resources/gel_diverse_data/100k/310523/100k-main_programme_v17_ukbb_worldwide_populations_310523.csv.gz` |
| NHS Genomic Medicine service (release 2) | `/gel_data_resources/gel_diverse_data/nhs-gms/310523/nhs-gms_v2_ukbb_worldwide_populations_310523.csv.gz` |

### Column descriptors

**44 total columns, 93,813 individuals**

| Field (snake\_case) | Enumerations/Data Type | Description |
| --- | --- | --- |
| Participant ID (`participant_id`) | participantId, xs:string | Participant Identifier (supplied by Genomics England) |
| Platekey (`platekey`) | varchar | Concatenation of Plate ID and Well ID - unique identifier for a processed well |
| Programme (`programme`) | varchar | 100,000 Genomes Project or NHS Genomic Medicine Service |
| Genome Build (genome\_build) | varchar | Reference Genome Build (GRCh37 or GRCh38) |
| Approximate FST to *reference\** (`approximate_fst_to_reference_*`) | float | Squared euclidean distance to *Reference* PC centres transformed to approximate FST (metric of genetic differentiation). Calculated after projecting individual genotypes and *Reference* allele frequencies onto PC1 to PC16 constructed using a curated subset of genomes from the UK Biobank and the 1000 Genomes Project. |
| Proportional similarity to *reference* (`_proportional_similarity_to_reference_*`) | float | Coefficient of relative genetic similarity to *Reference* modelled as a convex combination (non-negative and sum to 1) of coefficients from all reference groups. Calculated after projecting individual genotypes and *Reference* allele frequencies onto PC1 to PC16 constructed using a curated subset of genomes from the UK Biobank and the 1000 Genomes Project. |

\* One column for each of the 21 *reference* groups described below.

### Reference Groups

A short description of the 21 reference groups and their respective continental populations.

| Reference population | Super population | Super population code | Founder population? |
| --- | --- | --- | --- |
| United Kingdom | Europe | `EUR` | No |
| Ireland | Europe | `EUR` | No |
| Scandinavia | Europe | `EUR` | No |
| Europe South East | Europe | `EUR` | No |
| Europe North East | Europe | `EUR` | No |
| Europe South West | Europe | `EUR` | No |
| Italy | Europe | `EUR` | No |
| Finland | Europe | `EUR` | Yes |
| Ashkenazi | Europe | `EUR` | Yes |
| Africa North | North Africa | `NAF` | No |
| Middle East | Middle East | `MID` | Yes |
| Pakistan | South Asia | `SAS` | No |
| Sri Lanka | South Asia | `SAS` | No |
| Bangladesh | South Asia | `SAS` | No |
| Asia East | East Asia | `EAS` | No |
| Japan | East Asia | `EAS` | No |
| Philippines | East Asia | `EAS` | No |
| South America | South America | `AMR` | No |
| Africa East | East Africa | `EAF` | No |
| Africa South | Africa Niger-Congo \* | `ANC` | No |
| Africa West | Africa Niger-Congo \* | `ANC` | No |

\* despite being commonplace in genomics research, we do not recommend using a single "African" or `AFR` *super-population* for group assignment. If you wish to use information in this table to align group assignments with [gnomAD](https://gnomad.broadinstitute.org/news/2020-10-gnomad-v3-1-new-content-methods-annotations-and-data-availability/) or the [1,000 Genomes Project](https://www.internationalgenome.org/data-portal/population) who do utilise this terminology, we recommend using the "Africa Niger-Congo" or `ANC` *super-population* category which includes both Africa West and Africa South reference populations described in [Prive *et al* 2022 (a)](https://europepmc.org/article/MED/35604078).

For more information on Africa genomics, diversity, and identity we recommend these reviews by [Yere *et al* 2022](https://europepmc.org/article/MED/35688877) and [Pereira *et al* 2021.](https://europepmc.org/article/MED/33432191)

## How do I use this table for group assignment?

You can use these tables to identify groups of participants genetically similar to some larger *super-population*, such as South Asia, or to analyse a smaller subset of participants, such as those genetically similar to Ashkenazi Jews. We strongly recommend you read the [original methodological paper](https://europepmc.org/article/MED/35604078) to best understand how best to use this table.

Here is a short walkthrough using R:

First, we read the table into memory and select the columns containing information on approximate FST:

Assign participants to sub-populations

```
library(tidyverse)

gms_table <- read_csv("/gel_data_resources/gel_diverse_data/nhs-gms/310523/nhs-gms_v2_ukbb_worldwide_populations_310523.csv.gz")

fst_matrix <- gms_table %>%
  select(
    starts_with("Approximate FST to")
  ) %>%
  rename_all(
    ~stringr::str_replace(., "^Approximate FST to ", "")
  ) %>%
  as.matrix()
```

Let's say we want to identify participants genetically similar to European groups, akin to those described in [gnomAD](https://gnomad.broadinstitute.org/news/2020-10-gnomad-v3-1-new-content-methods-annotations-and-data-availability/) (Non-Finnish European), and assign all other participants to super populations.

To do this, we simply group together multiple *sub-populations* into *super-populations*.

Assign participants to sub-populations

```
# First select sub-population names from columns
group <- colnames(fst_matrix)

# Next define each super-population using vectors of sub-populations
group[group %in% c("Scandinavia", "United Kingdom", "Ireland", "Italy", "Europe South West", "Europe South East", "Europe North East")] <- "Non-Finnish Europe"
group[group %in% c("Africa West", "Africa South")] <- "Africa Niger-Congo"
group[group %in% c("Pakistan", "Sri Lanka", "Bangladesh")] <- "South Asia"
group[group %in% c("Asia East", "Japan", "Philippines")] <- "East Asia"
```

Now we can define a threshold of approximate FST between a participant and a particular reference group to assign the participant to the group. You should consider the size of your threshold, and the corresponding stringency, for your studies.

In this example the threshold is set to FST = 0.002, as was used in [Prive *et al* 2022 (b)](https://www.cell.com/ajhg/fulltext/S0002-9297(21)00420-1). For GWAS, you might want a more lenient threshold like FST = 0.005, as used in the [*bigsnpr* manual](https://privefl.github.io/bigsnpr/articles/ancestry.html).

Assign participants to sub-populations

```
threshold <- 0.002
```

In many instances, the FST threshold may be lenient enough that an individual could be reasonably assigned to multiple groups. In such instances, we can simply take the minimum FST between those multiple groups in order to assign. Individuals who cannot be assigned to any single group at the given threshold are given *NA*.

Now putting this all together...

Assign participants to sub-populations

```
cluster <- group[apply(fst_matrix, 1, function(x) {
  ind <- which.min(x)
  if (isTRUE(x[ind] < threshold)) ind else NA
})]

assignments <- data.frame(
  participant_id = gms_table$`Participant ID`,
  group_assignment = cluster
  )

assignments %>%
  count(group_assignment)             

# group_assignment    n
# 1         Africa East    5
# 2  Africa Niger-Congo   82
# 3        Africa North   23
# 4           Ashkenazi   38
# 5           East Asia   31
# 6         Middle East  118
# 7  Non-Finnish Europe 3221
# 8       South America   >5
# 9          South Asia  526
# 10               <NA>  325
```

And now you should have a table of participants labelled according to the reference groups defined above.

For example, here we can see that there are 3,221 participants in the [NHS Genomic Medicine Service release 2](../current_gms/) that are genetically similar enough to at least one Non-Finnish European (NFE) reference group in the [UK Biobank](https://www.ukbiobank.ac.uk/) at FST < 0.002 to be confidently labelled as such.

## Differences to other genetic similarity and ancestry data in the RE

Participants in [aggV2](../aggv2/) have been classified into groups using a [random Forest classifier](../ancestry_inference/) trained on data from the [1,000 Genomes Project](https://www.internationalgenome.org/). The differences between these data are:

| Difference | Genetic similarity | AggV2 ancestry |
| --- | --- | --- |
| Participants | All participants in 100kGP release 17 and NHS GMS release 2 | Participants in release 10 whose genomes were aligned to GRCh38 |
| Method | [Prive *et al* 2022 (a)](https://europepmc.org/article/MED/35604078) | [random Forest classifier](../ancestry_inference/) |
| Compared to | an extended dataset including the [UK Biobank](https://www.ukbiobank.ac.uk/) | [1,000 Genomes Project](https://www.internationalgenome.org/) |

The benefits of using the genetic similarity data tables over the aggV2 ancestry inference include:

- a greater diversity of worldwide populations (e.g. Middle East or East Africa)
- coefficients of proportional genetic similarity (e.g. 75% United Kingdom, 25% West Africa)

## How was this table created?

This table was created using the methodologies outlines in [Prive *et al* 2022 (a)](https://academic.oup.com/bioinformatics/article/38/13/3477/6590645?login=false) and further described in the [documentation](https://privefl.github.io/bigsnpr/articles/ancestry.html) for the R package [*bigsnpr*](https://privefl.github.io/bigsnpr/). Please cite Florian Prive's work if using this methodology in your own analyses.

### Public File Paths

| File and descriptions | File path |
| --- | --- |
| UK Biobank and 1,000 Genomes reference PC loadings (GRCh38) | `/public_data_resources/ukbb_prive/uk_biobank_1kg_grch38_projection.csv.gz` |
| UK Biobank and 1,000 Genomes reference allele frequencies (GRCh38) | `/public_data_resources/ukbb_prive/uk_biobank_1kg_grch38_freqs.csv.gz` |
| UK Biobank and 1,000 Genomes reference PC loadings (GRCh37) | /`public_data_resources/ukbb_prive/uk_biobank_1kg_grch37_projection.csv.gz` |
| UK Biobank and 1,000 Genomes reference allele frequencies (GRCh37) | `/public_data_resources/ukbb_prive/uk_biobank_1kg_grch37_freqs.csv.gz` |

### Methodology

60,825 high-quality (HQ) SNPs aligned to [GRCh38](https://www.ncbi.nlm.nih.gov/assembly/GCF_000001405.26/) were extracted from the [aggV2](../aggv2/) and [aggCOVID v5](../covid_agg/). These HQ SNPs were lifted over to [GRCh37](https://www.ncbi.nlm.nih.gov/assembly/GCF_000001405.13/) coordinates using [UCSC LiftOver](https://genome.sph.umich.edu/wiki/LiftOver) when necessary. For each participant or rare disease family, genotypes at these HQ SNPs coordinates were extracted from VCF files using [PLINK 2.0](https://www.cog-genomics.org/plink/2.0/), and genotypes at non-variable sites in each individual set as homozygous for the reference allele using [bcftools 1.12](https://samtools.github.io/bcftools/bcftools.html).

assign\_pipeline.sh

```
#!/usr/bin/env bash

file=$1 # Original VCF
hq_bed=$2 # HQ sites BED file
dummy_vcf=$3 # HQ sites VCF file (with dummy genotypes)
ref=$4 # Reference build
out_prefix=$5 # Output prefix

### Load required packages

module load R/4.3.3
module load plink/2.0
module load bcftools/1.16
module load tabix/1.18

ukbb_assigner=/pgen_int_work/BRS/dd/sam/projects/ukbb-assigner/ukbb-assigner.R # UKBB Assigner script location

dir=$(dirname $out_file)
tmp_name=$(echo $RANDOM | md5sum | head -c 20; echo)
file_tmp=${dir}/${tmp_name}

if [[ $ref == "v38" ]]
then
  reference_genome=/public_data_resources/reference/GRCh38/GRCh38Decoy_no_alt.fa
else if [[ $ref == "v37" ]]
then
  reference_genome=/public_data_resources/reference/GRCh37/Homo_sapiens.GRCh37.75.dna.primary_assembly.fa
fi

plink2 --vcf ${file}
--extract bed1 ${hq_bed}
--vcf-half-call reference
--allow-extra-chr
--make-bed
--out ${file_tmp}_1

plink2 --bfile ${file_tmp}_1
--export vcf bgz
--ref-from-fa force
--fa ${reference_genome}
--out ${file_tmp}_2

bcftools merge
--missing-to-ref
${file_tmp}_2.vcf.gz ${dummy_vcf} |
bcftools view
-s ^DUMMY
-Oz -o ${file_tmp}_3.vcf.gz

plink2 --vcf
${file_tmp}_3.vcf.gz
--geno 0
--make-bed
--out
${out_prefix}

rm ${file_tmp}*

Rscript ${ukbb_assigner}
-p ${out_prefix}
--tmpDir tmp
-r ${ref}
-m
-o ${out_prefix}.ukbb_group
```

For each participant, their genetic similarity to worldwide populations in the UK Biobank was estimated using the [ukbb-assigner](https://cnfl.extge.co.uk/pages/viewpage.action?pageId=382829231) tool.

HQ sites were intersected with 5,816,590 loci aligned to [GRCh37](https://www.ncbi.nlm.nih.gov/assembly/GCF_000001405.13/) detailed in [Prive *et al* 2022 (a)](https://academic.oup.com/bioinformatics/article/38/13/3477/6590645?login=false) (converted to to [GRCh38](https://www.ncbi.nlm.nih.gov/assembly/GCF_000001405.26/) coordinates using [UCSC Liftover](https://genome.sph.umich.edu/wiki/LiftOver) when necessary) resulting in 55,706 sites used for inference.

The big\_prodMat() function from the [*bigsnpr*](https://privefl.github.io/bigsnpr/) R package was used to project participant genotypes and reference group allele frequencies at these 55,706 sites onto the top 16 linkage-disequilibrium scaled principal components (PC1-PC16) calculated using a selection of individuals from the [UK Biobank](https://www.ukbiobank.ac.uk/) and the [1,000 Genomes Project](https://www.internationalgenome.org/) as calculated in [Prive *et al* 2022 (a)](https://europepmc.org/article/MED/35604078).

ukbb-assigner.R

```
#!/usr/bin/env/Rscript

if (!suppressMessages(suppressWarnings(require("pacman")))) install.packages("pacman")
pacman::p_load(tidyverse, bigsnpr, optparse, tools)

option_list <- list(
  optparse::make_option(c("-v", "--vcf"),
    type = "character",
    default = NULL,
    help = "Path to single or multi-sample VCF file (must be gzipped)",
  ),
  optparse::make_option(c("-p", "--plink"),
    type = "character",
    default = NULL,
    help = "Path to single or multi-sample binary plink file prefix bed/bim/fam",
  ),
  optparse::make_option(c("-r", "--reference"),
    type = "character",
    default = "v38",
    help = "Reference genome build (options: v37 or v38).",
  ),
  optparse::make_option(c("-o", "--output"),
    type = "character",
    default = file.path("assignment"),
    help = "Output prefix. default - assignment",
  ),
  optparse::make_option(c("--tmpDir"),
    type = "character",
    default = getwd(),
    help = "Path to temporary directory.",
  ),
  optparse::make_option(c("-m", "--mixture"),
    action = "store_true",
    default = FALSE,
    help = "Also output population-specific mixture fractions.",
  )
)

opt_parser <- optparse::OptionParser(option_list = option_list)
opt <- optparse::parse_args(opt_parser)

tmpDir <- opt$tmpDir
if (substr(tmpDir, nchar(tmpDir), nchar(tmpDir)) == "/") {
  tmpDir <- tmpDir
} else {
  tmpDir <- paste0(tmpDir, "/")
}

reference <- opt$reference
if (reference == "v38") {
  ukbb_files_path <- "/public_data_resources/ukbb_prive/uk_biobank_1kg_grch38"
} else if  (reference == "v37") {
  ukbb_files_path <- "/public_data_resources/ukbb_prive/uk_biobank_1kg_grch37"
}

cat("Reading in reference PC loadings and Allele Frequencies...n")
all_freq_ukbb <- bigreadr::fread2(paste0(ukbb_files_path, "_freqs.csv.gz")) %>%
  dplyr::select(-rsid) %>%
  mutate(chr = as.character(chr))
loadings_ukbb <- bigreadr::fread2(paste0(ukbb_files_path, "_projection.csv.gz")) %>%
  dplyr::select(-rsid) %>%
  mutate(chr = as.character(chr))
cat("Complete.n")

n_pcs <- 16
## Here, we will apply the correction for PC shrinkage calculated by Prive _et al_ 2022
correction_full <- c(1, 1, 1, 1.008, 1.021, 1.034, 1.052, 1.074, 1.099,
                        1.123, 1.15, 1.195, 1.256, 1.321, 1.382, 1.443)
correction <- correction_full[1:n_pcs]  

### Projection function
project_genomes <- function(bedfile, all_freq, loadings, correction) {
  ## Match alleles
  bim <- sub_bed(bedfile, ".bim") %>%
    bigreadr::fread2(select = c(1, 4:6),
                   col.names = c("chr", "pos", "a1", "a0")) %>%
    mutate(beta = 1, chr = as.character(chr))

  matched <- bim %>%
    snp_match(all_freq[1:4])

  ## Get genotypes from bedfile (WARNING: CREATES TEMPORARY FILE)
  random_number <- paste0(as.character(sample.int(100, 10)), collapse = "")
  backingfile <- paste0(tmpDir, "temp", random_number)
  rds <- snp_readBed2(
    bedfile,
    backingfile = backingfile,
    ind.col = matched$`_NUM_ID_.ss`
  )
  obj.bigsnp <- snp_attach(rds)

  ## Rapidly impute missing genotypes
  ## exclude those with lots of missing genotypes
  G <- obj.bigsnp$genotypes
  five_perc_miss <- 0.05 * nrow(obj.bigsnp$fam)

  nb_na <- big_counts(G)[4, ]
  ind <- which(nb_na < five_perc_miss)
  cat(paste0(length(ind), " SNPs remaining after filtering on >5% missingnessn"))

  G2 <- snp_fastImputeSimple(G)

  ### Project samples onto PC space
  PROJ <- as.matrix(loadings[matched$`_NUM_ID_`[ind], -(1:4)])
  all_proj <- big_prodMat(G2, sweep(PROJ, 2, correction / 2, '*'),
    ind.col = ind,
    # scaling to get G if beta = 1 and (2 - G) if beta = -1
    center = 1 - matched$beta[ind],
    scale = matched$beta[ind]
  ) %>%
  data.frame() %>%
  drop_na() %>%
  as.matrix()
  rownames(all_proj) <- obj.bigsnp$fam[, c(2)]

  ### Create matrix cross product
  X <- crossprod(PROJ,
    as.matrix(all_freq[matched$`_NUM_ID_`[ind], -(1:4)])
  )
  system(glue::glue("rm {backingfile}.bk"))
  system(glue::glue("rm {backingfile}.rds"))
  ### Return labelled matrix without missing samples
  return(list(X, all_proj))
}  

### Run projection
system.time(
  projection_files <- project_genomes(
    bedfile = bedfile,
    all_freq = all_freq_ukbb,
    loadings = loadings_ukbb,
    correction = correction,
    tmpDir = tmpDir
))
```

The SNP intersection and projection takes approximately **10 seconds**.

Squared Euclidean distance between each participant and 21 curated reference groups on PC space were converted into approximate FST ([Prive *et al* 2022 (b)](https://europepmc.org/article/MED/35604078)).

ukbb-assigner.R

```
### continued...

### Gather reference (X) projection and sample projection (all_proj)
X <- projection_files[[1]]
all_proj <- projection_files[[2]]

### Assign participants and get approximate FST function  
assign_euclidean <- function(X, all_proj) {
  # Get pop centres from matrix crossprod
  all_centers <- t(X)

  ### squared distance to centres to assign
  max_sq_dist <- max(dist(all_centers)^2) / 0.16

  ## Find square distance to centres from projection
  all_sq_dist <- apply(all_centers, 1, function(one_center) {
    rowSums(sweep(all_proj, 2, one_center, '-')^2)
  })
  all_sq_dist <- all_sq_dist / max_sq_dist

  col <- colnames(all_sq_dist)
  return(cbind(data.frame(
    Sample = rownames(all_proj),
    ), data.frame(all_sq_dist) %>%
      setNames(paste("Approximate FST to", col, sep = " "))
  ))
}  

cat("Getting approximate FST to groups.n")
system.time(
  out <- assign_euclidean(
    X = X,
    all_proj = all_proj
  )
)
```

Obtaining approximate FST to reference groups after SNP intersection and projection takes approximately **0.5 seconds**.

Coefficients of proportional genetic similarity to each of these 21 reference groups were calculated using an extension of the Summix method also described in [Prive *et al* 2022 (a)](https://europepmc.org/article/MED/35604078).

ukbb-assigner.R

```
### continued...

#### Proportional genetic similarity function
assign_admixture <- function(X, all_proj) {
  # Generate inputs for QP
  cp_X_pd <- Matrix::nearPD(crossprod(X), base.matrix = TRUE)
  Amat <- cbind(1, diag(ncol(X)))
  bvec <- c(1, rep(0, ncol(X)))

  # solve a QP for each projected individual
  all_res <- apply(all_proj, 1, function(y) {
    quadprog::solve.QP(
      Dmat = cp_X_pd$mat,
      dvec = crossprod(y, X),
      Amat = Amat,
      bvec = bvec,
      meq  = 1
    )$sol %>%
    round(7)
  })
  all_res <- t(all_res)
  colnames(all_res) <- colnames(X)

  all_prop <- all_res %>%
    as.data.frame() %>%
    setNames(paste("Proportional similarity to", colnames(.), sep = " ")) %>%
    mutate(Platekey = rownames(.), .before = colnames(.)[1])

  return(all_prop)
}  

### Run to get proportional genetic similarity
mixture <- opt$mixture
if (mixture) {
  system.time(
    mixtures <- assign_admixture(
      X = X,
      all_proj = all_proj,
      group = group
    )
  )
  out <- out %>%
    left_join(mixtures, by = "Sample")
}
cat("Complete.n")
write_tsv(out, paste0(opt$output, ".tsv"))
```

Obtaining proportional genetic similarity to reference groups using the Summix method after SNP intersection and projection takes approximately **10 seconds**.

## Don't you mean ancestry groups?

You may be familiar with other terms such as genetic ancestry, inferred ancestry, ethnicity or race. Here, we prefer instead to use the more precise term of **genetic similarity**.

We prefer this term because it doesn't infer anything about where a person ot their family come from, which can lead to misunderstandings or misinterpretations. A person could have genetic similarity to, for example, Middle East labelled reference genomes in the UK Biobank (to some threshold value e.g. approximate FST < 0.002), but it would be wrong to say they are of *Middle Eastern ancestry* or *Middle Eastern descent*, as they and their family are from Europe!

Please do not use this information to describe an individual's personal identity, and do not over-interpret results. For more information, we recommend reading discussions such as those authored by [Graham Coop](https://arxiv.org/abs/2207.11595).

## What if the genomes I wish to analyse are not included here?

Currently, consented participants from the [100,000 Genomes Project 100kGP release 17](../current_release/) or the [NHS GMS release 2](../current_gms/) are included in this table. However, we recognise that a smaller subset of consented participants from the [NHS GMS release 2](../current_gms/) may not be included in this table owing to one or more individuals within a family withdrawing consent.

We plan on including these genomes at a later date. However, in the meantime, please see the *Methodology* section below for guidance on how to generate this information for any participant.

## Contact

For any additional help or advice on genetic similarity assignment, participant genetic ancestry, or utilising this updated methodology please [raise a ticket](https://jiraservicedesk.extge.co.uk/servicedesk/customer/portals) and tag Sam Tallman (samuel.tallman@genomicsengland.co.uk).

July 28, 2025
