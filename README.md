# GERE coder
A skill for coding in the Genomics England Research Environment.

Develop locally, deploy in the RE.

## Challenges addressed by this `SKILL.md`

### The agent can't access the GERE filesystem
The skill comes bundles with a manifest of GERE file paths and types.
Taken from the publicly available [GEL docs](https://re-docs.genomicsengland.co.uk/).

Need to update this for a different TRE? Here's a prompt you could adapt.

>Use the docs at https://re-docs.genomicsengland.co.uk/ to produce a JSON file containing filepaths of the key data available in the Genomics England research environment and CloudOS. This resource will be used by agents to develop code locally, which can then be run in the airgapped research environment. Also provide a schema for the JSON file. For each entry provide the file path in the HPC, and/or the corresponding s3 path in CloudOS, and, if available the URL or access point in LabKey. For each entry also provide a succinct description of <80 characters, a concrete example filepath, and an informative "keywords" field (max 5 keywords per entry). The attached data dictionaries give more detail on the names and contents of the clinical data files in LabKey. Ask me any questions if clarification is needed.

### The agent can't read files in the GERE
The skill expects to work with standard bioinformatics file formats, but prompts for
synthetic data from the user if necessary. It keeps a memory of bespoke files and formats.

## Suggestions for your project's `AGENTS.md` file
- Bake-in sanity checks into your pipelines with logging and assertions. For example, log data shapes after reading in, after every filter or transformation step, and before writing out.
- Work on a separate git branch for each new analysis.
- Use modular pipelines - one discrete pipeline for each analysis step, coordinated by a driver script (e.g. a `Snakefile`)
- List your tooling and code preferences.

## Suggestions for your own practice
- Use aliases to reduce friction from verbose commands, e.g. `git`.
```bash
# Example alias for a quick-and-dirty push to GitHub
$ type gwip 
gwipp is an alias for git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign --message "--wip-- [skip ci]" && git push
```
- Use a task manager (e.g. `pixi`, `just`, `make`) alongside aliases to reduce friction in quick iteration between your local machine and the TRE.
- Use a modern package manager to maintain a consistent environment locally and in the 
GERE. Try [Pixi](https://pixi.prefix.dev/latest/), for example. Installation instructions for Pixi in the GERE are [here](https://github.com/alexblakes/snippets/blob/main/gel_pixi.md).
- Get familiar with your debugger in the TRE
- Only write code on your local machine - this takes discipline.
