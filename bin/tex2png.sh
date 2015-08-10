#!/bin/sh
# @liara

dati=${1%.*}

if [ -f $1 ];
then
    latex "$1" 
    dvips -Ppdf -G0 "$dati".dvi
    ps2pdf "$dati".ps
    pdftoppm -png "$dati".pdf > "$dati".png
    rm -f *.aux *.log *.out *.nav *.snm *.toc *.dvi *.ps
else
    echo "Invalid entry."
    exit 0
fi

# vim: set ft=sh ts=2 sw=2 tw=0 fenc=utf-8:
