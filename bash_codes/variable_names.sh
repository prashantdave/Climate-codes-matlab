#!/bin/bash
for i in 1 2 3 4 5 6 7 8 9
do

    ./matlab_script.sh 0.$i
    variables_file="/home/prashant/Desktop/nc_data/ECHAM-HAM/Results/2001/alpha/0.$i/significant_variables.txt"
    if [ -f $variables_file ]
        then rm $variables_file
    fi

    files="01 activ aerom conv diag forcing inputm nudg radm tracerm xtsurf"
    for file in $files
    do
        ls /home/prashant/Desktop/nc_data/ECHAM-HAM/2001/$file/0609/mat_files/significant_variables >> $variables_file

        rm -f /home/prashant/Desktop/nc_data/ECHAM-HAM/2001/$file/0609/mat_files/significant_variables/*.mat
    done

done
