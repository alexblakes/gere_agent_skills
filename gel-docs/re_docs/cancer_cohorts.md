---
title: 'Building cancer cohorts programmatically - Genomics England Research Environment User Guide'
source_url: https://re-docs.genomicsengland.co.uk/cancer_cohorts/
scraped_at: 2026-05-04T06:31:29Z
---

# Building cancer cohorts programmatically

[Give us feedback on this tutorial](https://www.smartsurvey.co.uk/s/OO0DH4/)

There are a huge number of tables that you can use to build rare disease cohorts. This tutorial will take you through some of the tables and give you some example scripts that you can use in python or R, or using R in an interactive session on CloudOS, to access the data.

The advantage of building cohorts programmatically is that the underlying tables are exposed, allowing you to verify the data in bulk. This also allows you to do very complex queries. You can save and tweak scripts to re-use in new releases or for similar queries.

## Tables to query

To build cohorts, you might query the following tables:

100kGP or main programmeNHS GMS

| Table | Field | Details |
| --- | --- | --- |
| `cancer_analysis` | `disease_type` | Find participants recruited for a cancer type |
| `hes_op`, `hes_apc`, `hes_ae` | `diag_all` | All diagnoses from hospital episode statistics as ICD10 codes |
| `cancer_staging_consolidated` | `diagnosis_date`, `grade`, `component_tnm_t`, `component_tnm_n`, `component_tnm_m`, `ajcc_stage`, `dukes`, `figo`, `gleason_primary`, `gleason_combined` | Find staging and grading details. Since participants can have multiple tumours, double-check the `diagnosis_date` against the `cancer_analysis.tumour_clinical_sample_time` |
| `av_tumour` | `er_status`, `pr_status`, `her2_status` | Hormone status of female cancers |
| `cancer_participant_tumour_metastatic_site` | `metastatic_site` |  |
| `cancer_registry` | `cancer_site` | Cancers as ICD10 codes |
| `sact` | `analysis_group`, `drug_group` | Chemotherapy drugs |
| `rtds` |  | Radiotherapy treatment |
| `av_treatment` |  | Details of surgery |
| `av_imd` | `imd` | Deprivation index |
| `cancer_risk_factor_general` |  | risk factors for cancer |
| `cancer_risk_factor_cancer_specific` |  | risk factors for specific cancer types |
| `participant_summary` | `yob`, `genetically_inferred_ancestry_thr`, `participant_karyotyped_sex` | Age, ethnicity and sex |
| `aggregate_gvcf_sample_stats` | `sample_source`, `sample_preparation_method`, `sample_library_type` | Filter by sampling details |
| `genome_file_paths_and_types` | `platekey`, `filename`, `file_path`, `file_sub_type` | Get paths for genomic files |

| Table | Field | Details |
| --- | --- | --- |
| `cancer_analysis` | `clinical_indication_full_name` | Find participants recruited for a cancer type |
| `hes_op`, `hes_apc`, `hes_ae` | `diag_all` | All diagnoses from hospital episode statistics as ICD10 codes |
| `av_tumour` | `diagnosisdatebest`, `grade`, `dukes`, `figo`, `gleason_primary`, `gleason_combined`, `t_best`, `n_best`, `m_best`, `er_status`, `pr_status`, `her2_status` | Find staging, grading and hormone status. Since participants can have multiple tumours, double-check the `diagnosis_date` against the `cancer_analysis.tumour_clinical_sample_time` |
| `sact` | `analysis_group`, `drug_group` | Chemotherapy drugs |
| `rtds` |  | Radiotherapy treatment |
| `av_treatment` |  | Details of surgery |
| `av_imd` | `imd` | Deprivation index |
| `participant` | `participant_year_of_birth`, `ethnicity_description`, `administrative_gender` | Age, ethnicity and sex |
| `genome_file_paths_and_types` | `platekey`, `filename`, `path`, `file_sub_type` | Get paths for genomic files |

## Contents:

- [Import modules/libraries you need](#modules)
- [Helper function to access the LabKey API](#helper)
- [Cancer recruited disease](#rec)
  - [Recruited disease](#rec1)
  - [Confirming the diagnosis](#conf)
- [Cancer characteristics](#char)
  - [Staging](#stage)
  - [Hormone status](#hormone)
  - [Metastases](#meta)
- [Cancer treatment](#treat)
  - [Chemotherapy and immunotherapy](#chem)
  - [Radiotherapy](#radio)
  - [Surgery](#surg)
- [Demographics](#demo)
  - [Deprivation and ethnicity](#dep)
  - [Risk factors](#risk)
- [Age](#age)
- [Consent status](#consent)
- [Outputs](#file)

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

## Cancer recruited disease

### Recruited disease

For cancer cohorts, the simplest way and main start point for building a cohort is to search by the recruited cancer type. This can be found in the `cancer_analysis` table.

100kGP or main programmeNHS GMS

The following code creates the required SQL query to find all participants in the `cancer_analysis` table with the `disease_type` listed as `BREAST`. Then, it runs the `query_to_df` function defined above to get a dataframe. In the code, we've defined the cancer type as an object, making it easy for you to change it to your cancer of interest.

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
type <- "BREAST"
cancer_type <- paste("SELECT   participant_id, disease_type, study_abbreviation ",
 "FROM cancer_analysis ",
 "WHERE disease_type='", type, "'", sep="")

 cancer_query <- query_to_df(cancer_type, version)
```

```
type = "BREAST"

cancer_type = (f'''
    SELECT participant_id, disease_type, study_abbreviation
    FROM cancer_analysis
    WHERE disease_type='{type}'
    ''')

cancer_query = query_to_df(cancer_type, version)
```

```
type <- "BREAST"
cancer_type <- paste("SELECT   participant_id, disease_type, study_abbreviation ",
 "FROM cancer_analysis ",
 "WHERE disease_type='", type, "'", sep="")

 cancer_query <- query_to_df(cancer_type, version)
```

```
type = "BREAST"

cancer_type = (f'''
    SELECT participant_id, disease_type, study_abbreviation
    FROM cancer_analysis
    WHERE disease_type='{type}'
    ''')

cancer_query = query_to_df(cancer_type, version)
```

The following code creates the required SQL query to find all participants in the `cancer_analysis` table with the `clinical_indication_full_name` including the word `Breast`. Then, it runs the `query_to_df` function defined above to get a dataframe. In the code, we've defined the cancer type as an object, making it easy for you to change it to your cancer of interest.

RE LabKey API RRE LabKey API Python

```
type <- "Breast"
gms_cancer_type <- paste("SELECT participant_id, clinical_indication_full_name, tumour_uid
    FROM cancer_analysis
    WHERE clinical_indication_full_name LIKE'%", type, "%'", sep="")
gms_cancer_query <- query_to_df(gms_cancer_type, gms_version)
```

```
type = "Breast"

gms_cancer_type = (f'''
    SELECT participant_id, clinical_indication_full_name, tumour_uid
    FROM cancer_analysis
    WHERE clinical_indication_full_name LIKE '%{type}%'
    ''')
gms_cancer_query = query_to_df(gms_cancer_type, gms_version)
```

This query will not get you all participants who have had breast cancer, since some participants may have had multiple cancers in their lifetimes. It also may not be 100% accurate due to flaws in the way the data was curated into the database.

### Confirming the diagnosis

We recommend that you check any recruited cancer against the diagnosis codes in the participants' health records.

The diagnosis codes are found in the hes tables:

- `hes_apc`: Admitted patient care
- `hes_op`: Outpatients
- `hes_ae`: Accident and emergency

These tables all contain columns named diag\_all, which contains [ICD10 codes](../clinical_data/) for the diagnoses the participant received on these hospital visits. You can find all relevant ICD10 codes for your disease of interest on the [WHO ICD website](https://icd.who.int/browse10/2016/en).

Here's an example of how you can search for a code for breast cancer, checking against all the hes tables which have been pre-filtered using a list of participant IDs named `participant` (perhaps the participant IDs from the previous query).

100kGP or main programmeNHS GMS

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
hes_tables <- c("apc", "op", "ae")
icd_code <- "C50"

concatenated <- c()

for (hes_table in hes_tables) {
  sqlstr <- paste("SELECT participant_id ",
                  "FROM hes_", hes_table,
                  " WHERE participant_id IN (", participant, ")",
                  " AND diag_all LIKE '%", icd_code, "%'",
                  sep = "")

  filtered_participants <- query_to_df(sqlstr, version)
  if (nrow(filtered_participants) > 0) {
    concatenated <- append(concatenated, filtered_participants$participant_id) }
}
new_participants <- unique(concatenated)
```

```
hes_tables = ["apc", "op", "ae"]
icd_code = 'C50'

concatenated = []

for hes_table in hes_tables:
    sqlstr = (
        f'''
        SELECT participant_id
        FROM hes_{hes_table}
        WHERE participant_id IN {*participant,}
        AND diag_all LIKE '%{icd_code}%'
        '''
    )
    filtered_participants = query_to_df(sqlstr, version)
    if not filtered_participants.empty:
        concatenated += list(filtered_participants['participant_id'])

new_participants = np.unique(concatenated)
```

```
hes_tables <- c("apc", "op", "ae")
icd_code <- "C50"

concatenated <- c()

for (hes_table in hes_tables) {
  sqlstr <- paste("SELECT participant_id ",
                  "FROM hes_", hes_table,
                  " WHERE participant_id IN (", participant, ")",
                  " AND diag_all LIKE '%", icd_code, "%'",
                  sep = "")

  filtered_participants <- query_to_df(sqlstr, version)
  if (nrow(filtered_participants) > 0) {
    concatenated <- append(concatenated, filtered_participants$participant_id) }
}
new_participants <- unique(concatenated)
```

```
hes_tables = ["apc", "op", "ae"]
icd_code = 'C50'

concatenated = []

for hes_table in hes_tables:
    sqlstr = (
        f'''
        SELECT participant_id
        FROM hes_{hes_table}
        WHERE participant_id IN {*participant,}
        AND diag_all LIKE '%{icd_code}%'
        '''
    )
    filtered_participants = query_to_df(sqlstr, version)
    if not filtered_participants.empty:
        concatenated += list(filtered_participants['participant_id'])

new_participants = np.unique(concatenated)
```

RE LabKey API RRE LabKey API Python

```
hes_tables <- c("apc", "op", "ae")
icd_code <- "C50"

concatenated <- c()

for (hes_table in hes_tables) {
  sqlstr <- paste("SELECT participant_id ",
                  "FROM hes_", hes_table,
                  " WHERE participant_id IN ('", paste(participant, collapse = "', '"),
                  "') AND diag_all LIKE '%", icd_code, "%'",
                  sep = "")

  filtered_participants <- query_to_df(sqlstr, gms_version)
  if (nrow(filtered_participants) > 0) {
    concatenated <- append(concatenated, filtered_participants$participant_id) }
}
new_participants <- unique(concatenated)
```

```
hes_tables = ["apc", "op", "ae"]
icd_code = 'C50'

concatenated = []

for hes_table in hes_tables:
    sqlstr = (
        f'''
        SELECT participant_id
        FROM hes_{hes_table}
        WHERE participant_id IN {*participant,}
        AND diag_all LIKE '%{icd_code}%'
        '''
    )
    filtered_participants = query_to_df(sqlstr, gms_version)
    if not filtered_participants.empty:
        concatenated += list(filtered_participants['participant_id'])

new_participants = np.unique(concatenated)
```

## Cancer characteristics

The data from the National Cancer Registration and Analysis Service (NCRAS) contains information on hormonal status, stage and diagnosis dates. We can find these data in the `av_tumour` table.

> **Note:**
>
> Some participants have multiple tumour samples sequenced. It is good practice to match `diagnosisdatebest` from `av_tumour` with `tumour_clinicial_sample_time` from `cancer_analysis` when merging data.

100kGP or main programmeNHS GMS

### Staging

We can find the grading and stage of cancers in the `cancer_staging_consolidated` table, which contains details of:

- AJCC
- FIGO
- Dukes
- Gleason
- TNM

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
staging_sql <- paste("SELECT
        ca.participant_id,
        ca.tumour_sample_platekey,
        ca.disease_type,
        ca.tumour_clinical_sample_time,
        csc.diagnosis_date,
        csc.grade,
        csc.component_tnm_t,
        csc.component_tnm_n,
        csc.component_tnm_m,
        csc.ajcc_stage,
        csc.dukes,
        csc.figo,
        csc.gleason_primary,
        csc.gleason_combined
    FROM cancer_analysis ca
    INNER JOIN cancer_staging_consolidated csc
    ON ca.participant_id = csc.participant_id
    AND csc.diagnosis_date =
                (
                SELECT
                    MAX(csc_e.diagnosis_date)
                FROM
                    cancer_staging_consolidated csc_e
                WHERE
                    csc_e.participant_id = csc.participant_id
                    AND
                    ca.tumour_clinical_sample_time >= csc_e.diagnosis_date
                )
    WHERE ca.participant_id IN (", participant, ")",
    sep="")

staging_query <- query_to_df(staging_sql, version)
```

```
staging_sql = (f'''
    SELECT
      ca.participant_id,
      ca.tumour_sample_platekey,
      ca.disease_type,
      ca.tumour_clinical_sample_time,
      csc.diagnosis_date,
      csc.grade,
      csc.component_tnm_t,
      csc.component_tnm_n,
      csc.component_tnm_m,
      csc.ajcc_stage,
      csc.dukes,
      csc.figo,
      csc.gleason_primary,
      csc.gleason_combined
    FROM cancer_analysis ca
    INNER JOIN cancer_staging_consolidated csc
    ON ca.participant_id = csc.participant_id
    AND csc.diagnosis_date =
                (
                SELECT
                    MAX(csc_e.diagnosis_date)
                FROM
                    cancer_staging_consolidated csc_e
                WHERE
                    csc_e.participant_id = csc.participant_id
                    AND
                    ca.tumour_clinical_sample_time >= csc_e.diagnosis_date
                )
    WHERE ca.participant_id IN {*bc_participant,}
    ''')

staging_query = query_to_df(staging_sql, version)
```

```
staging_sql <- paste("SELECT
        ca.participant_id,
        ca.tumour_sample_platekey,
        ca.disease_type,
        ca.tumour_clinical_sample_time,
        csc.diagnosis_date,
        csc.grade,
        csc.component_tnm_t,
        csc.component_tnm_n,
        csc.component_tnm_m,
        csc.ajcc_stage,
        csc.dukes,
        csc.figo,
        csc.gleason_primary,
        csc.gleason_combined
    FROM cancer_analysis ca
    INNER JOIN cancer_staging_consolidated csc
    ON ca.participant_id = csc.participant_id
    AND csc.diagnosis_date =
                (
                SELECT
                    MAX(csc_e.diagnosis_date)
                FROM
                    cancer_staging_consolidated csc_e
                WHERE
                    csc_e.participant_id = csc.participant_id
                    AND
                    ca.tumour_clinical_sample_time >= csc_e.diagnosis_date
                )
    WHERE ca.participant_id IN (", participant, ")",
    sep="")

staging_query <- query_to_df(staging_sql, version)
```

```
staging_sql = (f'''
    SELECT
      ca.participant_id,
      ca.tumour_sample_platekey,
      ca.disease_type,
      ca.tumour_clinical_sample_time,
      csc.diagnosis_date,
      csc.grade,
      csc.component_tnm_t,
      csc.component_tnm_n,
      csc.component_tnm_m,
      csc.ajcc_stage,
      csc.dukes,
      csc.figo,
      csc.gleason_primary,
      csc.gleason_combined
    FROM cancer_analysis ca
    INNER JOIN cancer_staging_consolidated csc
    ON ca.participant_id = csc.participant_id
    AND csc.diagnosis_date =
                (
                SELECT
                    MAX(csc_e.diagnosis_date)
                FROM
                    cancer_staging_consolidated csc_e
                WHERE
                    csc_e.participant_id = csc.participant_id
                    AND
                    ca.tumour_clinical_sample_time >= csc_e.diagnosis_date
                )
    WHERE ca.participant_id IN {*bc_participant,}
    ''')

staging_query = query_to_df(staging_sql, version)
```

This query works if the list of participant IDs is quite short, however there is a limit on the size of an SQL string. If you have a large number of IDs, this query may fail; we recommend fetching the whole table without filtering then subsetting the table afterwards.

### Hormone status

We can also assess oestrogen receptor (ER), progesterone receptor (PR), and HER2 status of our breast cancer samples.

The following SQL query fetches data from the `av_tumour` table, matching to the `cancer_analysis` table by the `participant_id`, filtering by a list of participant IDs called `participant`.

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
hormone_sql <- paste("SELECT
        ca.participant_id,
        ca.tumour_sample_platekey,
        ca.disease_type,
        av.anon_tumour_id,
        av.er_status,
        av.pr_status,
        av.her2_status
    FROM cancer_analysis ca
    INNER JOIN av_tumour av
    ON ca.participant_id = av.participant_id
    WHERE ca.participant_id IN (", bc_participant, ")",
    sep= "")

hormone_query <- query_to_df(hormone_sql, version)
```

```
hormone_sql = (f'''
    SELECT
        ca.participant_id,
        ca.tumour_sample_platekey,
        ca.disease_type,
        av.anon_tumour_id,
        av.er_status,
        av.pr_status,
        av.her2_status
    FROM cancer_analysis ca
    INNER JOIN av_tumour av
    ON ca.participant_id = av.participant_id
    WHERE ca.participant_id IN {*bc_participant,}
    ''')

hormone_query = query_to_df(hormone_sql, version)
```

```
hormone_sql <- paste("SELECT
        ca.participant_id,
        ca.tumour_sample_platekey,
        ca.disease_type,
        av.tumour_pseudo_id,
        av.er_status,
        av.pr_status,
        av.her2_status
    FROM cancer_analysis ca
    INNER JOIN av_tumour av
    ON ca.participant_id = av.participant_id
    WHERE ca.participant_id IN (", bc_participant, ")",
    sep= "")

hormone_query <- query_to_df(hormone_sql, version)
```

```
hormone_sql = (f'''
    SELECT
        ca.participant_id,
        ca.tumour_sample_platekey,
        ca.disease_type,
        av.anon_tumour_id,
        av.er_status,
        av.pr_status,
        av.her2_status
    FROM cancer_analysis ca
    INNER JOIN av_tumour av
    ON ca.participant_id = av.participant_id
    WHERE ca.participant_id IN {*bc_participant,}
    ''')

hormone_query = query_to_df(hormone_sql, version)
```

### Metastases

We will now query the `cancer_participant_tumour_metastatic_site` table to find participants in our cohort whose tumours have metastasised.

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
metastases_sql <- paste("SELECT participant_id, metastatic_site
    FROM cancer_participant_tumour_metastatic_site
    WHERE participant_id IN (", bc_participant, ")", sep = "")

metastases_query <- query_to_df(metastases_sql, version)
```

```
metastases_sql = ( f'''
    SELECT participant_id, metastatic_site
    FROM cancer_participant_tumour_metastatic_site
    WHERE participant_id IN {*bc_participant,}
    ''')

metastases_query = query_to_df(metastases_sql, version)
```

```
metastases_sql <- paste("SELECT participant_id, metastatic_site
    FROM cancer_participant_tumour_metastatic_site
    WHERE participant_id IN (", bc_participant, ")", sep = "")

metastases_query <- query_to_df(metastases_sql, version)
```

```
metastases_sql = ( f'''
    SELECT participant_id, metastatic_site
    FROM cancer_participant_tumour_metastatic_site
    WHERE participant_id IN {*bc_participant,}
    ''')

metastases_query = query_to_df(metastases_sql, version)
```

This is unlikely to find all the participants whose tumours have metastasised as the `cancer_participant_tumour_metastatic_site` table is not complete. You can supplement this query by looking for ICD-10 codes for metastases in the hospital episode statistics tables, or looking at the `cancer_registry` table. Extra care is needed to differentiate between metastasis, new primary tumours or recurrence of the primary tumour.

The query below searches the `hes_*` tables for ICD-10 codes associated with metastasis: C76-C80. It then concatenates these into a single table.

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
meta_codes <- c('C76', 'C77', 'C78', 'C79', 'C80')
hes_tables <- c("apc", "op", "ae")

meta_concat <- data.frame()

diag_statement <- paste(meta_codes, collapse = "%' OR diag_all LIKE '%")

for (hes_table in hes_tables) {
  sqlstr <- paste("SELECT participant_id, diag_all ",
      "FROM hes_", hes_table,
      " WHERE participant_id IN (", bc_participant, ")",
      " AND diag_all LIKE '%", diag_statement, "%'",
      sep = "")
    meta_hes <- query_to_df(sqlstr, version)
    if (nrow(meta_hes) > 0) {
    meta_concat <- rbind(meta_concat, meta_hes)
    }
}
```

```
meta_codes = ['C76', 'C77', 'C78', 'C79', 'C80']
hes_tables = ["apc", "op", "ae"]

meta_concat = pd.DataFrame()

diag_statement = "%' OR diag_all LIKE '%".join(meta_codes)

for hes_table in hes_tables:
    sqlstr = (
        f'''
        SELECT participant_id, diag_all
        FROM hes_{hes_table}
        WHERE participant_id IN {*bc_participant,}
        AND diag_all LIKE '%{diag_statement}%'
        ''')
    meta_hes = query_to_df(sqlstr, version)
    if not meta_hes.empty:
        meta_concat = pd.concat([meta_hes, meta_concat])
```

```
meta_codes <- c('C76', 'C77', 'C78', 'C79', 'C80')
hes_tables <- c("apc", "op", "ae")

meta_concat <- data.frame()

diag_statement <- paste(meta_codes, collapse = "%' OR diag_all LIKE '%")

for (hes_table in hes_tables) {
  sqlstr <- paste("SELECT participant_id, diag_all ",
      "FROM hes_", hes_table,
      " WHERE participant_id IN (", bc_participant, ")",
      " AND diag_all LIKE '%", diag_statement, "%'",
      sep = "")
    meta_hes <- query_to_df(sqlstr, version)
    if (nrow(meta_hes) > 0) {
    meta_concat <- rbind(meta_concat, meta_hes)
    }
}
```

```
meta_codes = ['C76', 'C77', 'C78', 'C79', 'C80']
hes_tables = ["apc", "op", "ae"]

meta_concat = pd.DataFrame()

diag_statement = "%' OR diag_all LIKE '%".join(meta_codes)

for hes_table in hes_tables:
    sqlstr = (
        f'''
        SELECT participant_id, diag_all
        FROM hes_{hes_table}
        WHERE participant_id IN {*bc_participant,}
        AND diag_all LIKE '%{diag_statement}%'
        ''')
    meta_hes = query_to_df(sqlstr, version)
    if not meta_hes.empty:
        meta_concat = pd.concat([meta_hes, meta_concat])
```

Similarly, we can search the `cancer_site` column of `cancer_registry` for the same ICD-10 codes.

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
site_statement <- paste(meta_codes, collapse = "%' OR cancer_site LIKE '%")

reg_sql <- paste("SELECT participant_id, cancer_site ",
      "FROM cancer_registry
      WHERE participant_id IN (", bc_participant, ")",
      " AND cancer_site LIKE '%", site_statement, "%'",
      sep = "")

reg_query <- query_to_df(reg_sql, version)
```

```
site_statement = "%' OR cancer_site LIKE '%".join(meta_codes)

reg_sql = (
    f'''
    SELECT participant_id, cancer_site
    FROM cancer_registry
    WHERE participant_id IN {*bc_participant,}
    AND cancer_site LIKE '%{site_statement}%'
    ''')

reg_query = query_to_df(reg_sql, version)
```

```
site_statement <- paste(meta_codes, collapse = "%' OR cancer_site LIKE '%")

reg_sql <- paste("SELECT participant_id, cancer_site ",
      "FROM cancer_register_nhsd
      WHERE participant_id IN (", bc_participant, ")",
      " AND cancer_site LIKE '%", site_statement, "%'",
      sep = "")

reg_query <- query_to_df(reg_sql, version)
```

```
site_statement = "%' OR cancer_site LIKE '%".join(meta_codes)

reg_sql = (
    f'''
    SELECT participant_id, cancer_site
    FROM cancer_registry
    WHERE participant_id IN {*bc_participant,}
    AND cancer_site LIKE '%{site_statement}%'
    ''')

reg_query = query_to_df(reg_sql, version)
```

We can find the grading and stage of cancers in the `av_tumour` table. We can also assess oestrogen receptor (ER), progesterone receptor (PR), and HER2 status of our breast cancer samples.

The following SQL query fetches data from the `av_tumour` table, matching to the `cancer_analysis` table by the `participant_id`, filtering by a list of participant IDs called `participant`.

RE LabKey API RRE LabKey API Python

```
gms_staging_sql <- paste("SELECT
        ca.participant_id,
        ca.tumour_sample_platekey,
        ca.clinical_indication_full_name,
        ca.tumour_sample_clinical_sample_date_time,
        at.anon_tumour_id,
        at.er_status,
        at.pr_status,
        at.her2_status,
        at.diagnosisdatebest,        
        at.grade,
        at.t_best,
        at.n_best,
        at.m_best
    FROM cancer_analysis ca
    INNER JOIN av_tumour at
    ON ca.participant_id = at.participant_id
    AND at.diagnosisdatebest =
            (
            SELECT
                MAX(ate.diagnosisdatebest)
            FROM
                av_tumour ate
            WHERE
                ate.participant_id = at.participant_id
                AND
                ca.tumour_sample_clinical_sample_date_time >= ate.diagnosisdatebest
            )
    WHERE ca.participant_id IN ('", paste(gms_list, collapse = "', '"),
    "')",
    sep="")

gms_staging_query <- query_to_df(gms_staging_sql, gms_version)
```

```
gms_staging_sql = (f'''
    SELECT
        ca.participant_id,
        ca.tumour_sample_platekey,
        ca.clinical_indication_full_name,
        ca.tumour_sample_clinical_sample_date_time,
        at.anon_tumour_id,
        at.er_status,
        at.pr_status,
        at.her2_status,
        at.diagnosisdatebest,        
        at.grade,
        at.t_best,
        at.n_best,
        at.m_best
    FROM cancer_analysis ca
    INNER JOIN av_tumour at
    ON ca.participant_id = at.participant_id
    AND at.diagnosisdatebest =
            (
            SELECT
                MAX(ate.diagnosisdatebest)
            FROM
                av_tumour ate
            WHERE
                ate.participant_id = at.participant_id
                AND
                ca.tumour_sample_clinical_sample_date_time >= ate.diagnosisdatebest
            )
    WHERE ca.participant_id IN {*participant,}
    ''')

gms_staging_query = query_to_df(gms_staging_sql, gms_version)
```

## Cancer treatment

### Chemotherapy and immunotherapy

NHSE's [systemic anti-cancer therapy](https://digital.nhs.uk/ndrs/data/data-sets/sact) (`sact`) contains clinical management on patients receiving cancer chemotherapy, and newer agents that have anti-cancer effects, in or funded by the NHS in England.

- `sact` is in a long format, with participants occuring in multiple rows, each capturing one regimen of treatment.
- Therapies can be captured in both the `drug_group` and `analysis_group` as part of multi-drug regimens.

The following function checks SACT table for the drug specified.

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
sact_drug_finder <- function(drug.names, treat.df){
  # checks SACT table for presence of particular drugs in both the
  # drug_group as well as the analysis_group columns

  # Args:
  #   drug.names  = character vector of drug names (str)
  #   treat.df    = Data frame containing a treatment table

  # Returns:
  #   Data frame of treatment table with rows containing the drug of interest.

  require(tidyverse)

  all.drugs <- drug.names %>%
    toupper() %>%
    unique() %>%
    paste(collapse = "|")

  # Treatment tables use redundant terminology
  drug.cols <- c("analysis_group", "drug_group", "regimenname", "drugname", "eventdesc")
  ## Identify columns of the current table
  table.drug.cols <- intersect(colnames(treat.df), drug.cols)

  treat.df %>%
    pivot_longer(all_of(table.drug.cols),
                 names_to = "drug_source", values_to = "drug") %>%
    filter(!is.na(drug)) %>%
    filter(str_detect(drug, all.drugs)) %>%
    distinct() %>%
    pivot_wider(names_from = "drug_source", values_from = "drug")
}
```

```
def sact_drug_finder(drugname, df):
    """checks SACT table for presence of particular drugs in both the
    drug_group as well as the analysis_group columns

    Args:
        drugname (list): list of drug names (str)
        df (DataFrame): Pandas dataframe of SACT table.

    Returns:
        Dataframe of sact with rows containing the drug of interest. columns
        d1 to d5 have been added to split up drugs in 'analysis_group', column
        d0 contains the drug noted in 'drug_group'.
    """
    drugname_u = list(map(str.upper, drugname))
    newd = df['analysis_group'].str.count('\+').max()
    # +1 for range end, +1 because number of '+' != number of columns.
    newcols = ['d' + str(x) for x in range(1,newd+2)]
    df[newcols] = df['analysis_group'].str.split(
        '+', expand=True
        )
    df[newcols] = df[newcols].apply(lambda x: x.str.strip())
    df['d0'] = df['drug_group']  

    ncol=sum(df.columns.str.contains('^d[0-newd+1]+'))
    cols_select = ['participant_id'] + list(df.columns[
        df.columns.str.contains('^d[0-newd+1]+')
        ])
    sact_diag = df[
        [c for c in df.columns if c in cols_select]
        ]
    mask = functools.reduce(np.logical_or,
                                    [sact_diag[
                                        'd'+ '%.1d' % i
                                        ].str.contains('|'.join(drugname_u),
                                            na=False) for i in range(0,ncol)])
    return df.iloc[sact_diag[mask].index].reset_index()
```

```
sact_drug_finder <- function(drug.names, treat.df){
  # checks SACT table for presence of particular drugs in both the
  # drug_group as well as the analysis_group columns

  # Args:
  #   drug.names  = character vector of drug names (str)
  #   treat.df    = Data frame containing a treatment table

  # Returns:
  #   Data frame of treatment table with rows containing the drug of interest.

  require(tidyverse)

  all.drugs <- drug.names %>%
    toupper() %>%
    unique() %>%
    paste(collapse = "|")

  # Treatment tables use redundant terminology
  drug.cols <- c("analysis_group", "drug_group", "regimenname", "drugname", "eventdesc")
  ## Identify columns of the current table
  table.drug.cols <- intersect(colnames(treat.df), drug.cols)

  treat.df %>%
    pivot_longer(all_of(table.drug.cols),
                 names_to = "drug_source", values_to = "drug") %>%
    filter(!is.na(drug)) %>%
    filter(str_detect(drug, all.drugs)) %>%
    distinct() %>%
    pivot_wider(names_from = "drug_source", values_from = "drug")
}
```

```
def sact_drug_finder(drugname, df):
    """checks SACT table for presence of particular drugs in both the
    drug_group as well as the analysis_group columns

    Args:
        drugname (list): list of drug names (str)
        df (DataFrame): Pandas dataframe of SACT table.

    Returns:
        Dataframe of sact with rows containing the drug of interest. columns
        d1 to d5 have been added to split up drugs in 'analysis_group', column
        d0 contains the drug noted in 'drug_group'.
    """
    drugname_u = list(map(str.upper, drugname))
    newd = df['analysis_group'].str.count('\+').max()
    # +1 for range end, +1 because number of '+' != number of columns.
    newcols = ['d' + str(x) for x in range(1,newd+2)]
    df[newcols] = df['analysis_group'].str.split(
        '+', expand=True
        )
    df[newcols] = df[newcols].apply(lambda x: x.str.strip())
    df['d0'] = df['drug_group']  

    ncol=sum(df.columns.str.contains('^d[0-newd+1]+'))
    cols_select = ['participant_id'] + list(df.columns[
        df.columns.str.contains('^d[0-newd+1]+')
        ])
    sact_diag = df[
        [c for c in df.columns if c in cols_select]
        ]
    mask = functools.reduce(np.logical_or,
                                    [sact_diag[
                                        'd'+ '%.1d' % i
                                        ].str.contains('|'.join(drugname_u),
                                            na=False) for i in range(0,ncol)])
    return df.iloc[sact_diag[mask].index].reset_index()
```

We can query the sact table with a list of `anon_tumour_ids`, we've called the list `tumour_ids` in this query.

100kGP or main programmeNHS GMS

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
sact_sql <- paste(
    "SELECT
        participant_id,
        anon_tumour_id,
        analysis_group,
        primary_diagnosis,
        drug_group,
        cycle_number,
        programme_number,
        start_date_of_cycle,
        administration_date
    FROM
        sact
    WHERE
        anon_tumour_id IN (", tumour_ids, ")", sep="")

sact_query <- query_to_df(sact_sql, version)
sact_trastuzumab <- sact_drug_finder(list('Trastuzumab'), sact_query)
```

```
sact_sql = (f'''
    SELECT
        participant_id,
        anon_tumour_id,
        analysis_group,
        primary_diagnosis,
        drug_group,
        cycle_number,
        programme_number,
        start_date_of_cycle,
        administration_date
    FROM
        sact
    WHERE
        anon_tumour_id IN {*tumour_ids,}
    ''')

sact_query = query_to_df(sact_sql, version)
sact_trastuzumab = sact_drug_finder(['Trastuzumab'], sact_query)
```

```
sact_sql <- paste(
    "SELECT
        participant_id,
        tumour_pseudo_id,
        analysis_group,
        primary_diagnosis,
        drug_group,
        cycle_number,
        programme_number,
        start_date_of_cycle,
        administration_date
    FROM
        sact
    WHERE
        tumour_pseudo_id IN (", tumour_ids, ")", sep="")

sact_query <- query_to_df(sact_sql, version)
sact_trastuzumab <- sact_drug_finder(list('Trastuzumab'), sact_query)
```

```

```
sact_sql = (f'''
    SELECT
        participant_id,
        anon_tumour_id,
        analysis_group,
        primary_diagnosis,
        drug_group,
        cycle_number,
        programme_number,
        start_date_of_cycle,
        administration_date
    FROM
        sact
    WHERE
        anon_tumour_id IN {*tumour_ids,}
    ''')

sact_query = query_to_df(sact_sql, version)
sact_trastuzumab = sact_drug_finder(['Trastuzumab'], sact_query)
```

RE LabKey API RRE LabKey API Python

```
gms_sact_sql <- paste(
    "SELECT
        participant_id,
        anon_tumour_id,
        analysis_group,
        primary_diagnosis,
        drug_group,
        cycle_number,
        programme_number,
        start_date_of_cycle,
        administration_date
    FROM
        sact
    WHERE
        anon_tumour_id IN ('", paste(tumour_ids, collapse = "', '"), "')", sep="")

gms_sact_query <- query_to_df(gms_sact_sql, gms_version)
gms_sact_trastuzumab <- sact_drug_finder(list('Trastuzumab'), gms_sact_query)
```

```
gms_sact_sql = (f'''
    SELECT
        participant_id,
        anon_tumour_id,
        analysis_group,
        primary_diagnosis,
        drug_group,
        cycle_number,
        programme_number,
        start_date_of_cycle,
        administration_date
    FROM
        sact
    WHERE
        anon_tumour_id IN {*gms_tumour_ids,}
    ''')

gms_sact_query = query_to_df(gms_sact_sql, gms_version)
gms_sact_trastuzumab = sact_drug_finder(['Trastuzumab'], gms_sact_query)
```

`sact_trastuzumab` now contains all treatment cycles of tumours treated with Trastuzumab in our breast cancer cohort.

### Radiotherapy

We're now going to find particpants who had anti-cancer radiotherapy on their primary tumour. To do this we're filtering the [`rtds`](https://digital.nhs.uk/ndrs/data/data-sets/rtds) table by `radiotherapyintent` `1`,and `rttreatmentregion` `P`.

100kGP or main programmeNHS GMS

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
intent <- "1"
region <- "P"

rtds_sql <- paste(
    "SELECT
        participant_id,
        apptdate,
        radiotherapyintent,
        rttreatmentregion,
        rtactualdose,
        radiotherapybeamtype,
        radiotherapybeamenergy
    FROM rtds
    WHERE participant_id IN (", participant,
        ") AND radiotherapyintent = ", intent,
        "AND rttreatmentregion = '", region, "'",
    sep="")

rtds_query <- query_to_df(rtds_sql, version)
```

```
intent = "1"
region = "P"

rtds_sql = (f'''
    SELECT
        participant_id,
        apptdate,
        radiotherapyintent,
        rttreatmentregion,
        rtactualdose,
        radiotherapybeamtype,
        radiotherapybeamenergy
    FROM rtds
    WHERE participant_id IN {*participant,}
        AND radiotherapyintent = '{intent}'
        AND rttreatmentregion = '{region}'
    ''')

rtds_query = query_to_df(rtds_sql, version)
```

```
intent <- "1"
region <- "P"

rtds_sql <- paste(
    "SELECT
        participant_id,
        apptdate,
        radiotherapyintent,
        rttreatmentregion,
        rtactualdose,
        radiotherapybeamtype,
        radiotherapybeamenergy
    FROM rtds
    WHERE participant_id IN (", participant,
        ") AND radiotherapyintent = ", intent,
        "AND rttreatmentregion = '", region, "'",
    sep="")

rtds_query <- query_to_df(rtds_sql, version)
```

```
intent = "1"
region = "P"

rtds_sql = (f'''
    SELECT
        participant_id,
        apptdate,
        radiotherapyintent,
        rttreatmentregion,
        rtactualdose,
        radiotherapybeamtype,
        radiotherapybeamenergy
    FROM rtds
    WHERE participant_id IN {*participant,}
        AND radiotherapyintent = '{intent}'
        AND rttreatmentregion = '{region}'
    ''')

rtds_query = query_to_df(rtds_sql, version)
```

RE LabKey API RRE LabKey API Python

```
gms_rtds_sql <- paste(
    "SELECT
        participant_id,
        apptdate,
        radiotherapyintent,
        rttreatmentregion,
        rtactualdose,
        radiotherapybeamtype,
        radiotherapybeamenergy
    FROM rtds
    WHERE participant_id IN ('", paste(participant, collapse = "', '"),
    "') AND radiotherapyintent = ", intent,
    " AND rttreatmentregion = '", region, "'",
    sep="")

gms_rtds_query <- query_to_df(gms_rtds_sql, gms_version)
```

```
intent = "1"
region = "P"

gms_rtds_sql = (f'''
    SELECT
        participant_id,
        apptdate,
        radiotherapyintent,
        rttreatmentregion,
        rtactualdose,
        radiotherapybeamtype,
        radiotherapybeamenergy
    FROM rtds
    WHERE participant_id IN {*participant,}
        AND radiotherapyintent = '{intent}'
        AND rttreatmentregion = '{region}'
    ''')

gms_rtds_query = query_to_df(gms_rtds_sql, gms_version)
```

### Surgery

This query will identify all participants from our list who have had curative surgery.

100kGP or main programmeNHS GMS

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
treatment <- "Surgery - curative"

surgery_sql <- paste("SELECT
        participant_id,
        eventdesc,
        opcs4_code,
        opcs4_name
    FROM av_treatment
    WHERE participant_id IN (", participant, ")
        AND eventdesc = '", treatment, "'",       
    sep = "")

surgery_query <- query_to_df(surgery_sql, version)
```

```
treatment = "Surgery - curative"

surgery_sql = (f'''
    SELECT
        participant_id,
        eventdesc,
        opcs4_code,
        opcs4_name
    FROM av_treatment
    WHERE participant_id IN {*participant,}
        AND eventdesc = '{treatment}'       
    ''')

surgery_query = query_to_df(surgery_sql, version)
```

```
treatment <- "Surgery - curative"

surgery_sql <- paste("SELECT
        participant_id,
        eventdesc,
        opcs4_code,
        opcs4_name
    FROM av_treatment
    WHERE participant_id IN (", participant, ")
        AND eventdesc = '", treatment, "'",       
    sep = "")

surgery_query <- query_to_df(surgery_sql, version)
```

```
treatment = "Surgery - curative"

surgery_sql = (f'''
    SELECT
        participant_id,
        eventdesc,
        opcs4_code,
        opcs4_name
    FROM av_treatment
    WHERE participant_id IN {*participant,}
        AND eventdesc = '{treatment}'       
    ''')

surgery_query = query_to_df(surgery_sql, version)
```

RE LabKey API RRE LabKey API Python

```
treatment <- "Surgery - curative"

gms_surgery_sql <- paste("SELECT
        participant_id,
        eventdesc,
        opcs4_code,
        opcs4_name
    FROM av_treatment
    WHERE participant_id IN ('", paste(participant, collapse = "', '"),
    "')
        AND eventdesc = '", treatment, "'",       
    sep = "")

gms_surgery_query <- query_to_df(gms_surgery_sql, gms_version)
```

```
treatment = "Surgery - curative"

gms_surgery_sql = (f'''
    SELECT
        participant_id,
        eventdesc,
        opcs4_code,
        opcs4_name
    FROM av_treatment
    WHERE participant_id IN {*participant,}
        AND eventdesc = '{treatment}'       
    ''')

gms_surgery_query = query_to_df(gms_surgery_sql, gms_version)
gms_surgery_query
```

## Demographics

We're now going to fetch some general details about the participants that you might use to filter participants by demographics, looking at deprivation, ethnicity and risk factors.

### Deprivation and ethnicity

In the following query, we will fetch deprivation index data for our breast cancer list. We will also get ethnicity, both self-declared ethnicity (`participant_ethnic_category`) and genetically inferred ethnicity (`genetically_inferred_ancestry_thr`). The former is useful, along with the deprivation index, to look at societal effects on cancer. The latter is useful for looking at links between cancer and genetic ancestry.

100kGP or main programmeNHS GMS

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
demographics_sql <-paste("SELECT p.participant_id, p.participant_ethnic_category,
    ps.genetically_inferred_ancestry_thr, imd.imd
    FROM participant as p, participant_summary as ps, av_imd as imd
    WHERE p.participant_id = ps.participant_id
    AND p.participant_id = imd.participant_id
    AND p.participant_id IN (", participant, ")",
    sep="")

demographics_query <- query_to_df(demographics_sql, version)
```

```
demographics_sql = (f'''
    SELECT p.participant_id, p.participant_ethnic_category,
    ps.genetically_inferred_ancestry_thr, imd.imd
    FROM participant as p, participant_summary as ps, av_imd as imd
    WHERE p.participant_id = ps.participant_id
    AND p.participant_id = imd.participant_id
    AND p.participant_id IN {*participant,}
    ''')

demographics_query = query_to_df(demographics_sql, version)
```

```
demographics_sql <-paste("SELECT p.participant_id, p.participant_ethnic_category,
    ps.genetically_inferred_ancestry_thr, imd.quintile_2015
    FROM participant as p, participant_summarys as ps, av_imd as imd
    WHERE p.participant_id = ps.participant_id
    AND p.participant_id = imd.participant_id
    AND p.participant_id IN (", participant, ")",
    sep="")

demographics_query <- query_to_df(demographics_sql, version)
```

```
demographics_sql = (f'''
    SELECT p.participant_id, p.participant_ethnic_category,
    ps.genetically_inferred_ancestry_thr, imd.imd
    FROM participant as p, participant_summarys as ps, av_imd as imd
    WHERE p.participant_id = ps.participant_id
    AND p.participant_id = imd.participant_id
    AND p.participant_id IN {*participant,}
    ''')

demographics_query = query_to_df(demographics_sql, version)
```

### Risk factors

General risk factors, including height, weight, alcohol consumption and smoking, are in the `cancer_risk_factor_general` table, whereas risk factors specific to certain cancers are in `cancer_risk_factor_cancer_specific`, segrated into `cancer_type`. In the query below we will pull out participants from our participant list who currently smoke.

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
smoking <- "Current smoker"

smoking_sql <- paste(
    "SELECT participant_id
    FROM cancer_risk_factor_general
    WHERE participant_id IN (", participant, ")
    AND smoking_status ='", smoking, "'",
    sep = "")

smoking_query <- query_to_df(smoking_sql, version)
```

```
smoking = "Current smoker"

smoking_sql = (f'''
    SELECT participant_id
    FROM cancer_risk_factor_general
    WHERE participant_id IN {*participant,}
    AND smoking_status ='{smoking}'
    ''')

smoking_query = query_to_df(smoking_sql, version)
```

```
smoking <- "Current smoker"

smoking_sql <- paste(
    "SELECT participant_id
    FROM cancer_risk_factor_general
    WHERE participant_id IN (", participant, ")
    AND smoking_status ='", smoking, "'",
    sep = "")

smoking_query <- query_to_df(smoking_sql, version)
```

```
smoking = "Current smoker"

smoking_sql = (f'''
    SELECT participant_id
    FROM cancer_risk_factor_general
    WHERE participant_id IN {*participant,}
    AND smoking_status ='{smoking}'
    ''')

smoking_query = query_to_df(smoking_sql, version)
```

In the next query we will pull out a number of breast cancer risk factors for our list.

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
bc_risk_sql <- paste(
    "SELECT participant_id, age_of_menarche, age_of_menopause, number_of_pregnancies
    FROM cancer_risk_factor_cancer_specific
    WHERE participant_id IN (", participant, ")",
    sep = "")

bc_risk_query <- query_to_df(bc_risk_sql, version)
```

```
bc_risk_sql = (f'''
    SELECT participant_id, age_of_menarche, age_of_menopause, number_of_pregnancies
    FROM cancer_risk_factor_cancer_specific
    WHERE participant_id IN {*participant,}
    ''')

bc_risk_query = query_to_df(bc_risk_sql, version)
```

```
bc_risk_sql <- paste(
    "SELECT participant_id, age_of_menarche, age_of_menopause, number_of_pregnancies
    FROM cancer_risk_factor_cancer_specific
    WHERE participant_id IN (", participant, ")",
    sep = "")

bc_risk_query <- query_to_df(bc_risk_sql, version)
```

```
bc_risk_sql = (f'''
    SELECT participant_id, age_of_menarche, age_of_menopause, number_of_pregnancies
    FROM cancer_risk_factor_cancer_specific
    WHERE participant_id IN {*participant,}
    ''')

bc_risk_query = query_to_df(bc_risk_sql, version)
```

RE LabKey API RRE LabKey API Python

```
gms_demographics_sql <-paste("SELECT p.participant_id, p.ethnicity_description,  imd.imd
    FROM participant as p, av_imd as imd
    WHERE p.participant_id = imd.participant_id
    AND p.participant_id IN ('", paste(participant, collapse = "', '"),
    "')",
    sep="")

gms_demographics_query <- query_to_df(gms_demographics_sql, gms_version)
```

```
gms_demographics_sql = (f'''
    SELECT p.participant_id, p.ethnicity_description, imd.imd
    FROM participant as p, av_imd as imd
    WHERE p.participant_id = imd.participant_id
    AND p.participant_id IN {*participant,}
    ''')

gms_demographics_query = query_to_df(gms_demographics_sql, gms_version)
```

## Age

We donât have Age stored. You need to calculate it from the year of birth. Age will always be an approximation, since we only have year and not full date: this is particularly important for anything in small children.

We're going to find different ages for our list of participants, starting with current age:

100kGP or main programmeNHS GMS

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
current_age_sql <- paste("SELECT participant_id,
    (YEAR(CURDATE()) - yob) as current_age
    FROM participant_summary
    WHERE participant_id IN (", participant, ")",
    sep="")

current_age_query <- query_to_df(current_age_sql, version)
```

```
current_age_sql = (f'''
    SELECT participant_id,
    (YEAR(CURDATE()) - yob) as current_age
    FROM participant_summary
    WHERE participant_id IN {*participant,}
    ''')

current_age_query = query_to_df(current_age_sql, version)
```

```
current_age_sql <- paste("SELECT participant_id,
    (YEAR(CURDATE()) - yob) as current_age
    FROM participant_summary
    WHERE participant_id IN (", participant, ")",
    sep="")

current_age_query <- query_to_df(current_age_sql, version)
```

```
current_age_sql = (f'''
    SELECT participant_id,
    (YEAR(CURDATE()) - yob) as current_age
    FROM participant_summary
    WHERE participant_id IN {*participant,}
    ''')

current_age_query = query_to_df(current_age_sql, version)
```

RE LabKey API RRE LabKey API Python

```
gms_current_age_sql <- paste("SELECT participant_id,
    (YEAR(CURDATE()) - participant_year_of_birth) as current_age
    FROM participant
    WHERE participant_id IN ('", paste(participant, collapse = "', '"),
    "')",
    sep="")

gms_current_age_query <- query_to_df(gms_current_age_sql, gms_version)
```

```
gms_current_age_sql = (f'''
    SELECT participant_id,
    (YEAR(CURDATE()) - participant_year_of_birth) as current_age
    FROM participant
    WHERE participant_id IN {*participant,}
    ''')

gms_current_age_query = query_to_df(gms_current_age_sql, gms_version)
```

To get the date when the sample was taken, you need to get the year from clinic\_sample.

100kGP or main programmeNHS GMS

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
sample_age_sql <- paste("SELECT ps.participant_id, cs.clinic_sample_id,
    (YEAR (cs.clinic_sample_datetime) - ps.yob) as sample_age
    FROM participant_summary as ps
    JOIN clinic_sample as cs
    ON ps.participant_id = cs.participant_id
    WHERE ps.participant_id IN (", participant, ")",
    sep="")

sample_age_query <- query_to_df(sample_age_sql, version)
```

```
sample_age_sql = (f'''
    SELECT ps.participant_id, cs.clinic_sample_id,
    (YEAR (cs.clinic_sample_datetime) - ps.yob) as sample_age
    FROM participant_summary as ps
    JOIN clinic_sample as cs
    ON ps.participant_id = cs.participant_id
    WHERE ps.participant_id IN {*participant,}
    ''')

sample_age_query = query_to_df(sample_age_sql, version)
sample_age_query
```

```
sample_age_sql <- paste("SELECT ps.participant_id, cs.clinic_sample_id,
    (YEAR (cs.clinic_sample_datetime) - ps.yob) as sample_age
    FROM participant_summary as ps
    JOIN clinic_sample as cs
    ON ps.participant_id = cs.participant_id
    WHERE ps.participant_id IN (", participant, ")",
    sep="")

sample_age_query <- query_to_df(sample_age_sql, version)
```

```
sample_age_sql = (f'''
    SELECT ps.participant_id, cs.clinic_sample_id,
    (YEAR (cs.clinic_sample_datetime) - ps.yob) as sample_age
    FROM participant_summary as ps
    JOIN clinic_sample as cs
    ON ps.participant_id = cs.participant_id
    WHERE ps.participant_id IN {*participant,}
    ''')

sample_age_query = query_to_df(sample_age_sql, version)
sample_age_query
```

RE LabKey API RRE LabKey API Python

```
gms_sample_age_sql <- paste("SELECT p.participant_id, ca.tumour_sample_clinical_sample_date_time,
    (YEAR (ca.tumour_sample_clinical_sample_date_time) - p.participant_year_of_birth) as sample_age
    FROM participant as p
    JOIN cancer_analysis as ca
    ON p.participant_id = ca.participant_id
    WHERE p.participant_id IN ('", paste(participant, collapse = "', '"),
    "')", sep="")

gms_sample_age_query <- query_to_df(gms_sample_age_sql, gms_version)
```

```
gms_sample_age_sql = (f'''
SELECT p.participant_id, ca.tumour_sample_clinical_sample_date_time,
    (YEAR (ca.tumour_sample_clinical_sample_date_time) - p.participant_year_of_birth) as sample_age
    FROM participant as p
    JOIN cancer_analysis as ca
    ON p.participant_id = ca.participant_id
    WHERE p.participant_id IN {*participant,}
    ''')

gms_sample_age_query = query_to_df(gms_sample_age_sql, gms_version)
```

You can get age at diagnosis from the cancer tables. This can sometimes be tricky as some records can be incomplete.

100kGP or main programmeNHS GMS

In this example, we're going to find a diagnosis date from the `cancer_participant_tumour`, `av_tumour` and `cancer_register` tables by finding the oldest record with the diagnosis code we're interested in out of all those tables.

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
cpt_sql <- paste("SELECT DISTINCT participant_id,
        YEAR(diagnosis_date) as diagnosis_date,
        diagnosis_icd_code as icd10_code
    FROM cancer_participant_tumour
    WHERE participant_id IN (", participant, ")
    AND diagnosis_icd_code like '%", icd_code, "%'",
    sep="")
cpt_query = query_to_df(cpt_sql, version)

av_sql <- paste("SELECT DISTINCT participant_id,
        YEAR(diagnosisdatebest) as diagnosis_date,
        site_icd10_o2 as icd10_code
    FROM av_tumour
    WHERE participant_id IN (", participant, ")
    AND site_icd10_o2 like '%", icd_code, "%'",
    sep="")
av_query = query_to_df(av_sql, version)

cr_sql <- paste("SELECT DISTINCT participant_id,
        YEAR(event_date) as diagnosis_date,
        cancer_site as icd10_code
    FROM cancer_registry
    WHERE participant_id IN (", participant, ")
    AND cancer_site like '%", icd_code, "%'",
    sep="")
cr_query = query_to_df(cr_sql, version)

diagnosis_concat <- rbind(cpt_query, av_query, cr_query)
aggregate(diagnosis_concat$diagnosis_date, by = list(diagnosis_concat$participant_id, diagnosis_concat$icd10_code), min)

yob_sql <- paste("SELECT participant_id, yob
    FROM participant_summary
    WHERE participant_id IN (", participant, ")", sep = "")
yob_query <- query_to_df(yob_sql, version)

diag_age_table <- merge(yob_query, diagnosis_concat)
diag_age_table$diag_age <- as.numeric(diag_age_table$diagnosis_date) - as.numeric(diag_age_table$yob)
```

```
cpt_sql = (f'''
    SELECT DISTINCT participant_id,
        YEAR(diagnosis_date) as "diagnosis_date",
        diagnosis_icd_code as "icd10_code"
    FROM cancer_participant_tumour
    WHERE participant_id IN {*participant,}
    AND diagnosis_icd_code like '%{icd_code}%'
    ''')
cpt_query = query_to_df(cpt_sql, version)

av_sql = (f'''
    SELECT DISTINCT participant_id,
        YEAR(diagnosisdatebest) as "diagnosis_date",
        site_icd10_o2 as "icd10_code"
    FROM av_tumour
    WHERE participant_id IN {*participant,}
    AND site_icd10_o2 like '%{icd_code}%'
    ''')
av_query = query_to_df(av_sql, version)

cr_sql = (f'''
    SELECT DISTINCT participant_id,
        YEAR(event_date) as "diagnosis_date",
        cancer_site as "icd10_code"
    FROM cancer_registry
    WHERE participant_id IN {*participant,}
    AND cancer_site like '%{icd_code}%'
    ''')
cr_query = query_to_df(cr_sql, version)

diagnosis_concat = pd.concat([cpt_query, av_query, cr_query])
diagnosis_concat.sort_values(
    ['diagnosis_date'],
    ascending=True, inplace=True)
diagnosis_concat.drop_duplicates(
    ['participant_id', 'icd10_code'],
    keep ='first', inplace=True)

yob_sql = (f'''
    SELECT participant_id, yob
    FROM participant_summary
    WHERE participant_id IN {*participant,}
    ''')
yob_query = query_to_df(yob_sql, version)

diag_age_table = pd.merge(yob_query, diagnosis_concat)
diag_age_table['diag_age'] = diag_age_table['diagnosis_date'] - diag_age_table['yob']
```

```
cpt_sql <- paste("SELECT DISTINCT participant_id,
        YEAR(diagnosis_date) as diagnosis_date,
        diagnosis_icd_code as icd10_code
    FROM cancer_participant_tumour
    WHERE participant_id IN (", participant, ")
    AND diagnosis_icd_code like '%", icd_code, "%'",
    sep="")
cpt_query = query_to_df(cpt_sql, version)

av_sql <- paste("SELECT DISTINCT participant_id,
        YEAR(diagnosisdatebest) as diagnosis_date,
        site_icd10_o2 as icd10_code
    FROM av_tumour
    WHERE participant_id IN (", participant, ")
    AND site_icd10_o2 like '%", icd_code, "%'",
    sep="")
av_query = query_to_df(av_sql, version)

cr_sql <- paste("SELECT DISTINCT participant_id,
        YEAR(event_date) as diagnosis_date,
        cancer_site as icd10_code
    FROM cancer_registry
    WHERE participant_id IN (", participant, ")
    AND cancer_site like '%", icd_code, "%'",
    sep="")
cr_query = query_to_df(cr_sql, version)

diagnosis_concat <- rbind(cpt_query, av_query, cr_query)
aggregate(diagnosis_concat$diagnosis_date, by = list(diagnosis_concat$participant_id, diagnosis_concat$icd10_code), min)

yob_sql <- paste("SELECT participant_id, yob
    FROM participant_summary
    WHERE participant_id IN (", participant, ")", sep = "")
yob_query <- query_to_df(yob_sql, version)

diag_age_table <- merge(yob_query, diagnosis_concat)
diag_age_table$diag_age <- as.numeric(diag_age_table$diagnosis_date) - as.numeric(diag_age_table$yob)
```

```
cpt_sql = (f'''
    SELECT DISTINCT participant_id,
        YEAR(diagnosis_date) as "diagnosis_date",
        diagnosis_icd_code as "icd10_code"
    FROM cancer_participant_tumour
    WHERE participant_id IN {*participant,}
    AND diagnosis_icd_code like '%{icd_code}%'
    ''')
cpt_query = query_to_df(cpt_sql, version)

av_sql = (f'''
    SELECT DISTINCT participant_id,
        YEAR(diagnosisdatebest) as "diagnosis_date",
        site_icd10_o2 as "icd10_code"
    FROM av_tumour
    WHERE participant_id IN {*participant,}
    AND site_icd10_o2 like '%{icd_code}%'
    ''')
av_query = query_to_df(av_sql, version)

cr_sql = (f'''
    SELECT DISTINCT participant_id,
        YEAR(event_date) as "diagnosis_date",
        cancer_site as "icd10_code"
    FROM cancer_registry
    WHERE participant_id IN {*participant,}
    AND cancer_site like '%{icd_code}%'
    ''')
cr_query = query_to_df(cr_sql, version)

diagnosis_concat = pd.concat([cpt_query, av_query, cr_query])
diagnosis_concat.sort_values(
    ['diagnosis_date'],
    ascending=True, inplace=True)
diagnosis_concat.drop_duplicates(
    ['participant_id', 'icd10_code'],
    keep ='first', inplace=True)

yob_sql = (f'''
    SELECT participant_id, yob
    FROM participant_summary
    WHERE participant_id IN {*participant,}
    ''')
yob_query = query_to_df(yob_sql, version)

diag_age_table = pd.merge(yob_query, diagnosis_concat)
diag_age_table['diag_age'] = diag_age_table['diagnosis_date'] - diag_age_table['yob']
```

Age at death can be easily calculated from the `participant_summary` table:

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
death_sql <- paste("SELECT participant_id, yob, death_date,
    (YEAR (death_date) - yob) as death_age
    FROM participant_summary
    WHERE participant_id IN (", participant, ")", sep = "")
death_query <- query_to_df(death_sql, version)
```

```
death_sql = (f'''
    SELECT participant_id, yob, death_date,
    (YEAR (death_date) - yob) as death_age
    FROM participant_summary
    WHERE participant_id IN {*participant,}
    ''')
death_query = query_to_df(death_sql, version)
```

```
death_sql <- paste("SELECT participant_id, yob, death_date,
    (YEAR (death_date) - yob) as death_age
    FROM participant_summary
    WHERE participant_id IN (", participant, ")", sep = "")
death_query <- query_to_df(death_sql, version)
```

```
death_sql = (f'''
    SELECT participant_id, yob, death_date,
    (YEAR (death_date) - yob) as death_age
    FROM participant_summary
    WHERE participant_id IN {*participant,}
    ''')
death_query = query_to_df(death_sql, version)
```

In this example, we're going to find a diagnosis date from the `tumour` and `av_tumour` tables by finding the oldest record with the diagnosis code we're interested in out of all those tables.

RE LabKey API RRE LabKey API Python

```
tumour_id_list <- as.list(gms_cancer_query$tumour_uid)

gms_t_sql <- paste("SELECT DISTINCT participant_id,
        tumour_diagnosis_year as diagnosis_date
    FROM tumour
    WHERE uid IN ('", paste(tumour_id_list, collapse = "', '"),
    "')",
    sep="")
gms_t_query = query_to_df(gms_t_sql, gms_version)

gms_av_sql <- paste("SELECT DISTINCT participant_id,
        YEAR(diagnosisdatebest) as diagnosis_date
    FROM av_tumour
    WHERE participant_id IN ('", paste(gms_list, collapse = "', '"),
    "')",
    sep="")
gms_av_query = query_to_df(gms_av_sql, gms_version)

gms_diagnosis_concat <- rbind(gms_t_query, gms_av_query)
aggregate(gms_diagnosis_concat$diagnosis_date, by = list(gms_diagnosis_concat$participant_id), min)

gms_yob_sql <- paste("SELECT participant_id, participant_year_of_birth
    FROM participant
    WHERE participant_id IN ('", paste(gms_list, collapse = "', '"),
    "')", sep = "")
gms_yob_query <- query_to_df(gms_yob_sql, gms_version)

gms_diag_age_table <- merge(gms_yob_query, gms_diagnosis_concat)
gms_diag_age_table$diag_age <- as.numeric(gms_diag_age_table$diagnosis_date) - as.numeric(gms_diag_age_table$participant_year_of_birth)
```

```
tumour_id_list = gms_cancer_query['tumour_uid'].tolist()

gms_t_sql = (f'''
    SELECT DISTINCT participant_id,
        tumour_diagnosis_year as "diagnosis_date"
    FROM tumour
    WHERE uid IN {*tumour_id_list,}
    ''')
gms_t_query = query_to_df(gms_t_sql, gms_version)

gms_av_sql = (f'''
    SELECT DISTINCT participant_id,
        YEAR(diagnosisdatebest) as "diagnosis_date",
    FROM av_tumour
    WHERE participant_id IN {*gms_list,}
    ''')
gms_av_query = query_to_df(gms_av_sql, gms_version)

gms_diagnosis_concat = pd.concat([gms_t_query, gms_av_query])
gms_diagnosis_concat.sort_values(
    ['diagnosis_date'],
    ascending=True, inplace=True)
gms_diagnosis_concat.drop_duplicates(
    ['participant_id'],
    keep ='first', inplace=True)

gms_yob_sql = (f'''
    SELECT participant_id, participant_year_of_birth
    FROM participant
    WHERE participant_id IN {*gms_list,}
    ''')
gms_yob_query = query_to_df(gms_yob_sql, gms_version)

gms_diag_age_table = pd.merge(gms_yob_query, gms_diagnosis_concat)
gms_diag_age_table['diag_age'] = gms_diag_age_table['diagnosis_date'] - gms_diag_age_table['participant_year_of_birth']
```

## Consent status

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

## Output data

Depending on your end goal, there are a number of different data types you might want to fetch:

- `genome_file_paths_and_types`
  - gvcfs
  - SV/CNV files
- For filtering out data from gene-centric pipelines ([Small Variant workflow](../small_variant/), [gene-centric SNV report](../gene-centric-snv-report/))
  - `participant_id`
- Phenotype files (for [AVT](../avt/) and [GWAS](../gwas/) downstream analysis):
  - Platekey
  - Phenotype: 0, 1 or score
  - Covariates: age, sex etc

100kGP or main programmeNHS GMS

The original alignments and VCF locations can be found in the `cancer_analysis` table, whereas a realignment using DRAGEN can be found in `cancer_100K_genomes_realigned_on_pipeline_2` using the participant ID. In this query, we're going to get the tumour platekey, filepath of the somatic small variants VCF for these participants.

RE LabKey API RRE LabKey API PythonCloudOS interactive session RCloudOS interactive session Python

```
filetype <- "somatic_small_variants_vcf_path"

path_sql <- paste("SELECT ca.participant_id,
      ca.", filetype, " as ca_filepath,
      cr.", filetype, " as dragen_filepath,
      ca.tumour_sample_platekey
    FROM cancer_analysis as ca,
    cancer_100K_genomes_realigned_on_pipeline_2 as cr
    WHERE ca.participant_id IN (", participant, ")
    AND ca.participant_id = cr.participant_id", sep="")

path_query <- query_to_df(path_sql, version)
```

```
filetype = "somatic_small_variants_vcf_path"

path_sql = (f'''
    SELECT ca.participant_id,
        ca.{filetype} as "ca_filepath",
        cr.{filetype} as "dragen_filepath",
        ca.tumour_sample_platekey
    FROM cancer_analysis as ca,
    cancer_100K_genomes_realigned_on_pipeline_2 as cr
    WHERE ca.participant_id IN {*participant,}
    AND ca.participant_id = cr.participant_id
''')

path_query = query_to_df(path_sql, version)
```

```
filetype <- "somatic_small_variants_vcf_path"

path_sql <- paste("SELECT ca.participant_id,
      ca.", filetype, " as ca_filepath,
      cr.", filetype, " as dragen_filepath,
      ca.tumour_sample_platekey
    FROM cancer_analysis as ca,
    cancer_100K_genomes_realigned_on_pipeline_2 as cr
    WHERE ca.participant_id IN (", participant, ")
    AND ca.participant_id = cr.participant_id", sep="")

path_query <- query_to_df(path_sql, version)
```

```
filetype = "somatic_small_variants_vcf_path"

path_sql = (f'''
    SELECT ca.participant_id,
        ca.{filetype} as "ca_filepath",
        cr.{filetype} as "dragen_filepath",
        ca.tumour_sample_platekey
    FROM cancer_analysis as ca,
    cancer_100K_genomes_realigned_on_pipeline_2 as cr
    WHERE ca.participant_id IN {*participant,}
    AND ca.participant_id = cr.participant_id
''')

path_query = query_to_df(path_sql, version)
```

The alignments and VCF locations can be found in the `cancer_analysis` table. In this query, we're going to get the tumour platekey, filepath of the somatic small variants VCF for these participants.

RE LabKey API RRE LabKey API Python

```
filetype <- "somatic_small_variants_vcf_path"

gms_path_sql <- paste("SELECT participant_id,
      ", filetype, ", tumour_sample_platekey
    FROM cancer_analysis
    WHERE participant_id IN ('", paste(gms_list, collapse = "', '")", sep="")

gms_path_query <- query_to_df(gms_path_sql, gms_version)
```

```
filetype = "somatic_small_variants_vcf_path"

gms_path_sql = (f'''
    SELECT participant_id, {filetype}, tumour_sample_platekey
    FROM cancer_analysis
    WHERE participant_id IN {*participant,}
''')

gms_path_query = query_to_df(gms_path_sql, gms_version)
```

February 5, 2026
