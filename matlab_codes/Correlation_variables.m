function [corr_coeff] = Correlation_variables[var1_path,var2_path]
    
    lat = [40.103, 38.238, 36.372, 34.507, 32.642, 30.777, 28.911, 27.046, 25.181, 23.315, 21.450, 19.585, 17.720, 15.855, 13.990, 12.124, 10.259, 8.394, 6.528, 4.663, 2.798, 0.933, -0.933];    
    lon = [48.75, 50.625, 52.5, 54.375, 56.25, 58.125, 60.0, 61.875, 63.75, 65.625, 67.50, 69.375, 71.25, 73.125, 75.0, 76.875, 78.75, 80.625, 82.50, 84.375, 86.25, 88.125, 90.0, 91.875, 93.75, 95.625, 97.5, 99.375,  101.25];

    A = dlmread(var1_path,',');
    B = dlmread(var2_path,',');
  
    var_0 = [];
    var_1 = [];
    [m,n] = size(A);
    count = 1;
    corr_coff = [];
    mean_var_0 = [];
    mean_var_1 = [];
    
    for i=1:length(lat)
        var_0(:,i,:) = A(:,count:count+length(lon)-1);
        var_1(:,i,:) = B(:,count:count+length(lon)-1);
        count = count+length(lon);
    end

    [p,q,r] = size(var_0);
    mean_var_0(:,:) = mean(var_0,1);
    mean_var_1(:,:) = mean(var_1,1);    
    spatial_var_0 = reshape(mean_var_0, 1,length(lat)*length(lon))';
    spatial_var_1 = reshape(mean_var_1, 1,length(lat)*length(lon))';
    corr_coeff = (corr(spatial_var_0,spatial_var_1))