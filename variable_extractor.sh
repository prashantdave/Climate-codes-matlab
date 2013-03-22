#!/bin/bash
file_name=$1 #input-1 should be netCDF file name
line_number=`ncdump -c $file_name|grep -n "global attributes"|cut -d ":" -f1 - `
ncdump -c $file_name|head -n $line_number - |grep -v "global attributes"> variables_info.txt
