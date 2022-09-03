#!/bin/sh
source sh/prcplaylist.src
#prcplaylist "PLUlK5tPwfK5ICvNt_3XyFrsu_BE2NerpJ" # $1
if [ "$1" != "" ]; then
  prcplaylist "$1"
else
  prcplaylist $(cat play.list | dmenu -l 10 -p 'list' | awk '{print $1}' FS=';')
fi
