function Correlation_significance_test(Threshold) 

a = {'01','activ','aeronm','conv','diag','forcing','inputm','nudg','radm','tarcerm','xtsurf'};
counter=0;
for i=1:length(a)    
    dir_path = cell2mat(strcat('/home/prashant/Desktop/nc_data/ECHAM-HAM/2001/',a(i),'/0609/mat_files'));
    mat_files_path=cell2mat(strcat('/home/prashant/Desktop/nc_data/ECHAM-HAM/2001/',a(i),'/0609/mat_files/*.mat'));
    significant_variables_path = cell2mat(strcat('/home/prashant/Desktop/nc_data/ECHAM-HAM/2001/',a(i),'/0609/mat_files/significant_variables'));
    files = dir(mat_files_path);

    for l = 1:length(files)
            s1 = files(l).name; 
            s = sprintf('%s/',dir_path,s1);
            load (s(1:end-1));
    
            n = 667;
            alpha = 0.05;
%            Threshold = 0.7 %Corrleation Coefficient value; H_0 >= 0.7 (null hypothesis) H_a < 0.7 (alternate hypothesis).
    
            % Fishers Z-transformation              
            Zr = atanh(corr_coeff_0);
            Z_rho = atanh(Threshold);    
            sigma_z = 1/sqrt(n-3);
            z = (Zr-Z_rho)/sigma_z;
            P = normcdf(z);
            
            % Fraction of grid point for which null hypothesis can not be rejected (w.r.t total no. of grid points)        
            fraction = length(find(P>alpha))/n
            if (fraction >= 0.70)
                s2=sprintf('%s/',significant_variables_path,s1(1:end-4));
                s_mat = sprintf('%s', s2(1:end-1),'.mat');      
                save(s_mat);
                counter = counter+1
            end
            counter
    end
end
