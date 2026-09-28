---
title: 'Accessing medical history data programmatically - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/medhist_api/
scraped_at: 2026-05-04T06:32:59Z
---

# Accessing medical history data programmatically

[Give us feedback on this tutorial](https://www.smartsurvey.co.uk/s/OZMXSU/)

There are a huge number of tables that you can use to query medical history. This tutorial will take you through some of the tables and give you some example scripts that you can use in python or R to access the data, or using R in an interactive session on CloudOS, to access the data.

The advantage of querying medical history programmatically is that the underlying tables are exposed, allowing you to verify the data in bulk. This also allows you to do very complex queries. You can save and tweak scripts to re-use in new releases or for similar queries.

## Tables to query

To access medical history, you might query the following tables:

| Table | Full name | Details | Programme availability |
| --- | --- | --- | --- |
| `hes_apc` | Hospital episode statistics - Admitted patient care | Details of any overnight stays in hospital | 100kGP and NHS GMS |
| `hes_op` | Hospital episode statistics - Outpatients | Details of any planned day appointments in hospital | 100kGP and NHS GMS |
| `hes_ae` | Hospital episode statistics - Accident and emergency | Details of unplanned walk-in/ambulance visits to hospital | 100kGP and NHS GMS |
| `hes_cc` | Hospital episode statistics - Critical care | Details of any time spent on life support | 100kGP and NHS GMS |
| `ecds` | Emergency care dataset | Details of unplanned walk-in/ambulance visits to hospital | 100kGP and NHS GMS |
| `did` | Diagnostic imaging metadata | Details of any medical imaging | 100kGP only |

The tables for medical history are extensive and were designed for medical record keeping, not for scientific research. They may have a lot of fields not relevant to research, or that are confusing. We recommend referring to the latest data dictionaries for [100kGP](../100k_data_dictionary/) and [NHS GMS](../GMS_data_dictionary/) for full details of these tables.

For your convenience, [concatenations](../general_clinical/) of some of the diagnosis and treatment columns, can make them easier to query. All the example code makes use of these concatenated columns, rather than the source data.

Diagnosis and treatment columns

| Table | Concatenated Column Name | Source Columns | Description | Codes used |
| --- | --- | --- | --- | --- |
| `ecds` | `diagnosis_code_all` | `diagnosis_code_01` - `diagnosis_code_12` | Diagnoses | SNOMED CT |
| `ecds` | `diagnosis_qualifier_all` | `diagnosis_qualifier_01` - `diagnosis_qualifier_12` | Diagnosis qualifiers | SNOMNED CT |
| `ecds` | `investigation_code_all` | `investigation_code_01` - `investigation_code_12` | Investigations | SNOMED CT |
| `ecds` | `treatment_code_all` | `treatment_code_01` - `treatment_code_12` | Treatments | SNOMED CT |
| `hes_apc` | `diag_all` | `diag_01` - `diag_20` | Diagnoses | ICD-10 |
| `hes_apc` | `opertn_all` | `opertn_01` - `opertn_24` | Treatments | OPCS |
| `hes_ae` | `diag_all` | `diag_01` - `diag_12` | Diagnoses | ICD-10 |
| `hes_ae` | `diag2_all` | `diag2_01` - `diag2_12` | Diagnoses in two characters | Refer to the [100kGP](../100k_data_dictionary/) and [NHS GMS](../GMS_data_dictionary/) data dictionaries |
| `hes_ae` | `diaga_all` | `diaga_01` - `diaga_12` | Diagnosis anatomical area | Refer to the [100kGP](../100k_data_dictionary/) and [NHS GMS](../GMS_data_dictionary/) data dictionaries |
| `hes_ae` | `diags_all` | `diags_01` - `diags_12` | Diagnosis anatomical site | Left, Right, Bilateral, not applicable |
| `hes_ae` | `invest_all` | `invest_01` - `invest_12` | Investigations | 6an |
| `hes_ae` | `invest2_all` | `invest2_01` - `invest2_12` | Investigations | Refer to the [100kGP](../100k_data_dictionary/) and [NHS GMS](../GMS_data_dictionary/) data dictionaries |
| `hes_ae` | `treat2_all` | `treat2_01` - `treat2_12` | Treatment two-letter codes | Refer to the [100kGP](../100k_data_dictionary/) and [NHS GMS](../GMS_data_dictionary/) data dictionaries |
| `hes_ae` | `treat_all` | `treat_01` - `treat_12` | Treatments | 6an |
| `hes_op` | `diag_all` | `diag_01` - `diag_12` | Diagnoses | ICD-10 |
| `hes_op` | `opertn_all` | `opertn_01` - `opertn_24` | Treatments | OPCS |

Links between tables

Some of the tables have fields which link them together, allowing you to see how medical events relate to each other. However many of the tables can only be linked through participant IDs and corresponding dates.

| Tables | Column(s) linking them | Details |
| --- | --- | --- |
| `hes_apc` and `hes_ae` | `aekey` and `epikey` | Where an accident and emergency visit results in the participant being admitted to an overnight stay |
| `hes_apc` and `hes_cc` | `susrecid` | Where a participant spends some time on life-support during an overnight stay |

Dates in tables

Many of the tables have multiple date fields, signifying different events. We have highlighted that fields we think are the most useful.

| Table | Field | Meaning | Most useful date in the table? |
| --- | --- | --- | --- |
| `did` | `did_date1` | The date of referral |  |
| `did` | `did_date2` | The date the referral was received |  |
| `did` | `did_date3` | The date of imaging | yes |
| `did` | `did_date4` | The date of the report |  |
| `hes_ae` | `appdate` | Record updates |  |
| `hes_ae` | `arrivaldate` | the date of arrival | yes |
| `hes_ae` | `cdsextdate` | Record updates |  |
| `hes_ae` | `subdate` | Record updates |  |
| `hes_ae` | `suslddate` | Record updates |  |
| `hes_apc` | `apcend_1` - `apcend_9` | End date of periods of augmented care |  |
| `hes_apc` | `apcstar_1` - `apcstar_9` | Start date of periods of augmented care |  |
| `hes_apc` | `admidate` | Date of admission | yes |
| `hes_apc` | `anasdate` | Date of first antenatal assessment |  |
| `hes_apc` | `cdsextdate` | Record updates |  |
| `hes_apc` | `disdate` | Date of discharge | yes |
| `hes_apc` | `disreadydate` | Date the participant was medically ready for discharge |  |
| `hes_apc` | `elecdate` | Date of decision to admit |  |
| `hes_apc` | `epiend` | Date of end of care under a particular consultant |  |
| `hes_apc` | `epistart` | Date of start of care under a particular consultant |  |
| `hes_apc` | `opdate_01` - `opdate_24` | Date of corresponding numbered treatment in columns `oper_01` - `oper_24` |  |
| `hes_apc` | `rtt_per_end` | End date of a referral treatment period |  |
| `hes_apc` | `rtt_per_start` | Start date of a referral treatment period |  |
| `hes_apc` | `subdate` | Record updates |  |
| `hes_apc` | `suslddate` | Record updates |  |
| `hes_cc` | `ccdisdate` | Date of discharge | yes |
| `hes_cc` | `ccstartdate` | Date of start | yes |
| `hes_op` | `apptdate` | Date of appointment | yes |
| `hes_op` | `dnadate` | Date of missed appointment |  |
| `hes_op` | `reqdate` | Date referral received |  |
| `hes_op` | `rtt_per_end` | End date of a referral treatment period |  |
| `hes_op` | `rtt_per_start` | Start date of a referral treatment period |  |
| `hes_op` | `subdate` | Record updates |  |
| `hes_op` | `suslddate` | Record updates |  |
| `ecds` | `arrival_date` | Date of arrival | yes |
| `ecds` | `assessment_date` | Date of assessment | yes |
| `ecds` | `conclusion_date` | Date of conclusion of treatment in accident and emergency |  |
| `ecds` | `departure_date` | Date of leaving accident and emergency | yes |
| `ecds` | `injury_date` | Date of injury | yes |
| `ecds` | `investigation_date_01` - `investigation_date_12` | Date of corresponding numbered investigation in columns `investigation_code_01` - `investigation_code_12` |  |
| `ecds` | `period_end_date` | End date of referral to treatment |  |
| `ecds` | `period_start_date` | Start date of referral to treatment |  |
| `ecds` | `referral_assessment_date_1` - `referral_assessment_date_4` | Date of corresponding numbered referral in columns `referred_to_service_1` - `referred_to_service_4` |  |
| `ecds` | `service_request_date_1` - `service_request_date_4` | Date of corresponding numbered referral in columns `referred_to_service_1` - `referred_to_service_4` |  |
| `ecds` | `treatment_date_01` - `treatment_date_10` | Date of corresponding numbered treatment in columns `treatment_code_01` - `treatment_code_10` |  |

## Contents:

- [Import modules/libraries you need](#modules)
- [Helper function to access the LabKey API](#helper)
- [`tidyup` function for making diagnosis and treatment columns for readable](#tidyup)
- [Get details from a single `hes_*` table or `ecds` for a participant](#hes)
- [Plot events in medical history over time](#time)
- [Match accident and emergency episodes to overnight admissions](#ae_apc)
- [Find critical care periods within an overnight stay](#apc_cc)
- [Pull out time periods from medical history tables](#times)
- [Find events and episodes within a time period](#events)

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

## `tidyup` function for making diagnosis and treatment columns more readable

Many of the queries presented in this tutorial will pull up columns of [concatenated data](../general_clinical/), such as `diag_all` and `opertn_all`. These are presented in the form:

`code1|code2|code3||||||||`

In this example above, `code1` etc represent an ICD10 or opcs code. Each vertical pipe `|` represents one of the columns that were concatenated together; where these columns were empty, there are no spaces between the pipes.

The following function uses a regex to tidy up these to comma separated values, deleting any empty fields. It takes a dataframe as input and returns the tidied-up dataframe. You can use this any time you want to view the output of these analyses.

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
tidyup <- function(df){
  df[] <- lapply(df, gsub, pattern='\\|{2,}', replacement='')
  df[] <- lapply(df, gsub, pattern='\\|', replacement=', ')
  data.frame(df)
}
```

```
def tidyup(dataframe):
    dataframe.replace('\|\|+', '', regex=True, inplace = True)
    dataframe.replace('\|', ', ', regex=True, inplace = True)
```

```
tidyup <- function(df){
  df[] <- lapply(df, gsub, pattern='\\|{2,}', replacement='')
  df[] <- lapply(df, gsub, pattern='\\|', replacement=', ')
  data.frame(df)
}
```

```
def tidyup(dataframe):
    dataframe.replace('\|\|+', '', regex=True, inplace = True)
    dataframe.replace('\|', ', ', regex=True, inplace = True)
```

## Get details from a single `hes_*` table or `ecds` for a participant

We're going to find all diagnoses for an individual from a [`hes_*` table](../general_clinical/). In this case we're going to query `hes_ae`. If you want to query `hes_apc` or `hes_op`, you would need to change the date field to one(s) [available in those tables](../current_release/); you might also want to add further diagnosis and treatment columns.

In this and all following code we will refer to a string `part_id`, which is the participant\_id of the participant of interest. Assume that you have already defined this string in your code.

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
hes_sql <- paste("SELECT participant_id, arrivaldate, diag_all  
    FROM hes_ae
    WHERE participant_id = '", part_id, "'",  sep="")

hes_query <- query_to_df(hes_sql, version)
```

```
hes_sql = (f'''
    SELECT participant_id, arrivaldate, diag_all
    FROM hes_ae
    WHERE participant_id = '{part_id}'
    ''')

hes_query = query_to_df(hes_sql, version)
hes_query
```

```
hes_sql <- paste("SELECT participant_id, arrivaldate, diag_all  
    FROM hes_ae
    WHERE participant_id = '", part_id, "'",  sep="")

hes_query <- query_to_df(hes_sql, version)
```

```
hes_sql = (f'''
    SELECT participant_id, arrivaldate, diag_all
    FROM hes_ae
    WHERE participant_id = '{part_id}'
    ''')

hes_query = query_to_df(hes_sql, version)
hes_query
```

The table `ecds` covers emergency admissions after 2017. The `ecds` table has different column headings, so we have to alter our queries accordingly. The following query gets all the diagnoses, treatments and investigations for a participant, with the date of arrival.

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
ecds_sql <- paste("SELECT participant_id, seen_date, diagnosis_code_all, investigation_code_all, treatment_code_all ",
    "FROM ecds ",
    "WHERE participant_id = '", part_id, "'",  sep="")

ecds_query <- query_to_df(ecds_sql, version)
```

```
ecds_sql = (f'''
    SELECT participant_id, seen_date, diagnosis_code_all, investigation_code_all, treatment_code_all
    FROM ecds
    WHERE participant_id = '{part_id}'
    ''')

ecds_query = query_to_df(ecds_sql, version)
```

```
ecds_sql <- paste("SELECT participant_id, seen_date, diagnosis_code_all, investigation_code_all, treatment_code_all ",
    "FROM ecds ",
    "WHERE participant_id = '", part_id, "'",  sep="")

ecds_query <- query_to_df(ecds_sql, version)
```

```
ecds_sql = (f'''
    SELECT participant_id, seen_date, diagnosis_code_all, investigation_code_all, treatment_code_all
    FROM ecds
    WHERE participant_id = '{part_id}'
    ''')

ecds_query = query_to_df(ecds_sql, version)
```

## Plot events in medical history over time

The following code allows you to pull out all events from a participants medical history, and display them in a single plot.

### Find all diagnoses

First, we will pull out all diagnoses from the `hes_*` and `ecds` tables. Dates in all these tables are coded differently.

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
diag_table <- data.frame()

ae_sql <- paste(
    "SELECT participant_id, arrivaldate as date, diag_all
    FROM hes_ae
    WHERE participant_id = '", part_id, "'",  sep="")
ae_query <- query_to_df(ae_sql, version)
if (nrow(ae_query) > 0) {
  ae_query$table <- 'hes_ae - A&E diagnosis code'
  diag_table <- rbind(diag_table, ae_query)
}

apc_sql <- paste(
    "SELECT participant_id, admidate as date, diag_all
    FROM hes_apc
    WHERE participant_id = '", part_id, "'",  sep="")
apc_query <- query_to_df(apc_sql, version)
if (nrow(apc_query) > 0) {
  apc_query$table <- 'hes_apc - ICD10 code'
  diag_table <- rbind(diag_table, apc_query)
}

op_sql <- paste(
    "SELECT participant_id, apptdate as date, diag_all
    FROM hes_op
    WHERE participant_id = '", part_id, "'",  sep="")
op_query <- query_to_df(op_sql, version)
if (nrow(op_query) > 0) {
  op_query$table <- 'hes_op - ICD10 code'
  diag_table <- rbind(diag_table, op_query)
}

ecds_sql <- paste(
    "SELECT participant_id, seen_date as date, diagnosis_code_all as diag_all
    FROM ecds
    WHERE participant_id = '", part_id, "'",  sep="")
ecds_query <- query_to_df(ecds_sql, version)
```

```
ae_sql = (f'''
    SELECT participant_id, arrivaldate as date, diag_all
    FROM hes_ae
    WHERE participant_id = '{part_id}'
    ''')
ae_query = query_to_df(ae_sql, version)
ae_query['table'] = 'hes_ae - A&E diagnosis code'

apc_sql = (f'''
    SELECT participant_id, admidate as date, diag_all
    FROM hes_apc
    WHERE participant_id = '{part_id}'
    ''')
apc_query = query_to_df(apc_sql, version)
apc_query['table'] = 'hes_apc - ICD10 code'

op_sql = (f'''
    SELECT participant_id, apptdate as date, diag_all
    FROM hes_op
    WHERE participant_id = '{part_id}'
    ''')
op_query = query_to_df(op_sql, version)
op_query['table'] = 'hes_op - ICD10 code'

ecds_sql = (f'''
    SELECT participant_id, seen_date as date, diagnosis_code_all as diag_all
    FROM ecds
    WHERE participant_id = '{part_id}'
    ''')
ecds_query = query_to_df(ecds_sql, version)
ecds_query['table'] = 'ecds - SNOMED CT'

diag_table = pd.concat([ae_query, apc_query, op_query, ecds_query])
```

```
diag_table <- data.frame()

ae_sql <- paste(
    "SELECT participant_id, arrivaldate as date, diag_all
    FROM hes_ae
    WHERE participant_id = '", part_id, "'",  sep="")
ae_query <- query_to_df(ae_sql, version)
if (nrow(ae_query) > 0) {
  ae_query$table <- 'hes_ae - A&E diagnosis code'
  diag_table <- rbind(diag_table, ae_query)
}

apc_sql <- paste(
    "SELECT participant_id, admidate as date, diag_all
    FROM hes_apc
    WHERE participant_id = '", part_id, "'",  sep="")
apc_query <- query_to_df(apc_sql, version)
if (nrow(apc_query) > 0) {
  apc_query$table <- 'hes_apc - ICD10 code'
  diag_table <- rbind(diag_table, apc_query)
}

op_sql <- paste(
    "SELECT participant_id, apptdate as date, diag_all
    FROM hes_op
    WHERE participant_id = '", part_id, "'",  sep="")
op_query <- query_to_df(op_sql, version)
if (nrow(op_query) > 0) {
  op_query$table <- 'hes_op - ICD10 code'
  diag_table <- rbind(diag_table, op_query)
}

ecds_sql <- paste(
    "SELECT participant_id, seen_date as date, diagnosis_code_all as diag_all
    FROM ecds
    WHERE participant_id = '", part_id, "'",  sep="")
ecds_query <- query_to_df(ecds_sql, version)
```

```
ae_sql = (f'''
    SELECT participant_id, arrivaldate as date, diag_all
    FROM hes_ae
    WHERE participant_id = '{part_id}'
    ''')
ae_query = query_to_df(ae_sql, version)
ae_query['table'] = 'hes_ae - A&E diagnosis code'

apc_sql = (f'''
    SELECT participant_id, admidate as date, diag_all
    FROM hes_apc
    WHERE participant_id = '{part_id}'
    ''')
apc_query = query_to_df(apc_sql, version)
apc_query['table'] = 'hes_apc - ICD10 code'

op_sql = (f'''
    SELECT participant_id, apptdate as date, diag_all
    FROM hes_op
    WHERE participant_id = '{part_id}'
    ''')
op_query = query_to_df(op_sql, version)
op_query['table'] = 'hes_op - ICD10 code'

ecds_sql = (f'''
    SELECT participant_id, seen_date as date, diagnosis_code_all as diag_all
    FROM ecds
    WHERE participant_id = '{part_id}'
    ''')
ecds_query = query_to_df(ecds_sql, version)
ecds_query['table'] = 'ecds - SNOMED CT'

diag_table = pd.concat([ae_query, apc_query, op_query, ecds_query])
```

Instead of using our tidyup function, we want to split the table to have one diagnosis per row

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
diag_table <- separate_longer_delim(diag_table, diag_all, delim ="|")
diag_table$diag_all[diag_table$diag_all==""] <- NA
diag_table <- diag_table[complete.cases(diag_table), ]
diag_table$date <- as.Date(diag_table$date)
```

```
diag_table['diag_all'] = diag_table['diag_all'].str.split("|")
diag_table = diag_table.explode('diag_all')
diag_table = diag_table.replace(r'^\s*$', np.nan, regex=True)
diag_table = diag_table.dropna(subset=['diag_all'])
diag_table['date']= pd.to_datetime(diag_table['date'])
```

```
diag_table <- separate_longer_delim(diag_table, diag_all, delim ="|")
diag_table$diag_all[diag_table$diag_all==""] <- NA
diag_table <- diag_table[complete.cases(diag_table), ]
diag_table$date <- as.Date(diag_table$date)
```

```
diag_table['diag_all'] = diag_table['diag_all'].str.split("|")
diag_table = diag_table.explode('diag_all')
diag_table = diag_table.replace(r'^\s*$', np.nan, regex=True)
diag_table = diag_table.dropna(subset=['diag_all'])
diag_table['date']= pd.to_datetime(diag_table['date'])
```

Now we can plot all diagnoses over time.

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
library(ggplot2)
ggplot(data = diag_table, aes(x = date, y = diag_all, colour = table)) +
  geom_point() +
  labs(x = "Date of diagnosis",
    y = "Codes",
    title = "Diagnoses over time")
```

```
plt.plot_date(diag_table['date'], diag_table['diag_all'], xdate=True, ydate=False)
plt.xticks(rotation=70)
groups = diag_table.groupby('table')
for name, group in groups:
    plt.plot(group.date, group.diag_all, marker='o', linestyle='', markersize=3, label=name)
plt.legend()
plt.title('Diagnoses over time', fontweight="bold")
plt.xlabel('Date of diagnosis')
plt.ylabel('ICD10 or SNOMED CT codes')
plt.show()
```

```
library(ggplot2)
ggplot(data = diag_table, aes(x = date, y = diag_all, colour = table)) +
  geom_point() +
  labs(x = "Date of diagnosis",
    y = "Codes",
    title = "Diagnoses over time")
```

```
plt.plot_date(diag_table['date'], diag_table['diag_all'], xdate=True, ydate=False)
plt.xticks(rotation=70)
groups = diag_table.groupby('table')
for name, group in groups:
    plt.plot(group.date, group.diag_all, marker='o', linestyle='', markersize=3, label=name)
plt.legend()
plt.title('Diagnoses over time', fontweight="bold")
plt.xlabel('Date of diagnosis')
plt.ylabel('ICD10 or SNOMED CT codes')
plt.show()
```

### Find all investigations

To find all investigations, we will search the `hes_ae`, `did` (100kGP only) and `ecds` tables. There is a `try/except` around the code for the `did` table, this is because the `did` table does not exist for NHS GMS.

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
invest_table <- data.frame()

ae_invest_sql <- paste(
    "SELECT participant_id, arrivaldate as date,invest_all
    FROM hes_ae
    WHERE participant_id = '", part_id, "'",  sep="")
ae_invest_query <- query_to_df(ae_invest_sql, version)
if (nrow(ae_invest_query) > 0) {
  ae_invest_query$table <- 'hes_ae - A&E investigation code'
  invest_table <- rbind(invest_table, ae_invest_query)
}

try({did_invest_sql <- paste(
    "SELECT participant_id, did_date3 as date, did_snomedct_code invest_all 
    FROM did
    WHERE participant_id = '", part_id, "'", sep="")
did_invest_query <- query_to_df(did_invest_sql, version)
if (nrow(did_invest_query) > 0) {
did_invest_query$table <- 'did _SNOMED CT code'
invest_table <- rbind(invest_table, did_invest_query)
}
})

ecds_invest_sql <- paste(
    "SELECT participant_id, seen_date as date, investigation_code_all as invest_all
    FROM ecds
    WHERE participant_id = '", part_id, "'",  sep="")
ecds_invest_query <- query_to_df(ecds_invest_sql, version)
```

```
ae_invest_sql = (f'''
    SELECT participant_id, arrivaldate as date, invest_all
    FROM hes_ae
    WHERE participant_id = '{part_id}'
    ''')
ae_invest_query = query_to_df(ae_invest_sql, version)
ae_invest_query['table'] = 'hes_ae - A&E investigation code'

try:
    did_invest_sql = (f'''
        SELECT participant_id, did_date3 as date, did_snomedct_code invest_all 
        FROM did
        WHERE participant_id = '{part_id}'
        ''')
    did_invest_query = query_to_df(did_invest_sql, version)
    did_invest_query['table'] = 'did - SNOMED CT code'
except:
    pass

ecds_invest_sql = (f'''
    SELECT participant_id, seen_date as date, investigation_code_all as invest_all
    FROM ecds
    WHERE participant_id = '{part_id}'
    ''')
ecds_invest_query = query_to_df(ecds_invest_sql, version)
ecds_invest_query['table'] = 'ecds - SNOMED CT'

try:
    invest_table = pd.concat([ae_invest_query, did_invest_query, ecds_invest_query])
except:
    invest_table = pd.concat([ae_invest_query, ecds_invest_query])
invest_table
```

```
invest_table <- data.frame()

ae_invest_sql <- paste(
    "SELECT participant_id, arrivaldate as date,invest_all
    FROM hes_ae
    WHERE participant_id = '", part_id, "'",  sep="")
ae_invest_query <- query_to_df(ae_invest_sql, version)
if (nrow(ae_invest_query) > 0) {
  ae_invest_query$table <- 'hes_ae - A&E investigation code'
  invest_table <- rbind(invest_table, ae_invest_query)
}

try({did_invest_sql <- paste(
    "SELECT participant_id, did_date3 as date, did_snomedct_code invest_all 
    FROM did
    WHERE participant_id = '", part_id, "'", sep="")
did_invest_query <- query_to_df(did_invest_sql, version)
if (nrow(did_invest_query) > 0) {
did_invest_query$table <- 'did _SNOMED CT code'
invest_table <- rbind(invest_table, did_invest_query)
}
})

ecds_invest_sql <- paste(
    "SELECT participant_id, seen_date as date, investigation_code_all as invest_all
    FROM ecds
    WHERE participant_id = '", part_id, "'",  sep="")
ecds_invest_query <- query_to_df(ecds_invest_sql, version)
```

```
ae_invest_sql = (f'''
    SELECT participant_id, arrivaldate as date, invest_all
    FROM hes_ae
    WHERE participant_id = '{part_id}'
    ''')
ae_invest_query = query_to_df(ae_invest_sql, version)
ae_invest_query['table'] = 'hes_ae - A&E investigation code'

try:
    did_invest_sql = (f'''
        SELECT participant_id, did_date3 as date, did_snomedct_code invest_all 
        FROM did
        WHERE participant_id = '{part_id}'
        ''')
    did_invest_query = query_to_df(did_invest_sql, version)
    did_invest_query['table'] = 'did - SNOMED CT code'
except:
    pass

ecds_invest_sql = (f'''
    SELECT participant_id, seen_date as date, investigation_code_all as invest_all
    FROM ecds
    WHERE participant_id = '{part_id}'
    ''')
ecds_invest_query = query_to_df(ecds_invest_sql, version)
ecds_invest_query['table'] = 'ecds - SNOMED CT'

try:
    invest_table = pd.concat([ae_invest_query, did_invest_query, ecds_invest_query])
except:
    invest_table = pd.concat([ae_invest_query, ecds_invest_query])
invest_table
```

We can process and plot this in the same way as we did for the diagnoses.

### Find all treatments

Finally, we can do the same for treatments, fetching from the `hes_ae`, `hes_apc`, `hes_op` and `ecds` tables, and processing and plotting in the same way.

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
treat_table <- data.frame()

ae_treat_sql <- paste(
    "SELECT participant_id, arrivaldate as date, treat_all
    FROM hes_ae
    WHERE participant_id = '", part_id, "'",  sep="")
ae_treat_query <- query_to_df(ae_treat_sql, version)
if (nrow(ae_treat_query) > 0) {
  ae_treat_query$table <- 'hes_ae - A&E treatment code'
  treat_table <- rbind(treat_table, ae_treat_query)
}

apc_treat_sql <- paste(
    "SELECT participant_id, admidate as date, opertn_all as treat_all
    FROM hes_apc
    WHERE participant_id = '", part_id, "'",  sep="")
apc_treat_query <- query_to_df(apc_treat_sql, version)
if (nrow(apc_treat_query) > 0) {
  apc_treat_query$table <- 'hes_apc - OPCS4'
  treat_table <- rbind(treat_table, apc_treat_query)
}

op_treat_sql <- paste(
    "SELECT participant_id, apptdate as date, opertn_all as treat_all
    FROM hes_op
    WHERE participant_id = '", part_id, "'",  sep="")
op_treat_query <- query_to_df(op_treat_sql, version)
if (nrow(op_treat_query) > 0) {
  op_treat_query$table <- 'hes_op - OPCS4'
  treat_table <- rbind(treat_table, op_treat_query)
}

ecds_treat_sql <- paste(
    "SELECT participant_id, seen_date as date, treatment_code_all as treat_all
    FROM ecds
    WHERE participant_id = '", part_id, "'",  sep="")
ecds_treat_query <- query_to_df(ecds_treat_sql, version)
```

```
ae_treat_sql = (f'''
    SELECT participant_id, arrivaldate as date, treat_all
    FROM hes_ae
    WHERE participant_id = '{part_id}'
    ''')
ae_treat_query = query_to_df(ae_treat_sql, version)
ae_treat_query['table'] = 'hes_ae - A&E treatment code'

apc_treat_sql = (f'''
    SELECT participant_id, admidate as date, opertn_all as treat_all
    FROM hes_apc
    WHERE participant_id = '{part_id}'
    ''')
apc_treat_query = query_to_df(apc_treat_sql, version)
apc_treat_query['table'] = 'hes_apc -OPCS4'

op_treat_sql = (f'''
    SELECT participant_id, apptdate as date, opertn_all as treat_all
    FROM hes_op
    WHERE participant_id = '{part_id}'
    ''')
op_treat_query = query_to_df(op_treat_sql, version)
op_treat_query['table'] = 'hes_op - OPCS4'

ecds_treat_sql = (f'''
    SELECT participant_id, seen_date as date, treatment_code_all as treat_all
    FROM ecds
    WHERE participant_id = '{part_id}'
    ''')
ecds_treat_query = query_to_df(ecds_treat_sql, version)
ecds_treat_query['table'] = 'ecds - SNOMED CT'

treat_table = pd.concat([ae_treat_query, apc_treat_query, op_treat_query, ecds_treat_query])
```

```
treat_table <- data.frame()

ae_treat_sql <- paste(
    "SELECT participant_id, arrivaldate as date, treat_all
    FROM hes_ae
    WHERE participant_id = '", part_id, "'",  sep="")
ae_treat_query <- query_to_df(ae_treat_sql, version)
if (nrow(ae_treat_query) > 0) {
  ae_treat_query$table <- 'hes_ae - A&E treatment code'
  treat_table <- rbind(treat_table, ae_treat_query)
}

apc_treat_sql <- paste(
    "SELECT participant_id, admidate as date, opertn_all as treat_all
    FROM hes_apc
    WHERE participant_id = '", part_id, "'",  sep="")
apc_treat_query <- query_to_df(apc_treat_sql, version)
if (nrow(apc_treat_query) > 0) {
  apc_treat_query$table <- 'hes_apc - OPCS4'
  treat_table <- rbind(treat_table, apc_treat_query)
}

op_treat_sql <- paste(
    "SELECT participant_id, apptdate as date, opertn_all as treat_all
    FROM hes_op
    WHERE participant_id = '", part_id, "'",  sep="")
op_treat_query <- query_to_df(op_treat_sql, version)
if (nrow(op_treat_query) > 0) {
  op_treat_query$table <- 'hes_op - OPCS4'
  treat_table <- rbind(treat_table, op_treat_query)
}

ecds_treat_sql <- paste(
    "SELECT participant_id, seen_date as date, treatment_code_all as treat_all
    FROM ecds
    WHERE participant_id = '", part_id, "'",  sep="")
ecds_treat_query <- query_to_df(ecds_treat_sql, version)
```

```
ae_treat_sql = (f'''
    SELECT participant_id, arrivaldate as date, treat_all
    FROM hes_ae
    WHERE participant_id = '{part_id}'
    ''')
ae_treat_query = query_to_df(ae_treat_sql, version)
ae_treat_query['table'] = 'hes_ae - A&E treatment code'

apc_treat_sql = (f'''
    SELECT participant_id, admidate as date, opertn_all as treat_all
    FROM hes_apc
    WHERE participant_id = '{part_id}'
    ''')
apc_treat_query = query_to_df(apc_treat_sql, version)
apc_treat_query['table'] = 'hes_apc -OPCS4'

op_treat_sql = (f'''
    SELECT participant_id, apptdate as date, opertn_all as treat_all
    FROM hes_op
    WHERE participant_id = '{part_id}'
    ''')
op_treat_query = query_to_df(op_treat_sql, version)
op_treat_query['table'] = 'hes_op - OPCS4'

ecds_treat_sql = (f'''
    SELECT participant_id, seen_date as date, treatment_code_all as treat_all
    FROM ecds
    WHERE participant_id = '{part_id}'
    ''')
ecds_treat_query = query_to_df(ecds_treat_sql, version)
ecds_treat_query['table'] = 'ecds - SNOMED CT'

treat_table = pd.concat([ae_treat_query, apc_treat_query, op_treat_query, ecds_treat_query])
```

## Match accident and emergency episodes to overnight admissions

Where accident and emergency admissions resulted in the participant being admitted for overnight care, the entries in the `hes_ae` and `hes_apc` tables are linked by the `aekey` and `epikey`. The following query finds all diagnoses and operations the participant received in both A&E and after admission to overnight care. Note that in this code we rename the column headers, since many of these are the same between `hes_ae` and `hes_apc`.

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
ae_apc_sql <- paste("SELECT ae.participant_id,
  ae.arrivaldate as ae_arrival,
  ae.diag_all as ae_diag,
  apc.admidate as apc_arrival,
  apc.disdate as apc_discharge,
  apc.opertn_all as apc_operation,
  apc.diag_all as apc_diag
    FROM hes_ae as ae, hes_apc as apc
    WHERE ae.epikey = apc.epikey
    AND ae.participant_id = '", part_id, "'",  sep = "")

ae_apc_query <- query_to_df(ae_apc_sql, version)
```

```
ae_apc_sql = (f'''
    SELECT ae.participant_id,
    ae.arrivaldate as ae_arrival,
    ae.diag_all as ae_diag,
    apc.admidate as apc_arrival,
    apc.disdate as apc_discharge,
    apc.opertn_all as apc_operation,
    apc.diag_all as apc_diag
    FROM hes_ae as ae, hes_apc as apc
    WHERE ae.epikey = apc.epikey
    AND ae.participant_id =  '{part_id}'
    ''')

ae_apc_query = query_to_df(ae_apc_sql, version)
```

```
ae_apc_sql <- paste("SELECT ae.participant_id,
  ae.arrivaldate as ae_arrival,
  ae.diag_all as ae_diag,
  apc.admidate as apc_arrival,
  apc.disdate as apc_discharge,
  apc.opertn_all as apc_operation,
  apc.diag_all as apc_diag
    FROM hes_ae as ae, hes_apc as apc
    WHERE ae.epikey = apc.epikey
    AND ae.participant_id = '", part_id, "'",  sep = "")

ae_apc_query <- query_to_df(ae_apc_sql, version)
```

```
ae_apc_sql = (f'''
    SELECT ae.participant_id,
    ae.arrivaldate as ae_arrival,
    ae.diag_all as ae_diag,
    apc.admidate as apc_arrival,
    apc.disdate as apc_discharge,
    apc.opertn_all as apc_operation,
    apc.diag_all as apc_diag
    FROM hes_ae as ae, hes_apc as apc
    WHERE ae.epikey = apc.epikey
    AND ae.participant_id =  '{part_id}'
    ''')

ae_apc_query = query_to_df(ae_apc_sql, version)
```

## Find critical care periods within an overnight stay

Critical care periods in the `hes_cc` table all fall within periods of overnight care in `hes_apc`. These are linked together by the `susrecid` column.

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
apc_cc_sql <- paste("SELECT apc.participant_id,
  apc.admidate as apc_arrival,
  apc.disdate as apc_discharge,
  apc.opertn_all as apc_operation,
  apc.diag_all as apc_diag,
  cc.ccstartdate as cc_start,
  cc.ccdisdate as cc_discharge
    FROM hes_apc as apc, hes_cc as cc
    WHERE apc.susrecid = cc.susrecid
    AND apc.participant_id = '", part_id, "'", 
  "ORDER BY apc.admidate", sep = "")

apc_cc_query <- query_to_df(apc_cc_sql, version)
```

```
apc_cc_sql = (f'''
    SELECT apc.participant_id,
    apc.admidate as apc_arrival,
    apc.disdate as apc_discharge,
    apc.opertn_all as apc_operation,
    apc.diag_all as apc_diag,
    cc.ccstartdate as cc_start,
    cc.ccdisdate as cc_discharge
    FROM hes_apc as apc, hes_cc as cc
    WHERE apc.susrecid = cc.susrecid
    AND apc.participant_id = '{part_id}'
    ORDER BY apc.admidate
    ''')

apc_cc_query = query_to_df(apc_cc_sql, version)
```

```
apc_cc_sql <- paste("SELECT apc.participant_id,
  apc.admidate as apc_arrival,
  apc.disdate as apc_discharge,
  apc.opertn_all as apc_operation,
  apc.diag_all as apc_diag,
  cc.ccstartdate as cc_start,
  cc.ccdisdate as cc_discharge
    FROM hes_apc as apc, hes_cc as cc
    WHERE apc.susrecid = cc.susrecid
    AND apc.participant_id = '", part_id, "'", 
  "ORDER BY apc.admidate", sep = "")

apc_cc_query <- query_to_df(apc_cc_sql, version)
```

```

```
apc_cc_sql = (f'''
    SELECT apc.participant_id,
    apc.admidate as apc_arrival,
    apc.disdate as apc_discharge,
    apc.opertn_all as apc_operation,
    apc.diag_all as apc_diag,
    cc.ccstartdate as cc_start,
    cc.ccdisdate as cc_discharge
    FROM hes_apc as apc, hes_cc as cc
    WHERE apc.susrecid = cc.susrecid
    AND apc.participant_id = '{part_id}'
    ORDER BY apc.admidate
    ''')

apc_cc_query = query_to_df(apc_cc_sql, version)
```

## Pull out time periods from medical history tables

Other tables, such as the `hes_op` table of Outpatients day appointments at a hospital, and `did` table of diagnostic imaging, do not have explicit links to other tables. These can only be linked to other medical history tables by the dates of events.

The following code pulls out the start and end dates of periods of admitted patient care where a diagnosis was made (in this case R06, abnormalities of breathing). We will pull dates out of the table `apc_cc_query` that we created above.

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
diag <- 'R06'
episodes <- apc_cc_query %>% filter(grepl(diag, apc_diag))

for(i in 1:nrow(episodes)) {
  start_date <- episodes[i, "apc_arrival"]
  end_date <- episodes[i, "apc_discharge"]

  # carry out a query using the start and end date
}
```

```
diag = 'R06'
episodes = apc_cc_query[apc_cc_query['apc_diag'].str.contains(diag)]

for i in range(len(episodes)):
  start_date = episodes.iloc[i]['apc_arrival']
  end_date = episodes.iloc[i]['apc_discharge']

  # carry out a query using the start and end date
```

```
diag <- 'R06'
episodes <- apc_cc_query %>% filter(grepl(diag, apc_diag))

for(i in 1:nrow(episodes)) {
  start_date <- episodes[i, "apc_arrival"]
  end_date <- episodes[i, "apc_discharge"]

  # carry out a query using the start and end date
}
```

```
diag = 'R06'
episodes = apc_cc_query[apc_cc_query['apc_diag'].str.contains(diag)]

for i in range(len(episodes)):
  start_date = episodes.iloc[i]['apc_arrival']
  end_date = episodes.iloc[i]['apc_discharge']

  # carry out a query using the start and end date
```

Alternatively, you may wish to take a start or end date from one event and find all other events within a period of time before or after that event.

Because the date format is different between 100kGP and NHS GMS (NHS GMS includes time, which is always 00:00:00.000) we've included a `try/except` for pulling the date out of the dataframe.

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
diag <- 'R06'
episodes <- apc_cc_query %>% filter(grepl(diag, apc_diag))

for(i in 1:nrow(episodes)) {
  start_date <- episodes[i, "apc_discharge"]
  end_date <- as.Date(start_date) + 90

  # carry out a query using the start and end date
}
```

```
diag = 'R06'
episodes = apc_cc_query[apc_cc_query['apc_diag'].str.contains(diag)]

for i in range(len(episodes)):
  start_date = episodes.iloc[i]['discharge']
    try:
        end_date = datetime.strptime(date, '%Y-%m-%d') + pd.DateOffset(days = 90)
    except:
        end_date = datetime.strptime(date, '%Y-%m-%d %H:%M:%S.%f') + pd.DateOffset(days = 90)

  # carry out a query using the start and end date
```

```
diag <- 'R06'
episodes <- apc_cc_query %>% filter(grepl(diag, apc_diag))

for(i in 1:nrow(episodes)) {
  start_date <- episodes[i, "apc_discharge"]
  end_date <- as.Date(start_date) + 90

  # carry out a query using the start and end date
}
```

```
diag = 'R06'
episodes = apc_cc_query[apc_cc_query['apc_diag'].str.contains(diag)]

for i in range(len(episodes)):
  start_date = episodes.iloc[i]['discharge']
    try:
        end_date = datetime.strptime(date, '%Y-%m-%d') + pd.DateOffset(days = 90)
    except:
        end_date = datetime.strptime(date, '%Y-%m-%d %H:%M:%S.%f') + pd.DateOffset(days = 90)

  # carry out a query using the start and end date
```

## Find events and episodes within a time period

We can use the dates we have pulled out to find all events in other tables that occurred within that time period. In the following query, we will query the [`did` table of diagnostic imaging](../general_clinical/) in 100kGP for rows where the imaging date `did_date3` falls within the hospital stay.

To match up rows from `did` to rows from our `hes_*` tables, we will create our own index called `did_index`.

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
row_counter <- 1
did_combined <- data.frame()

for(i in 1:nrow(episodes)) {

  start_date <- episodes[i, "apc_arrival"]
  end_date <- episodes[i, "apc_discharge"]

  episodes$did_index[i] <- row_counter

  did_sql <- paste("SELECT participant_id,
    did_date3, ic_region_desc, ic_snomedct_desc, ic_sub_sys_desc, ic_nicip_desc
    FROM did
    WHERE participant_id = '", part_id, "'", 
    " AND did_date3 >= '", start_date,
    "' AND did_date3 <= '", end_date,
    "'", sep = "")

  did_query <- query_to_df(did_sql, version)
  did_query$did_index <- row_counter
  did_combined <- rbind(did_combined, did_query)
  row_counter <- row_counter + 1
}

episodes <- merge(episodes, did_combined, by = c("did_index", "participant_id"))
```

```
row_counter = 1
did_combined = pd.DataFrame()

for i in range(len(episodes)):
    start_date = episodes.iloc[i]['apc_arrival']
    end_date = episodes.iloc[i]['apc_discharge']

    episodes.loc[episodes.index[i], 'did_index'] = row_counter

    did_sql = (f'''
        SELECT participant_id,
        did_date3, ic_region_desc, ic_snomedct_desc, ic_sub_sys_desc, ic_nicip_desc
        FROM did
        WHERE participant_id = '{part_id}'
        AND did_date3 >= '{start_date}'
        AND did_date3 <= '{end_date}'
        ''')

    did_query = query_to_df(did_sql, version)
    did_query['did_index'] = row_counter
    did_combined = pd.concat([did_query, did_combined])
    row_counter += 1

episodes = pd.merge(episodes, did_combined, on = ['did_index', 'participant_id'])
```

```
row_counter <- 1
did_combined <- data.frame()

for(i in 1:nrow(episodes)) {

  start_date <- episodes[i, "apc_arrival"]
  end_date <- episodes[i, "apc_discharge"]

  episodes$did_index[i] <- row_counter

  did_sql <- paste("SELECT participant_id,
    did_date3, ic_region_desc, ic_snomedct_desc, ic_sub_sys_desc, ic_nicip_desc
    FROM did
    WHERE participant_id = '", part_id, "'", 
    " AND did_date3 >= '", start_date,
    "' AND did_date3 <= '", end_date,
    "'", sep = "")

  did_query <- query_to_df(did_sql, version)
  did_query$did_index <- row_counter
  did_combined <- rbind(did_combined, did_query)
  row_counter <- row_counter + 1
}

episodes <- merge(episodes, did_combined, by = c("did_index", "participant_id"))
```

```
row_counter = 1
did_combined = pd.DataFrame()

for i in range(len(episodes)):
    start_date = episodes.iloc[i]['apc_arrival']
    end_date = episodes.iloc[i]['apc_discharge']

    episodes.loc[episodes.index[i], 'did_index'] = row_counter

    did_sql = (f'''
        SELECT participant_id,
        did_date3, ic_region_desc, ic_snomedct_desc, ic_sub_sys_desc, ic_nicip_desc
        FROM did
        WHERE participant_id = '{part_id}'
        AND did_date3 >= '{start_date}'
        AND did_date3 <= '{end_date}'
        ''')

    did_query = query_to_df(did_sql, version)
    did_query['did_index'] = row_counter
    did_combined = pd.concat([did_query, did_combined])
    row_counter += 1

episodes = pd.merge(episodes, did_combined, on = ['did_index', 'participant_id'])
```

February 3, 2026
