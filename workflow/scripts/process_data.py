from pathlib import Path
import pandas as pd
import numpy as np

REQUIRED_KEYS = {"x", "y"}


def add_sin_information(
    in_path: Path, out_path: Path, colnames: dict[str, str]
):
    """Add sine-transformed column to data.

    Reads a CSV file with x-values, computes sin(x) for each value,
    and writes the result as a tab-separated file.

    Args:
        in_path: Path to input CSV file (single column expected).
        out_path: Path where output TSV file should be written.
        colnames: Dictionary with required keys:
            - "x": Name of the input column.
            - "y": Name to use for the output sine column.

    Raises:
        ValueError: If colnames doesn't contain required keys.
        FileNotFoundError: If input file doesn't exist.
        KeyError: If specified column names conflict with pandas operations.

    """
    if not REQUIRED_KEYS.issubset(colnames.keys()):
        raise KeyError(
            f"Your configuration is malformed. "
            f"Please check that column_names indeed contains: {REQUIRED_KEYS}"
        )

    x_col_name = colnames["x"]
    y_col_name = colnames["y"]

    data_frame = pd.read_csv(in_path, names=[x_col_name])
    data_frame[y_col_name] = np.sin(data_frame[x_col_name])
    data_frame.to_csv(out_path, sep="\t", index=False)


if __name__ == "__main__":
    try:
        from snakemake.script import snakemake

        add_sin_information(
            Path(snakemake.input[0]),
            Path(snakemake.output[0]),
            snakemake.config["column_names"],
        )

    except ImportError:
        print(
            "Error: Script executed outside Snakemake context. ",
            "Please only use this via the `snakemake` workflow manager.\n",
            "To do this, use `snakemake --cores all --sdn conda`",
        )
    except KeyError as e:
        print(f"ERROR: {e}")
