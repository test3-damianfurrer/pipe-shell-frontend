#!/bin/bash
ln -sf do.sh play
ln -sf do.sh listenall
ln -sf do.sh update
echo "UCf93fPKwotph47H3_KDcRyg" > abos.lst
./update
echo "PLDIoUOhQQPlXqz5QZ3dx-lh_p6RcPeKjv" > pllists.lst
./test.sh "upd_playlist"
newpath=$(echo "$PWD/_c/duration2text" | sed 's/\//\\\//g')
sed -i "s/\/home\/damian\/pip\/_c\/duration2text/$newpath/" sh/_thumbdl.src
cd _c
gcc -o duration2text duration2text.c
