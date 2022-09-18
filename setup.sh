#!/bin/bash
ln -sf do.sh play
ln -sf do.sh listenall
ln -sf do.sh update
echo "UCf93fPKwotph47H3_KDcRyg" > abos.lst
./update
echo "PLDIoUOhQQPlXqz5QZ3dx-lh_p6RcPeKjv" > pllists.lst
./test.sh "upd_playlist"
