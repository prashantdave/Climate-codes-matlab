clc
clear all
lat = xlsread('gradsECHAM.xlsx','Sheet1', 'A1:A912');
lon = xlsread('gradsECHAM.xlsx','Sheet1', 'B1:B912');
C = ['assim_jan.xlsx'; 'assim_feb.xlsx'; 'assim_mar.xlsx'; 'assim_apr.xlsx'; 'assim_may.xlsx'; 'assim_jun.xlsx'; 'assim_jul.xlsx'; 'assim_aug.xlsx'; 'assim_sep.xlsx'; 'assim_oct.xlsx'; 'assim_nov.xlsx'; 'assim_dec.xlsx'];
D =  ['assim_jan.txt'; 'assim_feb.txt'; 'assim_mar.txt'; 'assim_apr.txt'; 'assim_may.txt'; 'assim_jun.txt'; 'assim_jul.txt'; 'assim_aug.txt'; 'assim_sep.txt'; 'assim_oct.txt'; 'assim_nov.txt'; 'assim_dec.txt'];
for m = 1:12
    A = xlsread(C(m,:));
    xolda = zeros(912,1);
    count = 1;
    for i = 1:48
        for j = 1:19
            xolda(count) = A(j,i);
            count = count + 1;
        end
    end
    M = [lat lon xolda];
    dlmwrite(D(m,:), M, 'delimiter', '\t', 'precision', 4);
end