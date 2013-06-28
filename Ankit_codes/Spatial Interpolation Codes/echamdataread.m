%script to read variables from NC files (2010a onwards), for this script
%you will need the NC files (in the name the two digits next to 2o12
%indicate the month no.) in the same folder as this code. works for other
%variables as well.
clc
clear all
fname = 'T63_2006_WNUD_Okt10_200612.01_radm.nc';
modlat = ncread(fname, 'lat');
modlon = ncread(fname, 'lon');
aaod = ncread(fname, 'ABS_2D'); %here, the variable that we read is the total absorption optical thickness at 550 nm
dim = size(aaod);
N = dim(1,3);
aaod = sum(aaod,3);
aaod = aaod./N;
count = 1;
for j = 17:64 %the files provide data globally, here we pick the data that is in our region of interest
    for i = 46:-1:28
         lat(count) = modlat(i);
        lon(count) = modlon(j);
        aaod_dec(count) = aaod(j,i);
        count=count+1;
    end
end
M = [lat' lon' aaod_dec'];
save('aaod_dec.mat', 'M')