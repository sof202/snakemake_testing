# Job Scheduler

So this is possible, but you need to install plugins for it to work with
something like slurm. This is to be expected due to the huge number of
different schedulers and environments in which one might want to run a
snakemake workflow.

From the plugins I've looked at:

- usage is super simple, just an additional command line argument
- There's workarounds in case you bump into problems
    - Specifying a certain max ram/time
    - Passing as a script instead of a command

You can also just put a bit in the settings to specify the executor (so you
don't need to specify from the command line every time).

We can always make our own wrapper for pigeon/isca too (as it would appear that
the people at Gustave Roussy did this). We can always copy them on this too.
