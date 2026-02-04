from snakemake.script import snakemake
import pandas as pd
import numpy as np


def add_sin_information(in_path, out_path, colnames):
    x_col_name = colnames["x"]
    y_col_name = colnames["y"]

    data_frame = pd.read_csv(in_path, names=[x_col_name])
    data_frame[y_col_name] = np.sin(data_frame[x_col_name])
    data_frame.to_csv(out_path, sep="\t", index=False)


if __name__ == "__main__":
    add_sin_information(
        snakemake.input[0],
        snakemake.output[0],
        snakemake.config["column_names"],
    )
