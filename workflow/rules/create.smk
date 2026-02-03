rule create_data:
    input:
        "data/input/file.txt"
    output:
        "data/data.tsv"
    shell:
        "generate_data_snakemake {input} > {output}"

