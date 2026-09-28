---
title: 'Finding participants with prioritised variants programmatically - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/api_genotypes/
scraped_at: 2026-05-04T06:31:18Z
---

# Finding participants with prioritised variants programmatically

[Give us feedback on this tutorial](https://www.smartsurvey.co.uk/s/2DY25E/)

Not all genetic variants can be found using LabKey. The only variants you can see in LabKey are those that have been prioritised as likely causal for the disorder studied. For rare disease, variants are prioritised using [tiering](../tiering/) and [Exomiser](../exomiser/), whereas cancer variants are prioritised using [cancer tiering](../cancer_tiering/), in the tables `tiering_data`, `exomiser` and `cancer_tier_and_domain_variants` respectively for 100k and NHS GMS.

## Contents:

- [Import modules/libraries you need](#modules)
- [Helper function to access the LabKey API](#helper)
- [Querying the tiering\_data table](#tiering)
- [Querying the exomiser table](#exomiser)
- [Querying the cancer\_tier\_and\_domain\_variants table](#cancer_tiering)

## Setting up access

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

Before you get started with using the LabKey APIs, you need to ensure you have it set up correctly, [following this document](../labkey_api/). We recommend running your LabKey API scripts on the HPC, [as detailed here](../hpc/), as they can be quite large.

Before you get started with using the LabKey APIs, you need to ensure you have it set up correctly, [following this document](../labkey_api/). We recommend running your LabKey API scripts on the HPC, [as detailed here](../hpc/), as they can be quite large.

To query our tables using CloudOS, you will need to set up an [interactive session](https://lifebit.atlassian.net/wiki/spaces/CD/pages/813105209/Interactive+sessions). You will need to use conda to install the required R packages:

```
conda create -n r-tables r-glue r-tidyverse r-data.table r-dbi r-rpostgres r-irkernel -y
conda activate r-tables
```

You can now launch an R notebook under the `r-tables` kernel. [More details](https://lifebit.atlassian.net/wiki/spaces/CD/pages/813106134/Query+the+database+to+build+a+cohort)

To query our tables using CloudOS, you will need to set up an [interactive session](https://lifebit.atlassian.net/wiki/spaces/CD/pages/813105209/Interactive+sessions). You will need to use conda to install the required python packages:

```
conda create -n python-tables psycopg2 ipykernel sqlalchemy pandas numpy -y
conda activate python-tables
```

You can now launch a Jupyter notebook under the `python-tables` kernel.

## Import modules/libraries you need

LabKey has an underlying SQL database. To access it you will need to have the labkey module/library loaded. You will also be working with tables and dataframes. Here you can see the modules/libraries you should load in your scripts:

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
library(tidyverse)
library(Rlabkey)
library(readr)
```

If you are using the Rlabkey package version 3 or above, you should also add the following line:

```
labkey.setWafEncoding(FALSE)
```

```
import numpy as np
import functools
import labkey
import pandas as pd
from packaging.version import InvalidVersion
from importlib.metadata import version
from pandas import DataFrame
from typing import List
import traceback
```

```
library(tidyverse)
library(data.table)
library(glue)
library(RPostgres)
library(readr)
```

```
import numpy as np
import functools
import psycopg2
from sqlalchemy import create_engine, event, text
```

## Helper function to access the LabKey API

We have here a helper function called `query_to_df` that you can use to access the LabKey API in the RE and return data as a dataframe. You need to give it:

- `sql_query`: an SQL query to access the LabKey tables
- `database`: the version of the database you want to access for example `/main-programme/main-programme_v19_2024-10-31`
- `maxrows`: maximum number of rows you want to return. This parameter defaults to 100000000, but if the output contains exactly the default value, then we suggest increasing this value.

Feel free to include this function in all your scripts and invoke it every time you want to query the data.

> **baseURL change:**
>
> We have updated the baseURL for accessing LabKey. If you are already using the LabKey API, you will find that this code is not compatible with your existing `.netrc` file. Please [update this file](../labkey_api_configuration/) to the new version. The new version contains the configuration for both the new baseURL and the old one, so you will not need to retroactively update old scripts.

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
labkey.setWafEncoding(FALSE)
query_to_df <- function(sql_query, database){

    labkey.setDefaults(baseUrl = "https://labkey.prod.aws.gel.ac/labkey/")

    labkey.executeSql(folderPath = database,
                      schemaName = "lists",
                      colNameOpt = "rname",
                      sql = sql_query) %>%
        mutate(across(everything(), as.character))
}
```

```
# Helper functions to check labkey version and compare it to required versions for different 
# API calls

def get_labkey_version() -> str | None:
    """
    Helper functiont to recover the version of the labkey package in your enviroment
    Args:None
    Returns: str: Version number as string 
    """
    try:
        ver = importlib.metadata.version("labkey")
        return ver
    except InvalidVersion:
        print("Invalid version format for labkey.")
        return None

def is_at_least_version(required_version: str) -> bool | None:
    """
    Helper function to check if labkey version is at least a specified version
    Args: required_cersion (str): the minimum version that is needed to select query functionality
    Returns: Bool: does the labkey package meet the requirement
    """
    current_version = get_labkey_version()
    if current_version is None:
        return False
    try:
        return current_version >= required_version
    except InvalidVersion:
        print("Invalid version format for comparison.")
        return False

def is_one_of_versions(allowed_versions: List[str]) -> bool:
    """
    Helper function to check if the labkey package one of a list of specifically supported versions
    Args:allowed_versions (List)
    """
    current_version = get_labkey_version()
    if current_version is None:
        return False
    return current_version in allowed_versions

# Main function to execute labkey sql query and return results as a pandas dataframe
def query_to_df(sql_query, database) -> DataFrame | str | Exception:
    """generate an pandas dataframe from labkey sql query
    Args:
        sql_query (str): SQL query to execute
        database (str): LabKey project name
    Returns:
        pd.DataFrame: DataFrame containing the results of the SQL query
        msg (str): An error message that will let you know if your version of the package is supported
        Exception: A generic error generated if there is an issue with your enviroment or implementation
    """
    try:
        if is_one_of_versions(['1.2.0', '1.4.0', '1.4.1']):
            server_context = labkey.utils.create_server_context(
                server="labkey.prod.aws.gel.ac",
                project=database,
                use_ssl=True
            )
            results = labkey.api.query.execute_sql(
                server_context,
                sql=sql_query,
                schema_name="lists",
                max_rows=100000000
                )

            return DataFrame(results['rows'])

        elif is_at_least_version('2.4.0'):
            from labkey.api_wrapper import APIWrapper
            context_path = "labkey"
            api = APIWrapper(
                domain="labkey.prod.aws.gel.ac",
                container_path=database,
                context_path=context_path,
                use_ssl=True
            )
            results = api.query.execute_sql(
                sql=sql_query,
                schema_name="lists",
                max_rows= 100000000,
                waf_encode_sql=False
            )

            return DataFrame(results['rows'])

        else:
            msg = f"labkey version {get_labkey_version()} not supported, please update to version 1.2.0 or higher"

            return msg

    except Exception as e :
        print(f"Exception occurred:: {e}")
        traceback.print_exc()
        raise
```

```
query_to_df <- function(sql_query, database){
  DBNAME = "gel_clinical_cb_sql_pro"
  HOST = "clinical-cb-sql-pro.cfe5cdx3wlef.eu-west-2.rds.amazonaws.com"
  PORT = 5432
  PASSWORD = 'anXReTz36Q5r'
  USER = 'jupyter_notebook'

  connection <- DBI::dbConnect(
      RPostgres::Postgres(),
      dbname = DBNAME,
      host = HOST,
      port = PORT,
      password = PASSWORD,
      user = USER,
      options = paste("-c search_path=", database, sep="")
      )

  dbGetQuery(connection, sql_query)
  }
```

```
def query_to_df(sql_query, version):
    database = "gel_clinical_cb_sql_pro"
    host = "clinical-cb-sql-pro.cfe5cdx3wlef.eu-west-2.rds.amazonaws.com"
    port = 5432
    password = 'anXReTz36Q5r'
    user = 'jupyter_notebook'
    engine = create_engine(f'''postgresql://{user}:{password}@{host}:{port}/{database}''')

    @event.listens_for(engine, "connect", insert=True)
    def set_search_path(dbapi_connection, connection_record):
        existing_autocommit = dbapi_connection.autocommit
        dbapi_connection.autocommit = True
        cursor = dbapi_connection.cursor()
        cursor.execute(f"SET SESSION search_path={version}")
        cursor.close()
        dbapi_connection.autocommit = existing_autocommit

    with engine.connect() as connection:
        result = connection.execute(text(sql_query))
        return(pd.DataFrame(result))
```

To run my queries, I'll need to set up my database version:

100kGP or main programmeNHS GMS

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
version <- "/main-programme/main-programme_v19_2024-10-31"
```

```
version = "/main-programme/main-programme_v19_2024-10-31"
```

```
version <- "source_data_100kv16_covidv4"
```

```
version = "source_data_100kv16_covidv4"
```

RE LabKey API RRE LabKey API Python

```
version <- "nhs-gms/nhs-gms-release_v5_2025-08-28"
```

```
version = "nhs-gms/nhs-gms-release_v5_2025-08-28"
```

## Querying the tiering\_data table

We can query the rare disease `tiering_data` table by a genomic locus or by a gene. The following query finds all participants with prioritised variants in a gene of interest, getting the variant loci and reference and alternative alleles. Since this is a gene-based query, it will find all rows where the gene name is listed, which will include participant genomes aligned to GRCh37 and GRCh38.

100kGP or main programmeNHS GMS

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
gene <- "NIPBL"
tiering_sql <- paste("SELECT participant_id, phenotype, assembly, chromosome, position, reference, alternate, genotype ",
"FROM tiering_data ",
"WHERE genomic_feature_hgnc='", gene, "'", sep="")

tiering_query <- labkey_to_df(tiering_sql, version, 10000)
```

```
gene = "NIPBL"

gene_tiering_sql = (f'''
    SELECT participant_id, phenotype, assembly, chromosome, position, reference, alternate, genotype
    FROM tiering_data
    WHERE genomic_feature_hgnc = '{gene}'
    ''')
gene_tiering_query = labkey_to_df(gene_tiering_sql, version, 10000)
```

```
gene <- "NIPBL"
tiering_sql <- paste("SELECT participant_id, phenotype, assembly, chromosome, position, reference, alternate, genotype ",
"FROM tiering_data ",
"WHERE genomic_feature_hgnc='", gene, "'", sep="")

tiering_query <- labkey_to_df(tiering_sql, version, 10000)
```

```
gene = "NIPBL"

gene_tiering_sql = (f'''
    SELECT participant_id, phenotype, assembly, chromosome, position, reference, alternate, genotype
    FROM tiering_data
    WHERE genomic_feature_hgnc = '{gene}'
    ''')
gene_tiering_query = query_to_df(gene_tiering_sql, version)
```

We can also query for a genomic locus. In this case we must include the genome assembly as an argument. For completeness, you may wish to also query for the remapped coordinate on GRCh37.

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
chromosome <- "5"
coordinate <- "37064560"
assembly <- "GRCh38"

locus_tiering_sql <- paste("SELECT participant_id, phenotype, genomic_feature_hgnc, genotype ",
    "FROM tiering_data ",
    "WHERE chromosome = '", chromosome,
    "' AND position = '", coordinate,
    "' AND assembly = '", assembly, "'", sep="")

locus_tiering_query <- labkey_to_df(locus_tiering_sql, version, 10000)
```

```
chromosome = "5"
coordinate = "37064560"
assembly = "GRCh38"

locus_tiering_sql = (f'''
    SELECT participant_id, phenotype, genomic_feature_hgnc, genotype
    FROM tiering_data
    WHERE chromosome = '{chromosome}'
    AND position = '{coordinate}'
    AND assembly = '{assembly}'
    ''')

locus_tiering_query = labkey_to_df(locus_tiering_sql, version, 10000)
```

```
chromosome <- "5"
coordinate <- "37064560"
assembly <- "GRCh38"

locus_tiering_sql <- paste("SELECT participant_id, phenotype, genomic_feature_hgnc, genotype ",
    "FROM tiering_data ",
    "WHERE chromosome = '", chromosome,
    "' AND position = '", coordinate,
    "' AND assembly = '", assembly, "'", sep="")

locus_tiering_query <- labkey_to_df(locus_tiering_sql, version, 10000)
```

```
chromosome = "5"
coordinate = "37064560"
assembly = "GRCh38"

locus_tiering_sql = (f'''
    SELECT participant_id, phenotype, genomic_feature_hgnc, genotype
    FROM tiering_data
    WHERE chromosome = '{chromosome}'
    AND position = '{coordinate}'
    AND assembly = '{assembly}'
    ''')

locus_tiering_query = query_to_df(locus_tiering_sql, version)
```

RE LabKey API RRE LabKey API Python

```
gene <- "NIPBL"
tiering_sql <- paste("SELECT participant_id, phenotype, chromosome, position, reference, alternate, genotype ",
"FROM tiering_data ",
"WHERE genomic_feature_hgnc='", gene, "'", sep="")

tiering_query <- labkey_to_df(tiering_sql, version, 10000)
```

```
gene = "NIPBL"

gene_tiering_sql = (f'''
    SELECT participant_id, phenotype, chromosome, position, reference, alternate, genotype
    FROM tiering_data
    WHERE genomic_feature_hgnc = '{gene}'
    ''')
gene_tiering_query = labkey_to_df(gene_tiering_sql, version, 10000)
```

We can also query for a genomic locus. All genomes in NHS GMS are aligned to GRCh38 so we do not need to specify the assembly.

RE LabKey API RRE LabKey API Python

```
chromosome <- "5"
coordinate <- "37064560"

locus_tiering_sql <- paste("SELECT participant_id, phenotype, genomic_feature_hgnc, genotype ",
    "FROM tiering_data ",
    "WHERE chromosome = '", chromosome,
    "' AND position = '", coordinate, "'", sep="")

locus_tiering_query <- labkey_to_df(locus_tiering_sql, version, 10000)
```

```
chromosome = "5"
coordinate = "37064560"

locus_tiering_sql = (f'''
    SELECT participant_id, phenotype, genomic_feature_hgnc, genotype
    FROM tiering_data
    WHERE chromosome = '{chromosome}'
    AND position = '{coordinate}'
    ''')

locus_tiering_query = labkey_to_df(locus_tiering_sql, version, 10000)
```

## Querying the exomiser table

The exomiser table allows you to search for participants by locus or gene, just like the tiering table. However, it also contains HGVS notation for variants in the form:

`gene_name:ENST0000000####:c.99A>T:p.(Gly33Glu)`

100kGP or main programmeNHS GMS

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
gene_name <- "MUM1L1"
aa_change <- "Leu7Gln"

exomiser_hgvs_sql <- paste( "SELECT participant_id, phenotype, assembly, chromosome, position, hgvs, reference, alternate, genotype ",
    "FROM exomiser ",
    " WHERE hgvs like '%", gene_name,
    "%' AND hgvs like '%", aa_change, "%'",
    sep="")

exomiser_hgvs_query <- labkey_to_df(exomiser_hgvs_sql, version, 10000)
```

```
gene_name = "MUM1L1"
aa_change = "Leu7Gln"

exomiser_hgvs_sql = (f'''
    SELECT participant_id, phenotype, assembly, chromosome, position, hgvs, reference, alternate, genotype
    FROM exomiser
    WHERE hgvs like '%{gene_name}%'
    AND hgvs like '%{aa_change}%'
    ''')
exomiser_hgvs_query = labkey_to_df(exomiser_hgvs_sql, version, 10000)
```

```
gene_name <- "MUM1L1"
aa_change <- "Leu7Gln"

exomiser_hgvs_sql <- paste( "SELECT participant_id, phenotype, assembly, chromosome, position, hgvs, reference, alternate, genotype ",
    "FROM exomiser ",
    " WHERE hgvs like '%", gene_name,
    "%' AND hgvs like '%", aa_change, "%'",
    sep="")

exomiser_hgvs_query <- labkey_to_df(exomiser_hgvs_sql, version, 10000)
```

```
gene_name = "MUM1L1"
aa_change = "Leu7Gln"

exomiser_hgvs_sql = (f'''
    SELECT participant_id, phenotype, assembly, chromosome, position, hgvs, reference, alternate, genotype
    FROM exomiser
    WHERE hgvs like '%{gene_name}%'
    AND hgvs like '%{aa_change}%'
    ''')

exomiser_hgvs_query = query_to_df(exomiser_hgvs_sql, version)
```

RE LabKey API RRE LabKey API Python

```
gene_name <- "MUM1L1"
aa_change <- "Leu7Gln"

exomiser_hgvs_sql <- paste( "SELECT participant_id, phenotype, chromosome, position, hgvs, reference, alternate, genotype ",
    "FROM exomiser ",
    " WHERE hgvs like '%", gene_name,
    "%' AND hgvs like '%", aa_change, "%'",
    sep="")

exomiser_hgvs_query <- labkey_to_df(exomiser_hgvs_sql, version, 10000)
```

```
gene_name = "MUM1L1"
aa_change = "Leu7Gln"

exomiser_hgvs_sql = (f'''
    SELECT participant_id, phenotype, chromosome, position, hgvs, reference, alternate, genotype
    FROM exomiser
    WHERE hgvs like '%{gene_name}%'
    AND hgvs like '%{aa_change}%'
    ''')

exomiser_hgvs_query = labkey_to_df(exomiser_hgvs_sql, version, 10000)
```

## Querying the cancer\_tier\_and\_domain\_variants table

Now we'll query the cancer\_tier\_and\_domain\_variants. This has a similar structure to the rare disease tiering table, so we can query it for a gene and/or region in the same way.

100kGP or main programmeNHS GMS

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
cancer_gene <- "TP53"

cancer_gene_tiering_sql = paste( "SELECT participant_id, disease_type, chr, pos, ref, alt
    FROM cancer_tier_and_domain_variants
    WHERE gene = '", cancer_gene, "'
    ", sep = "")
cancer_gene_tiering_query <- labkey_to_df(cancer_gene_tiering_sql, version, 10000)
```

```
cancer_gene = "TP53"

cancer_gene_tiering_sql = (f'''
    SELECT participant_id, disease_type, chr, pos, ref, alt
    FROM cancer_tier_and_domain_variants
    WHERE gene = '{cancer_gene}'
    ''')
cancer_gene_tiering_query = labkey_to_df(cancer_gene_tiering_sql, version, 10000)
```

```
cancer_gene <- "TP53"

cancer_gene_tiering_sql = paste( "SELECT participant_id, disease_type, chr, pos, ref, alt
    FROM cancer_tier_and_domain_variants
    WHERE gene = '", cancer_gene, "'
    ", sep = "")
cancer_gene_tiering_query <- labkey_to_df(cancer_gene_tiering_sql, version, 10000)
```

```
cancer_gene = "TP53"

cancer_gene_tiering_sql = (f'''
    SELECT participant_id, disease_type, chr, pos, ref, alt
    FROM cancer_tier_and_domain_variants
    WHERE gene = '{cancer_gene}'
    ''')
cancer_gene_tiering_query = query_to_df(cancer_gene_tiering_sql, version)
```

Since all cancer genomes are aligned to GRCh38, querying by a locus does not require the assembly argument.

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
cancer_chromosome <- "17"
cancer_coordinate <- "7675166"

cancer_locus_tiering_sql <- paste("SELECT participant_id, disease_type, gene
    FROM cancer_tier_and_domain_variants
    WHERE chr = '", cancer_chromosome, "'
    AND pos = '", cancer_coordinate, "'
    ", sep = "")

cancer_locus_tiering_query <- labkey_to_df(cancer_locus_tiering_sql, version, 10000)
```

```
cancer_chromosome = "17"
cancer_coordinate = "7675166"

cancer_locus_tiering_sql = (f'''
    SELECT participant_id, disease_type, gene
    FROM cancer_tier_and_domain_variants
    WHERE chr = '{cancer_chromosome}'
    AND pos = '{cancer_coordinate}'
    ''')

cancer_locus_tiering_query = labkey_to_df(cancer_locus_tiering_sql, version, 10000)
```

```
cancer_chromosome <- "17"
cancer_coordinate <- "7675166"

cancer_locus_tiering_sql <- paste("SELECT participant_id, disease_type, gene
    FROM cancer_tier_and_domain_variants
    WHERE chr = '", cancer_chromosome, "'
    AND pos = '", cancer_coordinate, "'
    ", sep = "")

cancer_locus_tiering_query <- labkey_to_df(cancer_locus_tiering_sql, version, 10000)
```

```
cancer_chromosome = "17"
cancer_coordinate = "7675166"

cancer_locus_tiering_sql = (f'''
    SELECT participant_id, disease_type, gene
    FROM cancer_tier_and_domain_variants
    WHERE chr = '{cancer_chromosome}'
    AND pos = '{cancer_coordinate}'
    ''')

cancer_locus_tiering_query = query_to_df(cancer_locus_tiering_sql, version)
```

RE LabKey API RRE LabKey API Python

```
cancer_gene <- "TP53"

cancer_gene_tiering_sql = paste( "SELECT participant_id, disease_type, chr, pos, ref, alt
    FROM cancer_tier_and_domain_variants
    WHERE gene = '", cancer_gene, "'
    ", sep = "")
cancer_gene_tiering_query <- labkey_to_df(cancer_gene_tiering_sql, version, 10000)
```

```
cancer_gene = "TP53"

cancer_gene_tiering_sql = (f'''
    SELECT participant_id, disease_type, chr, pos, ref, alt
    SELECT participant_id, disease_type, chr, pos, ref, alt
    FROM cancer_tier_and_domain_variants
    WHERE gene = '{cancer_gene}'
    ''')
cancer_gene_tiering_query = labkey_to_df(cancer_gene_tiering_sql, version, 10000)
```

We can also query a locus

RE LabKey API RRE LabKey API Python

```
cancer_chromosome <- "17"
cancer_coordinate <- "7675166"

cancer_locus_tiering_sql <- paste("SELECT participant_id, disease_type, gene
    FROM cancer_tier_and_domain_variants
    WHERE chr = '", cancer_chromosome, "'
    AND pos = '", cancer_coordinate, "'
    ", sep = "")

cancer_locus_tiering_query <- labkey_to_df(cancer_locus_tiering_sql, version, 10000)
```

```
cancer_chromosome = "17"
cancer_coordinate = "7675166"

cancer_locus_tiering_sql = (f'''
    SELECT participant_id, disease_type, gene
    FROM cancer_tier_and_domain_variants
    WHERE chr = '{cancer_chromosome}'
    AND pos = '{cancer_coordinate}'
    ''')

cancer_locus_tiering_query = labkey_to_df(cancer_locus_tiering_sql, version, 10000)
```

August 28, 2025
