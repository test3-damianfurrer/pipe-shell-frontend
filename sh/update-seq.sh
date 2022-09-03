#!/bin/bash
source ./sh/update-seq.src

grep -v '#' abos.lst | update_seq
