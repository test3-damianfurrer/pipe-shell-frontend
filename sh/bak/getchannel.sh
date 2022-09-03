#!/bin/sh
#wget -O channel.json "https://damianfurrer.ch/yt/channel/${1}" 2> /dev/null
curl "https://damianfurrer.ch/yt/channel/${1}" 2> /dev/null
