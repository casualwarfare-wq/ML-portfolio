#!/bin/bash
set -euo pipefail
POS=$1
log(){
    echo "Validation Complete for $1 $(date)"
}
[[ $POS =~ .+\.csv$ ]] || { echo "Not a CSV file"; exit 1;}
DUP=$(tail -n +2 "$POS"| sort |uniq -D | wc -l)
echo "Duplicate rows: $DUP"
ROWS=$(wc -l < "$POS")
(( $ROWS > 500 )) || { "Not enough data"; exit 1;}
NULL_ROWS=$(grep -c "NA" "$POS" || true)
(( ($NULL_ROWS/$ROWS)*10 < 10 )) || { echo "Too many nulls"; exit 1;}
echo " ==== FULL DATASET SUMMARY ===="
echo "File: $POS"
pwd
head -n 5 "$POS" | sort
echo "Duplicate rows: $DUP"
echo "Total rows: $ROWS"
echo "NULL Rows: $NULL_ROWS"
echo "expected values for cols: "
read FILE


COL=$(head -n 1 "$POS")
if [[ $FILE == "$COL" ]]; then
    echo "Check Passed"
else
    echo "Check Failed"; exit 1;
fi

log "$POS"









