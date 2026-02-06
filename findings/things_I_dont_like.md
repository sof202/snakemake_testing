# Things I Don't Like

- I don't like how it feels like everything relies on relative paths
    - You need to be in a specific directory to run the snakemake file and
    most imports are relative. I say most as things like the configuration file
    would then not be relative to the snakefile, but relative to the working
    directory.
    - I just feel like this is not too well designed as it feels more like you
    should just have all of these files in a single flat directory. However, in
    their best practices document, they specify they want a specific directory
    format. So I'm not so sure.
- This point is solved (I think) by nextflow, but it is really difficult to
have similar workflows that we do now as we are attempting to update files all
of the time (not create new ones, we overwrite instead).
    - The solution here in snakemake is to simply use the `temp()` helper
    function so you don't end up wasting space on shit (and a bit of rewriting
    in the code).
    - If AI is to be trusted (this is not normally), failure to comply with
    this notion of not overwriting input files will result in jobs running
    infinitely (or in the case of sorting or similar, just twice).
        - And depending on how you write your workflow, the DAG might be all
        fucky
    - This really isn't a problem with snakemake, it's just the limitations of
    the design behind it.
