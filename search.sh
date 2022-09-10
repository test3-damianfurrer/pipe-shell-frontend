#!/bin/bash
./sh/update-ifseq.sh
[ "$(type -t prcvideo)" == "function" ] || source ./sh/prcvideo.src
[ "$(type -t search_video)" == "function" ] || source ./sh/search-video.src
[ "$(type -t search_video_prcloop)" == "function" ] || source ./sh/search-video-prcloop.src
[ "$(type -t urlencode)" == "function" ] || source ./sh/urlencode.src
[ "$(type -t _pipedget)" == "function" ] || source sh/_pipedget.src

[ "$1" == "" ] && exit
#vlist=$(./sh/search-video.sh "${1}") || exit 1
##actions=$(echo "view"; echo "description"; echo "next"; echo "exit")

#maybe use: 
#        ./sh/search-video-prcloop.sh <<< "${relstream}"
url=$(urlencode <<< "$1")
# 2>/dev/null
_pipedget "search?q=${url}&filter=videos" | jq '.items[]' | search_video_prcloop

exit

while read line
do
  echo "$line"
  prcvideo "$line" || exit
done <<< $(search_video "${1}") || exit 1
#done <<< $vlist
