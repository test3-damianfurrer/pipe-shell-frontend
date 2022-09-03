#!/bin/sh
#$1 channel id
mkdir -p find
menu=$(echo "videos";echo "next page";echo "exit";)
channelinfo=$(curl "https://damianfurrer.ch/yt/channel/$1" 2>/dev/null)
sel=$(dmenu -l 5 -p "Action" <<< "$menu")
while [ "$sel" != "exit" ]
do
  sel2=$(echo "$sel")
  sel=""
  case "$sel2" in
  "videos")
	jq '.relatedStreams[]' <<< "${channelinfo}" | ./sh/search-video-prcloop.sh;; #./sh/search-video-prc.sh;;
  "prev page")
	channelinfo=$(echo "${prevpage}")
	prevpage=""
	menu=$(echo "videos";echo "next page"; echo "exit";)
	sel="videos"
  ;;
  "next page")
        menu=$(echo "videos";echo "next page";echo "prev page"; echo "exit";)
	prevpage=$(echo "${channelinfo}")
	nextpage=$(jq -r '.nextpage' <<< "${channelinfo}" | jq -sRr @uri) #| sed 's/\\"/"/g' | sed 's/\&/%26/g')
        channelinfo=$(curl "https://damianfurrer.ch/yt/nextpage/channel/$1?nextpage=${nextpage}" 2> /dev/null)
	sel="videos"
  ;;
  *)
  ;;
  esac
  [ "$sel" == "" ] && sel=$(dmenu -l 5 -p "Action" <<< "$menu")

done
#exit
##curl "https://damianfurrer.ch/yt/search?q=${1}&filter=videos" 2>/dev/null 
#cat result.json | jq '.items[]' > "result.json"
#cd ..
##./sh/search-video-prc.sh
