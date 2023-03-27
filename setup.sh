#!/bin/bash
set -e
ln -sf do.sh play
ln -sf do.sh listenall
ln -sf do.sh update

newpath=$(echo "$PWD/_c/duration2text" | sed 's/\//\\\//g')
sed 's/_duration2text_path_/'"${newpath}"'/' sh/_thumbdl.src.tmpl > sh/_thumbdl.src
source sh/_thumbdl.src

cd _c
gcc -o duration2text duration2text.c
cd ..

echo "UCf93fPKwotph47H3_KDcRyg" > abos.lst
./update
echo "PLDIoUOhQQPlXqz5QZ3dx-lh_p6RcPeKjv" > pllists.lst
./test.sh "upd_playlist"

