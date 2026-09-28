---
name: gere-coder
description: Use when writing, changing, or debugging data-analysis code that will be pasted into the Genomics England Research Environment. Use it whenever the user requests code written for GEL, GERE, the RE, 100kGP, or CloudOS.
---

# Coding for the GEL Research Environment

You are developing code locally to run in the Genomics England Research Environment.

## Secure corporate environment

- This environment is airgapped with no internet access.
- This environment has no access to external data sources or APIs.
- This environment has inbound, but not outbound, copy/paste functionality.
- You have no access to the file systems, raw data, code, logs, or intermediate outputs in the secure environment.

## Development

- Use the coding style, conventions, and tooling described in the repo's CLAUDE.md file.
- Use dry-runs to validate the pipeline locally. Do not run the real pipeline locally; it will fail.
- Build in small increments of only one or a few scripts or files at a time. The user needs to manually review, paste, and run these within the secure environment.
- Build scripts to fail loudly with succint and distinctive error messages.
- Provide a `touch` command for the user to create the necessary blank files in the RE. Do not do this if writing code for CloudOS.

## Debugging

- Never ask for full logs or complete error messages; the user cannot copy this data out of the secure environment.
- The user can only provide short manual summaries or screenshots of errors or exceptions.

## GERE paths

- Where filepaths for GERE data are required, look them up in the manifest at `gel_data_catalog.json`.
- Never fabricate a file path; when only a prefix or access point exists, or user input is strictly required, say so.
- Never read the full catalog into context. Query it with
  `jq -f scripts/query_catalog.jq` against `gel_data_catalog.json`.
- Supported named arguments for the query script: `id`, `programme`, `release`, `category`, `description`,
  `keywords` (comma-separated, AND logic), `format`, `path_kind`, `available_in`, `limit`,
  and `full`.
- Results are projected to `id`, `formats`, `paths`, and
  `example_filepath` to keep output small. If the complete entry is strictly
  needed (e.g. `labkey` coordinates, `source_urls`), use a
  throwaway `jq` command to query the json using the `id` field.
- If three queries fail, consult the schema at `gel_data_catalog.schema.json`. Report your key finding, in less than 80 characters, to facts.md for future reference.

```bash
# Example queries
jq -f scripts/query_catalog.jq --arg keywords exomiser gel_data_catalog.json
jq -f scripts/query_catalog.jq --arg programme gms --arg keywords tumour \
  --arg path_kind s3 gel_data_catalog.json
jq -f scripts/query_catalog.jq --arg programme 100kgp --arg format VCF \
  --arg available_in hpc gel_data_catalog.json
```

## Synthetic data

- Where standard or obvious file formats and data structures are used, produce small stubs of synthetic data for testing and development.
- If bespoke or custom file formats and data structures are used, search the `synthetic_data` directories within this skill, or under `data/` in the local repo, for synthetic data that can be used for testing and development.
- If you cannot find or create these synthetic data stubs, request the user to provide example synthetic data. Expand the user-provided data into a short stub of synthetic data for testing and development.
- Copy any synthetic data produced from user input to this skill's `synthetic_data` directory for future use.

## Facts from documentation

- If a lack of critical facts prevents progess, check this skill's `facts.md` file.
- You should only refer to the GEL documentation sparingly, where there is a genuine need to refine highly GEL-specific details.
- You must request user permission before every query of the GEL documentation.
- This documentation is available via the `/gel-docs` skill.
- If the docs are consulted, record the key fact, in less than 80 characters, to this skill's `facts.md` file for future reference.
