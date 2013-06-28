clc
clear all
model_aod=xlsread('gradsECHAM.xlsx','Sheet1', 'C1:C912');
load('aod_mm_jan06.mat')
misr_aod = aod_ave_jan(:,3);
misr_unc = aod_ave_jan(:,9);
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
backgrd = model_aod;
observation = misr_aod;
obserror = misr_unc;
Nr=912;N= Nr;
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
%O is a diagonal
O=zeros(Mo,Mo);
for i=1:Mo
    O(i,i)=obserror(i); %for misr we directly have variance.
end
%HB
%HB=zeros(M,N);
tempback = backgrd;
assimnew = zeros(size(backgrd));
Ptemp = B;
for i = 1:Mo
    B = Ptemp;
    Hrow = H(i,:);
    Q1 = Hrow*B*Hrow' + O(i,i);
    Q1i = 1/Q1;
    del = (observation(i) - Hrow*tempback);
    Q2 = Q1i*del;
    Q3 = B*Hrow'*Q2;
    assimnew = tempback + Q3;
    K = (B*Hrow')*Q1i;
    Ptemp = B - K*Hrow*B;
    tempback = assimnew;
end
%HB=H*B;
%HBHTO=(HB*H')+O;
%HBHTOi=pinv(HBHTO);
%O_Hb=observation-(H*backgrd);
%ixO_Hb=HBHTOi*(O_Hb);
%BHTixO_Hb=(B*H')*ixO_Hb;
%K=kalman gain matrix
%K=(B*H')*(HBHTOi);
%evaluation of post error covariance matrix P
Post_covar=zeros(N,N);
Pre_covar=zeros(N,N);
%P=B-(K*H*B);
%writing Pre-errorcovariance matrix
Pre_covar = B;
Post_covar = Ptemp;
%analysis=zeros(1,N);
%for i=1:N
 %   analysis(i)=backgrd(i)+BHTixO_Hb(i);
%end
zcounter = 0;
for i = 1:912
if (assimnew(i) <0)
zcounter = zcounter + 1;
end
end
zcounter 
%zcounter displays negative aod values if any
misr_jan_assim = assimnew;
pre_cov_jan = Pre_covar;
post_cov_jan = Post_covar;
corrcoef(misr_jan_assim, backgrd)
lat = xlsread('gradsECHAM.xlsx','Shet12', 'A1:A912');
lon = xlsread('gradsECHAM.xlsx','Shet12', 'B1:B912');
M = [lat lon misr_jan_assim];
dlmwrite('osassimjan.txt', M, 'delimiter', '\t', 'precision', 4);
save('osassimjan06.mat', 'M')