#!/bin/bash
sourceall(){
for f in src.do/*.src
do
 source $f
done
}

action(){
    action="$1"
    [ "$action" ] || action="_"
    grep -q "^${action}\$" <<< "${functions}" || { >&2 echo "ERROR: action \"${1}\" not found! Try \"help\""; exit 1; }

    $action "${2}" "${3}" "${4}" "${5}"
}
sourceall
#echo "functions: ${functions}"
called=$(basename "$0")
[ "$called" == "do.sh" ] && action "${1}" "${2}" "${3}" "${4}" "${5}"
[ "$called" == "do.sh" ] || action "${called}" "${1}" "${2}" "${3}" "${4}"
exit
