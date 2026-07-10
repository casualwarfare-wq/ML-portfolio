#!/bin/bash 
set -euo pipefail
TIME=$(date +%Y-%m-%d_%H-%M-%S)
Dir=$1
COM=$2
[ -d "$Dir" ] || mkdir "$Dir"
python analysis.py $COM | sort -t',' -k2 "$Dir/lot.csv" > "$Dir/run_$TIME.log"

tr -d '\r' eda.sh tmp && mv tmp eda.sh







