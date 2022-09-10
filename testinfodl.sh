#!/bin/bash
#$1 id
[ "$(type -t _pipedget)" == "function" ] || source sh/_pipedget.src
_pipedget "streams/$1" > inf.json
