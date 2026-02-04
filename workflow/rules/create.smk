rule create_data:
    input:
        "{data_directory}/input/{sample}.txt",
    output:
        "{data_directory}/{sample}.tsv",
    shell:
        "generate_data_snakemake {input} > {output}"
