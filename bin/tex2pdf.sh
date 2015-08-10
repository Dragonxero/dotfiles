#!/bin/sh
# @liara

if [ -f $1 ];
then
    pdflatex --shell-escape "$1"
    rm -f *.aux *.log *.out *.nav *.snm *.toc
else
    echo "Invalid entry."
    exit
fi

# vim: set ft=sh ts=2 sw=2 tw=0 fenc=utf-8:
