#!/bin/bash
set -euo pipefail
POS=$1
[ -f $POS ] || { echo "Not a file"; exit 1;}
COL=$(head -n 1 "$POS")
log(){
    echo "Validation Complete for $1 $(date)"
}
nullcheck()
{
    mapfile -t cols < <(head -n 1 "$POS" | tr ',' '\n')
    for C in "${cols[@]}"
    do
        COUNT=$(awk -F',' -v col="$C" '{print $col}' "$POS" | grep -c "NA" || true )
        ALL=$(awk -F',' -v col="$C" '{print $col}' "$POS" | wc -l)
        (( (COUNT/ALL)*10 < 1 )) || { echo "Too many nulls"; exit 1;}
    done
}
[[ $POS =~ .+\.csv$ ]] || { echo "Not a CSV file"; exit 1;}
DUP=$(tail -n +2 "$POS"| sort |uniq -D | wc -l)
echo "Duplicate rows: $DUP"
ROWS=$(wc -l < "$POS")
(( "$ROWS" > 200 )) || { "Not enough data"; exit 1;}
nullcheck
echo " ==== FULL DATASET SUMMARY ===="
echo "File: $POS"
pwd
head -n 1 "$POS"
echo "Duplicate rows: $DUP"
echo "Total rows: $ROWS"
echo "expected values for cols:" 

if [[ "$COL" =~ .+[A-Z,a-z,0-9],.+[A-Z,a-z,0-9] ]]; then
    echo "Check Passed"
else
    echo "Check Failed"; exit 1;
fi

log "$POS"










