#!/bin/sh
#for new setup use ./sh/update-seq
#this update is much slower, when acctual work has to be done.
# it is only faster for quickly checking everything, while having almost no real updating to do.

source ./sh/update.src
grep -v '#' abos.lst | update
