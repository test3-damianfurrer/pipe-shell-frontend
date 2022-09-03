#!/bin/sh
#cd "$1" || exit 1
set -e

[ -d "${1}" ] || exit 1
channelid=$(cat "${1}/id.json")
foldername=$(basename $(pwd -P))
#echo "$channelid"

cd "channels/${foldername}"
for f in _uploaded/*
do
  if [ "$f" != "_uploaded/*" ]; then
    vid=$(cat "${f}/id.txt")
    ../../sh/rmvideo.sh "${vid}"
  fi
done

rm -r "_uploaded"
rm -r "_duration"
cd ../../
cd "channels"
rm -r "${foldername}"
cd ../channel_ids
rm "${channelid}"

#cp channels.lst channels2.lst
cat channels.lst | grep -v "$channelid" > channels.lst
#rm channels2.lst
#or cat channels.lst | grep -v "$channelid" > channels.lst

