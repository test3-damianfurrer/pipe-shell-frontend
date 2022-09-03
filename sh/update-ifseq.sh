#!/bin/bash

source ./sh/update-ifdolong.src

grep -v '#' abos.lst | update_ifdolong
