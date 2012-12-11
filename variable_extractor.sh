#This file extracts a particular variable from the given netCDF file.
#The input to this file are path of the file and variable name
ncks -H -F -v $1 $2 | grep $1 > $1.txt
