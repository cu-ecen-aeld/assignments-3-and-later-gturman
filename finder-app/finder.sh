#!/bin/bash

#runtime arg 1 filesdir - path to a dir
#runtime arg 2 searchstr - string to search

if [ $# -ne 2 ]; then
    echo "Usage: $0 <filesdir> <searchstr>"
    exit 1
fi

filesdir=$1
searchstr=$2

if [ ! -d $filesdir ]; then
    echo "Error: $filesdir is not a directory or does not exist."
    exit 1
fi 

#if success, exit 0
#if fail, exit 1
#fail if args unspecified
#fail if filesdir is not a directory

fileMatch=0
lineMatch=0

for result in $(grep -crh $searchstr $filesdir); do
    lineMatch=$((lineMatch+result))
    let fileMatch++
done

echo "The number of files are $fileMatch and the number of matching lines are $lineMatch"
#x = number of files in dir and subdirs
#y = number of matching lines found, i.e. contains searchstr

exit 0
