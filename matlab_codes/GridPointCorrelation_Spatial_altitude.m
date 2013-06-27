clear all;
clc;
load ('/home/prashant/Desktop/nc_data/ECHAM-HAM/2001/0609/01/csv_with_altitude/aprl.csv');
load ('/home/prashant/Desktop/nc_data/ECHAM-HAM/2001/0609/01/csv_with_altitude/aprc.csv');

lat = [40.103, 38.238, 36.372, 34.507, 32.642, 30.777, 28.911, 27.046, 25.181, 23.315, 21.450, 19.585, 17.720, 15.855, 13.990, 12.124, 10.259, 8.394, 6.528, 4.663, 2.798, 0.933, -0.933];    
lon = [48.75, 50.625, 52.5, 54.375, 56.25, 58.125, 60.0, 61.875, 63.75, 65.625, 67.50, 69.375, 71.25, 73.125, 75.0, 76.875, 78.75, 80.625, 82.50, 84.375, 86.25, 88.125, 90.0, 91.875, 93.75, 95.625, 97.5, 99.375,  101.25];


%A = dlmread('/home/prashant/Desktop/nc_data/ECHAM-HAM/T63_WNUD_9year_200103/extracted_data/aerom/geosp.csv',',');
A = aprl+aprc;

%B = dlmread('/home/prashant/Desktop/nc_data/ECHAM-HAM/radm/0305/TAU_2D.csv',',');
dir_path = '/home/prashant/Desktop/nc_data/ECHAM-HAM/2001/0609/xtsurf/csv_with_altitude';
files = dir('/home/prashant/Desktop/nc_data/ECHAM-HAM/2001/0609/xtsurf/csv_with_altitude/*.csv');
mat_files_path='/home/prashant/Desktop/nc_data/ECHAM-HAM/2001/0609/xtsurf/csv_with_altitude/mat_files';

for l = 1:length(files)
    if (files(l).bytes >= 50)
        s1 = files(l).name;
        s = sprintf('%s/',dir_path,s1);
        s(1:end-1)
        B = dlmread(s(1:end-1),',');
    end

%     var_0 = [];
%     var_1 = [];
%     [m,n] = size(A);
%     count = 1;
%     corr_coff = [];
%     mean_var_0 = [];
%     mean_var_1 = [];
%     
%     for i=1:length(lat)
%         var_0(:,i,:) = A(:,count:count+length(lon)-1);
%         var_1(:,i,:) = B(:,count:count+length(lon)-1);
%         count = count+length(lon);
%     end
% 
%     [p,q,r] = size(var_0);
%     mean_var_0(:,:) = mean(var_0,1);
%     mean_var_1(:,:) = mean(var_1,1);    
%     spatial_var_0 = reshape(mean_var_0, 1,length(lat)*length(lon))';
%     spatial_var_1 = reshape(mean_var_1, 1,length(lat)*length(lon))';
    size(A), size(B)
    corr_coeff = (corr(A',B'));
    s1,size(corr_coeff)
    s2=sprintf('%s/',mat_files_path,s1(1:end-4));
    s_mat = sprintf('%s', s2(1:end-1),'.mat')
    no_num = isnan(corr_coeff);
    no_num_index = find(no_num==1);
    corr_coeff(no_num_index) = 0;
    no_num = isnan(corr_coeff)
    
%    if isnan(corr_coeff)
%        corr_coeff = 0;
 %   end             
    save(s_mat,'corr_coeff')

end

%     for k=0:9
%         for i=1:q
%             for j=1:r
%                 corr_coeff = 0;
%                 count = 1;
%         
%                 if ((k == 0))
%                     corr_coeff_0(i,j) = abs(corr(var_0(:,i,j),var_1(:,i,j)));
%                     corr_coeff_0(i,j);
%                 end
%         
%                 if ((i+k+1<=q) && (var(var_1(:,i+k+1,j)) > 0)) 
%                     corr_coeff = abs(corr(var_0(:,i,j),var_1(:,i+k+1,j))) + corr_coeff;
%                     count = count + 1;
%                     if ((j+k+1 <= r) && (var(var_1(:,i+k+1,j+k+1)) > 0))
%                         corr_coeff = abs(corr(var_0(:,i,j),var_1(:,i+k+1,j+k+1))) + corr_coeff;
%                         count = count + 1;
%                     end
%                     if ((j-k-1 > 0) && (var(var_1(:,i+k+1,j-k-1)) > 0))
%                         corr_coeff = abs(corr(var_0(:,i,j),var_1(:,i+k+1,j-k-1))) + corr_coeff;
%                         count = count + 1;
%                     end
%                 end
%         
%                 if ((i-k-1> 0) && (var(var_1(:,i-k-1,j)) > 0)) 
%                     corr_coeff = abs(corr(var_0(:,i,j),var_1(:,i-k-1,j))) + corr_coeff;
%                     count =count + 1;
%                     if ((j+k+1 <= r) && (var(var_1(:,i-k-1,j+k+1)) > 0))
%                         corr_coeff = abs(corr(var_0(:,i,j),var_1(:,i-k-1,j+k+1))) + corr_coeff;
%                         count = count + 1;
%                     end
%                     if ((j-k-1 > 0) && (var(var_1(:,i-k-1,j-k-1)) > 0))
%                         corr_coeff = abs(corr(var_0(:,i,j),var_1(:,i-k-1,j-k-1))) + corr_coeff;
%                         count = count + 1;
%                     end
%                 end
%         
%         
%                 if ((j+k+1<=r) && (var(var_1(:,i,j+k+1)) > 0))
%                     corr_coeff = abs(corr(var_0(:,i,j),var_1(:,i,j+k+1))) + corr_coeff;
%                     count = count + 1;
%                 end
%         
%                 if ((j-k-1> 0) && (var(var_1(:,i,j-k-1)) > 0)) 
%                     corr_coeff = abs(corr(var_0(:,i,j),var_1(:,i,j-k-1))) + corr_coeff;
%                     count = count + 1;
%                 end
%                 
%                 corr_coeff;
%                 Correlation_coeff(k+1,i,j) = corr_coeff/count;
%             end  
%         end
%     end

%     s1
%     max_corr = ((max(max(max(Correlation_coeff)))))
%     min_corr = min(min(min(Correlation_coeff)))
%     s2=sprintf('%s/',mat_files_path,s1(1:end-4));
%     s_mat = sprintf('%s', s2(1:end-1),'.mat');
% 
%     if (max_corr >= 0.2)
%         Correlation_coefficient(find(isnan(Correlation_coeff)==1)) = 0;
%         corr_coeff_0(find(isnan(corr_coeff_0)==1)) = 0;
%         save(s_mat,'Correlation_coeff','corr_coeff_0')
% %         fid = fopen('variable_and_correlation.txt','a');
% %         if fid >=0 
% %              fprintf(fid, '%s\t%u\n', s1, max_corr)
% %             fclose(fid)
% %         end
%     end
% %    end
% end