#!/bin/bash
set -euo pipefail
COM=$1
COL=$2
echo "What do you want to count in the column?"
read COUNT
awk -F',' -v col="$COL" '{print $col}' "$COM" | grep -n "$COUNT" | wc -l


