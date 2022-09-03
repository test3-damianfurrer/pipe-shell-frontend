#!/bin/sh
source ./sh/getchannel.src
source ./sh/setup.src

list=$(grep -v '#' abos.lst)
lines=$(echo "$list" | wc -l)
declare -i i
i=1

prcl(){
  if [ "$1" != "" ]; then
    chnljson=$(getchannel "${1}")
    lvid=$(jq -r '.relatedStreams[0].id' <<< "${chnljson}")
  [ -d "videos/$lvid" ] || setup <<< "${chnljson}" 1>&2 # &
  fi
}

#while read line
#do
#   prcl "${line}" > /dev/null 2>&1 &
#done <<< $list


while read line
do
   printf '%s   \r' "$i/$lines"
   i+=1
   prcl "${line}"
done <<< $list

#pgrep -c -P $$
