#!/bin/sh
source sh/comments.src

./sh/update-ifseq.sh
vidid="GSfR3uHbh60"
curl "https://damianfurrer.ch/yt/comments/$vidid" 2>/dev/null | prccomments "$vidid" ""

#exit
#replies=$(curl "https://damianfurrer.ch/yt/comments/$vidid" | jq -r '.comments[1].repliesPage' | jq -sRr @uri)
#curl "https://damianfurrer.ch/yt/nextpage/comments/GSfR3uHbh60?nextpage=${replies}" | jq '.'

