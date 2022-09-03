#!/bin/sh
mkdir -p search
cd search
wget -q -O "result.json" "https://damianfurrer.ch/yt/search?q=${1}&filter=channels"
jq '.items[].name' result.json | sed 's/^"//' | sed 's/"$//' > name.txt
jq '.items[].thumbnail' result.json | sed 's/^"//' | sed 's/"$//' > thumb.txt
jq '.items[].url' result.json | sed 's/^"//' | sed 's/"$//' > url.txt
mkdir -p res
cd res
declare -i i
i=1
while read line
do
#echo ">$line"
name=$(awk "NR == $i"' {print}' ../name.txt)
id=$(awk "NR == $i"' {print}' ../url.txt | sed 's/\/channel\///')
wget -q -O "${name}.webp" "${line}"
echo "${id}" > "${name}.txt"
i+=1
#exit
done < ../thumb.txt

selecttxt=$(cat ../name.txt | sed 's/$/.webp/' | /home/damian/source-code/sxiv/sxiv-test -iol | sed 's/.webp$/.txt/')
#cat "${selecttxt}"
while read line
do
	#echo ">$line"
	cat "${line}"
done <<< "${selecttxt}"
rm *
cd ..

