function [Corr_Matrix] = variables_load(year)

path_to_dir = strcat('/home/prashant/Desktop/nc_data/ECHAM-HAM/',year,'/0609');


%loading of required variables%
load (strcat(path_to_dir,'/01/csv_with_height/aprl.csv'));    % Stratiform precipitation (kg/m2s)
load (strcat(path_to_dir,'/01/csv_with_height/aprc.csv'));    % Convective precipitation (kg/m2s)
load (strcat(path_to_dir,'/01/csv_with_height/st.csv'));      % Temperature (K)
load (strcat(path_to_dir,'/01/csv_with_height/srad0u.csv'));  % Top solar radiation upward (W/m2)
load (strcat(path_to_dir,'/01/csv_with_height/srad0.csv'));   % Net top solar radiation (W/m2)
load (strcat(path_to_dir,'/01/csv_with_height/sraf0.csv'));   % Net top solar radiation (clear sky) (W/m2)
load (strcat(path_to_dir,'/01/csv_with_height/xlvi.csv'));      % Cloud water (kg/kg)
load (strcat(path_to_dir,'/01/csv_with_height/evap.csv'));    % Evaporation (kg/m2s)
load (strcat(path_to_dir,'/activ/csv_with_height/CDNC.csv')); % CDNC concentration (1/m3) 
load (strcat(path_to_dir,'/activ/csv_with_height/NA.csv'));   % Aerosol no for activation (1/m3)
load (strcat(path_to_dir,'/forcing/csv_with_height/FSW_TOTAL_SUR.csv')); % Total Aerosol forcing SW total sky (W/m2)
load (strcat(path_to_dir,'/radm/csv_with_height/TAU_2D.csv')); % Total Optical Thickness (1)


%Calculation required variables%
Stability = st(10,:)*0.9 - st(end,:);
CDNC_mean = mean(CDNC(6:end,:));
Dimming = FSW_TOTAL_SUR;
Precp = aprc + aprl;
%Cloud_water = mean(xlvi(6:end,:));
Cloud_water_vert_int = xlvi;
Evap = evap;

rsut = srad0u; 
rsutcs = sraf0 + srad0 + srad0u;
rsdt = srad0 + srad0u;
Cloud_albedo = (rsut-rsutcs)./rsdt;


%Calculation of correlation Matrix%
%Variable_Matrix = [TAU_2D', CDNC_mean', Cloud_albedo', Dimming', Stability', Evap', Cloud_water', Precp'];
%Variable_Matrix = [TAU_2D', CDNC_mean', Dimming', Stability', Evap', Cloud_water', Precp'];
Variable_Matrix = [TAU_2D', CDNC_mean', Dimming', Stability',Evap', Cloud_water_vert_int', Precp', Cloud_albedo' ];
Corr_Matrix = corrcoef(Variable_Matrix);
file_path = strcat(path_to_dir,'/CorrelationMatrix.txt')
save(file_path,'Corr_Matrix','-ASCII')
