#!/bin/bash
DIR="./*"

for file in $DIR; do
    [ -e "$file" ] || continue
    if [ -d "$file" ]; then
        for subfile in "$file"/*; do
            [ -f "$subfile" ] || continue
            echo "Checking $subfile"
                if [[ "$subfile" == "$file"/pyvenv.cfg ]]; then
                    echo "True: there is a python virtual environment in $DIR"
                    exit 0
                fi
        done
    fi
done
echo "False: there is no python virtual environment in $DIR"







