#!/bin/bash
#$1 id

currpresel="48 kbps{x}54796{x}M4A"

source ./sh/test-prcvideo.src
vinf=$(cat 'inf.json' 2>/dev/null)
jq -r '.audioStreams' <<< "${vinf}" #| jq -j '.[]|.quality,.bitrate,"_",.format,"\n"' | streamselect "${currpresel}" # > /dev/null
