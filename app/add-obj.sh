#!/bin/bash

FILE=''
while read LINE; do
    FILE+="${LINE}\n"
done
SESSION=`git log -1 --pretty=format:"%s" | grep -o 's:[[:digit:]]*\>' `
SESSION=${SESSION/s:/}
OBJ=`git log -1 --pretty=format:"%s" | grep -o 'o:[[:digit:]]*\>'`
OBJ=${OBJ/o:/}
IFS=$'\n'
SESSION_OBJS=( $(wget http://objiv-jmerelo.rhcloud.com/get/$SESSION -q -O - ) )  
unset IFS
((OBJ_IDX=OBJ-1))
echo -e $FILE
echo ${SESSION_OBJS[$OBJ_IDX]/[ ]/X}
