#!/bin/sh
chnl=$(cat -)
#[ -e "channel.json" ] || exit 1
[ "$chnl" = "" ] && exit 1
[ -d "channels" ]    || mkdir "channels"
[ -d "channel_ids" ] || mkdir "channel_ids"
channel=$(jq '.name' <<< "$chnl" | sed 's/^"//' | sed 's/"$//')
id=$(jq '.id' <<< "$chnl" | sed 's/^"//' | sed 's/"$//')


#mkdir -p "${channel}"
if [ -e "channel_ids/$id" ]; then
  echo "Updating: ${channel}"
else
  echo "Processing: ${channel}"
  if [ -e "channels/${channel}" ]; then
    mkdir -p "channels/${channel}_$id"
    cd "channel_ids"
      ln -s "../channels/${channel}_$id" "$id"
    cd ..
  else
    mkdir -p "channels/${channel}"
    cd "channel_ids"
      ln -s "../channels/${channel}" "$id"
    cd ..
  fi
fi

relstrm=$(jq '.relatedStreams[]' <<< "$chnl" )
#rm channel.json
./sh/process.sh "$id" <<< "$relstrm" &

jq -j '.id' <<< "$chnl" > "channel_ids/$id/id.json"
jq -j '.name' <<< "$chnl" | sed 's/\\"/"/g' > "channel_ids/$id/name.json"
#jq -j '.avatarUrl' <<< "$chnl" > "channel_ids/$id/avatarUrl.json"
#jq -j '.bannerUrl' <<< "$chnl" > "channel_ids/$id/bannerUrl.json"
wget -q -O "channel_ids/$id/avatar.webp" $(jq -j '.avatarUrl' <<< "$chnl") &
wget -q -O "channel_ids/$id/banner.webp" $(jq -j '.bannerUrl' <<< "$chnl") &
jq -j '.description' <<< "$chnl" | sed 's/\\"/"/g' > "channel_ids/$id/description.json"
jq -j '.nextpage' <<< "$chnl" | sed 's/\\"/"/g' > "channel_ids/$id/nextpage.json"
jq -j '.subscriberCount' <<< "$chnl" > "channel_ids/$id/subscriberCount.json"
jq -j '.verified' <<< "$chnl" > "channel_ids/$id/verified.json"
