#!/bin/bash
#$1 id
#source ./sh/selectavid.src
./sh/update-ifseq.sh
source ./sh/prcvideo.src
prcvideo "${1}" &
./update.sh
