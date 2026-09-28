---
title: 'Accessing mental health data programmatically - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/medhist_mh_api/
scraped_at: 2026-05-04T06:33:00Z
---

# Accessing mental health data programmatically

[Give us feedback on this tutorial](https://www.smartsurvey.co.uk/s/LGPEWD/)

The advantage of querying medical history programmatically is that the underlying tables are exposed, allowing you to verify the data in bulk. This also allows you to do very complex queries. You can save and tweak scripts to re-use in new releases or for similar queries.

There are a [huge number of tables](../general_clinical/) that you can use to query mental health history. This tutorial will take you through some of the tables and give you some example scripts that you can use in python or R to access the data.

## Contents:

- [Import modules/libraries you need](#modules)
- [Helper function to access the LabKey API](#helper)
- [Accessing mental health `mhmd` and `mhldds` tables](#old_mh)
- [Accessing mental health `mhsds` tables](#mh)

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

## Accessing mental health `mhmd` and `mhldds` tables

There are three sets of tables that cover different time periods:

- **mhmd** (Mental Health Minimum Dataset) â 2011-2014
- **mhldds** (Mental Health Learning Disabilities Dataset) â 2014-2016
- **mhsds** (Mental Health Services Dataset) â 2016 onwards

[`mhmd` and `mhldds`](../general_clinical/) both follow similar schema, with `record`, `event` and `episode` tables, where a `record` is a superset of `episodes` which is a superset of `events`, linked by a `spell_id`. We'll start by querying the `mhmd` tables to find all details for our participant of interest.

In this and all following code we will refer to a string `mh_part`, which is the participant\_id of the participant of interest. Assume that you have already defined this string in your code.

RE LabKey API RRE LabKey API PythonCloudOS interactive session

```
mhmd_sql <- paste("SELECT r.participant_id, r.mhd_mhmds_spell_id,
    ep.mhd_epitype, ep.mhd_epistart_date, ep.mhd_epiend_date,
    ev.mhd_eventtype, ev.mhd_eventdate
    FROM mhmd_v4_record as r
    LEFT JOIN mhmd_v4_episode as ep
        ON r.mhd_mhmds_spell_id = ep.mhd_mhmds_spell_id
    LEFT JOIN mhmd_v4_event as ev
        ON r.mhd_mhmds_spell_id = ev.mhd_mhmds_spell_id
    WHERE r.participant_id = ", mh_part,
    sep = "")

mhmd_query <- query_to_df(mhmd_sql, version)
```

```
mhmd_sql = (f'''
    SELECT r.participant_id, r.mhd_mhmds_spell_id,
    ep.mhd_epitype, ep.mhd_epistart_date, ep.mhd_epiend_date,
    ev.mhd_eventtype, ev.mhd_eventdate
    FROM mhmd_v4_record as r
    LEFT JOIN mhmd_v4_episode as ep
        ON r.mhd_mhmds_spell_id = ep.mhd_mhmds_spell_id
    LEFT JOIN mhmd_v4_event as ev
        ON r.mhd_mhmds_spell_id = ev.mhd_mhmds_spell_id
    WHERE r.participant_id = {mh_part}
    ''')
mhmd_query = query_to_df(mhmd_sql, version)
```

```
mhmd_sql <- paste("SELECT r.participant_id, r.mhd_mhmds_spell_id,
    ep.mhd_epitype, ep.mhd_epistart_date, ep.mhd_epiend_date,
    ev.mhd_eventtype, ev.mhd_eventdate
    FROM mhmd_v4_record as r
    LEFT JOIN mhmd_v4_episode as ep
        ON r.mhd_mhmds_spell_id = ep.mhd_mhmds_spell_id
    LEFT JOIN mhmd_v4_event as ev
        ON r.mhd_mhmds_spell_id = ev.mhd_mhmds_spell_id
    WHERE r.participant_id = ", mh_part,
    sep = "")

mhmd_query <- query_to_df(mhmd_sql, version)
```

We can use a very similar query with `mhldds`, as most of the columns are the same. You may find you need to change the column selections for certain data types.

RE LabKey API RRE LabKey API PythonCloudOS interactive session

```
mhldds_sql <- paste("SELECT r.participant_id, r.mhd_mhmds_spell_id,
    ep.mhd_epitype, ep.mhd_epistart_date, ep.mhd_epiend_date,
    ev.mhd_eventtype, ev.mhd_eventdate
    FROM mhldds_record as r
    LEFT JOIN mhldds_episode as ep
        ON r.mhd_mhmds_spell_id = ep.mhd_mhmds_spell_id
    LEFT JOIN mhldds_event as ev
        ON r.mhd_mhmds_spell_id = ev.mhd_mhmds_spell_id
    WHERE r.participant_id = ", mh_part,
    sep = "")

mhldds_query <- query_to_df(mhldds_sql, version)
```

```
mhldds_sql = (f'''
    SELECT r.participant_id, r.mhd_mhmds_spell_id,
    ep.mhd_epitype, ep.mhd_epistart_date, ep.mhd_epiend_date,
    ev.mhd_eventtype, ev.mhd_eventdate
    FROM mhldds_record as r
    LEFT JOIN mhldds_episode as ep
        ON r.mhd_mhmds_spell_id = ep.mhd_mhmds_spell_id
    LEFT JOIN mhldds_event as ev
        ON r.mhd_mhmds_spell_id = ev.mhd_mhmds_spell_id
    WHERE r.participant_id = {mh_part}
    ''')
mhldds_query = query_to_df(mhldds_sql, version)
```

```
mhldds_sql <- paste("SELECT r.participant_id, r.mhd_mhmds_spell_id,
    ep.mhd_epitype, ep.mhd_epistart_date, ep.mhd_epiend_date,
    ev.mhd_eventtype, ev.mhd_eventdate
    FROM mhldds_record as r
    LEFT JOIN mhldds_episode as ep
        ON r.mhd_mhmds_spell_id = ep.mhd_mhmds_spell_id
    LEFT JOIN mhldds_event as ev
        ON r.mhd_mhmds_spell_id = ev.mhd_mhmds_spell_id
    WHERE r.participant_id = ", mh_part,
    sep = "")

mhldds_query <- query_to_df(mhldds_sql, version)
```

## Accessing mental health `mhsds` tables

To query the [more recent `mhsds` records](../general_clinical/) we have to use a completely different method. We will query the curated tables, which are tied together by the `recordnumber`.

RE LabKey API RRE LabKey API PythonCloudOS interactive session

```
mhsds_sql <- paste("SELECT p.participant_id, p.recordnumber,
    p.startdategmpregistration, p.enddategmpregistration,
    i.startdatewardstay, i.enddatewardstay, i.treatfunccodemh,
    c.refertotreatperiodstartdate, c.refertotreatperiodenddate,
    a.startdatecareclust, a.enddatecareclust
    FROM mhsds_curated_participant as p
    FULL OUTER JOIN mhsds_curated_inpatient as i
        ON p.recordnumber = i.recordnumber
    FULL OUTER JOIN mhsds_curated_community as c
        ON p.recordnumber = c.recordnumber
    FULL OUTER JOIN  mhsds_curated_assessment_diagnoses_and_cluster as a
        ON p.recordnumber = a.recordnumber
    WHERE p.participant_id = ", mh_part,
    sep = "")

mhsds_query <- query_to_df(mhsds_sql, version)
```

```
mhsds_sql = (f'''
    SELECT p.participant_id, p.recordnumber,
    p.startdategmpregistration, p.enddategmpregistration,
    i.startdatewardstay, i.enddatewardstay, i.treatfunccodemh,
    c.refertotreatperiodstartdate, c.refertotreatperiodenddate,
    a.startdatecareclust, a.enddatecareclust
    FROM mhsds_curated_participant as p
    FULL OUTER JOIN mhsds_curated_inpatient as i
        ON p.recordnumber = i.recordnumber
    FULL OUTER JOIN mhsds_curated_community as c
        ON p.recordnumber = c.recordnumber
    FULL OUTER JOIN  mhsds_curated_assessment_diagnoses_and_cluster as a
        ON p.recordnumber = a.recordnumber
    WHERE p.participant_id = {mh_part}
    ''')

mhsds_query = query_to_df(mhsds_sql, version)
```

```
mhsds_sql <- paste("SELECT p.participant_id, p.recordnumber,
    p.startdategmpregistration, p.enddategmpregistration,
    i.startdatewardstay, i.enddatewardstay, i.treatfunccodemh,
    c.refertotreatperiodstartdate, c.refertotreatperiodenddate,
    a.startdatecareclust, a.enddatecareclust
    FROM mhsds_curated_participant as p
    FULL OUTER JOIN mhsds_curated_inpatient as i
        ON p.recordnumber = i.recordnumber
    FULL OUTER JOIN mhsds_curated_community as c
        ON p.recordnumber = c.recordnumber
    FULL OUTER JOIN  mhsds_curated_assessment_diagnoses_and_cluster as a
        ON p.recordnumber = a.recordnumber
    WHERE p.participant_id = ", mh_part,
    sep = "")

mhsds_query <- query_to_df(mhsds_sql, version)
```

February 3, 2026
