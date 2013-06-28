%This code interpolates values such as AOD, size fractions, shape fractions and
%SSA from the satellite resolution to model resolution using inverse of
%satellite aod variances as weights
clc
clear all
res=[];
fid = fopen('jan06list.txt');% reading all files for the month of the given month in an array called 'filename', this can be created by using the command prompt and the command dir *.* > filenames.txt
while ~feof(fid)
    C=fgetl(fid);
    d = ('C:\Documents and Settings\Administrator\Desktop\Ankit\ankit_temp\jan assimilation\');%should be the directory path in which your files are stored, prefix needed for hdfread
    cd = strcat(d, C);
    res=[res;cd];
end
fclose(fid);
filename=res;
n=size(res, 1);
aod = [];
xdim = xlsread('jan06.xlsx', 'A:A'); %reading hdf file dimensions - make a list of dimensions according to day(manual, but makes processing much faster)
ydim = xlsread('jan06.xlsx','B:B');
days = size(xdim,1);
model_lat = xlsread('echamlocation.xlsx', 'A:A'); % reading model grid lat lon from excel file
model_lon = xlsread('echamlocation.xlsx', 'B:B');
latno = size(model_lat,1);
lonno = size(model_lon,1);
d = latno*lonno;
aod_day = zeros(d,8,n); %array where gridded aods will be stored (per file), further processed to monthly averages
count1 = 1;
grid = zeros(d,2);
for j = 1:lonno
    for i = 1:latno %writing model lat lon to final aod grid
        grid(count1,1) = model_lat(i);
        grid(count1,2) = model_lon(j);
        count1 = count1 + 1;
    end
end
filecount = 1;
countvec = ones(d,1);
for i = 1:n
    for j = 1:days
        if (str2double(res(i,113:115)))==(1+(j-1))%here look at the character array after running it once where your code will run without processing any files. do character (array col dimension - 37) as the second number, and that-2 as the first. 
            i
            tempaod = zeros(xdim(j), ydim(j), 4);
            tempssa = zeros(xdim(j), ydim(j), 4);
            tempaodfrac = zeros(xdim(j), ydim(j), 4, 5);
            lat = zeros(xdim(j), ydim(j));
            lon = zeros(xdim(j), ydim(j));
            aod_550 = zeros(xdim(j), ydim(j));
            ssa_550 =  zeros(xdim(j), ydim(j));
            aod_small = zeros(xdim(j), ydim(j));
            aod_medium = zeros(xdim(j), ydim(j));
            aod_large = zeros(xdim(j), ydim(j));
            aod_sph = zeros(xdim(j), ydim(j));
            aod_nsph = zeros(xdim(j), ydim(j));
            aod_unc = zeros(xdim(j), ydim(j));
            AOD = zeros(xdim(j), ydim(j), 10);
            lat = hdfread(res(i,:), '/RegParamsAer/Data Fields/Latitude', 'Index', {[1 1],[1 1],[xdim(j) ydim(j)]});
            lon = hdfread(res(i,:), '/RegParamsAer/Data Fields/Longitude', 'Index', {[1 1],[1 1],[xdim(j) ydim(j)]});
            tempaod =  hdfread(res(i,:), '/RegParamsAer/Data Fields/RegBestEstimateSpectralOptDepth', 'Index', {[1 1 1],[1 1 1],[xdim(j) ydim(j) 4]});
            tempaodfrac = hdfread(res(i,:), '/RegParamsAer/Data Fields/RegBestEstimateSpectralOptDepthFraction', 'Index', {[1 1 1 1],[1 1 1 1],[xdim(j) ydim(j) 4 5]});
            tempaodunc = hdfread(res(i,:), '/RegParamsAer/Data Fields/RegBestEstimateSpectralOptDepthUnc', 'Index', {[1 1 1],[1 1 1],[xdim(j) ydim(j) 4]});
            tempssa = hdfread(res(i,:), '/RegParamsAer/Data Fields/RegBestEstimateSpectralSSA', 'Index', {[1 1 1],[1 1 1],[xdim(j) ydim(j) 4]});
            aod_550(:,:) = squeeze(tempaod(:,:,2));
            ssa_550(:,:) = squeeze(tempssa(:,:,2));
            aod_small(:,:) = squeeze(tempaodfrac(:,:,2,1));
            aod_medium(:,:) = squeeze(tempaodfrac(:,:,2,2));
            aod_large(:,:) = squeeze(tempaodfrac(:,:,2,3));
            aod_sph(:,:) = squeeze(tempaodfrac(:,:,2,4));
            aod_nsph(:,:) = squeeze(tempaodfrac(:,:,2,5));
            aod_unc(:,:) = squeeze(tempaodunc(:,:,2));
            f_aaod = zeros(size(ssa_550));
            for u = 1:size(ssa_550,1) %here we define the variable that will act as the ratio of AAOD/AOT (absorption : total optical depth)
                for v = 1:size(ssa_550,2)
                    if ssa_550(u,v) > -9999
                        f_aaod(u,v) = 1-ssa_550(u,v);
                    end
                end
            end
            AOD(:,:,1) = aod_550(:,:);%creating array of necessary values
            AOD(:,:,2) = aod_small(:,:);
            AOD(:,:,3) = aod_medium(:,:);
            AOD(:,:,4) = aod_large(:,:);
            AOD(:,:,5) = aod_sph(:,:);
            AOD(:,:,6) = aod_nsph(:,:);
            AOD(:,:,7) = f_aaod(:,:);
            AOD(:,:,8) = aod_unc(:,:);
            AOD(:,:,9) = lat(:,:);
            AOD(:,:,10) = lon(:,:);
            for k = 1:xdim(j)%replacing fill value with zero
                for l = 1:ydim(j)
                    for m = 1:8
                        if AOD(k,l,m) == -9999
                           AOD(k,l,m) = 0;
                        end
                    end
                end
            end
            %g = max(AOD(:,:,8),[],1);%finding the maximum value of uncertainty in the model grid, this is used as a weight for elements with uncertainty reported as zero. (since there is no uncertainty reported, we know that the value was obtained from a single mixture, hence the retrieval has maximum uncertainty)
            %r = max(g,[],2);
            count2 = 1;
            for p = 1:lonno-1%these would depend on your model lat lon extents and dimensions
                for q = 1:latno-1
                    for k = 1:xdim(j)
                        for l = 1:ydim(j)
                            if AOD(k,l,9) >= model_lat(q) && AOD(k,l,9) < model_lat(q+1)
                                if AOD(k,l,10) >= model_lon(p) && AOD(k,l,10) < model_lon(p+1)
                                    if AOD(k,l,8)~=0
                                        for m = 1:7
                                            aod_day(count2, m, filecount) = aod_day(count2, m, filecount)+ AOD(k,l,m)/(AOD(k,l,8)^2);
                                        end
                                        aod_day(count2, 8, filecount) = aod_day(count2,8, filecount)+ 1/(AOD(k,l,8)^2);
                                    else
                                        if AOD(k,l,1)~=0
                                            countvec(count2,1) = countvec(count2,1)+1;
                                            for m = 1:7
                                                aod_day(count2, m, filecount) = aod_day(count2, m, filecount)+ AOD(k,l,8);
                                            end
                                            aod_day(count2, 8, filecount) = aod_day(count2, 8, filecount) + 1;
                                        end
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
%keeps track of which file is being processed
save('aodjan06.mat', 'aod_day')%saving filewise aod values
aod_ave = zeros(d,10);
aod_ave(:,1:2) = grid;
for i = 1:d %monthly mean, additions
    for j = 1:8
        for k = 1:n
            aod_ave(i,j+2) = aod_ave(i,j+2) + aod_day(i,j,k);
        end
    end
end
for i = 1:d %dividing by common denominator, sum of 1/variance^2
    if aod_ave(i,10) ~= 0
        for t = 3:9
            aod_ave(i,t) = aod_ave(i,t)/aod_ave(i,10);
        end
        aod_ave(i,10) = sqrt(1/aod_ave(i,10)); %thus here we have standard deviations, not variances
    else
        if aod_ave(i,10)==0 &&aod_ave(i,3) ~= 0
             for t = 3:9
                aod_ave(i,t) = aod_ave(i,t)/countvec(i,1);
            end
             aod_ave(i,10) = sqrt(1/aod_ave(i,10));
        end
    end
end
save('aod_mmean_jan06.mat', 'aod_ave')