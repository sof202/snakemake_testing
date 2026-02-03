# Snakemake Vs Nextflow

I think its really gonna come down to the syntax of each tool and documentation
(and possibly just available workflows already made) for the most part here.

People on reddit are saying that nextflow has more 'bells and whistles' and
that groovy is a weird choice.

Someone put it quite nicely:

- snakemake works like GNU make and builds processes/dependencies backwards
from outputs
    - File oriented
- Nexflow implements the datastream programming pattern and models inputs and
outputs using the FIFO queues (channels as they call em).
    - Process oriented

The above has a big implication in terms of outputs. snakemake is about
creating files from other files, nextflow doesn't have this restriction.

Another guy says (on their blog):

> In Nextflow, the designer explicitly defines the relationship between
> processes and their order of execution by connecting their channels. This
> kind of step-by-step description of the operations used to compute a result
> is called imperative programming. In contrast, Snakemake takes a declarative
> approach where the user asks the program to compute a result, here a file
> output, and the program determines the operations needed to achieve that.

## Conclusion

I think you really should just try to make the same thing with both workflow
managers and see if you like it. If you're using them to use other people's
pipelines, then it really doesn't matter at all ay?

There's also the design aspect and how you wrap your head around them.

Nextflow:

- Processes and channels
- Processes are operations (input -> output)
- Advantages and disadvantages:
    - Intermediate files are cleaned up (outputs are explicit)
    - Channels carry messages between processes in discrete chunks. They match
    messages from multiple input channels, though not necessarily in the same
    order they are created
- The concurrency of nextflow can make pipelines faster, but you need to think
about the implications of this (race conditions or just tools that are not
designed with this in mind, *i.e.* need all data at once)
- Puts files into separate directories for each process


snakemake:

- Again, like GNU make
- There isn't a pipeline per se, it is more that you have a bunch of 
input/output files for each rule (how to get to output from input) and you
request that some output file is made.
- Keeps all files in directory of workflow definition (like a normal shell
script)
    - Gotcha moment with output directories are made automatically unless the
    directory is an explicit output (which can cause errors due to directory
    existence)


Is one better than the other? No.

