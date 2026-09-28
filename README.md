# GERE agent skills
A skill for coding in the Genomics England Research Environment.

Develop locally, deploy in the RE.

## Challenges addressed by this `SKILL.md`

### The agent can't access the GERE filesystem
The skill comes bundles with a manifest of GERE file paths and types.
Taken from the publicly available [GEL docs](https://re-docs.genomicsengland.co.uk/).

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
- 