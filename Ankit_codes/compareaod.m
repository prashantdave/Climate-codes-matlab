clc
clear all
lat = xlsread('gradsECHAM.xlsx','Shet12', 'A1:A912');
lon = xlsread('gradsECHAM.xlsx','Shet12', 'B1:B912');
A = xlsread('assim_dec.xlsx');
B = zeros(size(A));
xolda = zeros(912,1);
count = 1;
for i = 1:48
    for j = 1:19
        xolda(count) = A(j,i);
        count = count + 1;
    end
end
load('quadrassimdecc.mat');
xnewa = M(:,3);
newcount = 1;
for i = 1:19
    for j = 1:48
        B(i,j) = xnewa(newcount,1);
        newcount = newcount + 1;
    end
end
ycount = 1;
for i = 1:48
    for j = 1:19
        xnewa(ycount,1) = B(j,i);
        ycount = ycount + 1;
    end
end
cor = corrcoef(xnewa, xolda);
scatter(xolda, xnewa)
load('modelaod.mat')
backgrd = model_aod(:,12);
modcount = 1;
for i = 1:19
    for j = 1:48
        B(i,j) = backgrd(modcount,1);
        modcount = modcount + 1;
    end
end
modrev = 1;
for i = 1:48
    for j = 1:19
        backgrd(modrev,1) = B(j,i);
        modrev = modrev + 1;
    end
end
corold = corrcoef(xolda,backgrd);
cornew = corrcoef(xnewa,backgrd);