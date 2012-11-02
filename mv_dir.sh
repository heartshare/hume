#!/bin/sh

for dir in `ls | grep "objects2*" `
do
    mv $dir b_$dir
done
