#!/bin/bash
source sh/comments.src

./sh/update-ifseq.sh
vidid="GSfR3uHbh60"
_pipedget "comments/$vidid" | prccomments "$vidid" ""

#exit
#replies=$(curl "0/comments/$vidid" | jq -r '.comments[1].repliesPage' | jq -sRr @uri)
#curl "nextpage/comments/GSfR3uHbh60?nextpage=${replies}" | jq '.'

