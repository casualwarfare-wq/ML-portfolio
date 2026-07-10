import pandas as pd
import data_profiling as dp
import sys

if len(sys.argv) != 3:
    sys.exit("Must provide a csv file and output folder: ")

data = pd.read_csv(sys.argv[1])
graph = dp.ProfileReport(data)
graph.to_file(sys.argv[2])
