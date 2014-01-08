function [Corr_Matrix, Variable_Matrix, Stability] = variables_load(year)

%path_to_dir = strcat('/home/prashant/Desktop/nc_data/ECHAM-HAM/',year,'/0609');
path_to_dir = strcat('/home/prashant/syno/Prashant_Data/',year);

%loading of required variables%
%load (strcat(path_to_dir,'/01/csv_files/aprl.csv'));    % Stratiform precipitation (kg/m2s)
%load (strcat(path_to_dir,'/01/csv_files/aprc.csv'));    % Convective precipitation (kg/m2s)
%load (strcat(path_to_dir,'/01/csv_files/st.csv'));      % Temperature (K)
%load (strcat(path_to_dir,'/01/csv_files/srad0u.csv'));  % Top solar radiation upward (W/m2)
%load (strcat(path_to_dir,'/01/csv_files/srad0.csv'));   % Net top solar radiation (W/m2)
%load (strcat(path_to_dir,'/01/csv_files/sraf0.csv'));   % Net top solar radiation (clear sky) (W/m2)
%load (strcat(path_to_dir,'/01/csv_files/xlvi.csv'));      % Cloud water (kg/kg)
%load (strcat(path_to_dir,'/01/csv_files/evap.csv'));    % Evaporation (kg/m2s)
%load (strcat(path_to_dir,'/activ/csv_files/CDNC.csv')); % CDNC concentration (1/m3) 
%load (strcat(path_to_dir,'/activ/csv_files/NA.csv'));   % Aerosol no for activation (1/m3)
%load (strcat(path_to_dir,'/forcing/csv_files/FSW_TOTAL_SUR.csv')); % Total Aerosol forcing SW total sky (W/m2)
%load (strcat(path_to_dir,'/forcing/csv_files/FSW_CLEAR_SUR.csv')); % Total Aerosol forcing SW total sky (W/m2)
%load (strcat(path_to_dir,'/radm/csv_files/TAU_2D.csv')); % Total Optical Thickness (1)
%
%load (strcat(path_to_dir,'/activ/csv_files/CLIWC_TIME.csv')); % Total Aerosol forcing SW total sky (W/m2)
%load (strcat(path_to_dir,'/activ/csv_files/BURDEN_TIME.csv')); % Total Aerosol forcing SW total sky (W/m2)
%load (strcat(path_to_dir,'/01/csv_files/aclcac.csv')); % Total Aerosol forcing SW total sky (W/m2)
%load (strcat(path_to_dir,'/activ/csv_files/LWC_ACC.csv')); % Total Aerosol forcing SW total sky (W/m2)
%load (strcat(path_to_dir,'/activ/csv_files/CLIWC_TIME.csv')); % Total Aerosol forcing SW total sky (W/m2)
%load (strcat(path_to_dir,'/activ/csv_files/CLOUD_TIME.csv')); % Total Aerosol forcing SW total sky (W/m2)
%load (strcat(path_to_dir,'/01/csv_files/tsurf.csv')); % surface Temperature K
%%load('~/Desktop/nc_data/ECHAM-HAM/2001/0609/01/csv_files/aclcac.csv')
%%load('~/Desktop/nc_data/ECHAM-HAM/2001/0609/activ/csv_files/BURDEN_TIME.csv')
%%load('~/Desktop/nc_data/ECHAM-HAM/2001/0609/activ/csv_files/CLIWC_TIME.csv')
%CLIWC_TIME_mean = mean(CLIWC_TIME(5:end,:));
%%Calculation required variables%
%Stability = (st(22,:)*(1009/725)^0.286 - st(31,:));
%CDNC_mean = (mean(CDNC(12:23,:))); %10km to 5km
%Dimming_direct = -1*FSW_CLEAR_SUR;
%Dimming_indirect = -1*FSW_TOTAL_SUR;
%%Dimming_indirect = FSW_TOTAL_SUR-FSW_CLEAR_SUR;
%
%Precp = aprc + aprl;
%%Cloud_water = mean(xlvi(6:end,:));
%Cloud_water_vert_int = xlvi;
%Evap = evap;
%rsut = srad0u; 
%rsutcs = sraf0 + srad0 + srad0u;
%rsdt = srad0 + srad0u;
%Cloud_albedo = (rsut-rsutcs)./rsdt;
%
%CLIWC_TIME_mean = mean(CLIWC_TIME(6:16,:));
%CLOUD_TIME_mean = mean(CLOUD_TIME(6:16,:));
%LWC_ACC_mean = mean(LWC_ACC(6:end,:));
%%cloud_cover = mean(aclcac(6:16,:));
%
%
%%Calculation of correlation Matrix%
%%Variable_Matrix = [TAU_2D', CDNC_mean', Cloud_albedo', Dimming', Stability', Evap', Cloud_water', Precp'];
%%Variable_Matrix = [TAU_2D', CDNC_mean', Dimming', Stability', Evap', Cloud_water', Precp'];
%%Variable_Matrix = [TAU_2D', CDNC_mean', Dimming', Stability',Evap', Cloud_water_vert_int', Precp', Cloud_albedo' ];
%%Variable_Matrix = [TAU_2D', CDNC_mean',Cloud_albedo', Dimming_indirect', Dimming_direct', Stability',Evap', aprc',aprl', Cloud_water_vert_int'];
%%Variable_Matrix = [TAU_2D', CDNC_mean',Cloud_albedo', Dimming_indirect', Dimming_direct', Stability',Evap', aprc',aprl', BURDEN_TIME'];
%Variable_Matrix = [TAU_2D', CDNC_mean',Cloud_albedo', Dimming_indirect', Stability',Evap', aprc',aprl', BURDEN_TIME',tsurf'];
%
%%a = find(Variable_Matrix(:,5)>=10^33);
%%Variable_Matrix(a,5) = NaN;
%Corr_Matrix = corrcoef(Variable_Matrix);
%for i=1:10
%    VM_std(:,i)=Variable_Matrix(:,i)/norm(Variable_Matrix(:,i));
%     VM_std(:,i) = (Variable_Matrix(:,i)-mean(Variable_Matrix(:,i)))/std(Variable_Matrix(:,i));
%end
%%Corr_Matrix = cov(VM_std);
%%Variable_Matrix = VM_std;
%%file_path_VarMat = strcat(path_to_dir,'/DataMatrix.txt')
%%file_path_CorrMat = strcat(path_to_dir,'/CorrelationMatrix.txt')
%%save(file_path_VarMat,'Variable_Matrix','-ASCII')
%%save(file_path_CorrMat,'Corr_Matrix','-ASCII')

u_MAM=load('home/prashant/syno/Prashant_Data/2001/01/csv_files_lat_Increased/dv2uv/0305/u.csv');
v_MAM=load('home/prashant/syno/Prashant_Data/2001/01/csv_files_lat_Increased/dv2uv/0305/v.csv');

u_JJAS=load('home/prashant/syno/Prashant_Data/2001/01/csv_files_lat_Increased/dv2uv/0609/u.csv');
v_JJAS=load('home/prashant/syno/Prashant_Data/2001/01/csv_files_lat_Increased/dv2uv/0609/v.csv');

save('/home/prashant/Desktop/nc_data/ECHAM-HAM/2001/0609/DataMatrix.txt','Variable_Matrix','-ASCII')
save('/home/prashant/Desktop/nc_data/ECHAM-HAM/2001/0609/Correlation_Matrix.txt','Corr_Matrix','-ASCII')
