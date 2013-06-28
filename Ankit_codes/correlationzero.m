%finding correlation between MISR and MODIS AOD data
%in this file we consider 0s as valid retrievals.
clc
clear all
A = zeros(912,12);
B = zeros(912,12);
epsilon = zeros(12,1);
r = zeros(12,1);
s = zeros(12,1);%numerator of expression
t = zeros(12,1);
j = zeros(12,1);
m = zeros(12,1);
N = 912;
Sheet = ['Sheet1'; 'Sheet2'; 'Sheet3'; 'Sheet4'; 'Sheet5'; 'Sheet6'; 'Sheet7'; 'Sheet8'; 'Sheet9'; 'Shet10'; 'Shet11'; 'Shet12'];
for i = 1:12
    A(:,i) = xlsread('misraodmm.xlsx', Sheet(i,:), 'C1:C912');
    B(:,i) = xlsread('modismonthlymean06.xlsx', Sheet(i,:), 'A1:A912');
    j(i,1) = sum(A(:,i));
    m(i,1) = sum(B(:,i));
    for k = 1:912
        epsilon(i,1) = epsilon(i,1) + (A(k,i)-B(k,i))^2;
        s(i,1) = s(i,1)+ N*A(k,i)*B(k,i);
    end
    s(i,1) = s(i,1) - j(i,1)*m(i,1);        
    epsilon(i,1) = sqrt(epsilon(i,1)/912); %RMSE in MISR v/s MODIS scatter plot
    t(i,1) = s(i,1)/((sqrt(N*sum(A(:,i).*A(:,i)) - j(i,1)^2))*(sqrt(N*sum(B(:,i).*B(:,i)) - m(i,1)^2))); %regression value (misr v/s modis)
end
