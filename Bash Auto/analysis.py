import os
import sys
import pandas as pd


if len(sys.argv) != 2:
    print("Please provide the input csv name as an argument.")
    sys.exit(1)

input_path = sys.argv[1]

lot = pd.read_csv(input_path)
lot = lot.ffill()
lot.to_csv("OUTPUT/lot.csv", index=False)









