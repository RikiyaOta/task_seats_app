#!/bin/bash

#old_name="task_seat"
#new_name="task_sheet"

old_name="sheat"
new_name="sheet"

for filename in $(grep -r -l -E $old_name ${PWD})
do
    sed -e "s/${old_name}/${new_name}/g" $filename > ${filename}.tmp && cp ${filename}.tmp $filename && rm ${filename}.tmp
done
