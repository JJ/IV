#!/bin/bash

FILE=''
while read LINE; do
    FILE+="${LINE}\n"
done
COMMIT_MESSAGE=`git log -1 --pretty=format:"%s"`
echo -e $FILE
echo $COMMIT_MESSAGE