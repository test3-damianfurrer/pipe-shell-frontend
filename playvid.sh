#!/bin/sh
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
while [ $? -eq 0 ]
do
  id=$(selectavid "${folder}") || exit 1
  ./update.sh &
  prcvideo "${id}"

done
