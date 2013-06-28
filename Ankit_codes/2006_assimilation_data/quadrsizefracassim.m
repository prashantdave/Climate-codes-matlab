clc
clear all
N = 3*912;
load('misr_jan06_small.mat')
load('misr_jan06_large.mat')
load('jansmall06.mat')
load('janlarge06.mat')
load('aod_mm_jan06.mat')
load('modelaod.mat')
misr_s = misr_jan_small(:,3);
misr_sf = misr_jan_small(:,4);
misr_l = misr_jan_large(:,3);
misr_lf = misr_jan_large(:,4);
misr_unc = aod_ave_jan(:,9);
misr_aod =  aod_ave_jan(:,3);
model_small = Msmall_jan(:,3);
model_large = Mlarge_jan(:,3);
modelaod = model_aod(:,1);
lat = Msmall_jan(:,1);
lon = Msmall_jan(:,2);
temp1 = zeros(19,48);
temp2 = zeros(19,48);
temp3 = zeros(19,48);
temp4 = zeros(19,48);
temp5 = zeros(19,48);
temp6 = zeros(19,49);
backcount = 1;
for i = 1:19
    for j = 1:48
        temp1(i,j) = misr_s(backcount);
        temp2(i,j) = misr_sf(backcount);
        temp3(i,j) = misr_l(backcount);
        temp4(i,j) = misr_lf(backcount);
        temp5(i,j) = misr_unc(backcount);
        temp6(i,j) = misr_aod(backcount);
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
        misr_unc(miscount) = temp5(j,i);
        misr_aod(miscount) = temp6(j,i);
        miscount = miscount + 1;
    end
end
misr_so = misr_s;
misr_lo = misr_l;
misr_aodo = misr_aod;
backgrdfrac = zeros(N,1);
F1 = zeros(N/3,N);
F2 = zeros(N/3,N);
F3 = zeros(N/3,N);
io= 0;
Hmap=zeros(1,N/3);
misr_unc1 = zeros(N/3,1);
for i=1:N/3
    if misr_s(i)>0
        io=io+1;
        F1(io,i)=1;
        F2(io,i) =1;
        F3(io,i) = 1;
        Hmap1(i)=io;
        misr_s(io)=misr_s(i);
        misr_l(io) = misr_l(i);
        misr_sf(io) = misr_sf(i);
        misr_lf(io) = misr_lf(i);
        misr_unc1(io) = misr_unc(i);
        misr_aod(io) = misr_aodo(i);
        backgrdfrac(3*i-2) = model_small(i);
        backgrdfrac(3*i-1) = model_large(i);
        backgrdfrac(3*i) = modelaod(i);
    end
end
Fo = io;
F1 = F1(1:Fo,:);
F2 = F2(1:Fo,:);
F3 = F3(1:Fo,:);
misr_s = misr_s(1:Fo,1);
misr_l = misr_l(1:Fo,1);
misr_sf = misr_sf(1:Fo,1);
misr_lf = misr_lf(1:Fo,1);
obsfrac = zeros(2*Fo,1);
toterror = zeros(3*Fo,3*Fo);
Fcon = zeros(N/3,N);
%defining the constraint matrix
for i = 1:N/3
    Fcon(i,1) = 1;
    Fcon(i,2) = 1;
    Fcon(i,3) = -1;
end
for i = 1:Fo
    toterror(3*i-2,3*i-2) = misr_unc1(i)*misr_sf(i)^2;
    toterror(3*i-1,3*i-1) = misr_unc1(i)*misr_lf(i)^2;
    toterror(3*i,3*i) = misr_unc1(i);
end
F = zeros(3*Fo,N);
for i = 1:Fo
    obsfrac(3*i-2) = misr_s(i);
    F(3*i-2,:) = F1(i,:);        
    obsfrac(i) = misr_l(i);
    F(3*i-1,:) = F2(i,:);
    obsfrac(3*i) = misr_aod(i);
    F(3*i,:) = F2(i,:);
