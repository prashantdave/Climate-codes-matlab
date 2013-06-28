clc
clear all
model_aod=xlsread('gradsECHAM.xlsx','Shet12', 'C1:C912');
load('aod_mm_dec06.mat')
misr_aod = aod_ave_dec(:,3);
misr_unc = aod_ave_dec(:,9);
backgrd = model_aod;
observation = misr_aod;
obserror = misr_unc;
Nr=912;N= Nr;M=N;
fm=0.5;
em=0.1;
lx=19;
ly=48;
Hmap=zeros(1,N);
H=zeros(M,N);
B=zeros(N,N);
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
for i=1:912
    for j=1:912
        ix = floor(i/48);
        iy = i - ix*48;
        if ix == 0
            ix = ix + 1;
        end
        if iy == 0
            iy = iy + 48;
        end
        jx = floor(j/48);
        jy = j - jx*48;
        if jx == 0
            jx = jx + 1;
        end
        if jy == 0
            jy = jy + 48;
        end
        dx=abs(ix-jx);
        dy=abs(iy-jy);
        if dx <=0 && dy <=0
          B(i,j)=exp(-dx^2/lx^2/2-dy^2/ly^2/2);
            B(i,j)=B(i,j)*(backgrd(i)*fm+em)*(backgrd(j)*fm+em);
        else
           B(i,j) = 0;
          end
    end
    
end
%O is a diagonal
O=zeros(Mo,Mo);
for i=1:Mo
    O(i,i)=obserror(i); %for misr we directly have variance.
end
%HB
%HB=zeros(M,N);
HB=H*B;
HBHTO=(HB*H')+O;
HBHTOi=pinv(HBHTO);
O_Hb=observation-(H*backgrd);
ixO_Hb=HBHTOi*(O_Hb);
BHTixO_Hb=(B*H')*ixO_Hb;
%K=kalman gain matrix
K=(B*H')*(HBHTOi);
%evaluation of post error covariance matrix P
Post_covar=zeros(N,N);
Pre_covar=zeros(N,N);
P=B-(K*H*B);
%writing Pre-errorcovariance matrix
Pre_covar = B;
Post_covar = P;
analysis=zeros(1,N);
for i=1:N
    analysis(i)=backgrd(i)+BHTixO_Hb(i);
end
misr_dec_assim = analysis;
pre_cov_dec = Pre_covar;
post_cov_dec = Post_covar;
corrcoef(misr_dec_assim, backgrd)