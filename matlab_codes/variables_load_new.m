clear all;
clc;
year='2007'

path_to_dir_0609 = strcat('/home/prashant/Desktop/Echam-Ham_backup/csv_modified/',year,'/0609/');
path_to_dir_0305 = strcat('/home/prashant/Desktop/Echam-Ham_backup/csv_modified//',year,'/0305/');

aprc = load(strcat(path_to_dir_0609,'aprc.csv'));
aprl = load(strcat(path_to_dir_0609,'aprl.csv'));
Evap_rate = load(strcat(path_to_dir_0609,'evap.txt'));
u = load(strcat(path_to_dir_0609,'u.txt'));
v = load(strcat(path_to_dir_0609,'v.txt'));
SH = load(strcat(path_to_dir_0609,'q.txt'));
Stability = load(strcat(path_to_dir_0609,'st.txt'));
Latent_heat = load(strcat(path_to_dir_0609,'ahfl.txt'));

CDNC = load(strcat(path_to_dir_0609,'CDNC.txt'));
ICNC = load(strcat(path_to_dir_0609,'ICNC.txt'));
ICNC_BURDEN = load(strcat(path_to_dir_0609,'ICNC_BURDEN.txt'));
CDER = load(strcat(path_to_dir_0609,'REFFL.txt'));
W = load(strcat(path_to_dir_0609,'W_LARGE.txt'));


Sur_Direct_MAM = load(strcat(path_to_dir_0305,'FSW_CLEAR_SUR.txt'));
Sur_Direct_JJAS = load(strcat(path_to_dir_0609,'FSW_CLEAR_SUR.txt'));
Sur_Indirect_JJAS = load(strcat(path_to_dir_0609,'FSW_TOTAL_SUR.txt'));
TOA_Direct_MAM = load(strcat(path_to_dir_0305,'FSW_CLEAR_TOP.txt'));

AOD_MAM = load(strcat(path_to_dir_0305,'TAU_2D.txt'));
AOD_JJAS = load(strcat(path_to_dir_0609,'TAU_2D.txt'));
BC_AOD_JJAS = load(strcat(path_to_dir_0609,'TAU_COMP_BC.csv'));

u850=u(1,:);
v850=v(1,:);
uv850 = u850 + v850;
W_int = trapz(W);
SH_int = trapz(SH);

CDNC_mean = sum(CDNC,1);
ICNC_mean = sum(ICNC,1);
CDER_mean = mean(CDER,1);
CD_IC_NC = CDNC_mean;

LTS = Stability(2,:)*(1009/725)^0.286 - Stability(1,:);
precp = aprc+aprl;

%Data_Matrix_Direct =[AOD_JJAS', -1*Sur_Direct_JJAS', -1*Sur_Indirect_JJAS', LTS', SH_int', W_int', AOD_MAM', -1*Sur_Direct_MAM',-1*TOA_Direct_MAM', uv850', Evap_rate', precp']; 
%Data_Matrix_Indirect = [AOD_JJAS', BC_AOD_JJAS', SH_int', W_int', ICNC_BURDEN', -1*Latent_heat', CD_IC_NC', CDER_mean', -1*Sur_Indirect_JJAS',LTS', aprc', aprl'];

%Corr_Matrix_Direct = corrcoef(Data_Matrix_Direct);
%Corr_Matrix_Indirect = corrcoef(Data_Matrix_Indirect);

