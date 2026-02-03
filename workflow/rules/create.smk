rule create_data:
    input:
        "data/input/{sample}.txt"
    output:
        "data/{sample}.tsv"
    shell:
        "generate_data_snakemake {input} > {output}"
