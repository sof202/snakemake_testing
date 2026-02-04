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
