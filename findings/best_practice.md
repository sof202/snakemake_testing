# Best Practice

## ci/cd

snakemake comes with a builtin linter:

```bash
snakemake --lint
```

snakemake has a formater (that you need to install separately) too:

```bash
snakefmt directory/
snakefmt file.ext
```

Though this uses black (gross).

They also say that you should really be testing a workflow via GitHub actions.
This is good as it means this is probably quite easy to do.

## General

They say to avoid lambdas inside of rules. I presume because of readability.
Instead, use helper functions, ideally written in a separate file.

## Helper functions

There's a bunch of helper functions that they define for you that either 
replace python syntax or just help you to avoid making your own. You can find
these helpers
[here](https://snakemake.readthedocs.io/en/stable/snakefiles/rules.html#helpers-for-defining-rules).

There's nice stuff here like:

- `expand` (like unix {} behaviour)
- `multiext` (specify multiple output files easier with same prefix)
- 'Pathvar's, which use angle brackets (<>). This is basically just string
interpolation but handled via configuration
- `lookup` which looks useful for inspecting dictionaries or pandas
dataframe/series objects
- `branch` change inputs/outputs/program with conditional
    - This feels like its more to keep the flow concise
- `parse` can parse a file for perhaps a quick logging event
- `subpath` looks useful for anything you might do normally with `pathlib.Path`
- `flatten` flattens lists (nicer syntax than what you'd normally need to do)

### Your own helpers

You can write normal python inside of `.smk` or just the `Snakefile`. The
standard name for the helpers `.smk` file is `common.smk`. I don't really like
this name as it is super generic (and is no better than `utils.py`) but
whatever, standards gonna standards I guess.

## Reporting

You can make restructuredText reports from snakemake workflows. You can choose
what to include and group results too with categories and subcategories.

At the end you can render the report into html (with even possible custom
styles) by doing:

```bash
snakemake --report file_name.html
```

## Directory Structure

This is the structure they give:

```
project
├── .gitignore
├── README.md
├── LICENSE.md
├── workflow
│   ├── rules
|   │   ├── module1.smk
|   │   └── module2.smk
│   ├── envs
|   │   ├── tool1.yaml
|   │   └── tool2.yaml
│   ├── scripts
|   │   ├── script1.py
|   │   └── script2.R
│   ├── notebooks
|   │   ├── notebook1.py.ipynb
|   │   └── notebook2.r.ipynb
│   ├── report
|   │   ├── plot1.rst
|   │   └── plot2.rst
|   └── Snakefile
├── config
│   ├── config.yaml
│   └── some-sheet.tsv
├── results
└── resources
```

## Standards

You can use [snakedeploy](https://snakedeploy.readthedocs.io/en/stable/) for
automating deployment. If you comply with certain rules you can get your
workflows automatically listed on their workflow hub.

## R scripts

You might want to ensure that indeed, the Rscript has access to the snakemake
S4 object with something like:

```R
if (!exists("is_sourced") || !is_sourced) {
  if (exists("snakemake")) {
    main(...)
  } else {
    warning(
      "Script executed outside Snakemake context. ",
      "Provide arguments manually or source() individual functions."
    )
  }
}

```
