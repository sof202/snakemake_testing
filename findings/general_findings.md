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
