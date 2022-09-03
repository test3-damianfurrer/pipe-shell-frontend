#!/bin/sh
cd find || exit 1
stdi=$(cat -)
names=$(jq '.title' <<< "${stdi}" | sed 's/^"//' | sed 's/"$//' | sed 's/\//_/g')
thumbs=$(echo "${stdi}" | jq '.thumbnail' | sed 's/^"//' | sed 's/"$//')
urls=$(jq '.id' <<< "${stdi}" | sed 's/^"//' | sed 's/"$//')
#jq '.title' result.json | sed 's/^"//' | sed 's/"$//' | sed 's/\//_/g' > name.txt
#jq '.thumbnail' result.json | sed 's/^"//' | sed 's/"$//' > thumb.txt
#jq '.id' result.json | sed 's/^"//' | sed 's/"$//' > url.txt
mkdir -p res
cd res
declare -i i
i=1
while read line
do
#echo ">$line"
name=$(awk "NR == $i"' {print}' <<< "${names}")
#id=$(awk "NR == $i"' {print}' ../url.txt | sed 's/\/watch.v=\///')
id=$(echo "$urls" | awk "NR == $i"' {print}' )

wget -q -O "${name}.webp" "${line}"
echo "${id}" > "${name}.txt"
i+=1
#exit
done <<< "${thumbs}"
#done < ../thumb.txt

#echo "${names}" | 
selecttxt=$(sed 's/$/.webp/' <<< "${names}" | /home/damian/source-code/sxiv/sxiv-test -iol | sed 's/.webp$/.txt/')
#cat "${selecttxt}"
while read line
do
	#echo ">$line"
	[ "$line" != "" ] && cat "${line}"
done <<< "${selecttxt}"
rm *
