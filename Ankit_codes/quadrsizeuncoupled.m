clc
clear all
load('feblarge06.mat')
load('misr_feb06_large.mat')
load('aod_mm_feb06.mat')
misr_unc = aod_ave_feb(:,9);
misr_aod = misr_feb_large(:,3);
backgrd = Mlarge_feb(:,3);
misr_lf = misr_feb_large(:,4);
temp = zeros(19,48);
temp1 = zeros(19,48);
temp2 = zeros(19,48);
backcount = 1;
for i = 1:19
    for j = 1:48
        temp(i,j) = misr_aod(backcount);
        temp1(i,j) = misr_unc(backcount);
        temp2(i,j) = misr_lf(backcount);
        backcount = backcount + 1;
    end
end
miscount = 1;
for i = 1:48
    for j = 1:19
        misr_aod(miscount) = temp(j,i);
        misr_unc(miscount) = temp1(j,i);
        misr_lf(miscount) = temp2(j,i);
        miscount = miscount + 1;
    end
end
misr_orig = misr_aod;
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
for i = 1:N
    if misr_lf(i) < 1
    obserror(i) = obserror(i)*((misr_lf(i)^2));
    end
end
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
M1 = [a b misr_feb_large(:,3)];
M2 = [a b backgrd];
corassim_feb = corrcoef(backgrd, xassim)
figure(1)
scatter(backgrd,xassim)
xlabel('model large feb')
ylabel('assim large feb')
figure(2)
scatter(misr_orig, xassim)
xlabel('misr large feb')
ylabel('assim large feb')
%save('quadrassimfeblarge.mat', 'M', 'corassim_feb', '-v7.3')
%dlmwrite('quadrassimfeblarge.txt', M, 'delimiter', '\t', 'precision', 4)
%dlmwrite('misrlargefeb.txt', M1, 'delimiter', '\t', 'precision', 4)
%dlmwrite('modellargefeb.txt', M2, 'delimiter', '\t', 'precision', 4)