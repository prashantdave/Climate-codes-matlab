#!/bin/bash
#for i in activ forcing radm 

tar -xvzf  T63_WNUD_9year_200604.tgz -C  T63_WNUD_9year_200604
tar -xvzf  T63_WNUD_9year_200605.tgz -C  T63_WNUD_9year_200605
tar -xvzf  T63_WNUD_9year_200606.tgz -C  T63_WNUD_9year_200606
tar -xvzf  T63_WNUD_9year_200607.tgz -C  T63_WNUD_9year_200607
tar -xvzf  T63_WNUD_9year_200608.tgz -C  T63_WNUD_9year_200608
tar -xvzf  T63_WNUD_9year_200609.tgz -C  T63_WNUD_9year_200609

for i in activ aerom conv diag forcing inputm nudg radm tracerm xtsurf
do
    echo $i
    cdo -f nc2 mergetime T63_WNUD_9year_200603/T63_WNUD_10Year_200603.01_$i.nc T63_WNUD_9year_200604/T63_WNUD_10Year_200604.01_$i.nc T63_WNUD_9year_200605/T63_WNUD_10Year_200605.01_$i.nc T63_WNUD_9year_200606/T63_WNUD_10Year_200606.01_$i.nc T63_WNUD_9year_200607/T63_WNUD_10Year_200607.01_$i.nc T63_WNUD_9year_200608/T63_WNUD_10Year_200608.01_$i.nc T63_WNUD_9year_200609/T63_WNUD_10Year_200609.01_$i.nc ../../../Prashant_Data/2006/$i/T63_WNUD_10Year_2006.01_$i.nc

done

mutt -s "2006 merging done" prash </dev/null
