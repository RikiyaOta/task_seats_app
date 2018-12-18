#!/bin/bash

#old_module_name="TaskSeat"
#new_module_name="TaskSheet"

old_module_name="Sheat"
new_module_name="Sheet"

for filename in $(grep -r -l -E $old_module_name ${PWD})
do
    sed -e "s/${old_module_name}/${new_module_name}/g" $filename > ${filename}.tmp && cp ${filename}.tmp $filename && rm ${filename}.tmp
done
