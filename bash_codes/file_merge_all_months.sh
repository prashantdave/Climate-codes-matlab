#!/bin/bash
#for i in activ forcing radm 

#tar -xvzf  T63_WNUD_9year_200003.tgz -C  T63_WNUD_9year_200003
#tar -xvzf  T63_WNUD_9year_200004.tgz -C  T63_WNUD_9year_200004
#tar -xvzf  T63_WNUD_9year_200005.tgz -C  T63_WNUD_9year_200005
#tar -xvzf  T63_WNUD_9year_200006.tgz -C  T63_WNUD_9year_200006
#tar -xvzf  T63_WNUD_9year_200007.tgz -C  T63_WNUD_9year_200007
#tar -xvzf  T63_WNUD_9year_200008.tgz -C  T63_WNUD_9year_200008
#tar -xvzf  T63_WNUD_9year_200009.tgz -C  T63_WNUD_9year_200009

for i in activ aerom conv diag forcing inputm nudg radm tracerm xtsurf
do
    echo $i
    cdo -f nc2 mergetime T63_WNUD_9year_200003/T63_WNUD_10Year_200003.01_$i.nc T63_WNUD_9year_200004/T63_WNUD_10Year_200004.01_$i.nc T63_WNUD_9year_200005/T63_WNUD_10Year_200005.01_$i.nc T63_WNUD_9year_200006/T63_WNUD_10Year_200006.01_$i.nc T63_WNUD_9year_200007/T63_WNUD_10Year_200007.01_$i.nc T63_WNUD_9year_200008/T63_WNUD_10Year_200008.01_$i.nc T63_WNUD_9year_200009/T63_WNUD_10Year_200009.01_$i.nc ../../../Prashant_Data/2000/$i/T63_WNUD_10Year_2000.01_$i.nc

done

mutt -s "2000 merging done" prash </dev/null
