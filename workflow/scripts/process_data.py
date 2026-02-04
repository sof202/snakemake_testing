import pandas as pd
import numpy as np

REQUIRED_KEYS = {"x", "y"}


def add_sin_information(in_path, out_path, colnames):
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
            snakemake.input[0],
            snakemake.output[0],
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
