#!/bin/bash
# $1 if file or directory contaaining *.jpg files

PATH=$1
WATERMARK="/mnt/h/kostyymilaenutus/logod ja watermargid/watermark300.png"
# $1 file with ful path
# saves file in same dir, with extra jpg extension
function processFile {
        FILE=$1    
        if [ -n "$1" ] && [ -f $FILE ]; then 
                echo watermark processing $FILE
                if [ -f $FILE.jpg ]; then
                        echo "WARNING: Output file $FILE.jpg already exist, overwrite ? [y/N]"
                        read -n1 X
                        if [ $X != 'y' ]; then exit 1; fi
                fi
                /usr/bin/composite -dissolve 40% -gravity center "$WATERMARK" $FILE $FILE.jpg                
        else
                echo ERROR: file $FILE not found
        fi
}

if [ -z "$1" ]; then 
        echo "Usage $0 {file|dir}"
elif [ -d $PATH ]; then
        echo processing directory $PATH
        for f in $PATH/*.jpg.jpg; do
                processFile $f
        done 
else
        processFile $PATH 
fi
