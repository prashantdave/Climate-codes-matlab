clc
clear all
Nr_h=2;Nr_OI=5;
N_OI=25;M_OI=25;
model_aod=xlsread('gradsECHAM.xlsx','Sheet3', 'C1:C912');
imax=19;jmax=48;
modelaod = zeros(imax, jmax);
misraod = zeros(imax,jmax);
misrunc = zeros(imax,jmax);
load('aod_mm_jan06.mat')
count = 1;
count1 = 1;
for m = 1:imax
    for n = 1:jmax
        misraod(m,n) = aod_ave_jan(count1,3);
        misrunc(m,n) = aod_ave_jan(count1,9);
        count1 = count1 + 1;
    end
end
for i = 1:imax
    for j = 1:jmax
        modelaod(i,j) = model_aod(count);
        count = count+1;
    end
end
backgrd=zeros(N_OI,1);
observation=zeros(M_OI,1);
obserror=zeros(M_OI,1);
aod2d_tot=zeros(imax,jmax);
error_covar=zeros(imax,jmax);
posterror_covar=zeros(imax,jmax);
for i=3:17
    for j=3:46
        for jj=j-Nr_h:j+Nr_h
            for ii=i-Nr_h:i+Nr_h
                icount=(jj-j+Nr_h)*Nr_OI+ii-i+Nr_h+1;
                backgrd(icount)=modelaod(ii,jj);
                observation(icount)=misraod(ii,jj);
                obserror(icount)=misrunc(ii,jj);
            end
        end
        [analysis Pre_covar Post_covar]=oifuncECHAM5grid_posteror(backgrd,observation,obserror);
        %         ileft=i;
        %         iright=i;
        %         jbottom=j;
        %         jtop=j;
        if i==3
            ileft=1;
            iright=i;
        elseif i==17
            ileft=i;
            iright=imax;
        else
            ileft=i;
            iright=i;
        end
        
        if j==3
            jbottom=1;
            jtop=j;
        elseif j==46
            jtop=jmax;
            jbottom=j;
        else
            jbottom=j;
            jtop=j;
        end
        for ii=ileft:iright
            for jj=jbottom:jtop
                icount=(jj-j+Nr_h)*Nr_OI+ii-i+Nr_h+1;
                aod2d_tot(ii,jj)=analysis(icount);
                error_covar(ii,jj)=Pre_covar(icount);
                posterror_covar(ii,jj)=Post_covar(icount);
            end
        end
    end
end
for j=1:jmax
    for i=1:imax
        if aod2d_tot(i,j)<=0
            aod2d_tot(i,j)=modelaod(i,j);
        end
    end
end
count2 = 1;
finalaod = zeros(912,1);
for i = 1:imax
    for j = 1:jmax
        finalaod(count2,1) =aod2d_tot(i,j);
        count2 = count2+1;
    end
end
lats = xlsread('gradsECHAM.xlsx','Shet12', 'A1:A912');
lons = xlsread('gradsECHAM.xlsx','Shet12', 'B1:B912');
Xa = [lats lons finalaod];
dlmwrite('assim_jan.txt', Xa, 'delimiter', '\t', 'precision', 4);
xlswrite('janassim.xlsx',finalaod)
xlswrite('assim_jan.xlsx',aod2d_tot)
xlswrite('Modelerror_jan.xlsx',error_covar)
xlswrite('Assimerror_jan.xlsx',posterror_covar)