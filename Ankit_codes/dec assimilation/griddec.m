clc
clear all
res=[];
fid = fopen('dec06list.txt');% reading all files for the month of decy in an array called 'filename'
while ~feof(fid)
    C=fgetl(fid);
    d = ('C:\Ankit\ankit_temp\dec assimilation\');%should be the directory path in which your files are stored
    cd = strcat(d, C);
    res=[res;cd];
end
fclose(fid);
filename=res;
n=size(res, 1);
aod = [];
xdim = xlsread('dec06.xlsx', 'A1:A31'); %reading hdf file dimensions - make a list of dimensions according to day(manual, but makes processing much faster)
ydim = xlsread('dec06.xlsx','B1:B31');
model_lat = xlsread('echamlocation.xlsx', 'A1:A19'); % reading model grid lat lon
model_lon = xlsread('echamlocation.xlsx', 'B1:B48');
d = 19*48;
aod_dec = zeros(d,7,n); %array where gridded aods will be stored
count1 = 1;
grid = zeros(d,2);
for i = 1:19 %writing model lat lon to final aod grid
    for j = 1:48
        grid(count1,1) = model_lat(i);
        grid(count1,2) = model_lon(j);
        count1 = count1 + 1;
    end
end
filecount = 1;
for i = 1:n
    for j = 1:31
        if (str2double(res(i,68:70)))==(335+(j-1))
            i
            tempaod = zeros(xdim(j), ydim(j), 4);
            tempaodfrac = zeros(xdim(j), ydim(j), 4, 5);
            lat = zeros(xdim(j), ydim(j));
            lon = zeros(xdim(j), ydim(j));
            aod_550 = zeros(xdim(j), ydim(j));
            aod_small = zeros(xdim(j), ydim(j));
            aod_medium = zeros(xdim(j), ydim(j));
            aod_large = zeros(xdim(j), ydim(j));
            aod_sph = zeros(xdim(j), ydim(j));
            aod_nsph = zeros(xdim(j), ydim(j));
            aod_unc = zeros(xdim(j), ydim(j));
            AOD = zeros(xdim(j), ydim(j), 9);
            lat = hdfread(res(i,:), '/RegParamsAer/Data Fields/Latitude', 'Index', {[1 1],[1 1],[xdim(j) ydim(j)]});
            lon = hdfread(res(i,:), '/RegParamsAer/Data Fields/Longitude', 'Index', {[1 1],[1 1],[xdim(j) ydim(j)]});
            tempaod =  hdfread(res(i,:), '/RegParamsAer/Data Fields/RegBestEstimateSpectralOptDepth', 'Index', {[1 1 1],[1 1 1],[xdim(j) ydim(j) 4]});
            tempaodfrac =  hdfread(res(i,:), '/RegParamsAer/Data Fields/RegBestEstimateSpectralOptDepthFraction', 'Index', {[1 1 1 1],[1 1 1 1],[xdim(j) ydim(j) 4 5]});
            tempaodunc = hdfread(res(i,:), '/RegParamsAer/Data Fields/RegBestEstimateSpectralOptDepthUnc', 'Index', {[1 1 1],[1 1 1],[xdim(j) ydim(j) 4]});
            aod_550(:,:) = squeeze(tempaod(:,:,2));
            aod_small(:,:) = squeeze(tempaodfrac(:,:,2,1));
            aod_medium(:,:) = squeeze(tempaodfrac(:,:,2,2));
            aod_large(:,:) = squeeze(tempaodfrac(:,:,2,3));
            aod_sph(:,:) = squeeze(tempaodfrac(:,:,2,4));
            aod_nsph(:,:) = squeeze(tempaodfrac(:,:,2,5));
            aod_unc(:,:) = squeeze(tempaodunc(:,:,2));
            AOD(:,:,1) = aod_550(:,:);%creating array of necessary values
            AOD(:,:,2) = aod_small(:,:);
            AOD(:,:,3) = aod_medium(:,:);
            AOD(:,:,4) = aod_large(:,:);
            AOD(:,:,5) = aod_sph(:,:);
            AOD(:,:,6) = aod_nsph(:,:);
            AOD(:,:,7) = aod_unc(:,:);
            AOD(:,:,8) = lat(:,:);
            AOD(:,:,9) = lon(:,:);
            for k = 1:xdim(j)%replacing fill value with zero
                for l = 1:ydim(j)
                    for m = 1:7
                        if AOD(k,l,m) == -9999
                            AOD(k,l,m) = 0;
                        end
                    end
                end
            end
            countvec = ones(d,1);
            count2 = 1;
            for p = 1:18
                for q = 1:47
                    for k = 1:xdim(j)
                        for l = 1:ydim(j)
                            if AOD(k,l,8) >= model_lat(p) && AOD(k,l,8) < model_lat(p+1)
                                if AOD(k,l,9) >= model_lon(q) && AOD(k,l,9) < model_lon(q+1)
                                    if AOD(k,l,7)~=0
                                        countvec(count2,1) = countvec(count2,1)+1;
                                        for m = 2:6
                                            aod_dec(count2, m, filecount) = aod_dec(count2, m, filecount)+ AOD(k,l,m)*AOD(k,l,1)/(AOD(k,l,7)^2);
                                        end
                                        aod_dec(count2, 1, filecount) = aod_dec(count2,1, filecount)+ AOD(k,l,1)/(AOD(k,l,7)^2);
                                        aod_dec(count2, 7, filecount) = aod_dec(count2,7, filecount)+ 1/(AOD(k,l,7)^2);
                                    end
                                end
                            end
                        end
                    end
                    count2 = count2+1;%keeps track of which grid cell is being processed
                end
            end
        end
    end
    filecount = filecount + 1;%keeps track of which file is being processed
end
save('aoddec06.mat', 'aod_dec')%saving filewise aod values
aod_ave_dec = zeros(d,9);
aod_ave_dec(:,1:2) = grid;
for i = 1:d %monthly mean, additions
    for j = 1:7
        for k = 1:n
        aod_ave_dec(i,j+2) = aod_ave_dec(i,j+2) + aod_dec(i,j,k);
        end
    end
end
for i = 1:d %dividing by common denominator, sum of 1/variance^2
    if aod_ave_dec(i,9) ~= 0
        for r = 3:8
            aod_ave_dec(i,r) = aod_ave_dec(i,r)/aod_ave_dec(i,9);
        end
        aod_ave_dec(i,9) = sqrt(1/aod_ave_dec(i,9));
    end
end
save ('aod_mm_dec06.mat', 'aod_ave_dec')%saving final aod values