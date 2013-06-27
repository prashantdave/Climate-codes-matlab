#!/bin/bash
cdo sp2gp 01/T63_WNUD_10Year_2004.01_0609.nc test.nc
cdo ml2hl,15000,14000,13000,12000,11000,10000,9000,8000,7000,6000,5000,4000,3000,2000,1000,0 test.nc 01/T63_WNUD_10Year_2004.01\_0609_hl.nc
for i in activ aerom conv diag forcing inputm nudg radm tracerm xtsurf 
do
  echo $i
  cdo sp2gp $i/T63_WNUD_10Year_2004.01_$i\_0609.nc test.nc
  cdo ml2hl,15000,14000,13000,12000,11000,10000,9000,8000,7000,6000,5000,4000,3000,2000,1000,0 test.nc $i/T63_WNUD_10Year_2004.01_$i\_0609_hl.nc
  echo "$i done"
done
