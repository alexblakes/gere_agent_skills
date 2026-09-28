---
title: 'File Manifest - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/aggv2_file_manifest/
scraped_at: 2026-05-04T06:30:59Z
summary: "File paths for aggV2 VCFs, VEP annotations, sample QC stats, PCA eigenvectors, kinship matrices, and LD-pruned SNP files for 78,195 samples."
---

# File Manifest

The root file path for all aggV2 data is:

`/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/`

Add this to the extended file paths in the table to generate the full file path.

| Files and descriptions | Extended file path |
| --- | --- |
| Aggregated genomic data | genomic\_data/gel\_mainProgramme\_aggV2\_.vcf.gz |
| Aggregated functional annotation data using VEP 98 | functional\_annotation/VEP/gel\_mainProgramme\_aggV2\_\_VEPannot.vcf.gz |
| Aggregated functional annotation data using VEP 99 | functional\_annotation/VEP\_99/gel\_mainProgramme\_aggV2\_\_VEPannot.vcf.gz |
| Test data. 5 chunks of 1000 variants each by 78,195 samples. Useful for testing scripts and workflows. Index files also present. | additional\_data/test\_data/gel\_mainProgramme\_aggV2\_.vcf.gz |
| Sample QC statistics. A tab-delimited version of the aggregate\_gvcf\_sample\_stats table in LabKey.Â | additional\_data/aggregate\_gvcf\_sample\_stats/aggregate\_gvcf\_sample\_stats\_v10\_78195.tsv |
| Chunk names. A seven column tab-delimited file of chunk names in aggV2 with full file paths to genotype and functional annotation VCFs. 0-indexed BED format.Â | additional\_data/chunk\_names/aggV2\_chunk\_names.bed |
| Chunk names. A seven column tab-delimited file of chunk names in aggV2 with full file paths to genotype and functional annotation VCFs.Â | additional\_data/chunk\_names/aggV2\_chunk\_names.tsv |
| aggV2 sample list. All sample IDs in aggV2.Â | additional\_data/sample\_list/aggV2\_sampleIds\_mpv10\_78195.tsv |
| XX female participant list | additional\_data/sample\_sex/xx\_females\_illumina\_ploidy\_samples\_40653.tsv |
| XY male participant list | additional\_data/sample\_sex/xy\_males\_illumina\_ploidy\_samples\_35822.tsv |
| High LD exclusion regions | additional\_data/PCs\_relatedness/ MichiganLD\_liftover\_exclude\_regions.txt |
| High confidence independent (MAF > 0.05) SNP binary files | additional\_data/HQ\_SNPs/GELautosomes\_LD\_pruned\_1kgp3Intersect\_maf0.05\_mpv10.\* |
| High confidence independent (MAF > 0.01) SNP binary files | additional\_data/HQ\_SNPs/MAF1/GELautosomes\_LD\_pruned\_1kgp3Intersect\_maf0.01\_mpv10.\* |
| PCs1-50 across all aggV2 participants | additional\_data/PCs\_relatedness/PCA/Â GEL\_aggV2\_MAF5\_mp10.eigenvec |
| Eigenvalues for unrelated aggV2 participants | additional\_data/PCs\_relatedness/PCA/GEL\_aggV2\_MAF5\_mp10.eigenval |
| Proportion of variance explained for PCs on unrelated aggv2 participants | additional\_data/PCs\_relatedness/PCA/GEL\_aggV2\_MAF5\_mp10.propvar |
| Pairwise kinship estimates for related individuals (threshold > 0.0442) | additional\_data/PCs\_relatedness/relatedness/GEL\_aggV2\_MAF5\_mp10\_0.0442.kin0 |
| Kinship matrix for all individuals in aggV2 (stored inÂ [triangle, binary format](https://www.cog-genomics.org/plink/2.0/distance)) | additional\_data/PCs\_relatedness/relatedness/GEL\_aggV2\_MAF5\_mp10.king.bin |
| List of related sample platekeys (threshold > 0.0442) | additional\_data/PCs\_relatedness/relatedness/GEL\_aggV2\_MAF5\_mp10.king.cutoff.related.id |
| List of unrelated sample platekeys (threshold < 0.0442) | additional\_data/PCs\_relatedness/relatedness/GEL\_aggV2\_MAF5\_mp10.king.cutoff.unrelated.id |
| All platekeys assessed for relatedness | additional\_data/PCs\_relatedness/relatedness/GEL\_aggV2\_MAF5\_mp10.king.id |
| Eigenvalues from PCA on 1KGP3 unrelated individuals using aggV2 HQ SNPs | additional\_data/ancestry/1KGP3\_PCs/1KGP3\_MAF5.eigenval |
| Eigenvectors from PCA on 1KGP3 unrelated individuals 1KGP3 using aggV2 HQ SNPs | additional\_data/ancestry/1KGP3\_PCs/1KGP3\_MAF5.eigenvec |
| PC loadings from PCA onÂ 1KGP3 unrelated individuals 1KGP3 using aggV2 HQ SNPs | additional\_data/ancestry/1KGP3\_PCs/1KGP3\_MAF5.pcl |
| Eigenvectors for projection of aggV2 samples into the unrelated individuals 1KGP3 PC loadings using aggV2 HQ SNPs | additional\_data/ancestry/1KGP3\_projection\_GEL/GEL\_aggV2\_proj\_on\_1KGP3\_MAF5\_mp10.eigenvec |
| Genetically inferred ancestry probabilities based on super-populations from the 1KGP3 | additional\_data/ancestry/MAF5\_superPop\_predicted\_ancestries.tsv |
| Genetically inferred ancestry probabilities based on sub-populations from the 1KGP3 | additional\_data/ancestry/MAF1/MAF1\_actg\_filtered\_subPop\_predicted\_ancestries.tsv |
| The VEP severity scale used in the bcftools +split-vep plugin.Â | additional\_data/VEP\_severity\_scale\_2020.txt |

October 24, 2024
