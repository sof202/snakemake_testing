import os

def get_targets(wildcards):
    """Generate target files based on configuration file."""
    data_dir = config["data_directory"]
    samples = config["samples"]
    return [
        os.path.join(data_dir, sample + ".tsv") for sample in samples
    ]
