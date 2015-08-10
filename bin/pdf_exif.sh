#!/bin/bash
# @liara

echo "Do you want to change all files in this directory? Enter y or n: "
read dec

if [ "$dec" == "n" ]
then

    echo "Enter the name of the file: "
    read file

    echo "Enter Title: "
    read title

    echo "Enter Author: "
    read author

    echo "Enter Producer: "
    read producer

    echo "Enter Creator: "
    read creator

    exiftool -Title="$title" -Author="$author" -Producer="$producer" -Creator="$creator" $file
    rm *_original
elif [ "$dec" == "y" ]
then
    for file in *.pdf
    do 
        exiftool -Title=${file%.*} -Author="dos" -Producer="dos" -Creator="dos" -XMPToolkit="" -CreateDate="" -ModifyDate="" $file
        rm *_original
    done
else
    echo "Invalid argument."
fi

# vim: set ft=sh ts=4 sw=4 tw=0 fenc=utf-8:
