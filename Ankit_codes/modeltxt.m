clc
clear all
Sheet = ['Sheet1'; 'Sheet2'; 'Sheet3'; 'Sheet4'; 'Sheet5'; 'Sheet6'; 'Sheet7'; 'Sheet8'; 'Sheet9'; 'Shet10'; 'Shet11'; 'Shet12'];
Mod = ['modeljan.txt';'modelfeb.txt';'modelmar.txt';'modelapr.txt';'modelmay.txt';'modeljun.txt';'modeljul.txt';'modelaug.txt';'modelsep.txt';'modeloct.txt';'modelnov.txt';'modeldec.txt'];
for i = 1:12
    a = xlsread('gradsECHAM.xlsx', Sheet(i,:), 'A1:A912');
    b = xlsread('gradsECHAM.xlsx', Sheet(i,:), 'B1:B912');
    c = xlsread('gradsECHAM.xlsx', Sheet(i,:), 'C1:C912');
    M = [a b c];
    dlmwrite(Mod(i,:), M, 'delimiter', '\t', 'precision', 4);
end