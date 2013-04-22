#!/bin/bash
Threshold=$1
cd_present=$PWD
cd /home/prashant/PhD/codes/matlab_codes/
matlab -nosplash -nodisplay -nodesktop -r "Spatial_Correlation_significance_test($Threshold); exit"
cd $cd_present
#matlab -nosplash -nodisplay -nodesktop -r "run /home/prashant/PhD/codes/matlab_codes/Correlation_significance_test.m, exit"
