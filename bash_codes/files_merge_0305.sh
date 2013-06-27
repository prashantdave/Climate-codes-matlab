#!/bin/bash
   echo  cdo -f nc2 mergetime T63_WNUD_10Year_200003.01.nc T63_WNUD_10Year_200004.01.nc T63_WNUD_10Year_200005.01.nc 01/T63_WNUD_10Year_2000.01_0305.nc
   echo   rm -f T63_WNUD_10Year_200003.01.nc T63_WNUD_10Year_200004.01.nc T63_WNUD_10Year_200005.01.nc

for i in activ aerom conv diag forcing inputm radm tracerm xtsurf
do
   echo  cdo -f nc2 mergetime T63_WNUD_10Year_200003.01_$i.nc T63_WNUD_10Year_200004.01_$i.nc T63_WNUD_10Year_200005.01_$i.nc $i/T63_WNUD_10Year_2000.01_$i\_0305.nc
   echo  rm -f nc2  T63_WNUD_10Year_200003.01_$i.nc T63_WNUD_10Year_200004.01_$i.nc T63_WNUD_10Year_200005.01_$i.nc 

done

        
