#!/bin/bash
source ./sh/updatepl.src
grep -v '#' pllists.lst | updatepl
