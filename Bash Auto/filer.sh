#!/bin/bash
if (($# >= 2))
then    
    DIR=$1
    shift
    NAMES=("$@")
elif (($# == 1))
then
    DIR=$1
    echo "Enter an array of names separated by spaces:"
    read -a NAMES
    echo "${NAMES[@]}"
else
    echo "Usage: $0 <path> <name1 name2 ...>"
    exit 1
fi
count=0
for file in "$DIR"/*; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        extension="${filename##*.}"
        new_name="${NAMES[$count]}.$extension"
        mv "$DIR/$filename" "$DIR/$new_name"
        echo "Renamed $file to $new_name"
        ((count++))
    fi
done






