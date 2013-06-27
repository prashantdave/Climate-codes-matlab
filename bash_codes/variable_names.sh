#!/bin/bash
for i in 1 2 3 4 5 6 7 8 9
do

    ./matlab_script.sh 0.$i
    variables_file="/home/prashant/Desktop/nc_data/ECHAM-HAM/Results/2001/alpha_height/0.$i/significant_variables.txt"
    if [ -f $variables_file ]
        then rm $variables_file
    fi

    files="01 activ aerom conv diag forcing inputm nudg radm tracerm xtsurf"
    for file in $files
    do
        echo " " >> $variables_file
        echo "$file" >> $variables_file
        ls /home/prashant/Desktop/nc_data/ECHAM-HAM/2001/0609/$file/csv_with_altitude/mat_files/significant_variables >> $variables_file
        
        rm -f /home/prashant/Desktop/nc_data/ECHAM-HAM/2001/0609/$file/csv_with_altitude/mat_files/significant_variables/*.mat
    done

done
