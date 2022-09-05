#!/bin/bash
#$1 id
#source ./sh/selectavid.src
#./sh/update-ifseq.sh
source ./sh/test-prcvideo.src
prcvideo "${1}" "info-out{;}next"
#./update.sh
