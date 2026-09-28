---
title: 'Extract variants by coordinate - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/var_by_coord/
scraped_at: 2026-05-04T06:34:11Z
---

# Extract variants by coordinate

This script extracts small variants (SNV and indels < 50bp) from VCF files of a cohort by chromosomal coordinates.

## Description

VCF (variant call format) files organise genomic variants in an easy to parse format. Given the region of interest, the script uses bcftools to extract small variants for a cohort of interest. You can use a rare disease cohort and fetch germline small variants from rare disease participants, or a cancer cohort and fetch somatic small variants from cancer participants.

Simply input the coordinates of your variant of interest, and the list of VCF files you are interested in. Note that a list of all VCF files is available for each programme.

## Instructions

### Location

The script is located within the Research Environment in this folder location:

(cancer variants) `/gel_data_resources/example_scripts/extract_variants_by_coordinate/somatic_ca`

or

(rare disease variants) `/gel_data_resources/example_scripts/extract_variants_by_coordinate/germline_rd`

Copy recursively the folder and its contents to your working directory using copy and paste or in the terminal with:

`cp -R /gel_data_resources/example_scripts/extract_variants_by_coordinate/somatic_ca /filepath/to/your/folder/`

and edit the files regions.txt and vcf\_list.txt as needed.

### Inputs and outputs

| Phenotype | File | Description |
| --- | --- | --- |
| Input | regions.txt | Tab-delimited list of chromosomal coordinates. Please be aware to correctly set the chromosome nomenclature for each genome build. GRCh37 uses 1,2,3,4, vs. GRCh38 using chr1, chr2, chr3, chr4, etc. |
| Input | vcf\_list.txt | The list with full-paths to VCF file of interest |
| Output | results.txt | A tab-delimted file of sample ID, variant information and quality |

Choose between `somatic_ca` for cancer variants, or `germline_rd` for rare disease variants and edit `regions.txt` to contain the coordinates of the gene/variant/location you are interested in, alternatively, you may want to edit the path on the script to regions.txt on the script. Also, change the `vcf_list.txt` to contain full-paths to the VCF of interest (if you use the `vcf_list.txt` as provided, you will query all the participants for the programme of interest).

Once connected to the HPC, submit the script as a job using:

`bsub -q queue_name -P project_code -cwd your_working_directory -e your_stderr_file -o your_stdout_file bash extract_variants_by_coordinate.sh`

## Scripts

Double helix - newHelix - old

extract\_variants\_by\_coordinate.sh for germline\_rd

```
#############################################################################################################################  
######################## Extract variants in a cohort by chromosomal coordinates ###########################################  
# This script subsets VCFs by coordinate and prints out sample ID and genotype  

# INPUT:  
        # 1: Tab-delimited list of chromosomal coordinates (regions.txt)  
        # 2\. A list of full-paths to VCF files of interest (vcf_list.txt)  

# OUTPUT:  
        # 1: A tab-delimted file of sample ID, variant information and quality (results.txt)  

# STEPS:  
        # 1: tabix to subset each VCF by the coordinates given  
        # 2: bcftools to split multiallelic variants across multiple lines  
        # 3: bcftools to filter for PASS variants and variants with a coverage >10 and genotype quality >15  
        # 4: bcftools to print out the sample ID, and variant and quality information as a text file  

# IMPORTANT!  

        # 1: Make sure the chromosome nomenculature is correct for GRCh37 and GRCh38  
        # 2: Do not mix genome builds in VCF file list  
        # 3: Change the file paths to suit your working environment  
        # 4: This script will only extract SNVs, if you need indels please comment out the '-i 'MIN(FMT/DP)>10 & MIN(FMT/GQ)>15' flag  
        # 5: This script will only function with Illumina germline variant calls - please use the relevant script to process somatic variants  

#!/bin/bash  

module load bcftools/1.16  

while read -r vcf; do  
        tabix -h $vcf -R regions.txt | \  
        bcftools norm -m -any | \  
        bcftools view -f PASS -i 'MIN(FMT/DP)>10 & MIN(FMT/GQ)>15' | \  
        bcftools query -f '[%SAMPLE]\t%CHROM\t%POS\t%ID\t%REF\t%ALT\t%QUAL\t%FILTER\t[%GT]\t[%GQ]\t[%DP]\n' >> results.txt;  
done < vcf_list.txt  

sed -i '1s/^/SAMPLE\tCHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tGT\tGQ\tDP\n/' results.txt  
###########################################################################################################################
```

extract\_variants\_by\_coordinate.sh for somatic\_ca

