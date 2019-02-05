#why ?
Unfortunately convert changes the image, which is very important to CBR and CBZ, so to have no loss of quality, practically using the original jpg inside the CBR(CBZ) you need to use img2pdf, I use this commands:

1) This to make a pdf file out of every jpg image without loss of either resolution or quality:
```
ls -1 ./*jpg | xargs -L1 -I {} img2pdf {} -o {}.pdf
```
2) This to concatenate the pdfpages into one:
```
pdftk *.pdf cat output combined.pdf
```
I made this batch files

#./cbr2pdf.sh:
```
	#!/bin/bash
	#set -xev
	ORIGINAL_FOLDER=`pwd` 
	JPEGS=`mktemp -d`
	unrar e "$1" "$JPEGS"
	cd "$JPEGS"
	ls -1 ./*jpg | xargs -L1 -I {} img2pdf {} -o {}.pdf
	pdftk *.pdf cat output combined.pdf
	cp "$JPEGS/combined.pdf" "$ORIGINAL_FOLDER/$1.pdf"
```

cat cbz2pdf.sh
```
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

```
	

To convert all cbr and cbz in folder and subfolder:

```	
	tree -fai . | grep -P "cbr$" | xargs -L1 -I{} ./cbr2pdf.sh {}
```
and

```	
	tree -fai . | grep -P "cbz$" | xargs -L1 -I{} ./cbz2pdf.sh {}
```
