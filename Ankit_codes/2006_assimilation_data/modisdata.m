%code for misr modis comparision
clc
clear all
Sheets = ['Sheet1';'Sheet2';'Sheet3';'Sheet4';'Sheet5';'Sheet6';'Sheet7';'Sheet8';'Sheet9';'Shet10';'Shet11';'Shet12'];
M = zeros(19,48,12);
for i = 1:12
    M(:,:,i) = xlsread('modis_monthly.xlsx', Sheets(i,:));
end
D = zeros(912,12);
for i = 1:12
    count = 1;
    for p = 1:19
        for q = 1:48
            D(count,i) = M(p,q,i);
            count = count + 1;
        end
    end
end
for i = 1:12
    xlswrite('modismonthlymean06.xlsx', D(:,i), Sheets(i,:));
end

