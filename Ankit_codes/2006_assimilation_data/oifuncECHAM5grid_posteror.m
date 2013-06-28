function[analysis Pre_covar Post_covar]=oifuncECHAM5grid_posteror(backgrd,observation,obserror) 
Nr=5;N=25;M=25; 
fm=0.5;em=0.1;lx=5;ly=5; 
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
for i=1:N 
    for j=1:N 
        dx=abs(double(mod(i-1,Nr)-mod(j-1,Nr))); 
        dy=abs(double((i-1)/Nr-(j-1)/Nr)); 
        B(i,j)=exp(-dx^2/lx^2/2-dy^2/ly^2/2); 
        B(i,j)=B(i,j)*(backgrd(i)*fm+em)*(backgrd(j)*fm+em); 
    end 
end 
%O is a diagonal 
O=zeros(Mo,Mo); 
for i=1:Mo 
    O(i,i)=obserror(i)^2; 
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
Post_covar=zeros(1,N); 
Pre_covar=zeros(1,N); 
P=B-(K*H*B); 
for j=1:5 
    for k=1:5 
        l=5*(j-1)+k; 
        Post_covar(l)=P(k,j); 
    end 
end 
%writing Pre-errorcovariance matrix 
for j=1:5 
    for k=1:5 
        l=5*(j-1)+k; 
        Pre_covar(l)=B(k,j); 
    end 
end 
analysis=zeros(1,N); 
for i=1:N     
    analysis(i)=backgrd(i)+BHTixO_Hb(i); 
end 