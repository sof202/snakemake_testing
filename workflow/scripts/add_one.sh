#!/bin/bash

# This is to get shellcheck to shut the fuck up about these associative arrays
# not existing.
declare -A snakemake_input snakemake_output

echo "Adding one to the value found in ${snakemake_input[0]}"
read -r value < "${snakemake_input[0]}"
new_value=$((value + 1))
echo "${new_value}" > "${snakemake_output[0]}"
