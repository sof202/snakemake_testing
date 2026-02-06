# General Findings

## Publishing/Finding Workflows

There exists [WorkflowHub](https://workflowhub.eu/). Which some of us might
find useful. Not only would you be able to find workflows to use, but it would
probably be a great place to share a workflow beyond just GitHub. I imagine
that it helps massively with adhering to best practices as they'll actually be
enforced here.

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

## GitHub AI usage

So in the last section I spoke of fixing an issue I found for snakemake. They
are using coderabbit (lazyness) to review code reviews. I hope that they aren't
using this religously. It made some suggestions that are just false and one of
the changes was, although correct (which was very useful) gave me a solution
that completely went against the current style of implementation. It also
didn't catch a way worse bug (which admittedly was rather difficult to spot).

My main issue with these code review agents is that maintainers will stop
actually looking at the code review and instead just refer to the agent. This
means potentially bad code can go in, while potentially good code can be
rejected. I will rescind these comments if I don't see evidence of this of
course.

## Wrappers and modularity

I'm not gonna use it here as there's no point. But it is possible to add
wrappers to your rules which means you don't have to type out the command
yourself. I'm not sure if this is best practice, but it could be useful if you
don't want to create loads of containers (as the wrapper will come with one).

For example, there is one for
[`samtools sort`](https://github.com/snakemake/snakemake-wrappers/blob/master/bio/samtools/sort/wrapper.py)
which comes with a conda environment with minimal dependencies. This seems very
useful for the average bioinformatics workflow (there's tonnes of these
wrappers too).

In terms of modularity, provided you put grouped rules into individual `.smk`
files (like done in this repo) you can choose to `include` whichever rules you
want. This even works a step further as you can import rules from other git
repositories online (be that your own or others). This saves you on writing the
same shit over and over again.

### Configuration

So all of these snakemake workflows come with a configuration file right? Well
it would be a spot of bother if you were bound to how they defined it. So you
can actually override this config when importing a module (which is lovely).
It would appear that best practice here says you should nest their config file
into your own (under a section named after the workflow it is for).

## Common Workflow Language (CWL)

I think this allows for interoperability between snakemake and nextflow
(primarily, its a common language and so in principle all workflow managers
could use this). Look
[here](https://snakemake.readthedocs.io/en/stable/snakefiles/modularization.html#common-workflow-language-cwl-support)
for details.

## Deployment

This would be super fuckin useful for something like the isoforms.com project.
You can specify (with the correct plugin) a destination that isn't just a local
file. For example, you could put the final output onto an aws s3 bucket. This
way, every time you update your code or an intermediate file in the analysis
(gtf files here), you will be able to re-upload to aws with the click of a
button (super useful).

If you are to use this, you should probably start being more explicit in your
file paths (for example, wrapping local files with `local()`).
