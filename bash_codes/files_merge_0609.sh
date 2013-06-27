#!/bin/bash
   cdo -f nc2 mergetime T63_WNUD_10Year_200406.01.nc T63_WNUD_10Year_200407.01.nc T63_WNUD_10Year_200408.01.nc T63_WNUD_10Year_200409.01.nc 01/T63_WNUD_10Year_2004.01_0609.nc
   rm -f T63_WNUD_10Year_200406.01.nc T63_WNUD_10Year_200407.01.nc T63_WNUD_10Year_200408.01.nc T63_WNUD_10Year_200409.01.nc

for i in activ aerom conv diag forcing inputm radm tracerm xtsurf
do
    echo $i
   cdo -f nc2 mergetime T63_WNUD_10Year_200406.01_$i.nc T63_WNUD_10Year_200407.01_$i.nc T63_WNUD_10Year_200408.01_$i.nc T63_WNUD_10Year_200409.01_$i.nc $i/T63_WNUD_10Year_2004.01_$i\_0609.nc
   rm -f nc2  T63_WNUD_10Year_200406.01_$i.nc T63_WNUD_10Year_200407.01_$i.nc T63_WNUD_10Year_200408.01_$i.nc T63_WNUD_10Year_200409.01_$i.nc

done

        
