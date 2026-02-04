from pathlib import Path


def get_targets(wildcards):
    """Generate target files based on configuration file."""
    data_dir = Path(config["data_directory"])
    return data_dir / "plots" / "plot.png"
