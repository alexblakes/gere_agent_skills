---
title: 'Labkey API - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/labkey_api/
scraped_at: 2026-05-04T06:32:53Z
---

# Labkey API

The LabKey API allows you to query the LabKey tables programmatically using SQL queries in a variety of programming languages.

To do very simple queries on the [clinical/phenotype data](../clinical_data/) you can use the [LabKey application](../labkey/) on the Research Environment desktop. However, in order to do more complex analyses across multiple tables, or query very large tables, it is recommended that you use the provided LabKey APIs.

The LabKey client libraries (APIs) provide secure, auditable, programmatic access to LabKey data and services and allow you to:

- Analyse and visualise data stored in LabKey in a statistical tool such as R or Python
- Perform routine, automated tasks in a programmatic way.
- Query and manipulate data in a repeatable and consistent way.

Currently, LabKey supports working with the following programming languages/environments.

- **Rlabkey Package**
- **Python API**
- JavaScript API
- Java API
- Perl API
- SAS Macros

We highly recommend using either the **Python LabKey API** or the **R LabKey API** to query the Genomics England clinical/phenotype data.

## Configuring access to the LabKey APIs

To get access, you will need to set up permissions with your username and password.

[Configure access](../labkey_api_configuration/)

## Writing LabKey API scripts

