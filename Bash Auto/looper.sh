#!/bin/bash
SCRIPT=$1

[[ "$SCRIPT" =~ .+\.py$ ]] || (echo "Error: Please provide a Python script file."; exit 1)

echo "Enter number of times to run the script:"
read LOOPS
for ((i=1; i<=LOOPS; i++)); do
    echo "$i"
    python "$SCRIPT"
done
