rule process_data:
    input:
        "{data_directory}/{sample}.tsv"
    output:
        "{data_directory}/{sample}_dataframe.tsv"
    conda:
        "../envs/pandas.yaml"
    script:
        "../scripts/process_data.py"

