clc
clear all
model_aod=xlsread('gradsECHAM.xlsx','Sheet2', 'C1:C912');
load('aod_mm_dec06.mat')
misr_aod = aod_ave_dec(:,3);
misr_unc = aod_ave_dec(:,9);
[misr_dec_assim pre_cov_dec post_cov_dec] = oifuncnonpartial(model_aod, misr_aod, misr_unc);
