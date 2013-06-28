clc
clear all
load('modelaod.mat')
load('aod_mm_feb06.mat')
misr_aod = aod_ave_feb(:,3);
misr_unc = aod_ave_feb(:,9);
backgrd = model_aod(:, 1);
temp = zeros(19,48);
temp1 = zeros(19,48);
backcount = 1;
for i = 1:19
    for j = 1:48
        temp(i,j) = misr_aod(backcount);
        temp1(i,j) = misr_unc(backcount);
        backcount = backcount + 1;
    end
end
miscount = 1;
for i = 1:48
    for j = 1:19
        misr_aod(miscount) = temp(j,i);
        misr_unc(miscount) = temp1(j,i);
        miscount = miscount + 1;
    end
end
observation = misr_aod;
obserror = misr_unc;
Nr=912;
N= Nr;
M=N;
fm=0.5;
em=0.1;
lx=19;
ly=48;
Hmap=zeros(1,N);
H=zeros(M,N);
io=0;
for i=1:N
    if observation(i)>0
        io=io+1;
        H(io,i)=1;
        Hmap(i)=io;
        observation(io)=observation(i);
        obserror(io)=obserror(i);
    end
end
Mo=io;
H=H(1:Mo,:);
observation=observation(1:Mo,1);
%calulate B
B = modelcov(backgrd);
Beig = eig(B);
lambmin = min(Beig);
if real(lambmin) < 0
    B = B + abs(lambmin*1.1).*eye(Nr);
end
Bnewmin = min(eig(B))
%O is a diagonal
O=zeros(Mo,Mo);
for i=1:Mo
    O(i,i)=obserror(i); %for misr we directly have variance.
end
oinv = pinv(O);
binv = .5*(pinv(B) + pinv(B)');
theta = binv + H'*oinv*H;
thetmin = min(eig(theta));
if thetmin < 0
    theta = theta - (thetmin*1.01).*eye(Nr);
end
thetnewmin = min(eig(theta))
phi = (backgrd'*binv + observation'*oinv*H);
lb = zeros(Nr,1);
ub = 4.*ones(Nr,1);
opts = optimset('Algorithm', 'interior-point-convex', 'MaxIter', 800, 'Display', 'off');
[xassim, fval, exitflag, output, lambda] = quadprog(theta, -phi, [], [], [], [], lb, ub, [], opts);
a = xlsread('gradsECHAM.xlsx', 'Sheet1', 'A1:A912');
b = xlsread('gradsECHAM.xlsx', 'Sheet1', 'B1:B912');
M = [a b xassim];
corassim_feb = corrcoef(backgrd, xassim)
scatter(backgrd,xassim)
%save('quadrassimfebc.mat', 'M', 'corassim_feb', '-v7.3')
%dlmwrite('quadrassimfebc.txt', M, 'delimiter', '\t', 'precision', 4)