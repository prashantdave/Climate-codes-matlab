 y=eig(0.5*(B+B'));
J=0.5*(B+B');
P=J+10^(-10)*eye(912,912);
Z=eig(P);
counter=0;
counter1=0;
N=912;
for i=1:N
    if(Z(i)<0)
        counter=counter+1;
    end
    if(isreal(Z(i))==0)
        counter1=counter1+1;
    end
end

P=eye(N,N);
T3=H*P*H'+O;
T2=inv(T3);
T4=eye(487,487)-T2*T3;
E4=eig(T4);
K1=P*H'*T2;
T1=K1*(observation-H*backgrd);
Xhat=backgrd+T1;

[A1,A2]=size(K1);
counter3=0;
for i=1:A1
    for j=1:A2
        if(K1(i,j)<0)
            counter3=counter3+1;
        end
    end
end