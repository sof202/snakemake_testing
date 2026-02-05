# Reporting

So you can make quite nice reports with snakemake. This means you can do simple
things from including certain files (which can be downloaded straight from the
html file) and showing plots (make sure they aren't too big as there's no
zoomy) to more complex things like conditional statements and rendering other
markdown documents. 

This for example could be very useful in the BrainFANS DNAm QC pipeline.
Imagine if each individual bit of the pipeline that you wanted to run could be
placed into one html file (like the rmd file currently does) that shows how the
entire process of qc went, not just the specific rendered document.

## Statistics

You can see all of the stats of the workflow run that was used to generate the
report. This is nice (although admittedly the graphs are super small). You can
check which of your scripts are taking the longest time (for this repo, the
creation of data is milliseconds, but processing and plotting takes >10x the
length of time). If your rules are atomic, you could get quite a lot out of
this from a profiling perspective (considering there's lots of external tools
we use that we'd have to write wrappers for to time execution).

On the same statistics page you can also see when each of the rules were
last executed. This would obviously be most useful when you have lots of rules
as you won't always be executing all of them.


## Customisability

You can provide your own stylesheets to the rendering of the report (which
would allow you to do simple things like change colours and add a logo or
something).

You can also directly generate html (through perhaps a python function). I can
see someone using this in some niche cases (like conditionally adding a bit of
additional context to some weird part of a pipeline that had to run).

## Partial reports

By specifying a specific rule or file, you can make a partial report instead
of making the full thing (perhaps if you just wanted to make a quick update
without running the whole pipeline again).

## Possible gotcha

It got me at least. The report is using the runtime stats found inside the
`.snakemake/` directory. This means re-running the report isn't gonna change
anything in the report. You need to rerun the pipeline first. This feels
obvious now I've put it down. I think the syntax of a [partial
report](#partial-reports) confused me slightly.
