#!/bin/sh
set -e
# in .videoStreams
streaminfos=$(cat -)

quals=$(jq -j '.[]|.quality,.bitrate,"_",.format,"\n"' <<< "${streaminfos}") 
declare -i index
index=$(grep -n "$(dmenu -l 10 -p Quality <<< "$quals")" <<< "$quals" | awk '{print $1}' FS=':')
index=$(($index-1))
jq -r ".[$index]" <<< "${streaminfos}"
