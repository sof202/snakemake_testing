from snakemake.script import snakemake
import pandas as pd
import numpy as np

def add_sin_information(in_path, out_path):
    data_frame = pd.read_csv(in_path, names=["x"])
    data_frame["y"] = np.sin(data_frame["x"])
    data_frame.to_csv(out_path, sep="\t", index=False)


if __name__ == "__main__":
    add_sin_information(snakemake.input[0], snakemake.output[0])
