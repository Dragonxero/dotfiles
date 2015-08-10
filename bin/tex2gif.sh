#!/bin/sh

dati=${1%.*}

if [ -f $1 ];
then
    latex "$1" 
    dvips -Ppdf -G0 "$dati".dvi
    ps2pdf "$dati".ps
    convert -delay 10 -loop 0 -density 200 -alpha off "$dati.pdf" "$dati.gif"
    rm -f *.aux *.log *.out *.nav *.snm *.toc *.dvi *.ps
else
    echo "Invalid entry."
    exit
fi
