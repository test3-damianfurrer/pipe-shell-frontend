#!/bin/bash
#$1 id

for x in {1..1000}
do
 ./teststreamsel.sh > /dev/null 2> /dev/null
done
