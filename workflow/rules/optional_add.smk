rule add_one:
    input:
        "{data_directory}/input/{sample}.txt"
    output:
        "{data_directory}/{sample}_plus_one.txt"
    script:
        "../scripts/add_one.sh"

