# EDA Pipeline

Containerized EDA tool. Accepts a dataset via URL or local file, runs ydata-profiling, outputs a timestamped HTML report.

## Usage
docker build -t edaproject-server .

# URL:
docker run -v $(pwd)/output:/app/output edaproject-server --url "<url>" --outdir /app/output

# Local file:
docker run -v $(pwd)/output:/app/output -v <local-csv-path>:/app/input.csv edaproject-server --file /app/input.csv --outdir /app/output

## Requirements
See requirements.txt

## For unintended uses
If you do a file for anything other than a csv the program will do a default csv instead. For more complex urls that don't have a direct link to a csv or require api auth this script will not work. 
