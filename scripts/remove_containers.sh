#!/bin/bash
filename='containers'
exec < $filename

while read line
do
  docker rm -f $line
done