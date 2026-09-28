---
title: 'Working with NHS GMS data within LabKey - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/labkey_gms/
scraped_at: 2026-05-04T06:32:55Z
---

# Working with NHS GMS data within LabKey

As of the 15th of June 2022, Genomics England has started the process of releasing consented genomic data from the NHS Genomic Medicine Service (NHS GMS) within the Research Environment. The clinical and other relevant information relating to these participants will be contained within LabKey tables in much the same way that the main programme data is stored. For a summary of the data structure, we recommend that you consult the appropriate page and release notes on the current NHS GMS release.

## Differences to 100kGP

Participant IDs within the NHS GMS data use a different format than found within the 100kGP.

Not all the same tables are included in the GMS release as in 100kGP, and many tables and field have been renamed. Please refer to the latest [GMS data dictionary](../current_gms/) for details of the tables and fields.

It is not possible to cross-query the 100K Genomes and NHS GMS data in a single step. If the query you are working with will return data in both datasets you would need to recover these in two separate queries prior to combining the data within R or Python dataframes.

In the 100kGP releases the distinction between the Cancer and Rare Disease cohorts was included in the Participants table. This information can now be found in the referral table using the Clinical Indication Code column. Codes containing 'R' will refer to Rare Disease referrals and 'M' to Cancer referrals.

## LabKey APIs

The LabKey interface will allow you to browse and filter the information located in a particular table. While this enables you to gain an insight into the information stored in that table, the major power of the LabKey database for cohort building lies in the ability to cross-query the tables. We would recommend the [use of the APIs](../labkey_api/) for this purpose. We support two APIs within the Research Environment, one for Python and one for R.

## Examples

The APIs mentioned above will accept queries in a number of formats, however, we would recommend using the execute SQL functions to submit SQL queries of the data in the release. Using SQL will allow you to as more complex questions that will touch data across multiple tables, and will allow the returned data to be processed in a more effective manner.

RE LabKey API RRE LabKey API Python

The R version needed to access the API can be loaded in the Research Environment with the command `module load R/4.3.3`.

The Python version needed to access the API can be loaded in the Research Environment with the command `module load python/3.11`.

## Import modules/libraries you need

LabKey has an underlying SQL database. To access it you will need to have the labkey module/library loaded. You will also be working with tables and dataframes. Here you can see the modules/libraries you should load in your scripts:

RE LabKey API RRE LabKey API Python

```
library(tidyverse)
library(Rlabkey)
library(readr)
```

```
import numpy as np
import functools
import labkey
import pandas as pd
```

## Helper function to access the LabKey API

We have here a helper function called `labkey_to_df` that you can use to access the LabKey API in the RE and return data as a dataframe. You need to give it:

- `sql_query`: an SQL query to access the LabKey tables
- `database`: the version of the database you want to access for example `/main-programme/main-programme_v19_2024-10-31`

Feel free to include this function in all your scripts and invoke it every time you want to query the data.

> **baseURL change:**
>
> We have updated the baseURL for accessing LabKey. If you are already using the LabKey API, you will find that this code is not compatible with your existing `.netrc` file. Please [update this file](../labkey_api_configuration/) to the new version. The new version contains the configuration for both the new baseURL and the old one, so you will not need to retroactively update old scripts.

RE LabKey API RRE LabKey API Python

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

To run my queries, I'll need to set up my database version:

RE LabKey API RRE LabKey API Python

```
version <- "nhs-gms/nhs-gms-release_v5_2025-08-28"
```

```
version = "nhs-gms/nhs-gms-release_v5_2025-08-28"
```

### Querying the LabKey data

In the following example, we will extract the genomic features for Tier 1 and 2 variants uncovered within participants that present an "intellectual disability" phenotype.

RE LabKey API RRE LabKey API Python

```
sql_query <- "SELECT
    DISTINCT td.participant_id,
    td.genomic_feature_hgnc,
    td.genotype,
    td.segregation_pattern,
    td.penetrance,
    td.phenotype AS tiered_phenotype,
    pa.phenotype AS panel_phenotype,
    pa.panel_name,
    td.ensembl_id,
    td.tier,
    td.chromosome,
    td.position,
    td.reference,
    td.alternate,
    CONCAT_WS(
      '_',
      td.chromosome,
      td.position,
      td.reference,
      td.alternate
      ) AS tiered_chr_pos_ref_alt,
    e.score,
    e.hgvs
  FROM
    tiering_data td
  JOIN
    panels_applied pa ON
      pa.participant_id = td.participant_id AND
      pa.phenotype = td.phenotype
  JOIN
    exomiser e ON e.participant_id = td.participant_id
  WHERE
    td.tier in ('TIER1', 'TIER2') AND
    LOWER(pa.phenotype) = LOWER('intellectual disability') AND
    (
      td.chromosome = e.chromosome AND
      td.position = e.position AND
      td.reference = e.reference AND
      td.alternate = e.alternate
      );"
```

```
sql_query = "SELECT
    DISTINCT td.participant_id,
    td.genomic_feature_hgnc,
    td.genotype,
    td.segregation_pattern,
    td.penetrance,
    td.phenotype AS tiered_phenotype,
    pa.phenotype AS panel_phenotype,
    pa.panel_name,
    td.ensembl_id,
    td.tier,
    td.chromosome,
    td.position,
    td.reference,
    td.alternate,
    CONCAT_WS(
      '_',
      td.chromosome,
      td.position,
      td.reference,
      td.alternate
      ) AS tiered_chr_pos_ref_alt,
    e.score,
    e.hgvs
  FROM
    tiering_data td
  JOIN
    panels_applied pa ON
      pa.participant_id = td.participant_id AND
      pa.phenotype = td.phenotype
  JOIN
    exomiser e ON e.participant_id = td.participant_id
  WHERE
    td.tier in ('TIER1', 'TIER2') AND
    LOWER(pa.phenotype) = LOWER('intellectual disability') AND
    (
      td.chromosome = e.chromosome AND
      td.position = e.position AND
      td.reference = e.reference AND
      td.alternate = e.alternate
      );"
```

The query above provides examples of:

- the SELECT, FROM, WHERE principles of the SQL language
- joining tables in single and multiple columns
- conditions within lists
- case-folding
- compound conditioning
- output collation

The basics of the SQL syntax can be reviewed from the [W3Schools](https://www.w3schools.com/sql/).

For more in-depth reference material and LabKey Specific commands, we would recommend consulting the [LabKey SQL guide](https://www.labkey.org/Documentation/wiki-page.view?name=labkeysql).

The information in this example can be drawn from three LabKey tables (`tiering_data`, `panels_applied` and `exomiser`) within a single query. As part of this query, we hope to obtain information on the number of participants affected, the genes that have been scored as being in Tier 1 or 2 within this cohort, and the indications of the genomic changes reported by the exomiser analysis.

You can then run the SQL query with to helper function to return a dataframe:

RE LabKey API RRE LabKey API Python

```
query <- query_to_df(sql_query, version)
```

```
query = query_to_df(sql_query, version)
```

February 3, 2026
