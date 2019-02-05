#!/bin/bash
set -xev
ORIGINAL_FOLDER=`pwd` 
JPEGS=`mktemp -d`
cp "$1" "$JPEGS"
cd "$JPEGS"
7z e "$1" 
ls -1 ./*jpg | xargs -L1 -I {} img2pdf {} -o {}.pdf
pdftk *.pdf cat output combined.pdf
cp "$JPEGS/combined.pdf" "$ORIGINAL_FOLDER/$1.pdf"
