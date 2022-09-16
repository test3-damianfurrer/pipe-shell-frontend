#!/bin/bash
#$1 channelname
./sh/update-ifseq.sh

source ./sh/selectavid.src
source ./sh/prcvideo.src

folder=$(echo "${1}" | sed 's/\/$//')
if [ "$folder" == "" ]; then
        #>&2 echo "Pass name!"
        #exit 1
        folder="videos"
fi
./update.sh &
sorting=$(getselectionmodes | _menu 5 "Sorting")
retc=0
#while [ $retc -eq 0 ]
#do
declare -i i
i=1
while [ $i -le 100 ]
do
  id=$(selectavid "${folder}" "$sorting" $i) || exit 1
  prcvideo "${id}" "view+{;}listen{;}126 kbps{x}132459{x}M4A{;}next" || retc=$?
  i+=1
done
#done
