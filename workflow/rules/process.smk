rule process_data:
    input:
        "{data_directory}/{sample}.tsv",
    output:
        report(
            "{data_directory}/{sample}_dataframe.tsv", caption="../report/process.rst"
        ),
    conda:
        "../envs/pandas.yaml"
    script:
        "../scripts/process_data.py"
