#!/bin/sh
relstream=$(cat -)
while read relv
do
	./sh/prcvideo.sh "$relv"
done <<< $(./sh/search-video-prc.sh <<< "${relstream}")