Here you will find a guide to writing LabKey API scripts in Python and R. Use the toggles to switch between the languages. You can find further information on using the API in [Python](https://github.com/LabKey/labkey-api-python) and [R](https://www.labkey.org/Documentation/wiki-page.view?name=rAPI) in the main LabKey documentation.

### Loading the required version of R or Python

The LabKey API only works with certain versions of R and Python. You will need to load the correct versions to run your scripts, and for Python this differs between the desktop and the HPC, which uses conda environments.

R - desktop or HPCPython desktopPython HPC

```
module load R/4.3.3
```

```
module load python/3.11
```

```
source /resources/conda/miniconda3/bin/activate && conda activate py3pypirev2
```

You can use interactive coding environments to work with the API, please check our further documentation on:

- [Jupyter notebooks on the desktop](../jupyter/)
- [Jupyter notebooks on the HPC](../hpc_jupyter/)
- [Rstudio on the desktop](../r/)
- [Rstudio on the HPC](../enable_rstudio/)

### Loading LabKey libraries/modules

You will need to load LabKey in your scripts, notebooks and interactive coding sessions. There are also a few other modules we recommend you load alongside these to help you manipulate the data.

RE LabKey API RRE LabKey API Python

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

### Helper function for using the API for SQL queries

The LabKey API works by enabling SQL queries of the LabKey tables. The following code is a helper function, `query_to_df` that connects to the server, executes an SQL query and returns the results as a dataframe. Feel free to include this function in all your scripts and invoke it every time you want to query the data.

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

You need to give this function:

- `sql_query`: an SQL query to access the LabKey tables
- `database`: the version of the database you want to access for example `/main-programme/main-programme_v19_2024-10-31`
  Here is an example of how you can use this function:

RE LabKey API RRE LabKey API Python

```
sql <- "SELECT
    p.participant_id,
    p.programme,
    sr.lab_sample_id,
    sr.delivery_date,
  FROM
    participant p
  JOIN
    sequencing_report sr ON p.participant_id = sr.participant_id
  WHERE
    YEAR(sr.delivery_date) BETWEEN 2019 AND 2021;"

database <- "/main-programme/main-programme_v19_2024-10-31"

query <- labkey_to_df(sql, database)
```

```
sql = f"""
  SELECT
    p.participant_id,
    p.programme,
    sr.lab_sample_id,
    sr.delivery_date,
  FROM
    participant p
  JOIN
    sequencing_report sr ON p.participant_id = sr.participant_id
  WHERE
    YEAR(sr.delivery_date) BETWEEN 2019 AND 2021;"""

database = "/main-programme/main-programme_v19_2024-10-31"

query = labkey_to_df(sql, database)
```

### Fetching a whole table

You can also fetch a whole table using the API, without using the helper function. Here is some example code to fetch the `sequencing_report`.

RE LabKey API RRE LabKey API Python

```
# Set the baseURL
labkey.setDefaults(baseUrl="https://labkey.prod.aws.gel.ac/labkey/")

sequencing_report <- labkey.selectRows(                             

    schemaName="lists",           # Do not change this
    colNameOpt="rname",           # Do not change this
    maxRows = 100000000,            # Do not change this
    folderPath="/main-programme/main-programme_v19_2024-10-31",    # This can be changed to different main programme releases    
    queryName="sequencing_report" # This can be changed to different table names

)
```

```
# Specify what we are connecting to, and what schema and tables we want  
labkey_server = "labkey.prod.aws.gel.ac" # The labkey server we are connecting to. This will not change  
project_name = "/main-programme/main-programme_v19_2024-10-31" # The data we want to access. This will change depending on your study  
context_path = "labkey" # This does not change  
schema_name = "lists" # The schema we are getting data from. This does not change  
query_name = "sequencing_report" # The table we want to get data from. This does change  

# Create an object that will let us connect to the LabKey databases. This does not change.  
server_context = labkey.utils.create_server_context(  
labkey_server, project_name, context_path, use_ssl=True  
)  

# The data are returned and stored in the variable results.  
results = labkey.query.select_rows(server_context, schema_name, query_name, max_rows=200000)  

# Data are returned as a dictionary, will all of the table information stored under the key "rows".  
# We make a dataframe of all of the table information using pandas.  
table_of_data = pd.DataFrame(results["rows"])
```

### Fetching part of a single table

The following code outlines how to filter a table by columns and/or rows in order to return a subset of a table, selecting specific columns (**colSelect**) and filtering for specified row values (**colFilter**). This does not allow you to combine this with another table, so in most cases using an SQL query is preferable.

RE LabKey API RRE LabKey API Python

```
labkey.setDefaults(baseUrl="https://labkey.prod.aws.gel.ac/labkey/")

participant <- labkey.selectRows(

    # Default selection
    schemaName="lists",       # Do not change this
    colNameOpt="rname",       # Do not change this
    maxRows = 100000000,        # Do not change this
    folderPath="/main-programme/main-programme_v19_2024-10-31",    # This can be changed to different main programme releases
    queryName="participant",  # This can be changed to different table names

    # Additional parameters
    colFilter=makeFilter(     # Make various filters to subset rows
      c("participant_type", "EQUAL", "Proband"),
      c("year_of_birth", "BETWEEN", "1990,2010")),
    colSelect=c("participant_id", "rare_diseases_family_id", "year_of_birth"),     # Choose to only select these columns
    colSort=("+year_of_birth") # Sort by these columns
```

```
# Specify what we are connecting to, and what schema and tables we want  
labkey_server = "labkey.prod.aws.gel.ac" # The labkey server we are connecting to. This will not change  
project_name = "/main-programme/main-programme_v19_2024-10-31" # The data we want to access. This will change depending on your study  
context_path = "labkey" # This does not change  
schema_name = "lists" # The schema we are getting data from. This does not change  

query_name = "participant" # The table we want to get data from. This does change  

columns = "participant_id, rare_diseases_family_id, year_of_birth"  

filter1 = labkey.query.QueryFilter("participant_type", "Proband")  
filter2 = labkey.query.QueryFilter("year_of_birth", "1990,2010", labkey.query.QueryFilter.Types.BETWEEN) # Return only reports with year of birth included in a range.

combined_filter = [filter1, filter2] # Combine the previous two filters.  

# Create an object that will let us connect to the LabKey databases. This does not change.  
server_context = labkey.utils.create_server_context(  
labkey_server, project_name, context_path, use_ssl=True  
)  

# Fetch and store only the columns that we want.  
selected_columns = labkey.query.select_rows(  
server_context, schema_name, query_name,  
columns = columns  
)  

# Filters can be used to fetch only the rows that we are interested in.  
selected_rows1 = labkey.query.select_rows(  
server_context, schema_name, query_name,  
filter_array = [filter1]  
)  
selected_rows2 = labkey.query.select_rows(#  
server_context, schema_name, query_name,  
filter_array = [filter2]  
)  

# Filters can also be combined to with each other and with column selection to do more powerful selection of data from a table.  
selected_data = labkey.query.select_rows(  
server_context, schema_name, query_name,  
filter_array = combined_filter,  
columns = columns  
)  

# Data can then be stored in a dataframe as normal.  
table_of_data = pd.DataFrame(selected_data["rows"])
```

### Video tutorials

RE LabKey API RRE LabKey API Python

## Filter for participants with active consent

You must filter participants in your analysis to ensure they all have active consent for research. To do this, use the `programme_consent_status` column of the `participant` table in the 100kGP. Here is example SQL using a participant\_id list called `list`.

RE LabKey API RRE LabKey API Python

```
consent_sql <- paste("SELECT
    participant_id, programme_consent_status
    FROM participant
    WHERE programme_consent_status = 'Consenting'
    AND participant_id IN (", list, ")",
    sep="")
```

```
consent_sql = (f'''
    SELECT participant_id, programme_consent_status
    FROM participant
    WHERE programme_consent_status = 'Consenting'
    AND participant_id IN {list}
''')
```

## Known errors

### SQL Syntax Error

If you encounter the following error while using the `Rlabkey` package:

```
Error in handleError(response, haltOnError) :
 HTTP request was unsuccessful. Status code = 500, Error message = Error on line 1: Syntax error near "<hashed query>"
```

You will be using a newer version of the `Rlabkey` package and need to include the `labkey.setWafEncoding(FALSE)` at the top of your script. You should edit this to conform to the following format:

```
labkey_to_df <- function(sql_query, database, maxrows){

    labkey.setWafEncoding(FALSE)
    labkey.setDefaults(baseUrl = "https://labkey-embassy.gel.zonelabkey/")

    labkey.executeSql(folderPath = database,
                      schemaName = "lists",
                      colNameOpt = "rname",
                      sql = sql_query,
                      maxRows = maxrows) %>%
        mutate(across(everything(), as.character))
}
```

February 25, 2026
