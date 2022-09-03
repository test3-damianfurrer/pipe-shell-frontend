#!/bin/sh
mkdir -p find
#cd search
#wget -q -O "result.json" "https://damianfurrer.ch/yt/search?q=${1}&filter=videos"
url=$(printf '%s' "${1}" | jq -sRr @uri) ##urlencode search query
curl "https://damianfurrer.ch/yt/search?q=${url}&filter=videos" 2>/dev/null | jq '.items[]' | ./sh/search-video-prc.sh
#exit
##curl "https://damianfurrer.ch/yt/search?q=${1}&filter=videos" 2>/dev/null 
#cat result.json | jq '.items[]' > "result.json"
#cd ..
##./sh/search-video-prc.sh
