---
title: 'Building rare disease cohorts programmatically - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/rd_cohorts/
scraped_at: 2026-05-04T06:33:30Z
---

# Building rare disease cohorts programmatically

[Give us feedback on this tutorial](https://www.smartsurvey.co.uk/s/E4038I/)

There are a huge number of tables that you can use to build rare disease cohorts. This tutorial will take you through some of the tables and give you some example scripts that you can use in python or R, or using R in an interactive session on CloudOS, to access the data.

The advantage of building cohorts programmatically is that the underlying tables are exposed, allowing you to verify the data in bulk. This also allows you to do very complex queries. You can save and tweak scripts to re-use in new releases or for similar queries.

> **Common disease cohorts:**
>
> To build common disease cohorts programmatically, we recommend you follow the steps here, omitting the steps on recruited disease, HPO terms and unsolved cases.

> **Currently available aggregates:**
>
> The currently available aggregates provided by Genomics England do not include NHS GMS data. An updated aggregate will be made available in 2025.

## Tables to query

To build cohorts, you might query the following tables:

100kGP or main programmeNHS GMS

| Table | Fields | Details |
| --- | --- | --- |
| `rare_diseases_participant_disease` | `normalised_specific_disease`, `normalised_disease_sub_group`, `normalised_disease_group` | Normalised terms for the recruited disease |
| `rare_disease_participant_phenotype` | `normalised_hpo_term`, `hpo_present` | The table contains all the HPO terms that were assessed, make sure you also filter by whether those terms were present. |
| `hes_op`, `hes_apc`, `hes_ae` | `diag_all` | All diagnoses from hospital episode statistics as ICD10 codes |
| `hes_op`, `hes_apc` | `opertn_all` | All treatments from hospital episode statistics as OPCS codes |
| `gmc_exit_questionnaire` | `case_solved_family` | Find families with solved or unsolved cases |
| `submitted_diagnostic discovery` | n/a | Find participants whose cases have been solved by other researchers |
| `mortality` | `icd10_multiple_cause_all` | Cause of death as ICD10 codes |
| `cancer_analysis` | `disease_type` | Exclude participants from the control with related cancers |
| `participant_summary` | `yob`, `genetically_inferred_ancestry_thr`, `participant_karyotyped_sex` | Age, ethnicity and sex |
| `aggregate_gvcf_sample_stats` | `sample_source`, `sample_preparation_method`, `sample_library_type` | Filter by sampling details |
| `genome_file_paths_and_types` | `platekey`, `filename`, `file_path`, `file_sub_type` | Get paths for genomic files |

| Table | Fields | Details |
| --- | --- | --- |
| `referral` | `clinical_indication_full_name` `clinical_indication_code` | Normalised term and ICD10 code for the recruited disease |
| `referral_participant` | `referral_id` `participant_id` | Linking the `referral_id` from the `referral` table to the `participant_id` found in other tables |
| `observation` | `normalised_hpo_id` `nromalised_hpo_term` `value_code` | The table contains all the HPO terms that were assessed, make sure you also filter by whether those terms were present. |
| `observation_component` | `observation_uid` `observation_component_code` `observation_component_code_description` | Features of the phenotypes in the `observation` table, such as severity, onset and laterality |
| `hes_op`, `hes_apc`, `hes_ae` | `diag_all` | All diagnoses from hospital episode statistics as ICD10 codes |
| `hes_op`, `hes_apc` | `opertn_all` | All treatments from hospital episode statistics as OPCS codes |
| `report_outcome_questionnaire` | `case_solved_family` | Find families with solved or unsolved cases |
| `mortality` | `icd10_multiple_cause_all` | Cause of death as ICD10 codes |
| `cancer_analysis` | `clinical_indication_full_name` | Exclude participants from the control with related cancers |
| `participant` | `participant_year_of_birth` `ethnicity` `ethnicity_description` `administrative_gender` | Age, ethnicity and sex |
| `genome_file_paths_and_types` | `platekey`, `filename`, `path`, `file_sub_type` | Get paths for genomic files |

## Contents:

- [Import modules/libraries you need](#modules)
- [Helper function to access the LabKey API](#helper)
- [Case cohort](#case)
  - [Recruited disease](#recruited)
  - [HPO terms](#hpo)
  - [ICD10 codes](#icd10)
  - [Unsolved cases](#unsolved)
- [Control cohort](#control)
  - [NOT phenotype](#not)
  - [Match demographics](#match)
- [General inclusion criteria](#gic)
- [Filepaths](#file)

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

## Case cohort

### Recruited disease

100kGP or main programmeNHS GMS

We can find participants recruited for a particular disease in the `rare_diseases_participant_disease` table. Here we define an SQL query. We will use as our example ADPKD (autosomal dominant polycystic kidney disease).

We need to start by searching for the `normalised_specific_disease` "Cystic kidney disease".

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
disease <- "Cystic kidney disease"

recruited_sql <- paste("SELECT participant_id,
        normalised_specific_disease,
        normalised_disease_sub_group,
        normalised_disease_group
    FROM rare_diseases_participant_disease
    WHERE normalised_specific_disease = '",
    disease, "'", sep="")

recruited_query <- query_to_df(recruited_sql, version)
```

```
disease = "Cystic kidney disease"

recruited_sql = (f'''
    SELECT participant_id,
        normalised_specific_disease,
        normalised_disease_sub_group,
        normalised_disease_group
    FROM rare_diseases_participant_disease
    WHERE normalised_specific_disease = '{disease}'
    ''')
recruited_query = query_to_df(recruited_sql, version)
```

```
disease <- "Cystic kidney disease"

recruited_sql <- paste("SELECT participant_id,
        normalised_specific_disease,
        normalised_disease_sub_group,
        normalised_disease_group
    FROM rare_diseases_participant_disease
    WHERE normalised_specific_disease = '",
    disease, "'", sep="")

recruited_query <- query_to_df(recruited_sql, version)
```

```
disease = "Cystic kidney disease"

recruited_sql = (f'''
    SELECT participant_id,
        normalised_specific_disease,
        normalised_disease_sub_group,
        normalised_disease_group
    FROM rare_diseases_participant_disease
    WHERE normalised_specific_disease = '{disease}'
    ''')
recruited_query = query_to_df(recruited_sql, version)
```

We can find participants recruited for a particular disease in the `referral` table. Here we define an SQL query. We will use as our example ADPKD (autosomal dominant polycystic kidney disease).

We need to start by searching for the `clinical_indication_full_name` "Cystic renal disease".

However this table does not include the `participant_id`, so we will need to link this to the `referral_participant` table with the `referral_id`. We will also filter this table by `referral_participant_is_proband` column to ensure we get probands and not family members.

RE LabKey API RRE LabKey API Python

```
gms_disease <- "Cystic renal disease"

gms_recruited_sql <- paste("SELECT r.referral_id,
        rp.participant_id,
        r.clinical_indication_code,
        r.clinical_indication_full_name
    FROM referral as r, referral_participant as rp
    WHERE r.clinical_indication_full_name = '", gms_disease, "'
    AND rp.referral_participant_is_proband = TRUE
    AND r.referral_id = rp.referral_id", sep ="")

gms_recruited_query <- query_to_df(gms_recruited_sql, gms_version)
gms_recruited_query
```

```
gms_disease = "Cystic renal disease"

gms_recruited_sql = (f'''
    SELECT r.referral_id,
        rp.participant_id,
        r.clinical_indication_code,
        r.clinical_indication_full_name
    FROM referral as r, referral_participant as rp
    WHERE r.clinical_indication_full_name = '{gms_disease}'
    AND rp.referral_participant_is_proband = TRUE
    AND r.referral_id = rp.referral_id
    ''')

gms_recruited_query = query_to_df(gms_recruited_sql, gms_version)
```

We will create a list of the participants found with this recruited disease.

### HPO terms

We can also find participants who have HPO terms linked to our phenotype of interest. You should independently research a relevant list of HPO terms for your phenotype.

100kGP or main programmeNHS GMS

For ADPKD we will query the `rare_diseases_participant_phenotype` table for the following HPO terms:

- Polycystic kidney dysplasia (HP:0000113)
- Multiple renal cysts (HP:0005562)

Make sure you include the column `hpo_present` in any query, as this table contains all HPO terms that were checked in the participant, not just those that are present.

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
hpo_codes <- c("HP:0000113", "HP:0005562")

hpo_sql <- paste("SELECT participant_id, normalised_hpo_id, normalised_hpo_term
    FROM rare_diseases_participant_phenotype
    WHERE normalised_hpo_id IN ('", paste(hpo_codes, collapse = "', '"),
    "') AND hpo_present = 'Yes'",
    sep = "")

hpo_query <- query_to_df(hpo_sql, version)
```

```
hpo_codes = ["HP:0000113", "HP:0005562"]

hpo_sql = (f'''
    SELECT participant_id, normalised_hpo_id, normalised_hpo_term
    FROM rare_diseases_participant_phenotype
    WHERE normalised_hpo_id IN {*hpo_codes,}
    AND hpo_present = 'Yes'
    ''')

hpo_query = query_to_df(hpo_sql, version)
```

```
hpo_codes <- c("HP:0000113", "HP:0005562")

hpo_sql <- paste("SELECT participant_id, normalised_hpo_id, normalised_hpo_term
    FROM rare_diseases_participant_phenotype
    WHERE normalised_hpo_id IN ('", paste(hpo_codes, collapse = "', '"),
    "') AND hpo_present = 'Yes'",
    sep = "")

hpo_query <- query_to_df(hpo_sql, version)
```

```
hpo_codes = ["HP:0000113", "HP:0005562"]

hpo_sql = (f'''
    SELECT participant_id, normalised_hpo_id, normalised_hpo_term
    FROM rare_diseases_participant_phenotype
    WHERE normalised_hpo_id IN {*hpo_codes,}
    AND hpo_present = 'Yes'
    ''')

hpo_query = query_to_df(hpo_sql, version)
```

For ADPKD we will query the `observation` table for the following HPO terms:

- Polycystic kidney dysplasia (HP:0000113)
- Multiple renal cysts (HP:0005562)

Make sure you include the column `value_code` in any query, as this table contains all HPO terms that were checked in the participant, not just those that are present.

RE LabKey API RRE LabKey API Python

```
hpo_codes <- c("HP:0000113", "HP:0005562")

gms_hpo_sql <- paste(
    "SELECT participant_id, normalised_hpo_id, normalised_hpo_term
    FROM observation
    WHERE normalised_hpo_id IN ('", paste(hpo_codes, collapse = "', '"),
    "') AND value_code = 'present'", sep="")

gms_hpo_query <- query_to_df(gms_hpo_sql, gms_version)
```

```
hpo_codes = ["HP:0000113", "HP:0005562"]

gms_hpo_sql = (f'''
    SELECT participant_id, normalised_hpo_id, normalised_hpo_term
    FROM observation
    WHERE normalised_hpo_id IN {*hpo_codes,}
    AND value_code = 'present'
    ''')

gms_hpo_query = query_to_df(gms_hpo_sql, gms_version)
```

### ICD10 codes

Lastly, we will search the hospital episode statistics to identify participants with diagnoses in their medical records that indicate your phenotype. Again, you should research the list of ICD10 codes independently.

For ADPKD we will search for the following codes:

- N28.1 (cyst of kidney)
- Q61 (cystic kidney disease)â¯
- Q61.2 (polycystic kidney, autosomal dominant)

There are three tables of hospital episode statistics with ICD-10 in the Genomics England data:
- `hes_apc`
- `hes_op`
- `hes_ae`

(There is also the `hes_cc` table, but this does not include diagnoses.)

100kGP or main programmeNHS GMS

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
icd_codes <- c('N281', 'Q61', 'Q612')
hes_tables = c("apc", "op", "ae")

icd_concat <- data.frame()

diag_statement <- paste((icd_codes), collapse = "%' OR diag_all LIKE '%")

for (hes_table in hes_tables) {
    sqlstr = paste(
        "SELECT participant_id, diag_all
        FROM hes_", hes_table,
        " WHERE diag_all LIKE '%", diag_statement, "%'", sep = "")
    icd_query <- query_to_df(sqlstr, version)
    if (nrow(icd_query) > 0){
        icd_concat = rbind(icd_query, icd_concat)
    }
  }
```

```
icd_codes = ['N281', 'Q61', 'Q612']
hes_tables = ["apc", "op", "ae"]

icd_concat = pd.DataFrame()

diag_statement = "%' OR diag_all LIKE '%".join(icd_codes)

for hes_table in hes_tables:
    sqlstr = (
        f'''
        SELECT participant_id, diag_all
        FROM hes_{hes_table}
        WHERE diag_all LIKE '%{diag_statement}%'
        ''')
    icd_query = query_to_df(sqlstr, version)
    if not icd_query.empty:
        icd_concat = pd.concat([icd_query, icd_concat])
```

```
icd_codes <- c('N281', 'Q61', 'Q612')
hes_tables = c("apc", "op", "ae")

icd_concat <- data.frame()

diag_statement <- paste((icd_codes), collapse = "%' OR diag_all LIKE '%")

for (hes_table in hes_tables) {
    sqlstr = paste(
        "SELECT participant_id, diag_all
        FROM hes_", hes_table,
        " WHERE diag_all LIKE '%", diag_statement, "%'", sep = "")
    icd_query <- query_to_df(sqlstr, version)
    if (nrow(icd_query) > 0){
        icd_concat = rbind(icd_query, icd_concat)
    }
  }
```

```
icd_codes = ['N281', 'Q61', 'Q612']
hes_tables = ["apc", "op", "ae"]

icd_concat = pd.DataFrame()

diag_statement = "%' OR diag_all LIKE '%".join(icd_codes)

for hes_table in hes_tables:
    sqlstr = (
        f'''
        SELECT participant_id, diag_all
        FROM hes_{hes_table}
        WHERE diag_all LIKE '%{diag_statement}%'
        ''')
    icd_query = query_to_df(sqlstr, version)
    if not icd_query.empty:
        icd_concat = pd.concat([icd_query, icd_concat])
```

RE LabKey API RRE LabKey API Python

```
icd_codes <- c('N281', 'Q61', 'Q612')
hes_tables = c("apc", "op", "ae")

icd_concat <- data.frame()

diag_statement <- paste((icd_codes), collapse = "%' OR diag_all LIKE '%")

for (hes_table in hes_tables) {
    sqlstr = paste(
        "SELECT participant_id, diag_all
        FROM hes_", hes_table,
        " WHERE diag_all LIKE '%", diag_statement, "%'", sep = "")
    icd_query <- query_to_df(sqlstr, gms_version,)
    if (nrow(icd_query) > 0){
        icd_concat = rbind(icd_query, icd_concat)
    }
  }
```

```
icd_codes = ['N281', 'Q61', 'Q612']
hes_tables = ["apc", "op", "ae"]

icd_concat = pd.DataFrame()

diag_statement = "%' OR diag_all LIKE '%".join(icd_codes)

for hes_table in hes_tables:
    sqlstr = (
        f'''
        SELECT participant_id, diag_all
        FROM hes_{hes_table}
        WHERE diag_all LIKE '%{diag_statement}%'
        ''')
    icd_query = query_to_df(sqlstr, gms_version)
    if not icd_query.empty:
        icd_concat = pd.concat([icd_query, icd_concat])
```

You can create a complete cohort by pulling out the lists of participants from the three queries above, combining the lists together and removing all duplicates.

### Unsolved cases

We can find cases that have been solved, and this has been approved by the GLHs, in the 100k `gmc_exit_questionnaire` table and NHS GMS `report_outcome_questionnaire` table.

The following SQL query uses a list of participants (`rd_participants`) and checks to see if the case is solved. The code has been written to see if `case_solved_family` is not `yes` as opposed to checking if it is `no`, as this will bring back families where the case is partially solved or if this is unknown. Alternatively, you might want solved cases only for eligibility to participate in a clinical trial.

100kGP or main programmeNHS GMS

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
solved <- "!= 'yes'"

gmc_sql <- paste(
    "SELECT participant_id, case_solved_family
    FROM gmc_exit_questionnaire
    WHERE participant_id in (", participants,
    ") AND case_solved_family ", solved, sep = "")

gmc_query <- query_to_df(gmc_sql, version)
```

```
solved = "!= 'yes'"

gmc_sql = (f'''
    SELECT participant_id, case_solved_family
    FROM gmc_exit_questionnaire
    WHERE participant_id in {*participants,}
    AND case_solved_family '{solved}'
    ''')

gmc_query = query_to_df(gmc_sql, version)
```

```
solved <- "yes"

gmc_sql <- paste(
    "SELECT participant_id, case_solved_family
    FROM gmc_exit_questionnaire
    WHERE participant_id in (", participants,
    ") AND case_solved_family != '", solved, "'", sep = "")

gmc_query <- query_to_df(gmc_sql, version)
```

```
solved = "!= 'yes'"

gmc_sql = (f'''
    SELECT participant_id, case_solved_family
    FROM gmc_exit_questionnaire
    WHERE participant_id in {*participants,}
    AND case_solved_family '{solved}'
    ''')

gmc_query = query_to_df(gmc_sql, version)
```

Cases that have been solved by RE researchers, but this solution has not yet been approved by the GLHs, can be found in the `submitted_diagnostic_discovery` table. We will now query our list to ensure that none appear in this table.

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
dd_sql <- paste("SELECT participant_id
    FROM submitted_diagnostic_discovery
    WHERE participant_id IN (",
    toString(gmc_query$participant_id),
    ")", sep ="")

dd_query <- query_to_df(dd_sql, version)
```

```
dd_sql = (f'''
    SELECT participant_id
    FROM submitted_diagnostic_discovery
    WHERE participant_id IN {*gmc_query['participant_id'].tolist(),}
    ''')

dd_query = query_to_df(dd_sql, version)
```

```
dd_sql <- paste("SELECT participant_id
    FROM submitted_diagnostic_discovery
    WHERE participant_id IN (",
    toString(gmc_query$participant_id),
    ")", sep ="")

dd_query <- query_to_df(dd_sql, version)
```

```
dd_sql = (f'''
    SELECT participant_id
    FROM submitted_diagnostic_discovery
    WHERE participant_id IN {*gmc_query['participant_id'].tolist(),}
    ''')

dd_query = query_to_df(dd_sql, version)
```

We can now generate a list of participants who match our cohort query and do not yet have a genetic diagnosis.

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
cohort <- as.list((gmc_query %>% filter(!participant_id %in% dd_query$participant_id))$participant_id)
```

```
cohort = [i for i in gmc_query['participant_id'].tolist() if i not in dd_query['participant_id'].tolist()]
```

```
cohort <- as.list((gmc_query %>% filter(!participant_id %in% dd_query$participant_id))$participant_id)
```

```
cohort = [i for i in gmc_query['participant_id'].tolist() if i not in dd_query['participant_id'].tolist()]
```

RE LabKey API RRE LabKey API Python

```
solved <- "!= 'yes'"

gmc_sql <- paste(
    "SELECT participant_id, case_solved_family
    FROM report_outcome_questionnaire
    WHERE participant_id in ('", paste(gms_participants, collapse = "', '")
    "') AND case_solved_family ", solved, sep = "")

gmc_query <- query_to_df(gmc_sql, version)
```

```
solved = "!= 'yes'"

gmc_sql = (f'''
    SELECT participant_id, case_solved_family
    FROM report_outcome_questionnaire
    WHERE participant_id in {*participants,}
    AND case_solved_family '{solved}'
    ''')

gmc_query = query_to_df(gmc_sql, version)
```

## Control cohort

### NOT phenotype

To build our control cohort, we need to exclude all participants who have the phenotype we're interested in. It is best to expand our criteria beyond that that we used to create cohort so that we exclude all phenotypes related to the phenotype of interest. We're going to query many of the same tables as before but at a higher level:

100kGP or main programmeNHS GMS

- For recruited disease, we will query a higher level, the `disease_group` in `rare_diseases_participant_disease` for an umbrella term.
- To exclude participants by HPO terms, we will use the terms we built our cohort with, plus additional more general terms.
- To exclude participants by events in their medical records, we will exclude:
  - all participants with an expanded list of ICD10-codes in their diagnoses in the hes tables
  - All participants who have received treatments relating to the disease of interest
  - All participants with related causes of death, who may never have been diagnosed with the disease of interest in their lifetime
- We will also exclude all participants with kidney cancer, by searching the cancer tables for "RENAL"

- For recruited disease, we will exclude all participants with the `clinical_indication`.
- To exclude participants by HPO terms, we will use the terms we built our cohort with, plus additional more general terms.
- To exclude participants by events in their medical records, we will exclude:
  - all participants with an expanded list of ICD10-codes in their diagnoses in the hes tables
  - All participants who have received treatments relating to the disease of interest
  - All participants with related causes of death, who may never have been diagnosed with the disease of interest in their lifetime
- We will also exclude all participants with kidney cancer, by searching the cancer tables for "Renal"

First we will make a list of all participants who DO have these diagnoses, codes and causes of death.

#### NOT recuited disease

100kGP or main programmeNHS GMS

Starting with recruited rare disease, where we will query `normalised_disease_group` for a general term: "Renal and urinary tract disorders".

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
not_disease <- "Renal and urinary tract disorders"

recruited_not_sql <- paste("SELECT participant_id,
        normalised_specific_disease,
        normalised_disease_sub_group,
        normalised_disease_group
    FROM rare_diseases_participant_disease
    WHERE normalised_disease_group = '",
    not_disease, "'", sep="")

recruited_not_query <- query_to_df(recruited_not_sql, version)
recruited_not_list <- as.list( recruited_not_query$participant_id)
```

```
not_disease = "Renal and urinary tract disorders"

recruited_not_sql = (f'''
    SELECT participant_id,
        normalised_specific_disease,
        normalised_disease_sub_group,
        normalised_disease_group
    FROM rare_diseases_participant_disease
    WHERE normalised_disease_group = '{not_disease}'
    ''')

recruited_not_query = query_to_df(recruited_not_sql, version)
recruited_not_list = recruited_not_query['participant_id'].tolist()
```

```
not_disease <- "Renal and urinary tract disorders"

recruited_not_sql <- paste("SELECT participant_id,
        normalised_specific_disease,
        normalised_disease_sub_group,
        normalised_disease_group
    FROM rare_diseases_participant_disease
    WHERE normalised_disease_group = '",
    not_disease, "'", sep="")

recruited_not_query <- query_to_df(recruited_not_sql, version)
recruited_not_list <- as.list( recruited_not_query$participant_id)
```

```
not_disease = "Renal and urinary tract disorders"

recruited_not_sql = (f'''
    SELECT participant_id,
        normalised_specific_disease,
        normalised_disease_sub_group,
        normalised_disease_group
    FROM rare_diseases_participant_disease
    WHERE normalised_disease_group = '{not_disease}'
    ''')

recruited_not_query = query_to_df(recruited_not_sql, version)
recruited_not_list = recruited_not_query['participant_id'].tolist()
```

We will use our list from our first query of the `referral` and `referral_particapant` tables.

#### NOT HPO phenotypes

100kGP or main programmeNHS GMS

Now we search the `rare_diseases_participant_phenotype` table for the expanded list of HPO terms:

- Polycystic kidney dysplasia (HP:0000113)
- Multicystic kidney dysplasia (HP:0000003)
- Multiple renal cysts (HP:0005562)
- **Abnormality of the kidney (HP:0000077)**

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
hpo_not_codes <- c("HP:0000113", "HP:0000003", "HP:0005562", "HP:0000077")

hpo_not_sql <- paste("SELECT participant_id, normalised_hpo_id, normalised_hpo_term
    FROM rare_diseases_participant_phenotype
    WHERE normalised_hpo_id IN ('", paste(hpo_not_codes, collapse = "', '"),
    "') AND hpo_present = 'Yes'",
    sep = "")

hpo_not_query <- query_to_df(hpo_not_sql, version)
hpo_not_list <- as.list( hpo_not_query$participant_id)
```

```
hpo_not_codes = ["HP:0000113", "HP:0000003", "HP:0005562", "HP:0000077"]

hpo_not_sql = (f'''
    SELECT participant_id, normalised_hpo_id, normalised_hpo_term
    FROM rare_diseases_participant_phenotype
    WHERE normalised_hpo_id IN {*hpo_not_codes,}
    AND hpo_present = 'Yes'
    ''')

hpo_not_query = query_to_df(hpo_not_sql, version)
hpo_not_list = hpo_not_query['participant_id'].tolist()
```

```
hpo_not_codes <- c("HP:0000113", "HP:0000003", "HP:0005562", "HP:0000077")

hpo_not_sql <- paste("SELECT participant_id, normalised_hpo_id, normalised_hpo_term
    FROM rare_diseases_participant_phenotype
    WHERE normalised_hpo_id IN ('", paste(hpo_not_codes, collapse = "', '"),
    "') AND hpo_present = 'Yes'",
    sep = "")

hpo_not_query <- query_to_df(hpo_not_sql, version)
hpo_not_list <- as.list( hpo_not_query$participant_id)
```

```
hpo_not_codes = ["HP:0000113", "HP:0000003", "HP:0005562", "HP:0000077"]

hpo_not_sql = (f'''
    SELECT participant_id, normalised_hpo_id, normalised_hpo_term
    FROM rare_diseases_participant_phenotype
    WHERE normalised_hpo_id IN {*hpo_not_codes,}
    AND hpo_present = 'Yes'
    ''')

hpo_not_query = query_to_df(hpo_not_sql, version)
hpo_not_list = hpo_not_query['participant_id'].tolist()
```

Now we search the `observation` table for the expanded list of HPO terms:

- Polycystic kidney dysplasia (HP:0000113)
- Multicystic kidney dysplasia (HP:0000003)
- Multiple renal cysts (HP:0005562)
- **Abnormality of the kidney (HP:0000077)**

RE LabKey API RRE LabKey API Python

```
hpo_not_codes <- c("HP:0000113", "HP:0000003", "HP:0005562", "HP:0000077")

gms_hpo_not_sql <- paste(
    "SELECT participant_id, normalised_hpo_id, normalised_hpo_term
    FROM observation
    WHERE normalised_hpo_id IN ('", paste(hpo_not_codes, collapse = "', '"),
    "') AND value_code = 'present'", sep="")

gms_hpo_not_query <- query_to_df(gms_hpo_not_sql, gms_version)
gms_hpo_not_list = as.list(gms_hpo_not_query$participant_id)
```

```
hpo_not_codes = ["HP:0000113", "HP:0000003", "HP:0005562", "HP:0000077"]

gms_hpo_not_sql = (f'''
    SELECT participant_id, normalised_hpo_id, normalised_hpo_term
    FROM observation
    WHERE normalised_hpo_id IN {*hpo_not_codes,}
    AND value_code = 'present'
    ''')

gms_hpo_not_query = query_to_df(gms_hpo_not_sql, gms_version)
gms_hpo_not_list = gms_hpo_not_query['participant_id'].tolist()
len(gms_hpo_not_list)
```

#### NOT diagnoses, treatments or causes of death in secondary clinical data

We will search for diagnoses in the secondary clinical data, again using an expanded list of terms:

- N19 Unspecified renal failure
- Y84.1 Kidney dialysis
- N18.5 Chronic kidney disease, stage 5
- N28.1 (cyst of kidney)
- Q61 (cystic kidney disease)â¯
- Q61.2 (polycystic kidney, autosomal dominant)â¯
- Q61.3 (polycystic kidney, unspecified)â¯
- Q61.8 (other cystic kidney diseases)
- Q61.9 (cystic kidney disease, unspecified)

100kGP or main programmeNHS GMS

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
icd_not_codes <- c('N281', 'Q61', 'Q612', 'Q613', 'Q618', 'Q619', 'N19', 'Y841', 'N185')
hes_tables = c("apc", "op", "ae")

icd_not_concat <- data.frame()

diag_not_statement <- paste((icd_not_codes), collapse = "%' OR diag_all LIKE '%")

for (hes_table in hes_tables) {
    sqlstr = paste(
        "SELECT participant_id, diag_all
        FROM hes_", hes_table,
        " WHERE diag_all LIKE '%", diag_not_statement, "%'", sep = "")
    icd_query <- query_to_df(sqlstr, version)
    if (nrow(icd_query) > 0){
        icd_not_concat <- rbind(icd_query, icd_not_concat)
    }
  }

icd_not_list <- as.list( icd_not_concat$participant_id)
```

```
icd_not_codes = ['N281', 'Q61', 'Q612', 'Q613', 'Q618', 'Q619', 'N19', 'Y841', 'N185']

hes_tables = ["apc", "op", "ae"]

icd_not_concat = pd.DataFrame()

diag_not_statement = "%' OR diag_all LIKE '%".join(icd_not_codes)

for hes_table in hes_tables:
    sqlstr = (
        f'''
        SELECT participant_id, diag_all
        FROM hes_{hes_table}
        WHERE diag_all LIKE '%{diag_not_statement}%'
        ''')
    icd_query = query_to_df(sqlstr, version)
    if not icd_query.empty:
        icd_not_concat = pd.concat([icd_query, icd_not_concat])

icd_not_list = icd_not_concat['participant_id'].tolist()
```

```
icd_not_codes <- c('N281', 'Q61', 'Q612', 'Q613', 'Q618', 'Q619', 'N19', 'Y841', 'N185')
hes_tables = c("apc", "op", "ae")

icd_not_concat <- data.frame()

diag_not_statement <- paste((icd_not_codes), collapse = "%' OR diag_all LIKE '%")

for (hes_table in hes_tables) {
    sqlstr = paste(
        "SELECT participant_id, diag_all
        FROM hes_", hes_table,
        " WHERE diag_all LIKE '%", diag_not_statement, "%'", sep = "")
    icd_query <- query_to_df(sqlstr, version)
    if (nrow(icd_query) > 0){
        icd_not_concat <- rbind(icd_query, icd_not_concat)
    }
  }

icd_not_list <- as.list( icd_not_concat$participant_id)
```

```
icd_not_codes = ['N281', 'Q61', 'Q612', 'Q613', 'Q618', 'Q619', 'N19', 'Y841', 'N185']

hes_tables = ["apc", "op", "ae"]

icd_not_concat = pd.DataFrame()

diag_not_statement = "%' OR diag_all LIKE '%".join(icd_not_codes)

for hes_table in hes_tables:
    sqlstr = (
        f'''
        SELECT participant_id, diag_all
        FROM hes_{hes_table}
        WHERE diag_all LIKE '%{diag_not_statement}%'
        ''')
    icd_query = query_to_df(sqlstr, version)
    if not icd_query.empty:
        icd_not_concat = pd.concat([icd_query, icd_not_concat])

icd_not_list = icd_not_concat['participant_id'].tolist()
```

RE LabKey API RRE LabKey API Python

```
icd_not_codes <- c('N281', 'Q61', 'Q612', 'Q613', 'Q618', 'Q619', 'N19', 'Y841', 'N185')
hes_tables = c("apc", "op", "ae")

icd_not_concat <- data.frame()

diag_not_statement <- paste((icd_not_codes), collapse = "%' OR diag_all LIKE '%")

for (hes_table in hes_tables) {
    sqlstr = paste(
        "SELECT participant_id, diag_all
        FROM hes_", hes_table,
        " WHERE diag_all LIKE '%", diag_not_statement, "%'", sep = "")
    icd_query <- query_to_df(sqlstr, gms_version)
    if (nrow(icd_query) > 0){
        icd_not_concat <- rbind(icd_query, icd_not_concat)
    }
  }

icd_not_list <- as.list( icd_not_concat$participant_id)
```

```
icd_not_codes = ['N281', 'Q61', 'Q612', 'Q613', 'Q618', 'Q619', 'N19', 'Y841', 'N185']

hes_tables = ["apc", "op", "ae"]

icd_not_concat = pd.DataFrame()

diag_not_statement = "%' OR diag_all LIKE '%".join(icd_not_codes)

for hes_table in hes_tables:
    sqlstr = (
        f'''
        SELECT participant_id, diag_all
        FROM hes_{hes_table}
        WHERE diag_all LIKE '%{diag_not_statement}%'
        ''')
    icd_query = query_to_df(sqlstr, gms_version)
    if not icd_query.empty:
        icd_not_concat = pd.concat([icd_query, icd_not_concat])

icd_not_list = icd_not_concat['participant_id'].tolist()
```

We will search the same hes tables for treatments relating to kidney disease:

- M01 Transplantation of kidney
- M01.1 Autotransplantation of kidney
- M01.2 Allotransplantation of kidney from live donor
- M01.3 Allotransplantation of kidney from cadaver NEC
- M01.4 Allotransplantation of kidney from cadaver heart beating
- M01.5 Allotransplantation of kidney from cadaver heart non-beating
- M01.8 Other specified transplantation of kidney
- M01.9 Unspecified transplantation of kidney
- X40.1 Renal dialysis

100kGP or main programmeNHS GMS

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
not_opcs <- c('M01', 'M011', 'M012', 'M013', 'M014', 'M015', 'M018', 'M019', 'X401')
opcs_hes = c("apc", "op")

opcs_not_concat <- data.frame()
opcs_not_statement <- paste((not_opcs), collapse = "%' OR opertn_all LIKE '%")

for (hes_table in opcs_hes) {
    sqlstr = paste(
        "SELECT participant_id, opertn_all
        FROM hes_", hes_table,
        " WHERE opertn_all LIKE '%", opcs_not_statement, "%'", sep = "")
    opcs_query <- query_to_df(sqlstr, version)
    if (nrow(opcs_query) > 0){
        opcs_not_concat = rbind(opcs_query, opcs_not_concat)
    }
  }

opcs_not_list <- as.list( opcs_not_concat$participant_id)
```

```
not_opcs = ['M01', 'M011', 'M012', 'M013', 'M014', 'M015', 'M018', 'M019', 'X401']
opcs_hes = ["apc", "op"]

opcs_not_statement = "%' OR opertn_all LIKE '%".join(not_opcs)
opcs_not_concat = pd.DataFrame()

for hes_table in opcs_hes:
    sqlstr = (
        f'''
        SELECT participant_id, opertn_all
        FROM hes_{hes_table}
        WHERE opertn_all LIKE '%{opcs_not_statement}%'
        ''')
    opcs_query = query_to_df(sqlstr, version)
    if not opcs_query.empty:
        opcs_not_concat = pd.concat([opcs_query, opcs_not_concat])

opcs_not_list = opcs_not_concat['participant_id'].tolist()
```

```
not_opcs <- c('M01', 'M011', 'M012', 'M013', 'M014', 'M015', 'M018', 'M019', 'X401')
opcs_hes = c("apc", "op")

opcs_not_concat <- data.frame()
opcs_not_statement <- paste((not_opcs), collapse = "%' OR opertn_all LIKE '%")

for (hes_table in opcs_hes) {
    sqlstr = paste(
        "SELECT participant_id, opertn_all
        FROM hes_", hes_table,
        " WHERE opertn_all LIKE '%", opcs_not_statement, "%'", sep = "")
    opcs_query <- query_to_df(sqlstr, version)
    if (nrow(opcs_query) > 0){
        opcs_not_concat = rbind(opcs_query, opcs_not_concat)
    }
  }

opcs_not_list <- as.list( opcs_not_concat$participant_id)
```

```
not_opcs = ['M01', 'M011', 'M012', 'M013', 'M014', 'M015', 'M018', 'M019', 'X401']
opcs_hes = ["apc", "op"]

opcs_not_statement = "%' OR opertn_all LIKE '%".join(not_opcs)
opcs_not_concat = pd.DataFrame()

for hes_table in opcs_hes:
    sqlstr = (
        f'''
        SELECT participant_id, opertn_all
        FROM hes_{hes_table}
        WHERE opertn_all LIKE '%{opcs_not_statement}%'
        ''')
    opcs_query = query_to_df(sqlstr, version)
    if not opcs_query.empty:
        opcs_not_concat = pd.concat([opcs_query, opcs_not_concat])

opcs_not_list = opcs_not_concat['participant_id'].tolist()
```

RE LabKey API RRE LabKey API Python

```
not_opcs <- c('M01', 'M011', 'M012', 'M013', 'M014', 'M015', 'M018', 'M019', 'X401')
opcs_hes = c("apc", "op")

opcs_not_concat <- data.frame()
opcs_not_statement <- paste((not_opcs), collapse = "%' OR opertn_all LIKE '%")

for (hes_table in opcs_hes) {
    sqlstr = paste(
        "SELECT participant_id, opertn_all
        FROM hes_", hes_table,
        " WHERE opertn_all LIKE '%", opcs_not_statement, "%'", sep = "")
    opcs_query <- query_to_df(sqlstr, gms_version)
    if (nrow(opcs_query) > 0){
        opcs_not_concat = rbind(opcs_query, opcs_not_concat)
    }
  }

opcs_not_list <- as.list( opcs_not_concat$participant_id)
```

```
not_opcs = ['M01', 'M011', 'M012', 'M013', 'M014', 'M015', 'M018', 'M019', 'X401']
opcs_hes = ["apc", "op"]

opcs_not_statement = "%' OR opertn_all LIKE '%".join(not_opcs)
opcs_not_concat = pd.DataFrame()

for hes_table in opcs_hes:
    sqlstr = (
        f'''
        SELECT participant_id, opertn_all
        FROM hes_{hes_table}
        WHERE opertn_all LIKE '%{opcs_not_statement}%'
        ''')
    opcs_query = query_to_df(sqlstr, gms_version, 1000000)
    if not opcs_query.empty:
        opcs_not_concat = pd.concat([opcs_query, opcs_not_concat])

opcs_not_list = opcs_not_concat['participant_id'].tolist()
```

We also want to exclude participants who have died of kidney related diseases, so we will use the `mortality` table to exclude:

- N19 Unspecified renal failure
- N28.1 Cyst of kidney
- Q61 Cystic kidney disease
- Q61.2 Polycystic kidney, autosomal dominant
- Q61.3 Polycystic kidney, unspecified
- Q61.8 Other cystic kidney diseases
- Q61.9 Cystic kidney disease, unspecified

100kGP or main programmeNHS GMS

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
not_death_icd = c('N19', 'N281', 'Q61', 'Q612', 'Q613', 'Q618', 'Q619')

mortality_not_statement <- paste((not_death_icd), collapse = "%' OR icd10_multiple_cause_all LIKE '%")

mortality_not_sql <- paste(
        "SELECT participant_id, icd10_multiple_cause_all
        FROM mortality
        WHERE icd10_multiple_cause_all LIKE '%", mortality_not_statement, "%'", sep = "")

mortality_not_query <- query_to_df(mortality_not_sql, version)
mortality_not_list <- as.list( mortality_not_query$participant_id)
length(mortality_not_list)
```

```
not_death_icd = ['N19', 'N281', 'Q61', 'Q612', 'Q613', 'Q618', 'Q619']

mortality_not_statement = "%' OR icd10_multiple_cause_all LIKE '%".join(not_death_icd)
mortality_not_sql = (
    f'''
    SELECT participant_id, icd10_multiple_cause_all
    FROM mortality
    WHERE icd10_multiple_cause_all LIKE '%{mortality_not_statement}%'
    ''')
mortality_not_query = query_to_df(mortality_not_sql, version)
mortality_not_list = mortality_not_query['participant_id'].tolist()
```

```
not_death_icd = c('N19', 'N281', 'Q61', 'Q612', 'Q613', 'Q618', 'Q619')

mortality_not_statement <- paste((not_death_icd), collapse = "%' OR icd10_multiple_cause_all LIKE '%")

mortality_not_sql <- paste(
        "SELECT participant_id, icd10_multiple_cause_all
        FROM mortality
        WHERE icd10_multiple_cause_all LIKE '%", mortality_not_statement, "%'", sep = "")

mortality_not_query <- query_to_df(mortality_not_sql, version)
mortality_not_list <- as.list( mortality_not_query$participant_id)
length(mortality_not_list)
```

```
not_death_icd = ['N19', 'N281', 'Q61', 'Q612', 'Q613', 'Q618', 'Q619']

mortality_not_statement = "%' OR icd10_multiple_cause_all LIKE '%".join(not_death_icd)
mortality_not_sql = (
    f'''
    SELECT participant_id, icd10_multiple_cause_all
    FROM mortality
    WHERE icd10_multiple_cause_all LIKE '%{mortality_not_statement}%'
    ''')
mortality_not_query = query_to_df(mortality_not_sql, version)
mortality_not_list = mortality_not_query['participant_id'].tolist()
```

RE LabKey API RRE LabKey API Python

```
not_death_icd = c('N19', 'N281', 'Q61', 'Q612', 'Q613', 'Q618', 'Q619')

mortality_not_statement <- paste((not_death_icd), collapse = "%' OR icd10_multiple_cause_all LIKE '%")

mortality_not_sql <- paste(
        "SELECT participant_id, icd10_multiple_cause_all
        FROM mortality
        WHERE icd10_multiple_cause_all LIKE '%", mortality_not_statement, "%'", sep = "")

mortality_not_query <- query_to_df(mortality_not_sql, gms_version)
mortality_not_list <- as.list( mortality_not_query$participant_id)
length(mortality_not_list)
```

```
not_death_icd = ['N19', 'N281', 'Q61', 'Q612', 'Q613', 'Q618', 'Q619']

mortality_not_statement = "%' OR icd10_multiple_cause_all LIKE '%".join(not_death_icd)
mortality_not_sql = (
    f'''
    SELECT participant_id, icd10_multiple_cause_all
    FROM mortality
    WHERE icd10_multiple_cause_all LIKE '%{mortality_not_statement}%'
    ''')
mortality_not_query = query_to_df(mortality_not_sql, gms_version)
mortality_not_list = mortality_not_query['participant_id'].tolist()
```

#### NOT related cancers

We will exclude all cancer participants with related cancers.

100kGP or main programmeNHS GMS

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
cancer_not_type <- "RENAL"
cancer_not_sql <- paste("SELECT   participant_id, disease_type, study_abbreviation ",
 "FROM cancer_analysis ",
 "WHERE disease_type='", cancer_not_type, "'", sep="")

cancer_not_query <- query_to_df(cancer_not_sql, version)
cancer_not_list <- as.list( cancer_not_query$participant_id)
```

```
cancer_not_type = "RENAL"
cancer_not_sql = (f'''
    SELECT participant_id, disease_type, study_abbreviation
    FROM cancer_analysis
    WHERE disease_type='{cancer_not_type}'
    ''')
cancer_not_query = query_to_df(cancer_not_sql, version)
cancer_not_list = cancer_not_query['participant_id'].tolist()
```

```
cancer_not_type <- "RENAL"
cancer_not_sql <- paste("SELECT   participant_id, disease_type, study_abbreviation ",
 "FROM cancer_analysis ",
 "WHERE disease_type='", cancer_not_type, "'", sep="")

cancer_not_query <- query_to_df(cancer_not_sql, version)
cancer_not_list <- as.list( cancer_not_query$participant_id)
```

```
cancer_not_type = "RENAL"
cancer_not_sql = (f'''
    SELECT participant_id, disease_type, study_abbreviation
    FROM cancer_analysis
    WHERE disease_type='{cancer_not_type}'
    ''')
cancer_not_query = query_to_df(cancer_not_sql, version)
cancer_not_list = cancer_not_query['participant_id'].tolist()
```

RE LabKey API RRE LabKey API Python

```
gms_cancer_not_type <- "Renal"
gms_cancer_not_sql <- paste(
    "SELECT participant_id, clinical_indication_full_name
    FROM cancer_analysis
    WHERE clinical_indication_full_name LIKE '%", gms_cancer_not_type, "%'",
    sep = "")
gms_cancer_not_query <- query_to_df(gms_cancer_not_sql, gms_version)
gms_cancer_not_list = as.list(gms_cancer_not_query$participant_id)
```

```
gms_cancer_not_type = "Renal"
gms_cancer_not_sql = (f'''
    SELECT participant_id, clinical_indication_full_name
    FROM cancer_analysis
    WHERE clinical_indication_full_name LIKE '%{gms_cancer_not_type}%'
    ''')
gms_cancer_not_query = query_to_df(gms_cancer_not_sql, gms_version)
gms_cancer_not_list = gms_cancer_not_query['participant_id'].tolist()
```

#### Combine and exclude

You can now combine all these into a single list. Then pull out all the participants from the `participant` table and remove your exclusion list to give only the participants who do NOT match the criteria. Note that you must pull the whole participant list then excluded afterwards, rather than including your exclusion list in your SQL statement, as this SQL would be too long to be processed.

### Match demographics

You can match on age and sex. To do this, you can the year of birth for the case and control cohorts, and calculate their mean years of birth. You can also pull out the phenotyped and genotyped sex.

100kGP or main programmeNHS GMS

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
case_sql <- paste("SELECT participant_id, yob,
    participant_phenotyped_sex, participant_karyotyped_sex
    FROM participant_summary
    WHERE participant_id IN (", toString(cohort), ")",
    sep = "")
case_query <- unique(query_to_df(case_sql, version))
case_yob_mean = mean(strtoi(case_query$yob))

control_sql <- paste("SELECT participant_id, yob,
    participant_phenotyped_sex, participant_karyotyped_sex
    FROM participant_summary
    WHERE participant_id IN (", toString(control), ")",
    sep = "")
control_query <- unique(query_to_df(control_sql, version))
control_yob_mean = mean(strtoi(control_query$yob))

cat("case mean = ", case_yob_mean, "\ncontrol mean = ", control_yob_mean)

cat("case XX = ", sum(case_query$participant_karyotyped_sex == "XX")/nrow(case_query),
    "\ncase Female = ", sum(case_query$participant_phenotyped_sex == "Female")/nrow(case_query),
    "\ncase XY = ", sum(case_query$participant_karyotyped_sex == "XY")/nrow(case_query),
    "\ncase Male = ", sum(case_query$participant_phenotyped_sex == "Male")/nrow(case_query),
    "\ncontrol XX = ", sum(control_query$participant_karyotyped_sex == "XX")/nrow(control_query),
    "\ncontrol Female = ", sum(control_query$participant_phenotyped_sex == "Female")/nrow(control_query),
    "\ncontrol XY = ", sum(control_query$participant_karyotyped_sex == "XY")/nrow(control_query),
    "\ncontrol Male = ", sum(control_query$participant_phenotyped_sex == "Male")/nrow(control_query))
```

```
from statistics import mean

case_sql = (f'''
    SELECT participant_id, yob,
    participant_phenotyped_sex, participant_karyotyped_sex
    FROM participant_summary
    WHERE participant_id IN {*cohort,}
    ''')
case_query = query_to_df(case_sql, version).drop_duplicates()
case_yob_mean = mean(case_query['yob'].tolist())

control_sql = (f'''
    SELECT participant_id, yob,
    participant_phenotyped_sex, participant_karyotyped_sex
    FROM participant_summary
    WHERE participant_id IN {*control,}
    ''')
control_query = query_to_df(control_sql, version).drop_duplicates()
control_yob_mean = mean(control_query['yob'].tolist())

print("case mean = ", case_yob_mean,
      "\ncontrol mean = ", control_yob_mean)

print("case XX = ", case_query['participant_karyotyped_sex'].value_counts()['XX']/len(case_query),
     "\ncase Female = ", case_query['participant_phenotyped_sex'].value_counts()['Female']/len(case_query),
     "\ncase XY = ", case_query['participant_karyotyped_sex'].value_counts()['XY']/len(case_query),
     "\ncase Male = ", case_query['participant_phenotyped_sex'].value_counts()['Male']/len(case_query),
     "\ncontrol XX = ", control_query['participant_karyotyped_sex'].value_counts()['XX']/len(control_query),
     "\ncontrol Female = ", control_query['participant_phenotyped_sex'].value_counts()['Female']/len(control_query),
     "\ncontrol XY = ", control_query['participant_karyotyped_sex'].value_counts()['XY']/len(control_query),
     "\ncontrol Male = ", control_query['participant_phenotyped_sex'].value_counts()['Male']/len(control_query))
```

```
case_sql <- paste("SELECT participant_id, yob,
    participant_phenotyped_sex, participant_karyotyped_sex
    FROM participant_summary
    WHERE participant_id IN (", toString(cohort), ")",
    sep = "")
case_query <- unique(query_to_df(case_sql, version))
case_yob_mean = mean(strtoi(case_query$yob))

control_sql <- paste("SELECT participant_id, yob,
    participant_phenotyped_sex, participant_karyotyped_sex
    FROM participant_summary
    WHERE participant_id IN (", toString(control), ")",
    sep = "")
control_query <- unique(query_to_df(control_sql, version))
control_yob_mean = mean(strtoi(control_query$yob))

cat("case mean = ", case_yob_mean, "\ncontrol mean = ", control_yob_mean)

cat("case XX = ", sum(case_query$participant_karyotyped_sex == "XX")/nrow(case_query),
    "\ncase Female = ", sum(case_query$participant_phenotyped_sex == "Female")/nrow(case_query),
    "\ncase XY = ", sum(case_query$participant_karyotyped_sex == "XY")/nrow(case_query),
    "\ncase Male = ", sum(case_query$participant_phenotyped_sex == "Male")/nrow(case_query),
    "\ncontrol XX = ", sum(control_query$participant_karyotyped_sex == "XX")/nrow(control_query),
    "\ncontrol Female = ", sum(control_query$participant_phenotyped_sex == "Female")/nrow(control_query),
    "\ncontrol XY = ", sum(control_query$participant_karyotyped_sex == "XY")/nrow(control_query),
    "\ncontrol Male = ", sum(control_query$participant_phenotyped_sex == "Male")/nrow(control_query))
```

```
from statistics import mean

case_sql = (f'''
    SELECT participant_id, yob,
    participant_phenotyped_sex, participant_karyotyped_sex
    FROM participant_summary
    WHERE participant_id IN {*cohort,}
    ''')
case_query = query_to_df(case_sql, version).drop_duplicates()
case_yob_mean = mean(case_query['yob'].tolist())

control_sql = (f'''
    SELECT participant_id, yob,
    participant_phenotyped_sex, participant_karyotyped_sex
    FROM participant_summary
    WHERE participant_id IN {*control,}
    ''')
control_query = query_to_df(control_sql, version).drop_duplicates()
control_yob_mean = mean(control_query['yob'].tolist())

print("case mean = ", case_yob_mean,
      "\ncontrol mean = ", control_yob_mean)

print("case XX = ", case_query['participant_karyotyped_sex'].value_counts()['XX']/len(case_query),
     "\ncase Female = ", case_query['participant_phenotyped_sex'].value_counts()['Female']/len(case_query),
     "\ncase XY = ", case_query['participant_karyotyped_sex'].value_counts()['XY']/len(case_query),
     "\ncase Male = ", case_query['participant_phenotyped_sex'].value_counts()['Male']/len(case_query),
     "\ncontrol XX = ", control_query['participant_karyotyped_sex'].value_counts()['XX']/len(control_query),
     "\ncontrol Female = ", control_query['participant_phenotyped_sex'].value_counts()['Female']/len(control_query),
     "\ncontrol XY = ", control_query['participant_karyotyped_sex'].value_counts()['XY']/len(control_query),
     "\ncontrol Male = ", control_query['participant_phenotyped_sex'].value_counts()['Male']/len(control_query))
```

RE LabKey API RRE LabKey API Python

```
gms_case_sql <- paste("SELECT participant_id, participant_year_of_birth, administrative_gender
    FROM participant
    WHERE participant_id IN ('", paste(gms_case_cohort, collapse = "', '"), "')",
    sep = "")
gms_case_query <- unique(query_to_df(gms_case_sql, gms_version))
gms_case_yob_mean = mean(strtoi(gms_case_query$participant_year_of_birth))

gms_control_sql <- paste("SELECT participant_id, participant_year_of_birth, administrative_gender
    FROM participant
    WHERE participant_id IN ('", paste(gms_control, collapse = "', '"), "')",
    sep = "")
gms_control_query <- unique(query_to_df(gms_control_sql, gms_version))
gms_control_yob_mean = mean(strtoi(gms_control_query$participant_year_of_birth))

cat("case mean = ", gms_case_yob_mean, "\ncontrol mean = ", gms_control_yob_mean)

cat("case Female = ", sum(gms_case_query$administrative_gender == "female")/nrow(gms_case_query),
  "\ncase Male = ", sum(gms_case_query$administrative_gender == "male")/nrow(gms_case_query),
  "\ncontrol Female = ", sum(gms_control_query$administrative_gender == "female")/nrow(gms_control_query),
  "\ncontrol Male = ", sum(gms_control_query$administrative_gender == "male")/nrow(gms_control_query))
```

```
from statistics import mean

gms_case_sql = (f'''
    SELECT participant_id, participant_year_of_birth, administrative_gender
    FROM participant
    WHERE participant_id IN {*gms_case_cohort,}
    ''')
gms_case_query = query_to_df(gms_case_sql, gms_version).drop_duplicates()
gms_case_yob_mean = mean(gms_case_query['participant_year_of_birth'].tolist())

gms_control_sql = (f'''
    SELECT participant_id, participant_year_of_birth, administrative_gender
    FROM participant
    WHERE participant_id IN {*gms_control,}
    ''')
gms_control_query = query_to_df(gms_control_sql, gms_version).drop_duplicates()
gms_control_yob_mean = mean(gms_control_query['participant_year_of_birth'].tolist())

print("case mean = ", gms_case_yob_mean,
      "\ncontrol mean = ", gms_control_yob_mean
     )

print("case Female = ", gms_case_query['administrative_gender'].value_counts()['female']/len(gms_case_query),
     "\ncase Male = ", gms_case_query['administrative_gender'].value_counts()['male']/len(gms_case_query),
     "\ncontrol Female = ", gms_control_query['administrative_gender'].value_counts()['female']/len(gms_control_query),
     "\ncontrol Male = ", gms_control_query['administrative_gender'].value_counts()['male']/len(gms_control_query)
     )
```

Compare the mean years of birth and sex ratios, to see if they are suitably close to continue

To ensure that the cohort is ethnically matched, we will filter to include only a single ethnicity for both case and control. In this case we will use European ethnicity.

100kGP or main programmeNHS GMS

There are three columns on ethnicity: `genetically_inferred_ancestry_thr` which gives the ancestry that the participant has â¥ 0.8 similarity to, `genetically_inferred_ancestry_nothr` the ancestry the participant has the highest similarity and `genetically_inferred_ancestry_value` the value of the highest similarity.

Stated and genomic ethnicity do not necessarily agree, so we recommend using the genomic ethnicity for cohort building.

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
eth <- "European"

case_ethnicity_sql <- paste("SELECT participant_id, genetically_inferred_ancestry_thr
    FROM participant_summary
    WHERE genetically_inferred_ancestry_thr = '", eth, "'
    AND participant_id IN (", toString(cohort), ")", sep ="")
case_ethnicity_query <- unique(query_to_df(case_ethnicity_sql, version))
filtered_case <- case_ethnicity_query$participant_id

control_ethnicity_sql <- paste("SELECT participant_id, genetically_inferred_ancestry_thr
    FROM participant_summary
    WHERE genetically_inferred_ancestry_thr = '", eth, "'
    AND participant_id IN (", toString(control), ")", sep ="")
control_ethnicity_query <- unique(query_to_df(control_ethnicity_sql, version))
filtered_control <- control_ethnicity_query$participant_id
```

```
eth = "European"

case_ethnicity_sql = (f'''
    SELECT participant_id, genetically_inferred_ancestry_thr
    FROM participant_summary
    WHERE genetically_inferred_ancestry_thr = '{eth}'
    AND participant_id IN {*cohort,}
    ''')
case_ethnicity_query = query_to_df(case_ethnicity_sql, version).drop_duplicates()
filtered_case = case_ethnicity_query['participant_id'].tolist()

control_ethnicity_sql = (f'''
    SELECT participant_id, genetically_inferred_ancestry_thr
    FROM participant_summary
    WHERE genetically_inferred_ancestry_thr = '{eth}'
    AND participant_id IN {*control,}
    ''')
control_ethnicity_query = query_to_df(control_ethnicity_sql, version).drop_duplicates()
filtered_control = control_ethnicity_query['participant_id'].tolist()
```

```
eth <- "European"

case_ethnicity_sql <- paste("SELECT participant_id, genetically_inferred_ancestry_thr
    FROM participant_summary
    WHERE genetically_inferred_ancestry_thr = '", eth, "'
    AND participant_id IN (", toString(cohort), ")", sep ="")
case_ethnicity_query <- unique(query_to_df(case_ethnicity_sql, version))
filtered_case <- case_ethnicity_query$participant_id

control_ethnicity_sql <- paste("SELECT participant_id, genetically_inferred_ancestry_thr
    FROM participant_summary
    WHERE genetically_inferred_ancestry_thr = '", eth, "'
    AND participant_id IN (", toString(control), ")", sep ="")
control_ethnicity_query <- unique(query_to_df(control_ethnicity_sql, version))
filtered_control <- control_ethnicity_query$participant_id
```

```
eth = "European"

case_ethnicity_sql = (f'''
    SELECT participant_id, genetically_inferred_ancestry_thr
    FROM participant_summary
    WHERE genetically_inferred_ancestry_thr = '{eth}'
    AND participant_id IN {*cohort,}
    ''')
case_ethnicity_query = query_to_df(case_ethnicity_sql, version).drop_duplicates()
filtered_case = case_ethnicity_query['participant_id'].tolist()

control_ethnicity_sql = (f'''
    SELECT participant_id, genetically_inferred_ancestry_thr
    FROM participant_summary
    WHERE genetically_inferred_ancestry_thr = '{eth}'
    AND participant_id IN {*control,}
    ''')
control_ethnicity_query = query_to_df(control_ethnicity_sql, version).drop_duplicates()
filtered_control = control_ethnicity_query['participant_id'].tolist()
```

We only have stated ethnicity for NHS GMS, not genetic ethnicity.

## General inclusion criteria

We're now going to filter both case and control cohorts by some general criteria. First we will join the two cohorts to a single dataframe with case or control added as column.

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
case_ethnicity_query$case <- "case"
control_ethnicity_query$case <- "control"

case_control_table <- subset( rbind(case_ethnicity_query, control_ethnicity_query), select = c(participant_id, case))
```

```
case_df = pd.DataFrame(filtered_case, columns = ['participant_id'])
case_df['case'] = "case"
control_df = pd.DataFrame(filtered_control, columns = ['participant_id'])
control_df['case'] = "control"

case_control_table = pd.concat([case_df, control_df]).drop_duplicates()
```

```
case_ethnicity_query$case <- "case"
control_ethnicity_query$case <- "control"

case_control_table <- subset( rbind(case_ethnicity_query, control_ethnicity_query), select = c(participant_id, case))
```

```
case_df = pd.DataFrame(filtered_case, columns = ['participant_id'])
case_df['case'] = "case"
control_df = pd.DataFrame(filtered_control, columns = ['participant_id'])
control_df['case'] = "control"

case_control_table = pd.concat([case_df, control_df]).drop_duplicates()
```

### QC filtering

100kGP or main programmeNHS GMS

We will first do some QC filtering. We want to include only participants who are XX or XY and whose phenotyped sex matches their genetic sex. We will include a filter for XX or XY in our SQL query, then drop any rows with XX Male or XY Female.

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
sex_sql <- paste("SELECT participant_id, participant_phenotyped_sex, participant_karyotyped_sex
    FROM participant_summary
    WHERE participant_id IN (",  toString(as.list(case_control_table$participant_id)),
    ") AND (participant_karyotyped_sex = 'XX'
    OR participant_karyotyped_sex = 'XY')", sep= "")

sex_query <- query_to_df(sex_sql, version)

female_query <- subset (sex_query, participant_phenotyped_sex == 'Female' & participant_karyotyped_sex == 'XX')
male_query <- subset (sex_query, participant_phenotyped_sex == 'Male' & participant_karyotyped_sex == 'XY')
sex_list <- c(as.list(female_query$participant_id), as.list(male_query$participant_id))

case_control_table <- filter(case_control_table, participant_id %in% sex_list)
```

```
sex_sql = (f'''
    SELECT participant_id, participant_phenotyped_sex, participant_karyotyped_sex
    FROM participant_summary
    WHERE participant_id IN {*case_control_table['participant_id'].tolist(),}
    AND (participant_karyotyped_sex = 'XX'
    OR participant_karyotyped_sex = 'XY')
    ''')
sex_query = query_to_df(sex_sql, version).drop_duplicates()

sex_query = sex_query.drop(sex_query[ (sex_query['participant_phenotyped_sex'] == 'Male') & (sex_query['participant_karyotyped_sex'] == 'XX') ].index)
sex_query = sex_query.drop(sex_query[ (sex_query['participant_phenotyped_sex'] == 'Female') & (sex_query['participant_karyotyped_sex'] == 'XY') ].index)

case_control_table = case_control_table.loc[
    case_control_table['participant_id'].isin
    (sex_query['participant_id'].tolist())]
```

```
sex_sql <- paste("SELECT participant_id, participant_phenotyped_sex, participant_karyotyped_sex
    FROM participant_summary
    WHERE participant_id IN (",  toString(as.list(case_control_table$participant_id)),
    ") AND (participant_karyotyped_sex = 'XX'
    OR participant_karyotyped_sex = 'XY')", sep= "")

sex_query <- query_to_df(sex_sql, version)

female_query <- subset (sex_query, participant_phenotyped_sex == 'Female' & participant_karyotyped_sex == 'XX')
male_query <- subset (sex_query, participant_phenotyped_sex == 'Male' & participant_karyotyped_sex == 'XY')
sex_list <- c(as.list(female_query$participant_id), as.list(male_query$participant_id))

case_control_table <- filter(case_control_table, participant_id %in% sex_list)
```

```
sex_sql = (f'''
    SELECT participant_id, participant_phenotyped_sex, participant_karyotyped_sex
    FROM participant_summary
    WHERE participant_id IN {*case_control_table['participant_id'].tolist(),}
    AND (participant_karyotyped_sex = 'XX'
    OR participant_karyotyped_sex = 'XY')
    ''')
sex_query = query_to_df(sex_sql, version).drop_duplicates()

sex_query = sex_query.drop(sex_query[ (sex_query['participant_phenotyped_sex'] == 'Male') & (sex_query['participant_karyotyped_sex'] == 'XX') ].index)
sex_query = sex_query.drop(sex_query[ (sex_query['participant_phenotyped_sex'] == 'Female') & (sex_query['participant_karyotyped_sex'] == 'XY') ].index)

case_control_table = case_control_table.loc[
    case_control_table['participant_id'].isin
    (sex_query['participant_id'].tolist())]
```

We will further filter by sample extraction methods. We are interested in samples taken as blood, using EDTA extraction and with PCR-free sequencing.

We will do this using the `aggregate_gvcf_sample_stats` table. This has the added benefit that we will also filter to only include participants included in the AggV2 aggregate VCF files, which may be very useful if you want to use AggV2, which also means all participants have their genomes aligned to GRCh38.

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
aggregate_sql = paste("SELECT participant_id, platekey
    FROM aggregate_gvcf_sample_stats
    WHERE participant_id IN(",  toString(case_control_table$participant_id),
    ") AND sample_source = 'BLOOD'
    AND sample_preparation_method = 'EDTA'
    AND sample_library_type = 'TruSeq PCR-Free High Throughput'", sep = "")
aggregate_query <- query_to_df(aggregate_sql, version)
case_control_table <- unique(merge(case_control_table, aggregate_query))
```

```
aggregate_sql = (f'''
    SELECT participant_id, platekey
    FROM aggregate_gvcf_sample_stats
    WHERE participant_id IN {*case_control_table['participant_id'].tolist(),}
    AND sample_source = 'BLOOD'
    AND sample_preparation_method = 'EDTA'
    AND sample_library_type = 'TruSeq PCR-Free High Throughput'
    ''')
aggregate_query = query_to_df(aggregate_sql, version)
case_control_table = aggregate_query.merge(case_control_table).drop_duplicates()
```

```
aggregate_sql = paste("SELECT participant_id, platekey
    FROM aggregate_gvcf_sample_stats
    WHERE participant_id IN(",  toString(case_control_table$participant_id),
    ") AND sample_source = 'BLOOD'
    AND sample_preparation_method = 'EDTA'
    AND sample_library_type = 'TruSeq PCR-Free High Throughput'", sep = "")
aggregate_query <- query_to_df(aggregate_sql, version)
case_control_table <- unique(merge(case_control_table, aggregate_query))
```

```
aggregate_sql = (f'''
    SELECT participant_id, platekey
    FROM aggregate_gvcf_sample_stats
    WHERE participant_id IN {*case_control_table['participant_id'].tolist(),}
    AND sample_source = 'BLOOD'
    AND sample_preparation_method = 'EDTA'
    AND sample_library_type = 'TruSeq PCR-Free High Throughput'
    ''')
aggregate_query = query_to_df(aggregate_sql, version)
case_control_table = aggregate_query.merge(case_control_table).drop_duplicates()
```

We need to check the relatedness between members of our cohort. To do this we can load the relatedness files that were calculated for the aggregated gVCFs.

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
relatedness_table = read_tsv('/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/additional_data/PCs_relatedness/relatedness/GEL_aggV2_MAF5_mp10_0.0442.kin0')
```

```
relatedness_table = pd.read_csv('/gel_data_resources/main_programme/aggregation/aggregate_gVCF_strelka/aggV2/additional_data/PCs_relatedness/relatedness/GEL_aggV2_MAF5_mp10_0.0442.kin0',sep = '\t')
relatedness_table
```

You will need to mount the following file to your Jupyter session: `GEL data resources > aggregations > gel_mainProgramme > aggV2 > genomic > additional_data > PCs_relatedness > relatedness > GEL_aggV2_MAF5_mp10_0.0442.kin0`

```
relatedness_table = read_tsv('mounted-data/GEL_aggV2_MAF5_mp10_0.0442.kin0')
```

You will need to mount the following file to your Jupyter session: `GEL data resources > aggregations > gel_mainProgramme > aggV2 > genomic > additional_data > PCs_relatedness > relatedness > GEL_aggV2_MAF5_mp10_0.0442.kin0`

```
relatedness_table = pd.read_csv('mounted-data/GEL_aggV2_MAF5_mp10_0.0442.kin0',sep = '\t')
relatedness_table
```

We're going to find all the monozygotic twins in the table by pulling out all of those where kinship is greater than 0.345.

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
mz_twins_table <- relatedness_table %>% filter(KINSHIP > 0.354)
```

```
mz_twins_table = relatedness_table[ (relatedness_table['KINSHIP'] > 0.354) ]
```

```
mz_twins_table <- relatedness_table %>% filter(KINSHIP > 0.354)
```

```
mz_twins_table = relatedness_table[ (relatedness_table['KINSHIP'] > 0.354) ]
```

Now we need to identify if any of these twins are in our cohort. If they are, we need to determine if either or both of the twins are affected by the phenotype of interest. If one of them is, we will keep that twin in our case cohort and discard the other. If both are affected, we will discard one at random.

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
twins_list <- split((mz_twins_table %>% select('IID1','IID2')), seq(nrow(mz_twins_table %>% select('IID1','IID2'))))

case_control_list <- as.list(case_control_table$platekey)

for (twins in twins_list) {
  if (twins$IID1 %in% case_control_list) {
    row <- case_control_table[case_control_table$platekey == twins$IID1 ,]
    if (row$case == 'case'){
      case_control_table <- case_control_table[case_control_table$platekey != twins$IID2,]

    }
  } else if (twins$IID2 %in% case_control_list){
    row <- case_control_table[case_control_table$platekey == twins$IID2 ,]
    if (row$case == 'case'){
      case_control_table <- case_control_table[case_control_table$platekey != twins$IID1,]
    }
  }
}
```

```
twins_list = mz_twins_table[['IID1', 'IID2']].values.tolist()

case_control_list = case_control_table['platekey'].tolist()

for twins in twins_list:
    if twins[0] in case_control_list:
        if (case_control_table.query('platekey == @twins[0]')['case']).values == 'case':
            case_control_table = case_control_table.drop(case_control_table[case_control_table['platekey'] == twins[1]].index)
            print (twins[1])
    elif twins[1] in case_control_list:
        if (case_control_table.query('platekey == @twins[1]')['case']).values == 'case':
            case_control_table = case_control_table.drop(case_control_table[case_control_table['platekey'] == twins[0]].index)
            print(twins[0])
```

```
twins_list <- split((mz_twins_table %>% select('IID1','IID2')), seq(nrow(mz_twins_table %>% select('IID1','IID2'))))

case_control_list <- as.list(case_control_table$platekey)

for (twins in twins_list) {
  if (twins$IID1 %in% case_control_list) {
    row <- case_control_table[case_control_table$platekey == twins$IID1 ,]
    if (row$case == 'case'){
      case_control_table <- case_control_table[case_control_table$platekey != twins$IID2,]

    }
  } else if (twins$IID2 %in% case_control_list){
    row <- case_control_table[case_control_table$platekey == twins$IID2 ,]
    if (row$case == 'case'){
      case_control_table <- case_control_table[case_control_table$platekey != twins$IID1,]
    }
  }
}
```

```
twins_list = mz_twins_table[['IID1', 'IID2']].values.tolist()

case_control_list = case_control_table['platekey'].tolist()

for twins in twins_list:
    if twins[0] in case_control_list:
        if (case_control_table.query('platekey == @twins[0]')['case']).values == 'case':
            case_control_table = case_control_table.drop(case_control_table[case_control_table['platekey'] == twins[1]].index)
            print (twins[1])
    elif twins[1] in case_control_list:
        if (case_control_table.query('platekey == @twins[1]')['case']).values == 'case':
            case_control_table = case_control_table.drop(case_control_table[case_control_table['platekey'] == twins[0]].index)
            print(twins[0])
```

Sampling type is consistent across NHS GMS so we do not need to filter by this.

### Consent status

100kGP or main programmeNHS GMS

You must filter participants in your analysis to ensure they all have active consent for research. To do this, use the `programme_consent_status` column of the `participant` table in the 100kGP. Here is example SQL using a participant\_id list called `list`.

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
consent_sql <- paste("SELECT
    participant_id, programme_consent_status
    FROM participant
    WHERE programme_consent_status = 'Consenting'
    AND participant_id IN (", list, ")",
    sep="")
consent_query <- query_to_df(consent_sql, version)
```

```
consent_sql = (f'''
    SELECT participant_id, programme_consent_status
    FROM participant
    WHERE programme_consent_status = 'Consenting'
    AND participant_id IN {list}
''')
consent_query = query_to_df(consent_sql, version)
```

```
consent_sql <- paste("SELECT
    participant_id, programme_consent_status
    FROM participant
    WHERE programme_consent_status = 'Consenting'
    AND participant_id IN (", list, ")",
    sep="")
consent_query <- query_to_df(consent_sql, version)
```

```
consent_sql = (f'''
    SELECT participant_id, programme_consent_status
    FROM participant
    WHERE programme_consent_status = 'Consenting'
    AND participant_id IN {list}
''')
consent_query = query_to_df(consent_sql, version)
```

We do not currently have participants who have withdrawn consent in NHS GMS.

## Filepaths

For many kinds of downstream analysis, you may wish to work with the genome files for that individual, such as the genomic VCFs. If you're working with the aggregate VCFs, you will need the platekeys.

In this query, we're going to get the platekey and filepath of the gVCF for these participants.

100kGP or main programmeNHS GMS

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
filetype <- "Genomic VCF"

path_sql <- paste("SELECT participant_id,
      platekey, filename, file_path
    FROM genome_file_paths_and_types
    WHERE participant_id IN (", toString(case_control_table$participant_id), ")
    AND file_sub_type = '", filetype, "'" , sep="")

path_query <- query_to_df(path_sql, version)
case_control_table_paths <- merge(case_control_table, path_query)
```

```
filetype = "Genomic VCF"

path_sql = (f'''
    SELECT participant_id, platekey, filename, file_path
    FROM genome_file_paths_and_types
    WHERE participant_id IN {*case_control_table['participant_id'].tolist(),}
    AND file_sub_type = '{filetype}'
''')

path_query = query_to_df(path_sql, version)
case_control_paths = path_query.merge(case_control_table)
```

```
filetype <- "Genomic VCF"

path_sql <- paste("SELECT participant_id,
      platekey, filename, file_path
    FROM genome_file_paths_and_types
    WHERE participant_id IN (", toString(case_control_table$participant_id), ")
    AND file_sub_type = '", filetype, "'" , sep="")

path_query <- query_to_df(path_sql, version)
case_control_table_paths <- merge(case_control_table, path_query)
```

```
filetype = "Genomic VCF"

path_sql = (f'''
    SELECT participant_id, platekey, filename, file_path
    FROM genome_file_paths_and_types
    WHERE participant_id IN {*case_control_table['participant_id'].tolist(),}
    AND file_sub_type = '{filetype}'
''')

path_query = query_to_df(path_sql, version)
case_control_paths = path_query.merge(case_control_table)
```

RE LabKey API RRE LabKey API Python

```
filetype <- "Genomic VCF"

gms_path_sql <- paste("SELECT participant_id,
      platekey, filename, path
    FROM genome_file_paths_and_types
    WHERE participant_id IN ('", paste(gms_case_control_table$participant_id, collapse = "', '"), "')
    AND file_sub_type = '", filetype, "'" , sep="")

gms_path_query <- query_to_df(gms_path_sql, gms_version)
gms_case_control_table_paths <- merge(gms_case_control_table, gms_path_query)
```

```
filetype = "Genomic VCF"

gms_path_sql = (f'''
    SELECT participant_id, platekey, filename, path
    FROM genome_file_paths_and_types
    WHERE participant_id IN {*gms_case_control_table['participant_id'].tolist(),}
    AND file_sub_type = '{filetype}'
''')

gms_path_query = query_to_df(gms_path_sql, gms_version)
gms_case_control_paths = gms_path_query.merge(gms_case_control_table)
```

## Input for GWAS and AVT workflows

Both the [GWAS](../gwas/) and [AVT](../avt/) workflows require a phenofile. This is a space or tab separated text file with the sample information, with headers. We can create this from our case/control cohort that we have created here.

The phenoFile must include a minimum of three columns: platekey, sex specification (`0` for male, `1` for female) and phenotype specification (`0` for control, `1` for cases). It can optionally also include other columns to specify other covariates, such as age and principal components.Â

In the following example, we will use the `case_control_table` we created earlier for our cohort, the year of birth query to get age, and the `aggregate_gvcf_sample_stats` table to get sex and covariate information.

100kGP or main programmeNHS GMS

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
covariates_sql <- paste("SELECT agss.participant_id, agss.platekey, (YEAR(CURDATE()) - ps.yob) as age, agss.karyotype,
    agss.pc1, agss.pc2, agss.pc3, agss.pc4, agss.pc5, agss.pc6, agss.pc7, agss.pc8, agss.pc9, agss.pc10, agss.pc11, agss.pc12, agss.pc13, agss.pc14, agss.pc15, agss.pc16, agss.pc17, agss.pc18, agss.pc19, agss.pc20,
    FROM aggregate_gvcf_sample_stats as agss
    participant_summary as ps
    WHERE agss.participant_id IN (", toString(case_control_table$participant_id), ")
    AND agss.participant_id = ps.participant_id" , sep="")

covariates_query <- query_to_df(covarates_sql, version)
case_control_covariates <- merge(case_control_table, covariates_query)

case_control_covariates[case_control_covariates == "XX"] <- "1"
case_control_covariates[case_control_covariates == "XY"] <- "0"
case_control_covariates[case_control_covariates == "case"] <- "1"
case_control_covariates[case_control_covariates == "control"] <- "0"

write_tsv(case_control_covariates, path = "phenofile.tsv")
```

```
covariates_sql = (f'''
    SELECT agss.participant_id, agss.platekey, (YEAR(CURDATE()) - ps.yob) as age, agss.karyotype,
    agss.pc1, agss.pc2, agss.pc3, agss.pc4, agss.pc5, agss.pc6, agss.pc7, agss.pc8, agss.pc9, agss.pc10, agss.pc11, agss.pc12, agss.pc13, agss.pc14, agss.pc15, agss.pc16, agss.pc17, agss.pc18, agss.pc19, agss.pc20,
    FROM aggregate_gvcf_sample_stats as agss,
    participant_summary as ps
    WHERE agss.participant_id IN {*case_control_table['participant_id'].tolist(),}
    AND agss.participant_id = ps.participant_id
''')

covariates_query = query_to_df(covariates_sql, version)
case_control_covariates = covariates_query.merge(case_control_table)

case_control_covariates['karyotype'].replace('XX', '1', inplace=True)
case_control_covariates['karyotype'].replace('XY', '0', inplace=True)
case_control_covariates['case'].replace('case', '1', inplace=True)
case_control_covariates['case'].replace('control', '0', inplace=True)

case_control_covariates.to_csv('phenofile.tsv', sep="\t")
```

```
covariates_sql <- paste("SELECT agss.participant_id, agss.platekey, (YEAR(CURDATE()) - kc.yob) as age, agss.karyotype,
  agss.pc1, agss.pc2, agss.pc3, agss.pc4, agss.pc5, agss.pc6, agss.pc7, agss.pc8, agss.pc9, agss.pc10, agss.pc11, agss.pc12, agss.pc13, agss.pc14, agss.pc15, agss.pc16, agss.pc17, agss.pc18, agss.pc19, agss.pc20,
  FROM aggregate_gvcf_sample_stats as agss
  AND participant_summary as kc
  WHERE agss.participant_id IN (", toString(case_control_table$participant_id), ")
  AND agss.participant_id = kc.participant_id" , sep="")

covariates_query <- query_to_df(covarates_sql, version)
case_control_covariates <- merge(case_control_table, covariates_query)

case_control_covariates[case_control_covariates == "XX"] <- "1"
case_control_covariates[case_control_covariates == "XY"] <- "0"
case_control_covariates[case_control_covariates == "case"] <- "1"
case_control_covariates[case_control_covariates == "control"] <- "0"

write_tsv(case_control_covariates, path = "phenofile.tsv")
```

```
covariates_sql = (f'''
    SELECT agss.participant_id, agss.platekey, (YEAR(CURDATE()) - ps.yob) as age, agss.karyotype,
    agss.pc1, agss.pc2, agss.pc3, agss.pc4, agss.pc5, agss.pc6, agss.pc7, agss.pc8, agss.pc9, agss.pc10, agss.pc11, agss.pc12, agss.pc13, agss.pc14, agss.pc15, agss.pc16, agss.pc17, agss.pc18, agss.pc19, agss.pc20,
    FROM aggregate_gvcf_sample_stats as agss,
    participant_summary as ps
    WHERE agss.participant_id IN {*case_control_table['participant_id'].tolist(),}
    AND agss.participant_id = ps.participant_id
''')

covariates_query = query_to_df(covariates_sql, version)
case_control_covariates = covariates_query.merge(case_control_table)

case_control_covariates['karyotype'].replace('XX', '1', inplace=True)
case_control_covariates['karyotype'].replace('XY', '0', inplace=True)
case_control_covariates['case'].replace('case', '1', inplace=True)
case_control_covariates['case'].replace('control', '0', inplace=True)

case_control_covariates.to_csv('phenofile.tsv', sep="\t")
```

It is not currently possible to run the GWAS or AVT workflows with NHS GMS data.

February 3, 2026
