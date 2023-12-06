#!/bin/bash
chechprogramavailable(){
  which "$1" 2>/dev/null >/dev/null || echo "Program '$1' must be installed!" >&2
  which "$1" 2>/dev/null >/dev/null || exit 1
}
set -e

#some programs might have alternatives and could be easy to change in the sh/_* files
#chechprogramavailable "x" - test
chechprogramavailable "jq"
chechprogramavailable "gcc"
chechprogramavailable "ffmpeg"
chechprogramavailable "mpv"
chechprogramavailable "dmenu"
chechprogramavailable "xmessage"
chechprogramavailable "xclip"
chechprogramavailable "sxiv"

ln -sf do.sh play
ln -sf do.sh listenall
ln -sf do.sh update

cp sh/_thumbsel.src.dflt.tmpl sh/_thumbsel.src
#if we have the sxiv list mod installed
[ -e "/usr/local/bin/sxiv" ] && cat sh/_thumbsel.src.tmpl > sh/_thumbsel.src

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

