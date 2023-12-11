#!/bin/bash
# script to generate pdf file from .lyx document and reduce its size

# run lyx pdflatex, this creates an enormous pdf
lyx -e pdf2 Requirements.lyx

# reduce size document through gostscript
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile=verwarming.pdf Requirements.pdf
