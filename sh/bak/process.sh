#!/bin/sh
relstrm=$(cat - | sed 's/|/I/g')
[ "$1" == "" ] && exit 1
cd "channel_ids/${1}"

mix=$(jq -rj '.id,"|",.title,"|",.thumbnail,"|",.uploaderName,"|",.uploaderUrl,"|",.url,"|",.uploadedDate,"|",.uploaded,"|",.uploaderVerified,"|",.duration,"|",.views,"|"' <<< "${relstrm}")

other(){

#exit
url=$(jq -r '.url' <<< "${relstrm}" | sed 's/^.//' | sed 's/.$//')
title=$(jq -r '.title' <<< "${relstrm}" | sed 's/^.//' | sed 's/.$//' | sed 's/\\"/"/g')
thumb=$(jq -r '.thumbnail' <<< "${relstrm}" | sed 's/^.//' | sed 's/.$//')
name=$(jq -r '.uploaderName' <<< "${relstrm}" | sed 's/^.//' | sed 's/.$//')
url=$(jq -r '.uploaderUrl' <<< "${relstrm}" | sed 's/^.//' | sed 's/.$//')
avatar=$(jq -r '.uploaderAvatar' <<< "${relstrm}" | sed 's/^.//' | sed 's/.$//')
date=$(jq -r '.uploadedDate' <<< "${relstrm}" | sed 's/^.//' | sed 's/.$//')
desc=$(jq -r '.shortDescription' <<< "${relstrm}" | sed 's/^.//' | sed 's/.$//' | sed 's/\\"/"/g')
duration=$(jq -r '.duration' <<< "${relstrm}" | sed 's/^.//' | sed 's/.$//')
views=$(jq -r '.views' <<< "${relstrm}" | sed 's/^.//' | sed 's/.$//')
uploaded=$(jq -r '.uploaded' <<< "${relstrm}" | sed 's/^.//' | sed 's/.$//')
verified=$(jq -r '.uploaderVerified' <<< "${relstrm}" | sed 's/^.//' | sed 's/.$//')

url=$(jq -r '.[].url' <<< "${relstrm}" | sed 's/^.//' | sed 's/.$//')
title=$(jq -r '.[].title' <<< "${relstrm}" | sed 's/^.//' | sed 's/.$//' | sed 's/\\"/"/g')
thumb=$(jq -r '.[].thumbnail' <<< "${relstrm}" | sed 's/^.//' | sed 's/.$//')
name=$(jq -r '.[].uploaderName' <<< "${relstrm}" | sed 's/^.//' | sed 's/.$//')
url=$(jq -r '.[].uploaderUrl' <<< "${relstrm}" | sed 's/^.//' | sed 's/.$//')
avatar=$(jq -r '.[].uploaderAvatar' <<< "${relstrm}" | sed 's/^.//' | sed 's/.$//')
date=$(jq -r '.[].uploadedDate' <<< "${relstrm}" | sed 's/^.//' | sed 's/.$//')
desc=$(jq -r '.[].shortDescription' <<< "${relstrm}" | sed 's/^.//' | sed 's/.$//' | sed 's/\\"/"/g')
duration=$(jq -r '.[].duration' <<< "${relstrm}" | sed 's/^.//' | sed 's/.$//')
views=$(jq -r '.[].views' <<< "${relstrm}" | sed 's/^.//' | sed 's/.$//')
uploaded=$(jq -r '.[].uploaded' <<< "${relstrm}" | sed 's/^.//' | sed 's/.$//')
verified=$(jq -r '.[].uploaderVerified' <<< "${relstrm}" | sed 's/^.//' | sed 's/.$//')
#}
}
echo "${url}" > url.txt
echo "${title}" >title.txt
echo "${thumb}" > thumbnail.txt
echo "${name}" > uploaderName.txt
echo "${url}" > uploaderUrl.txt
echo "${avatar}" > uploaderAvatar.txt
echo "${date}" > uploadedDate.txt
echo "${desc}" > shortDescription.txt
echo "${duration}" > duration.txt
echo "${views}" > views.txt
echo "${uploaded}" > uploaded.txt
echo "${verified}" > uploaderVerified.txt

#sed -i 's/\\"/"/g' title.txt
#sed -i 's/\\"/"/g' shortDescription.txt

#rm relatedstream.json
#../../sh/vids_sort.sh "${1}"

#mix2=$(sed -z 's/{;}/|/g' <<< "${mix}" )
[ -d "../../videos" ] || mkdir -p ../../videos

tr '|' '\0' <<< "${mix}" | xargs -0 -n 11 ../../sh/vids_info2.sh "${1}"


cd ..


