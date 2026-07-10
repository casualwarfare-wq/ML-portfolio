#!/bin/bash
POS=$1
filecheck() {
    if [ -f "$1" ]; then
        echo "File: $1"
        pwd "$1"
        #cat "$1"
        case "$1" in
            *.txt) echo "Text file";;
            *.csv) echo "CSV file";;
            *.json | *.html | *.css | *.js) echo "Web file";;
            *.sh) echo "Shell script";;
            *.py) echo "Python script";;
            *.java | *.class) echo "Java file";;
            *.mp3 | *.wav | *.flac | *.aiff | *.wma | *.aac | *.ogg |*.m4a) echo "Audio file";;
            *.mp4 | *.avi | *.mov | *.mkv | *.flv | *.wmv | *.webm | *.mpeg | *.mpg) echo "Video file";;
            *.jpg | *.jpeg | *.png | *.bmp | *.tiff | *.svg) echo "Image file";;
            *.gif) echo "GIF file";;
            *.pdf) echo "PDF file";;
            *.zip | *.tar | *.gz | *.rar | *.7z) echo "Compressed file";;
            *.cpp | *.cc | *.cxx | *.C | *.c | *.c++) echo "C/C++ source file";;
            *) echo "Random File";;
        esac
    else 
        echo "Not a file dumbass"
    fi
}

dircheck() {
    if [ -d "$1" ]; then
        echo "Directory: $1"
        pwd "$1"
        ls -l "$1"
        find "$1"
        for file in "$1"/*; do
            if [ -f "$file" ]; then
                filecheck "$file"
            elif [ -d "$file" ]; then
                dircheck "$file"
            fi
        done
    else
        echo "Not a directory dumbass"
    fi
}

filecheck "$POS"
dircheck "$POS"

