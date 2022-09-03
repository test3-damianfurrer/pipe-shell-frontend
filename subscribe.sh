#!/bin/bash
./sh/update-ifseq.sh
source ./sh/getchannel.src
source ./sh/search-channel.src
source ./sh/setup.src

[ "$1" == "" ] && exit 1
#echo "#$1" >> channels.lst
#./sh/search-channel.sh "${1}" >> channels.lst
res=$(search_channel "${1}")
[ "$res" != "" ] && echo "#--$1" >> abos.lst && echo "${res}" >> abos.lst && echo "#++$1" >> abos.lst

while read chnl
do
  getchannel "${chnl}" | setup
done <<< "$res"
