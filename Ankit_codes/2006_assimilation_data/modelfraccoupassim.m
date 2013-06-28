clc
clear all
N = 2*912;
load('misr_feb06_small.mat')
load('misr_feb06_large.mat')
load('febsmall06.mat')
load('feblarge06.mat')
load('aod_mm_feb06.mat')
misr_s = misr_feb_small(:,3);
misr_sf = misr_feb_small(:,4);
misr_l = misr_feb_large(:,3);
misr_lf = misr_feb_large(:,4);
misr_unc = aod_ave_feb(:,9);
model_small = Msmall_feb(:,3);
model_large = Mlarge_feb(:,3);
lat = Msmall_feb(:,1);
lon = Msmall_feb(:,2);
temp1 = zeros(19,48);
temp2 = zeros(19,48);
temp3 = zeros(19,48);
temp4 = zeros(19,48);
backcount = 1;
for i = 1:19
    for j = 1:48
        temp1(i,j) = misr_s(backcount);
        temp2(i,j) = misr_sf(backcount);
        temp3(i,j) = misr_l(backcount);
        temp4(i,j) = misr_lf(backcount);
        backcount = backcount + 1;
    end
end
miscount = 1;
for i = 1:48
    for j = 1:19
        misr_s(miscount) = temp1(j,i);
        misr_sf(miscount) = temp2(j,i);
        misr_l(miscount) = temp3(j,i);
        misr_lf(miscount) = temp4(j,i);
        miscount = miscount + 1;
    end
end
misr_so = misr_s;
misr_lo = misr_l;
F = zeros(N,N);
C1 = zeros(N/2,N/2);
C2 = zeros(N/2,N/2); 
io= 0;
Hmap=zeros(1,N);
misr_v = zeros(N,1);
for i = 1:N
    if rem(i,2)==1
        misr_v(i) = misr_so(fix(i/2)+1);
    else
        misr_v(i) = misr_lo(i/2);
    end
end
misr_unc1 = zeros(N,1);
for i=1:N
    if misr_v(i)>0
        io=io+1;
        F(io,i)=1;
        Hmap1(i)=io;
        misr_v(io)=misr_v(i);
        if(rem(i,2)==1)
            misr_unc1(io) = misr_unc(fix(i/2)+1);
        else
            misr_unc1(io) = misr_unc(i/2);
        end
    end
end
Fo = io;
F = F(1:Fo,:);
misr_v = misr_v(1:Fo,1);
obsfrac = zeros(Fo,1);
toterror = zeros(Fo,Fo);
for i = 1:Fo
    toterror(i,i) = misr_unc1(i);
end
C = zeros(Fo,Fo);
for i = 1:Fo
    if rem(i,2) == 1
        obsfrac(i) = misr_s(fix(i/2)+1);
        C(i,fix(i/2)+1) = misr_sf(fix(i/2)+1);
    else
        obsfrac(i) = misr_l(i/2);
        C(i,i/2) = misr_lf(i/2);
    end
end
backgrdfrac = zeros(N,1);
for i = 1:N
    if rem(i,2) == 1
        backgrdfrac(i) = model_small(fix(i/2)+1);
    else
        backgrdfrac(i) = model_small(i/2);
    end
end
Ofrac = C*toterror*C';
Bfrac = modelcovfrac(backgrdfrac);
Bfraceig = eig(Bfrac);
lambmin = min(Bfraceig);
if real(lambmin) < 0
    Bfrac = Bfrac + abs(lambmin*1.1).*eye(N);
end
Bfracnewmin = min(eig(Bfrac));
oinv = pinv(Ofrac);
binv = .5*(pinv(Bfrac) + pinv(Bfrac)');
theta = binv + F'*oinv*F;
thetmin = min(eig(theta));
if thetmin < 0
    theta = theta - (thetmin*1.01).*eye(N);
end
thetnewmin = min(eig(theta))
phi = (backgrdfrac'*binv + obsfrac'*oinv*F);
lb = zeros(N,1);
ub = 4.*ones(N,1);
opts = optimset('Algorithm', 'interior-point-convex', 'MaxIter', 800, 'Display', 'off');
[xassimfrac, fval, exitflag, output, lambda] = quadprog(theta, -phi, [], [], [], [], lb, ub, [], opts);
xassimfrac_small = zeros(N/2,1);
xassimfrac_large = zeros(N/2,1);
for i = 1:N
    if rem(i,2)==1
        xassimfrac_small(fix(i/2)+1) = xassimfrac(i);
    else
        xassimfrac_large(i/2) = xassimfrac(i);
    end
end
Msmall = [lat lon xassimfrac_small];
Mlarge = [lat lon xassimfrac_large];
Misrsmall = [lat lon misr_so];
Misrlarge = [lat lon misr_lo];
Modelsmall = [lat lon model_small];
Modellarge = [lat lon model_large];
corassim_feb_small = corrcoef(model_small, xassimfrac_small)
corassim_feb_large = corrcoef(model_large, xassimfrac_large)
figure(1)
scatter(model_small, xassimfrac_small)
xlabel('model small feb')
ylabel('assim small feb')
figure(2)
scatter(model_large, xassimfrac_large)
xlabel('model large feb')
ylabel('assim large feb')
figure(3)
scatter(misr_so, xassimfrac_large)
xlabel('misr small feb')
ylabel('assim small feb')
figure(4)
scatter(misr_lo, xassimfrac_large)
xlabel('misr large feb')
ylabel('assim large feb')
%dlmwrite('febsmallassim06.txt', Msmall,'delimiter', '\t', 'precision', 4)
%dlmwrite('feblargeassim06.txt', Mlarge,'delimiter', '\t', 'precision', 4)
%dlmwrite('febsmallmisr06.txt', Misrsmall,'delimiter', '\t', 'precision', 4)
%dlmwrite('feblargemisr06.txt', Misrlarge,'delimiter', '\t', 'precision', 4)
%dlmwrite('febsmallmod06.txt', Modelsmall, 'delimiter', '\t', 'precision', 4)
%dlmwrite('feblargemod06.txt', Modellarge, 'delimiter', '\t', 'precision', 4)