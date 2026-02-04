# General Findings

## Publishing/Finding Workflows

There exists [WorkflowHub](https://workflowhub.eu/). Which some of us might
find useful. Not only would you be able to find workflows to use, but it would
probably be a great place to share a workflow beyond just GitHub. I imagine
that it helps massively with adhering to best practices as they'll actually be
enforced here.

## Conda installation

So I found that to use conda you not only need to run snakemake like:

```bash
snakemake --cores number-of-cores --sdm conda
```

Otherwise it will fail.

On top of this, I also found that you need to have a pretty recent version of
conda:

```
CreateCondaEnvironmentException:
Conda must be version 24.7.1 or later, found version 23.10.0. Please update
conda to the latest version. Note that you can also install conda into the
snakemake environment without modifying your main conda installation.
```

Well, I say recent, but this version is from July 2024. But it's still worth
noting.

### Caching

The conda environment that snakemake creates for the workflow is cached. This
reduces start up time in subsequent runs.

### Channel priority

snakemake advised me that I turn on strict channel priority. So I did. It is
likely best practice beyond snakemake too (from a reproducibility standpoint).

```
Your conda installation is not configured to use strict channel priorities.
This is however important for having robust and correct environments (for
details, see https://conda-forge.org/docs/user/tipsandtricks.html). Please
consider to configure strict priorities by executing 'conda config --set
channel_priority strict'.
```

```bash
conda config --set channel_priority strict
```

## Make equivalency

So yes, it is truly just like GNU make. If you change a script, it will update
everything downstream in the DAG. If you change a file (intermediate or input)
it will update everything downstream in the DAG. You can set up rules that
branch and turn. It all makes sense.

## DAG creation

If you want to visualise the pipeline, you'd normally need to make some kinda
mermaid diagram or perhaps hop into one of the many many flowchart creation
webapps out there. However, with snakemake, you can just create one:

```bash
snakemake --dag
```

This creates a `dot` language file. To render it as an svg, you need `dot` to
render the file. You can do this like so:

```bash
snakemake --dag | dot -Tsvg > filename.svg
```

## Configuration Files

You can specify the config file to use on the command line. This means it
should (in my opinion) be best practice to provide an example config file with
the repo and then people can copy this and make their changes. This way
multiple runs can be made yadah yadah yadah (same thing that's been said loads
of times before). What is nice is that the way snakemake uses the configuration
file causes it to be somewhat verified automatically. You can at the very
least ensure that all entries do indeed exist in the file (in case their config
file is outdated).

### Explicit checking

So there is a way to explicitly check the configuration file (with types and
all). You'd need to make a schema and then explictly validate it.

```
$schema: "https://json-schema.org/draft-06/schema#"

description: an entry in the sample sheet
properties:
  sample:
    type: string
    description: sample name/identifier
  condition:
    type: string
    description: sample condition that will be compared during differential expression analysis (e.g. a treatment, a tissue time, a disease)
  case:
    type: boolean
    default: true
    description: boolean that indicates if sample is case or control

required:
  - sample
  - condition
```

There's one bit I hate here, and that would be the fact that there is very
poor coupling between the schema and any example config files you want to give
for the user to actually edit. The best thing I can think of (that's not overly
advanced) would be to make a script that generates the example config file from
this schema.
