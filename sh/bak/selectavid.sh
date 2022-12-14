#!/bin/sh
#$1 channelname or videos for all
if [ "$1" == "" ]; then
  >&2 echo "Pass name!"
  exit 1
fi
order=$((echo "newest"; echo "shortest"; echo "oldest"; echo "longest") | dmenu -l 5 -p "Sorting: ")

[ "$order" == "" ] && exit 1

cd "${1}"
if [ "$order" == "newest" ]; then
	order="_uploaded"
fi
if [ "$order" == "oldest" ]; then
	order="_uploaded"
	reverse="1"
fi
if [ "$order" == "shortest" ]; then
	order="_duration"
	reverse="1"
fi
if [ "$order" == "longest" ]; then
	order="_duration"
fi

cd "$order"

#if [ "$reverse" == "" ]; then
#vidfolder=$(ls | sort -n -r | sed 's/$/\/thumb.webp/' | /home/damian/source-code/sxiv/sxiv-test -oi1l | sed 's/\/thumb.webp//')
#else
#vidfolder=$(ls | sort -n | sed 's/$/\/thumb.webp/' | /home/damian/source-code/sxiv/sxiv-test -oi1l | sed 's/\/thumb.webp//')
#fi
if [ "$reverse" == "" ]; then
vidfolder=$(ls | awk '{print $0,gsub("^[0-9]{1,}_","",$0),$0}' OFS="/" | sed 's/\/[0-9]\//\//' | sort -n -r | head -n 100 | /home/damian/source-code/sxiv/sxiv-test -oi1l | awk '{print $1}' FS='/')
else
vidfolder=$(ls | awk '{print $0,gsub("^[0-9]{1,}_","",$0),$0}' OFS="/" | sed 's/\/[0-9]\//\//' | sort -n | head -n 100 | /home/damian/source-code/sxiv/sxiv-test -oi1l | awk '{print $1}' FS='/')
fi
#echo "${vidfolder}"
#exit

if [ "${vidfolder}" == "" ]; then
	exit 1
else
	#cd "${vidfolder}"
	#cat id.txt
	cat "${vidfolder}/id.txt"
fi
