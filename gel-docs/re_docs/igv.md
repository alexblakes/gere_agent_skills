---
title: 'Integrative Genome Viewer (IGV) - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/igv/
scraped_at: 2026-05-04T06:32:39Z
---

# Integrative Genome Viewer (IGV)

The [Integrative Genomics Viewer (IGV)](https://software.broadinstitute.org/software/igv/) is a high-performance, easy-to-use, interactive tool for the visual exploration of genomic data created by the Broad Institute. Due to its wide use in genomics, we have made verion 2.18.2 of this tool available within the Research Environment.

## Reference genome files

Reference genomes and gene annotation for **GRCh38/hg38** and **GRCh37/hg19** have been recovered and made available to IGV from within the RE filesystem as the IGV site has not been whitelisted. On first launch the genomes will not be immediately visible and you will need to select them by following `Genomes` -> `Load Genome from File ...` -> `public_data_resources` -> `IGV`. Once the genomes have been loaded you can easily access these by selecting the assembly at the top left on subsequent launches of the IGV software.

The files are identical to those automatically recovered by IGV outside of the RE and can be used in the same way. However, this will result in an error message when you load IGV - you can just dismiss this.

## Load your data

You can load genomic data from Genomics England to view in IGV. You can select `File` -> `Load from file` to click through to the file location. However, it is usually easier to select `File` -> `Load from URL` and paste in the file location, such as those you can find in the `genome_file_paths_and_types` table in LabKey.

[View full IGV documentation from the Broad](https://igv.org/doc/desktop/)

## FAQs

> **Problem loadingIGVin the research environment:**
>
> I have problems accessing IGV in the Research Environment. I get the message that the genome file cannot be read/loaded. How can the access be restored?
>
> The Broad Institute have changed where they host the genome files for IGV (from igvdata.broadinstitute.org/\* to https://s3.amazonaws.com/igvdata.broadinstitute.org/\*). As the latter is not 'white-listed' within the Research Environment, the genome files will not be accessible, causing an error to occur when attempting to load them within IGV.
>
> We have manually downloaded the FASTA, RefSeq annotation, chromosome cytoband, and chromosome aliases from the Broad for hg19/GRCh37 and hg38/GRCh38 reference assemblies and have created .genome files from them. These are identical to the default ones present in IGV and can be loaded manually. For a step-by-step guide on how to load these please follow the instructions here: Live Service Issues

March 26, 2026
