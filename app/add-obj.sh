#!/bin/bash

FILE=''
while read LINE; do
    FILE+="${LINE}\n"
done
echo "Read file"
SESSION=`git log -1 --pretty=format:"%s" | grep -o 's:[[:digit:]]*\>' `
SESSION=${SESSION/s:/}
OBJ=`git log -1 --pretty=format:"%s" | grep -o 'o:[[:digit:]]*\>'`
OBJ=${OBJ/o:/}
SESSION_OBJS=( $(wget http://objiv-jmerelo.rhcloud.com/get/$SESSION -q -O -)) 
echo $SESSION_OBJS[0]

echo -e $FILE
echo $COMMIT_MESSAGE