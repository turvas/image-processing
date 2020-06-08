#!/bin/bash
# $1 if file or directory contaaining *.jpg files

# read APIKEY
source remove-bg.apikey
PATH=$1

# $1 file with ful path
# saves file in same dir, with extra jpg extension
function processFile {
        FILE=$1    
        if [ -n "$1" ] && [ -f $FILE ]; then 
                echo processing $FILE
                /usr/bin/curl -H "X-API-Key: $APIKEY"            \
                        -H "accept: image/*"            \
                        -F "image_file=@$FILE"          \
                        -F "format=jpg"                 \
                        -X POST https://api.remove.bg/v1.0/removebg -o $FILE.jpg
        else
                echo ERROR: file $FILE not found
        fi
}

if [ -z "$1" ]; then 
        echo Current credit:
        /usr/bin/curl -sS -H "X-API-Key: $APIKEY" -H  'accept: */*' -X GET https://api.remove.bg/v1.0/account | /usr/bin/jq

elif [ -d $PATH ]; then
        echo processing directory $PATH
        for f in $PATH/*.jpg; do
                processFile $f
        done 
else
        processFile $PATH 
fi
