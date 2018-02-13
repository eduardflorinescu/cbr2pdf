#!/bin/bash
set -xev
ORIGINAL_FOLDER=`pwd` 
JPEGS=`mktemp -d`
unrar e "$1" "$JPEGS"
cd "$JPEGS"
ls -1 ./*jpg | xargs -L1 -I {} img2pdf {} -o {}.pdf
pdftk *.pdf cat output combined.pdf
cp "$JPEGS/combined.pdf" "$ORIGINAL_FOLDER/$1.pdf"

