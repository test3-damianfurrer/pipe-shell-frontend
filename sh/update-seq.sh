#!/bin/bash
[ "$1" != "" ] && source ./sh/update-seq-silent.src
[ "$1" != "" ] && grep -v '#' abos.lst | update_seq
[ "$1" != "" ] && exit

source ./sh/update-seq.src

grep -v '#' abos.lst | update_seq
