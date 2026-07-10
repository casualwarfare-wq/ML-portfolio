#!/bin/bash
set -euo pipefail
trap "rm -rf temp" EXIT
mkdir -p temp
FILE="${FILE:-}"
OUTDIR="${OUTDIR:-OUT}"
url="${url:-}"

while [[ $# -gt 0 ]]; do
    case "$1" in
        --file)
            FILE="$2"
            shift 2
            ;;
        --url)
            url="$2"
            shift 2
            ;;
        --outdir)
            OUTDIR="$2"
            shift 2
            ;;
        *)
            echo "Unknown argument: $1 using default"
            shift
            ;;
    esac
done

if [ -f "$FILE" ]; then
    [ -d "$OUTDIR" ] || mkdir -p "$OUTDIR"
    [[ "$FILE" =~ .+\.csv$ ]] || FILE="Teen_Mental_Health_Dataset.csv"
    TIMESTAMP=$(date +%Y%m%d_%H%M%S)
    ./validator.sh "$FILE" || { echo "check failed aborting"; exit 1; }
    python explore.py "$FILE" "$OUTDIR/output_$TIMESTAMP.html" || { echo "EDA failed"; exit 1; }
elif [ -n "$url" ]; then
    [ -d "$OUTDIR" ] || mkdir -p "$OUTDIR"
    TIMESTAMP=$(date +%Y%m%d_%H%M%S)
    curl -fsSL --retry 3 --retry-delay 2 -o "temp/data.csv" "$url"
    sleep 20
    ./validator.sh "temp/data.csv" || { echo "check failed aborting"; exit 1; }
    python explore.py "temp/data.csv" "$OUTDIR/output_$TIMESTAMP.html" || { echo "EDA failed"; exit 1; }
else
    echo "Invalid source: must provide --file, --url"
    exit 1
fi
echo "hello"
