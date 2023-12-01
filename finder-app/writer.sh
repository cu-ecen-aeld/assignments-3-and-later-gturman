#!/bin/bash

#check for 2 args
if [ $# -ne 2 ]; then
    echo "Usage: $0 <writefile> <writestr>"
    exit 1
fi

writefile="$1"
writestr="$2"

mkdir -p "$(dirname $writefile)"
echo $writestr > $writefile

if [ $? -ne 0 ]; then
    echo "Error: Failed to write to $writefile"
    exit 1
fi

exit 0
