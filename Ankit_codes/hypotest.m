clc
clear all
variance = eye(30);
C = zeros(60,30);
for i = 1:30
    C(2*i-1,i) = 0.5;
    C(2*i,i) = 0.5;
end
D = C*variance*C';
det(D)
