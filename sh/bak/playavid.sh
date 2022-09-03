#!/bin/sh
#$1 channelname
source ./sh/selectavid.src
folder=$(echo "${1}" | sed 's/\/$//')
if [ "$folder" == "" ]; then
	#>&2 echo "Pass name!"
	#exit 1
	folder="videos"
fi
id=$(selectavid "${folder}") || exit 1
#wget -q -O vid.json "https://damianfurrer.ch/yt/streams/$id"
echo "fetching stream"
vinf=$(curl "https://damianfurrer.ch/yt/streams/$id" 2> /dev/null)
err=$(jq '.error' <<< "${vinf}")
[ "$err" != "null" ] && jq '.message' <<< "${vinf}" >&2 && exit 1
stream=$(jq '.hls' <<< "${vinf}" | sed 's/^.//' | sed 's/.$//')
echo "mpv is loading video..."
mpv "${stream}" --no-terminal &
echo "(bg updating list..)"
./update.sh & #> /dev/null & #update in the background
wait $!
