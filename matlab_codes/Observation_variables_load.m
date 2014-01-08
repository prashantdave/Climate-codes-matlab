clear all;
clc;
year='2007'

%path_to_dir_0609 = strcat('/home/prashant/Desktop/Echam-Ham_backup/csv_modified/',year,'/0609/');
%path_to_dir_0305 = strcat('/home/prashant/Desktop/Echam-Ham_backup/csv_modified//',year,'/0305/');

aprc = load('/home/prashant/Desktop/nc_data/OBS-data/NCEP_data/Convective_Precipitation/csv_files/ConvectivePrecp_JJAS_2007.csv');
precp = load('/home/prashant/Desktop/nc_data/OBS-data/NCEP_data/Precipitation/csv_files/PrecpRate_JJAS_2007.csv');

Evap_rate = load('/home/prashant/Desktop/nc_data/OBS-data/NCEP_data/Evaporation/csv_files/PotentialEvap_JJAS_2007.csv');
u = load('/home/prashant/Desktop/nc_data/OBS-data/NCEP_data/UV_Wind/csv_files/Uwind_JJAS_2007.csv');
v = load('/home/prashant/Desktop/nc_data/OBS-data/NCEP_data/UV_Wind/csv_files/Vwind_JJAS_2007.csv');
SH = load('/home/prashant/Desktop/nc_data/OBS-data/NCEP_data/Specific_Humidity/csv_files/SpHumidity_JJAS_2007.csv');
Stability = load('/home/prashant/Desktop/nc_data/OBS-data/NCEP_data/Air_Temperature/csv_files/Temperature_JJAS_2007.csv');
W = load('/home/prashant/Desktop/nc_data/OBS-data/NCEP_data/Omega/csv_files/Omega_JJAS_2007.csv');
%Latent_heat = load(strcat(path_to_dir_0609,'ahfl.txt'));

%CDNC = load(strcat(path_to_dir_0609,'CDNC.txt'));
%ICNC = load(strcat(path_to_dir_0609,'ICNC.txt'));
%ICNC_BURDEN = load(strcat(path_to_dir_0609,'ICNC_BURDEN.txt'));
%CDER = load(strcat(path_to_dir_0609,'REFFL.txt'));

%Forcing variables
Sur_Direct_MAM = load('/home/prashant/Desktop/nc_data/OBS-data/Ceres/Surface/csv_files/Sur_Direct_MAM_2007.csv');
Sur_Direct_JJAS = load('/home/prashant/Desktop/nc_data/OBS-data/Ceres/Surface/csv_files/Sur_Direct_JJAS_2007.csv');
TOA_Direct_MAM = load('/home/prashant/Desktop/nc_data/OBS-data/Ceres/TOA/csv_files/TOA_Direct_MAM_2007.csv');

%Sur_Indirect_JJAS = load(strcat(path_to_dir_0609,'FSW_TOTAL_SUR.txt'));

%Aerosol concentrations
AOD_MAM = load('/home/prashant/Desktop/nc_data/OBS-data/MODIS/2007/csv_files/AOD_MAM_2007.csv');
AOD_JJAS = load('/home/prashant/Desktop/nc_data/OBS-data/MODIS/2007/csv_files/AOD_JJAS_2007.csv');
%BC_AOD_JJAS = load(strcat(path_to_dir_0609,'TAU_COMP_BC.csv'));

u850=u(1,:);
v850=v(1,:);
uv850 = u850 + v850;
W_int = trapz(W);
SH_int = trapz(SH);

%CDNC_mean = sum(CDNC,1);
%ICNC_mean = sum(ICNC,1);
%CDER_mean = mean(CDER,1);
%CD_IC_NC = CDNC_mean;

LTS = Stability(4,:)*(1000/700)^0.286 - Stability(1,:);
%precp = aprc+aprl;

%Data_Matrix_Direct =[AOD_JJAS', -1*Sur_Direct_JJAS', -1*Sur_Indirect_JJAS', LTS', SH_int', W_int', AOD_MAM', -1*Sur_Direct_MAM',-1*TOA_Direct_MAM', uv850', Evap_rate', precp']; 
%Data_Matrix_Indirect = [AOD_JJAS', BC_AOD_JJAS', SH_int', W_int', ICNC_BURDEN', -1*Latent_heat', CD_IC_NC', CDER_mean', -1*Sur_Indirect_JJAS',LTS', aprc', aprl'];

%Corr_Matrix_Direct = corrcoef(Data_Matrix_Direct);
%Corr_Matrix_Indirect = corrcoef(Data_Matrix_Indirect);

Data_Matrix_Direct =[AOD_JJAS', Sur_Direct_JJAS',  LTS', SH_int', W_int', AOD_MAM', Sur_Direct_MAM',TOA_Direct_MAM', uv850', Evap_rate', precp']; 
%Data_Matrix_Indirect = [AOD_JJAS', SH_int', W_int', ICNC_BURDEN', -1*Latent_heat', CD_IC_NC', CDER_mean', -1*Sur_Indirect_JJAS',LTS', aprc', aprl'];

Corr_Matrix_Direct = corrcoef(Data_Matrix_Direct)
%Corr_Matrix_Indirect = corrcoef(Data_Matrix_Indirect);

%Data_Matrix_Direct =[AOD_JJAS', -1*Sur_Direct_JJAS',  LTS', SH_int', W_int', AOD_MAM', -1*Sur_Direct_MAM',-1*TOA_Direct_MAM', uv850', Evap_rate', ICNC_BURDEN', -1*Latent_heat', CD_IC_NC', CDER_mean', -1*Sur_Indirect_JJAS', aprc', aprl']; 

%Corr_Matrix_Direct = corrcoef(Data_Matrix_Direct);

save('/home/prashant/Desktop/nc_data/OBS-data/coefficient_matrix/2007/Corr_Matrix_Direct.txt','Corr_Matrix_Direct','-ASCII')
save('/home/prashant/Desktop/nc_data/OBS-data/coefficient_matrix/2007/Data_Matrix_Direct.txt','Data_Matrix_Direct','-ASCII')

%save(strcat('/home/prashant/Desktop/Echam-Ham_backup/csv_modified/',year,'/','Corr_Matrix_Indirect.txt'),'Corr_Matrix_Indirect','-ASCII')
%save(strcat('/home/prashant/Desktop/Echam-Ham_backup/csv_modified/',year,'/','Data_Matrix_Indirect.txt'),'Data_Matrix_Indirect','-ASCII')
