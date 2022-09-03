#!/bin/sh
source ./sh/updatepl.src
grep -v '#' pllists.lst | updatepl
