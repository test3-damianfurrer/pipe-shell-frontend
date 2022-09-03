#!/bin/sh
#$1 videoid
set -e
cd videos #also search related links
[ "${1}" == "" ] && exit 1
dut=$(cat "${1}/_duration.txt")
tt=$(cat "${1}/_title.txt")
upt=$(cat "${1}/_uploaded.txt")
rm "_duration/${dut}"
rm "_uploaded/${upt}"
#also del in channel
rm "${1}/channel/_duration/${dut}"
rm "${1}/channel/_uploaded/${upt}"
rm "${1}/channel/_title/${tt}"

rm -r "${1}"
