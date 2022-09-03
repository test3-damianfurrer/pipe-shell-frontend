#!/bin/sh
set -e
#streams=$(curl "https://damianfurrer.ch/yt/streams/t_ZhpTTng0w" 2>/dev/null)
streams=$(cat -)


videostrm=$(jq -r '.videoStreams' <<< "${streams}" | ./sh/streamselect.sh)
video=$(jq -r ".url" <<< "${videostrm}")
vidonly=$(jq -r ".videoOnly" <<< "${videostrm}")
if [ "$vidonly" == "true" ]; then
  audio=$(jq -r '.audioStreams' <<< "${streams}" | ./sh/streamselect.sh | jq -r '.url')
  ffmpeg -i "${audio}" -i "${video}" -f matroska - 2>/dev/null | mpv -
else
  mpv "${video}"
fi
