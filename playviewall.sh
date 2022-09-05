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
retc=0
#while [ $retc -eq 0 ]
#do
declare -i i
i=1
while [ $i -le 100 ]
do
 ##newest, random, shortest
  id=$(selectavid "${folder}" "newest" $i) || exit 1
  prcvideo "${id}" "view+{;}qualselect{;}480p{x}530106{x}MPEG_4{v-a}126 kbps{x}132459{x}M4A{;}next" || retc=$?
  i+=1
done
#done
