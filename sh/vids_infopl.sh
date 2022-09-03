#!/bin/bash
workdir=$(pwd)
mkdir -p _duration
mkdir -p _uploaded
mkdir -p _title
cd ../../../videos
mkdir -p _durationpl
mkdir -p _uploadedpl
[ "${2}" == "" ] && exit 1
[ "${5}" == "" ] && exit 1
mkdir -p -- "${2}"
wget -q -O "${2}/thumb.webp" "${4}" > /dev/null || ( echo "failed to dl thumb to ${2};${3};${5}"; echo "dump: "; echo "$@"; ) &

echo "$2"  > "${2}/id.txt"
uploaded="${9}"
[ "${9}" == "-1" ] && uploaded=$(date +%s) && uploaded="${uploaded}000"
titleesc=$(echo "${3}" | sed 's/\//_/g' | sed 's/{semicolon}/;/g')
echo "${11}_${titleesc}" > "${2}/_duration.txt"
echo "${uploaded}_${titleesc}" > "${2}/_uploaded.txt"
echo "${titleesc}" > "${2}/_title.txt"

cd -- "${2}"
mkdir -p playlists
ln -s -f -- "${workdir}" "playlists/${1}"
ln -s -f -- "thumb.webp" "${titleesc}"
cd ..
cd _durationpl
ln -s -f -- "../${2}" "${11}_${titleesc}"
cd ../_uploadedpl
ln -s -f -- "../${2}" "${uploaded}_${titleesc}"

cd "../../playlists/byid/${1}"
cd _duration
ln -s -f -- "../../../../videos/${2}" "${11}_${titleesc}"
cd ../_uploaded
ln -s -f -- "../../../../videos/${2}" "${uploaded}_${titleesc}"
cd ../_title
ln -s -f -- "../../../../videos/${2}" "${titleesc}"
cd ..

