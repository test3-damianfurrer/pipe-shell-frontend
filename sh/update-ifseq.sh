#!/bin/sh

source ./sh/update-ifdolong.src

grep -v '#' abos.lst | update_ifdolong
