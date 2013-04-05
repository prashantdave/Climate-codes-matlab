clear all;
clc;
load ('/home/prashant/Desktop/nc_data/ECHAM-HAM/01/0609/aprl.csv');
load ('/home/prashant/Desktop/nc_data/ECHAM-HAM/01/0609/aprc.csv');

lat = [41.968,  40.103 ,  38.237, 36.372, 34.507,  32.641,  30.776,  28.911, 27.046, 25.180, 23.315, 21.450, 19.585, 17.720, 15.854,  13.991,12.124,  10.259,   8.393, 6.528];
    
lon = [63.75, 65.625, 67.5, 69.375, 71.25, 73.125, 75.0, 76.875, 78.75, 80.625, 82.5, 84.375, 86.25 ,88.125, 90.0, 91.875, 93.75, 95.625, 97.5, 99.375, 101.25];
     
%A = dlmread('/home/prashant/Desktop/nc_data/ECHAM-HAM/T63_WNUD_9year_200103/extracted_data/aerom/geosp.csv',',');
A = aprl+aprc;

%B = dlmread('/home/prashant/Desktop/nc_data/ECHAM-HAM/radm/0305/TAU_2D.csv',',');
dir_path = '~/Desktop/nc_data/ECHAM-HAM/01/0609';
files = dir('~/Desktop/nc_data/ECHAM-HAM/01/0609/*.csv');
mat_files_path='/home/prashant/Desktop/nc_data/ECHAM-HAM/01/0609/mat_files';

for l = 1:length(files)
    if (files(l).bytes >= 50)
        s1 = files(l).name;
        s = sprintf('%s/',dir_path,s1);
        s(1:end-1)
        B = dlmread(s(1:end-1),',');
    end
    
    var_0 = [];
    var_1 = [];
    [m,n] = size(A);
    count = 1;
    corr_coff = [];
    corr_coeff_0 = [];
    Correlation_coeff = [];

    for i=1:20
        var_0(:,i,:) = A(:,count:count+20);
        var_1(:,i,:) = B(:,count:count+20);
        count = count+21;
    end

    [p,q,r] = size(var_0);

    for k=0:9
        for i=1:q
            for j=1:r
                corr_coeff = 0;
                count = 1;
        
                if ((k == 0))
                    corr_coeff_0(i,j) = abs(corr(var_0(:,i,j),var_1(:,i,j)));
                    corr_coeff_0(i,j);
                end
        
                if ((i+k+1<=q) && (var(var_1(:,i+k+1,j)) > 0)) 
                    corr_coeff = abs(corr(var_0(:,i,j),var_1(:,i+k+1,j))) + corr_coeff;
                    count = count + 1;
                    if ((j+k+1 <= r) && (var(var_1(:,i+k+1,j+k+1)) > 0))
                        corr_coeff = abs(corr(var_0(:,i,j),var_1(:,i+k+1,j+k+1))) + corr_coeff;
                        count = count + 1;
                    end
                    if ((j-k-1 > 0) && (var(var_1(:,i+k+1,j-k-1)) > 0))
                        corr_coeff = abs(corr(var_0(:,i,j),var_1(:,i+k+1,j-k-1))) + corr_coeff;
                        count = count + 1;
                    end
                end
        
                if ((i-k-1> 0) && (var(var_1(:,i-k-1,j)) > 0)) 
                    corr_coeff = abs(corr(var_0(:,i,j),var_1(:,i-k-1,j))) + corr_coeff;
                    count =count + 1;
                    if ((j+k+1 <= r) && (var(var_1(:,i-k-1,j+k+1)) > 0))
                        corr_coeff = abs(corr(var_0(:,i,j),var_1(:,i-k-1,j+k+1))) + corr_coeff;
                        count = count + 1;
                    end
                    if ((j-k-1 > 0) && (var(var_1(:,i-k-1,j-k-1)) > 0))
                        corr_coeff = abs(corr(var_0(:,i,j),var_1(:,i-k-1,j-k-1))) + corr_coeff;
                        count = count + 1;
                    end
                end
        
        
                if ((j+k+1<=r) && (var(var_1(:,i,j+k+1)) > 0))
                    corr_coeff = abs(corr(var_0(:,i,j),var_1(:,i,j+k+1))) + corr_coeff;
                    count = count + 1;
                end
        
                if ((j-k-1> 0) && (var(var_1(:,i,j-k-1)) > 0)) 
                    corr_coeff = abs(corr(var_0(:,i,j),var_1(:,i,j-k-1))) + corr_coeff;
                    count = count + 1;
                end
                
                corr_coeff;
                Correlation_coeff(k+1,i,j) = corr_coeff/count;
            end  
        end
    end

    s1
    max_corr = ((max(max(max(Correlation_coeff)))))
    min_corr = min(min(min(Correlation_coeff)))
    s2=sprintf('%s/',mat_files_path,s1(1:end-4));
    s_mat = sprintf('%s', s2(1:end-1),'.mat');

    if (max_corr >= 0.2)
        Correlation_coefficient(find(isnan(Correlation_coeff)==1)) = 0;
        corr_coeff_0(find(isnan(corr_coeff_0)==1)) = 0;
        save(s_mat,'Correlation_coeff','corr_coeff_0')
%         fid = fopen('variable_and_correlation.txt','a');
%         if fid >=0 
%              fprintf(fid, '%s\t%u\n', s1, max_corr)
%             fclose(fid)
%         end
    end

end