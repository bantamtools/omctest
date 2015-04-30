#!/bin/bash

filepath=/Users/jbeckman/Desktop   # modify as desired
interval=20                         # reports per minute
timelimit=6000                      # how long to run, in seconds

mydate=`date "+%H:%M:%S"`           # the timestamp
freq=$((60/$interval))              # for sleep function
echo "TIME	%CPU	%MEM	STATE	RSS" > $filepath/$2.txt

while [ "$SECONDS" -le "$timelimit" ] ; do
  #ps -p$1 -opid -opcpu -ocomm -c | grep $1 | sed "s/^/$mydate /" >> $filepath/$2.txt
  ps -p$1 -o %cpu=,%mem=,state=,rss= | sed "s/^/$mydate /" >> $filepath/$2.txt
  sleep $freq
  mydate=`date "+%H:%M:%S"`
done
