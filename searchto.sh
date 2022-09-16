#!/bin/bash

./sh/update-ifseq.sh
[ "$(type -t prcvideo_loop)" == "function" ] || source ./sh/prcvideo-loop.src
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
#_pipedget "search?q=${url}&filter=videos" | jq -r '.items[].id' | prcloop # | search_video_prcloop
_pipedget "search?q=${url}&filter=videos" | jq -r '.items[]' | search_video "${1}" | prcvideo_loop \
"listen{;}126 kbps{x}132459{x}M4A{;}next"
