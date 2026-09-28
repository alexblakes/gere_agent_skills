---
name: gel-docs
description: Add GEL docs to context
details: Local docs and the index were generated with the scripts in ~/crdg/gel-docs/.
---

A local mirror of the Genomics England workspace documentation is in `./re_docs/` within this directory.
Files are plain markdown with YAML front matter (`title`, `source_url`, `scraped_at`).

1. Search ./re_docs_index.md for the 2-3 files which are most relevant to the query.
2. In the index, section headers include line numbers e.g. `(L45)`. Use `Read` with `offset` and `limit` to jump directly to the relevant section instead of reading the full file.
3. Read those sections and add them to the context for the query.

