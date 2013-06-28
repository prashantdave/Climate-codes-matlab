clc
clear all
A = ['Sheet1';'Sheet2';'Sheet3';'Sheet4';'Sheet5';'Sheet6';'Sheet7';'Sheet8';'Sheet9';'Shet10';'Shet11';'Shet12'];
B = zeros(19,48,3);
C = ['misrjan06.txt'; 'misrfeb06.txt'; 'misrmar06.txt'; 'misrapr06.txt'; 'misrmay06.txt'; 'misrjun06.txt'; 'misrjul06.txt'; 'misraug06.txt'; 'misrsep06.txt'; 'misroct06.txt'; 'misrnov06.txt'; 'misrdec06.txt'];
for m = 1:12;
    lat = xlsread('misraodmm.xlsx', A(m,:), 'A1:A912');
    lon = xlsread('misraodmm.xlsx', A(m,:), 'B1:B912');
xnewa = xlsread('misraodmm.xlsx', A(m,:), 'C1:C912');
newcount = 1;
for i = 1:19
    for j = 1:48
          B(i,j,1) = lat(newcount,1);
          B(i,j,2) = lon(newcount,1);
          B(i,j,3) = xnewa(newcount,1);
        newcount = newcount + 1;
    end
end
ycount = 1;
for i = 1:48
    for j = 1:19
        lat(ycount,1) = B(j,i,1);
        lon(ycount,1) = B(j,i,2);
        xnewa(ycount,1) = B(j,i,3);
        ycount = ycount + 1;
    end
end
M = [lat lon xnewa];
dlmwrite(C(m,:), M, 'delimiter', '\t', 'precision', 4);
end