rule plot_data:
    input:
        expand(
            "{data_directory}/{sample}_dataframe.tsv",
            data_directory=config["data_directory"],
            sample=config["samples"],
        ),
    output:
        report(
            "{data_directory}/plots/plot.png",
            caption="../report/plot.rst",
        ),
    conda:
        "../envs/R_ggplot2.yaml"
    script:
        "../scripts/plot_data.R"