end
Bfrac = modelcovfrac(backgrdfrac);
Bfraceig = eig(Bfrac);
lambmin = min(Bfraceig);
if real(lambmin) < 0
    Bfrac = Bfrac + abs(lambmin*1.1).*eye(N);
end
oinv = pinv(toterror);
Bfracnewmin = min(eig(Bfrac));
binv = .5*(pinv(Bfrac) + pinv(Bfrac)');
    theta = binv + F'*oinv*F;
thetmin = min(eig(theta));
if thetmin < 0
    theta = theta - (thetmin*1.01).*eye(N);
end
thetnewmin = min(eig(theta))
phi = (backgrdfrac'*binv + obsfrac'*oinv*F);
lb = zeros(N,1);
t1 = max(backgrdfrac);
t2 = max(obsfrac);
t = max([t1 t2]);
ub = t.*ones(N,1);
opts = optimset('Algorithm', 'interior-point-convex', 'MaxIter', 800, 'Display', 'off');
[xassimfrac, fval, exitflag, output, lambda] = quadprog(theta, -phi, [], [], [], [], lb, ub, [], opts);
xassimfrac_small = zeros(N/3,1);
xassimfrac_large = zeros(N/3,1);
xassimtotal = zeros(N/3,1);
for i = 1:N/3
        xassimfrac_small(i) = xassimfrac(3*i-2);
        xassimfrac_large(i) = xassimfrac(3*i-1);
        xassimtotal(i) = xassimfrac(3*i);
end
Misrsmall = [lat lon misr_so];
Misrlarge = [lat lon misr_lo];
Misrtotal = [lat lon misr_aod];
Modelsmall = [lat lon model_small];
Modellarge = [lat lon model_large];
Modeltotal = [lat lon modelaod];
Msmall = [lat lon xassimfrac_small];
Mlarge = [lat lon xassimfrac_large];
Mtotal = [lat lon xassimtotal];
corassim_jan_small = corrcoef(model_small, xassimfrac_small)
corassim_jan_large = corrcoef(model_large, xassimfrac_large)
corassim_jan_total = corrcoef(modelaod, xassimtotal)
figure(1)
scatter(model_small, xassimfrac_small)
xlabel('model small jan')
ylabel('assim small jan')
figure(2)
scatter(model_large, xassimfrac_large)
xlabel('model large jan')
ylabel('assim large jan')
figure(3)
scatter(modelaod, xassimfrac_large)
xlabel('model aod jan total')
ylabel('assimilated aod jan total')
figure(4)
scatter(misr_so, xassimfrac_large)
xlabel('misr small jan')
ylabel('assim small jan')
figure(5)
scatter(misr_lo, xassimfrac_large)
xlabel('misr large jan')
ylabel('assim large jan')
figure(6)
scatter(misr_aod, xassimtotal)
xlabel('misr aod jan total')
ylabel('assimilated aod jan total')
dlmwrite('fracsmallassimjan.txt', Msmall,'delimiter', '\t', 'precision', 4)
dlmwrite('fraclargeassimjan.txt', Mlarge,'delimiter', '\t', 'precision', 4)
dlmwrite('fractotassimjan.txt', Mtotal, 'delimiter', '\t', 'precision', 4)
dlmwrite('fracsmallmisrjan.txt', Misrsmall,'delimiter', '\t', 'precision', 4)
dlmwrite('fraclargemisrjan.txt', Misrlarge,'delimiter', '\t', 'precision', 4)
dlmwrite('fractotmisrjan.txt', Misrtotal,'delimiter', '\t', 'precision', 4)
dlmwrite('fracsmallmodjan.txt', Modelsmall, 'delimiter', '\t', 'precision', 4)
dlmwrite('fraclargemodjan.txt', Modellarge, 'delimiter', '\t', 'precision', 4)
dlmwrite('fractotmodjan.txt', Modeltotal, 'delimiter', '\t', 'precision', 4)