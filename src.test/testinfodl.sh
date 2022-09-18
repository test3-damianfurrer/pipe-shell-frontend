#!/bin/bash
functions=$(echo "${functions}";echo "test_infodl")
test_infodl(){
#$1 id
[ "$(type -t _pipedget)" == "function" ] || source sh/_pipedget.src
_pipedget "streams/$1" > inf.json
}