```
######################## Extract variants in a cohort by chromosomal cooordinates ###########################################  
# This script subsets VCFs by coordinate and prints out sample ID and genotype  

# INPUT:  
        # 1: Tab-delimited list of chromosomal coordinates (regions.txt)  
        # 2. A list of full-paths to VCF files of interest (vcf_list_somatic_ca.txt)  

# OUTPUT:  
        # 1: A tab-delimted file of sample ID, variant information and quality (results.txt)  

# STEPS:  
        # 1: tabix to subset each VCF by the coordinates given  
        # 2: bcftools to split multiallelic variants across multiple lines  
        # 3: bcftools to filter for PASS variants and variants with a coverage >10 and genotype quality >15  
        # 4: bcftools to print out the sample ID, and variant and quality information as a text file  

# IMPORTANT!  
        # 1: Make sure the chromosome nomenculature is correct for GRCh37 and GRCh38  
        # 2: Do not mix genome builds in VCF file list  
        # 3: Change the file paths to suit your working environment  
        # 4: This script will only extract SNVs, if you need indels please comment out the '-i 'MIN(FMT/DP)>10 & MIN(FMT/GQ)>15' flag  
        # 5: This script will only function with Illumina somatic variant calls - please use the relevant script to process germline variants  

#!/bin/bash  

module load bcftools/1.16  

while read -r vcf; do  
        tabix -h $vcf -R regions.txt | \  
        bcftools view -f PASS -i 'MIN(FMT/DP)>10' | \  
        bcftools query -f '[%SAMPLE]\t%CHROM\t%POS\t%ID\t%REF\t%ALT\t%QUAL\t%FILTER\t[%GT]\t[%DP]\n' >> results.txt;  
done < vcf_list_somatic_ca.txt  

sed -i '1s/^/SAMPLE\tCHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tGT\tDP\tINFO\n/' results.txt  
###########################################################################################################################
```

extract\_variants\_by\_coordinate.sh for germline\_rd

```
#############################################################################################################################  
######################## Extract variants in a cohort by chromosomal coordinates ###########################################  
# This script subsets VCFs by coordinate and prints out sample ID and genotype  

# INPUT:  
        # 1: Tab-delimited list of chromosomal coordinates (regions.txt)  
        # 2\. A list of full-paths to VCF files of interest (vcf_list.txt)  

# OUTPUT:  
        # 1: A tab-delimted file of sample ID, variant information and quality (results.txt)  

# STEPS:  
        # 1: tabix to subset each VCF by the coordinates given  
        # 2: bcftools to split multiallelic variants across multiple lines  
        # 3: bcftools to filter for PASS variants and variants with a coverage >10 and genotype quality >15  
        # 4: bcftools to print out the sample ID, and variant and quality information as a text file  

# IMPORTANT!  

        # 1: Make sure the chromosome nomenculature is correct for GRCh37 and GRCh38  
        # 2: Do not mix genome builds in VCF file list  
        # 3: Change the file paths to suit your working environment  
        # 4: This script will only extract SNVs, if you need indels please comment out the '-i 'MIN(FMT/DP)>10 & MIN(FMT/GQ)>15' flag  
        # 5: This script will only function with Illumina germline variant calls - please use the relevant script to process somatic variants  

#!/bin/bash  

module load bio/BCFtools/1.11-GCC-8.3.0  

while read -r vcf; do  
        tabix -h $vcf -R regions.txt | \  
        bcftools norm -m -any | \  
        bcftools view -f PASS -i 'MIN(FMT/DP)>10 & MIN(FMT/GQ)>15' | \  
        bcftools query -f '[%SAMPLE]\t%CHROM\t%POS\t%ID\t%REF\t%ALT\t%QUAL\t%FILTER\t[%GT]\t[%GQ]\t[%DP]\n' >> results.txt;  
done < vcf_list.txt  

sed -i '1s/^/SAMPLE\tCHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tGT\tGQ\tDP\n/' results.txt  
###########################################################################################################################
```

extract\_variants\_by\_coordinate.sh for somatic\_ca

```
######################## Extract variants in a cohort by chromosomal cooordinates ###########################################  
# This script subsets VCFs by coordinate and prints out sample ID and genotype  

# INPUT:  
        # 1: Tab-delimited list of chromosomal coordinates (regions.txt)  
        # 2. A list of full-paths to VCF files of interest (vcf_list_somatic_ca.txt)  

# OUTPUT:  
        # 1: A tab-delimted file of sample ID, variant information and quality (results.txt)  

# STEPS:  
        # 1: tabix to subset each VCF by the coordinates given  
        # 2: bcftools to split multiallelic variants across multiple lines  
        # 3: bcftools to filter for PASS variants and variants with a coverage >10 and genotype quality >15  
        # 4: bcftools to print out the sample ID, and variant and quality information as a text file  

# IMPORTANT!  
        # 1: Make sure the chromosome nomenculature is correct for GRCh37 and GRCh38  
        # 2: Do not mix genome builds in VCF file list  
        # 3: Change the file paths to suit your working environment  
        # 4: This script will only extract SNVs, if you need indels please comment out the '-i 'MIN(FMT/DP)>10 & MIN(FMT/GQ)>15' flag  
        # 5: This script will only function with Illumina somatic variant calls - please use the relevant script to process germline variants  

#!/bin/bash  

module load bio/BCFtools/1.11-GCC-8.3.0  

while read -r vcf; do  
        tabix -h $vcf -R regions.txt | \  
        bcftools view -f PASS -i 'MIN(FMT/DP)>10' | \  
        bcftools query -f '[%SAMPLE]\t%CHROM\t%POS\t%ID\t%REF\t%ALT\t%QUAL\t%FILTER\t[%GT]\t[%DP]\n' >> results.txt;  
done < vcf_list_somatic_ca.txt  

sed -i '1s/^/SAMPLE\tCHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tGT\tDP\tINFO\n/' results.txt  
###########################################################################################################################
```

January 19, 2026
