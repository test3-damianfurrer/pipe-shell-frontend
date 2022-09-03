#!/bin/bash
set -e
source ./sh/update-seqpl.src

grep -v '#' pllists.lst | update_seqpl
