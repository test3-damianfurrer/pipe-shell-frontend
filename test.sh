#!/bin/sh

teststreamsel(){
#$1 id

currpresel="48 kbps{x}54796{x}M4A"

source ./sh/test-prcvideo.src
vinf=$(cat 'inf.json' 2>/dev/null)
jq -r '.audioStreams[0]' <<< "${vinf}" | ./sh/streamselect

# | jq -j '.[]|.quality,.bitrate,"_",.format,"\n"'
# | ./sh/streamselect
# | streamselect "${currpresel}" # > /dev/null
}

teststreamsel2(){
#$1 id

for x in {1..1000}
do
 ./teststreamsel.sh > /dev/null 2> /dev/null
done
}
