#!/bin/sh
#tst(){
#  "subtitles"
#      "url"
#      "mimeType"
#      "name"
#      "code"
#      "autoGenerated"
#}

[ "$1" == "" ] && exit
#  actions=$(echo "next"; echo "view"; echo "info"; echo "description"; echo "related"; echo "view+"; echo "exit")
  actions=$(echo "next"; echo "view"; echo "info"; echo "related"; echo "view+"; echo "exit")
  vinf=$(curl "https://damianfurrer.ch/yt/streams/$1" 2>/dev/null)
  title=$(jq -r '.title' <<< "${vinf}")
#  curl "https://damianfurrer.ch/yt/streams/$1" 2>/dev/null | jq '.'
#  exit
  relstream=""
  sel=$(echo "$actions" | dmenu -l 5 -p "${title}")
  while [ "$sel" != "next" ]
  do
    case "$sel" in
      "showtmp")
	sxiv tmp.webp;sel="";;
      "back")
	sel="";;
      "view")
        stream=$(jq -r '.hls' <<< "${vinf}")
        mpv "$stream"
	sel=""
      ;;
      "qualselect")
	./sh/ffmpeg-video.sh <<< "${vinf}"
	sel=""
      ;;
      "view+")
	sel=$((echo "view&"; echo "qualselect";echo "listen"; echo "back";) | dmenu -l 10 -p "view+")
	#sel="view&"
      ;;
      "listen")
        stream=$(jq -r '.audioStreams' <<< "${vinf}" | ./sh/streamselect.sh | jq -r '.url')
	mpv "$stream"
	sel=""
      ;;
      "view&")
        stream=$(jq -r '.hls' <<< "${vinf}")
        mpv "$stream" --no-terminal &
	sel=""
      ;;
      "description")
        xmsgtext=$(jq -r '.description' <<< "${vinf}" | sed 's/<a .{1,}>//g' | sed 's/<\/a>//g' | sed 's/\\n/\n/g' | sed 's/<br>/\n/g')
	xmessage -file - -default "okay" <<< "$xmsgtext"
	sel=""
      ;;
      "related")
	[ "$relstream" == "" ] && relstream=$(jq '.relatedStreams[]' <<< "${vinf}")
	#echo "$relstream" > search/result.json
	./sh/search-video-prcloop.sh <<< "${relstream}"
	#while read relv
	#do
	#  ./sh/prcvideo.sh "$relv"
	#done <<< $(./sh/search-video-prc.sh <<< "${relstream}")
	sel=""
      ;;
      "info")
	uploadDate=$(jq '.uploadDate' <<< "${vinf}" | sed 's/^"//' | sed 's/"$//')
	dash=$(jq '.dash' <<< "${vinf}" | sed 's/^"//' | sed 's/"$//')
	lbryId=$(jq '.lbryId' <<< "${vinf}" | sed 's/^"//' | sed 's/"$//')
	duration=$(jq '.duration' <<< "${vinf}" | sed 's/^"//' | sed 's/"$//')
	views=$(jq '.views' <<< "${vinf}" | sed 's/^"//' | sed 's/"$//')
	likes=$(jq '.likes' <<< "${vinf}" | sed 's/^"//' | sed 's/"$//')
	dislikes=$(jq '.dislikes' <<< "${vinf}" | sed 's/^"//' | sed 's/"$//')
	livestream=$(jq '.livestream' <<< "${vinf}")
	proxyurl=$(jq '.proxyUrl' <<< "${vinf}" | sed 's/^"//' | sed 's/"$//')
	chapters=$(jq '.chapters' <<< "${vinf}")
	relstream=$(jq '.relatedStreams[]' <<< "${vinf}")

	uploader=$(jq '.uploader' <<< "${vinf}" | sed 's/^"//' | sed 's/"$//')
	uploaderUrl=$(jq '.uploaderUrl'  <<< "${vinf}" | sed 's/^"//' | sed 's/"$//')
	uploaderVerified=$(jq '.uploaderVerified' <<< "${vinf}" | sed 's/^"//' | sed 's/"$//')
	uploaderSubscriberCount=$(jq '.uploaderSubscriberCount' <<< "${vinf}" | sed 's/^"//' | sed 's/"$//')

	uploaderAvatar=$(jq '.uploaderAvatar' <<< "${vinf}" | sed 's/^"//' | sed 's/"$//')
	thumbnailUrl=$(jq '.thumbnailUrl' <<< "${vinf}" | sed 's/^"//' | sed 's/"$//')
	xmsgtext=$(echo "Id: $1";\
	  echo "Title: $title";\
	  echo "Uploaded: $uploadDate";\
	  echo "Duration: $duration";\
	  echo "Views: $views";\
	  echo "Likes: $likes / Dislikes: $dislikes";\
	  echo "livestream: $livestream";\
	  echo "proxy: $proxyurl";\
	  echo "chapters: $chapters";\
	  echo "lbry: $lbryId; dash: $dash";\
	  echo ""; echo "---uploader---";\
	  echo "Channel: $uploader"; echo "Url: $uploaderUrl";echo "Verified: $uploaderVerified";echo "Subscribers: $uploaderSubscriberCount"\
	)
	xmessage -file - -default "okay" -buttons "okay:0,description:10,Show Channel:50,ChannelThumb:20,Thumb:30,Copy:40" <<< "$xmsgtext"
	case $? in
	10)
	  sel="description" ;;
	20)
	  wget -q -O tmp.webp "${uploaderAvatar}"
	  sel="showtmp" ;;
	30)
	  wget -q -O tmp.webp "${thumbnailUrl}"
	  sel="showtmp" ;;
	40)
	  echo "$xmsgtext" >&2
	  sel="";;
	50)
	  ./sh/prcchannel.sh $(echo $uploaderUrl | sed 's/\/channel\///')
	  sel="";;
	*)
#	  echo "\$?: $?"
	  sel=""
	;;
	esac
      ;;
      "exit")
        exit 1
      ;;
    esac
    [ "$sel" == "" ] && sel=$(echo "$actions" | dmenu -l 5 -p "${title}" )
  done