%Data_Matrix_Direct =[AOD_JJAS', -1*Sur_Direct_JJAS',  LTS', SH_int', W_int', AOD_MAM', -1*Sur_Direct_MAM',-1*TOA_Direct_MAM', uv850', Evap_rate', precp']; 
%Data_Matrix_Indirect = [AOD_JJAS', SH_int', W_int', ICNC_BURDEN', -1*Latent_heat', CD_IC_NC', CDER_mean', -1*Sur_Indirect_JJAS',LTS', aprc', aprl'];
%Data_Matrix_Direct =[AOD_JJAS', -1*Sur_Direct_JJAS', SH_int', W_int', AOD_MAM', -1*Sur_Direct_MAM',-1*TOA_Direct_MAM', uv850', Evap_rate', precp']; 
%Data_Matrix_Direct =[AOD_JJAS', -1*Sur_Direct_JJAS', SH_int', AOD_MAM', -1*Sur_Direct_MAM',-1*TOA_Direct_MAM', uv850', Evap_rate', precp']; 
%Data_Matrix_Direct =[AOD_JJAS', -1*Sur_Direct_JJAS',  LTS', SH_int', AOD_MAM', -1*Sur_Direct_MAM',-1*TOA_Direct_MAM', uv850', Evap_rate', precp']; 
%Data_Matrix_Indirect = [AOD_JJAS', SH_int', W_int', ICNC_BURDEN', -1*Latent_heat', CD_IC_NC', CDER_mean', -1*Sur_Indirect_JJAS',LTS', aprc', aprl'];
%Data_Matrix_Indirect = [AOD_JJAS', SH_int', W_int', ICNC_BURDEN', -1*Latent_heat', CDER_mean', -1*Sur_Indirect_JJAS',LTS', aprc', aprl'];
%Data_Matrix_Indirect = [AOD_JJAS', SH_int', ICNC_BURDEN', -1*Latent_heat', CD_IC_NC', CDER_mean', -1*Sur_Indirect_JJAS',LTS', aprc', aprl'];
%Data_Matrix_Indirect = [AOD_JJAS', SH_int', ICNC_BURDEN', -1*Latent_heat', CDER_mean', -1*Sur_Indirect_JJAS',LTS', aprc', aprl'];
Data_Matrix_Indirect = [AOD_JJAS', SH_int', W_int', ICNC_BURDEN', -1*Latent_heat', -1*Sur_Indirect_JJAS',LTS', aprc', aprl'];
%Corr_Matrix_Direct = corrcoef(Data_Matrix_Direct);
Corr_Matrix_Indirect = corrcoef(Data_Matrix_Indirect);
%Corr_Matrix_Direct = corrcoef(Data_Matrix_Direct);

%Modified Model for Aerosol-Radiation 06-01-2014
%All
%Data_Matrix_Direct =[AOD_JJAS', -1*Sur_Indirect_JJAS', -1*Sur_Direct_JJAS',  LTS', SH_int',W_int', AOD_MAM', -1*Sur_Direct_MAM',-1*TOA_Direct_MAM', uv850', Evap_rate', precp']; 
%Corr_Matrix_Direct = corrcoef(Data_Matrix_Direct);

%Without_W
%Data_Matrix_Direct =[AOD_JJAS', -1*Sur_Indirect_JJAS', -1*Sur_Direct_JJAS',  LTS', SH_int', AOD_MAM', -1*Sur_Direct_MAM',-1*TOA_Direct_MAM', uv850', Evap_rate', precp']; 
%Corr_Matrix_Direct = corrcoef(Data_Matrix_Direct);

%Without_LTS
Data_Matrix_Direct =[AOD_JJAS', -1*Sur_Indirect_JJAS', -1*Sur_Direct_JJAS', SH_int',W_int', AOD_MAM', -1*Sur_Direct_MAM',-1*TOA_Direct_MAM', uv850', Evap_rate', precp']; 
Corr_Matrix_Direct = corrcoef(Data_Matrix_Direct);


%Data_Matrix_Direct =[AOD_JJAS', -1*Sur_Direct_JJAS',  LTS', SH_int', W_int', AOD_MAM', -1*Sur_Direct_MAM',-1*TOA_Direct_MAM', uv850', Evap_rate', ICNC_BURDEN', -1*Latent_heat', CD_IC_NC', CDER_mean', -1*Sur_Indirect_JJAS', aprc', aprl']; 

%Corr_Matrix_Direct = corrcoef(Data_Matrix_Direct);

save(strcat('/home/prashant/Desktop/Echam-Ham_backup/csv_modified2/06-01-2014/Direct_Effects/Without_LTS/',year,'/','Corr_Matrix_Direct.txt'),'Corr_Matrix_Direct','-ASCII')
save(strcat('/home/prashant/Desktop/Echam-Ham_backup/csv_modified2/06-01-2014/Direct_Effects/Without_LTS/',year,'/','Data_Matrix_Direct.txt'),'Data_Matrix_Direct','-ASCII')

%save(strcat('/home/prashant/Desktop/Echam-Ham_backup/csv_modified2/13-12-2013/Indirect_Effects/without_CDNC_CDER/',year,'/','Corr_Matrix_Indirect.txt'),'Corr_Matrix_Indirect','-ASCII')
%save(strcat('/home/prashant/Desktop/Echam-Ham_backup/csv_modified2/13-12-2013/Indirect_Effects/without_CDNC_CDER/',year,'/','Data_Matrix_Indirect.txt'),'Data_Matrix_Indirect','-ASCII')
