from pathlib import Path


def get_targets(wildcards):
    """Generate target files based on configuration file."""
    data_dir = Path(config["data_directory"])
    return data_dir / "plots" / "plot.png"

def get_add_targets(wildcards):
    """Generate target files based on configuration file."""
    data_directory = Path(config["data_directory"])
    samples = config["samples"]
    return [
        data_directory / f"{sample}_plus_one.txt" for sample in samples
    ]

