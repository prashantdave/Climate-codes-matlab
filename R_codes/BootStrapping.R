library(sem)
#Data.bd <- as.matrix(read.table("~/Desktop/nc_data/ECHAM-HAM/2001/0609/DataMatrix.txt"),header = FALSE)
#Correlation_Matrix = cor(Data.bd,use="complete.obs")

#for (i in 1:9)
#{
#    write(as.vector(Correlation_Matrix[i,])[1:i],file="/home/prashant/Desktop/nc_data/ECHAM-HAM/2001/0609/CorrelationMatrix.txt",append=TRUE)
#}

#R.bd <- readMoments(file="/home/prashant/Desktop/nc_data/ECHAM-HAM/2001/0609/Correlation_Matrix.txt",names=c("Aerosol","CDNC","Cloud_albedo","Dimming_indirect","Stability","Evap","aprc","aprl","Burden_Time", "tsurf"))


#R.bd <- readMoments(file="/home/prashant/Desktop/Echam-Ham_backup/csv_files/2002/Corr_Matrix_Indirect.txt",names=c("AOD_JJAS","BC_AOD_JJAS","SH_int","W_int","ICNC_BURDEN","Latent_heat","CD_IC_NC","CDER_mean", "Sur_Indirect_JJAS","LTS","aprc","aprl"))
#Model.bd <- specifyModel(file="/home/prashant/Desktop/nc_data/ECHAM-HAM/Aerosol_Clouds_Atmospheric_Dynamics.txt")
#sem.bd <- sem(Model.bd, R.bd, N=667, fixed.x=c("AOD_JJAS","BC_AOD_JJAS"),objective=objectiveML)

#R.bd <- readMoments(file="/home/prashant/Desktop/Echam-Ham_backup/csv_modified/extended_model/2007/Corr_Matrix_Direct.txt",names=c("AOD_JJAS","Sur_Direct_JJAS","LTS","SH_int","W_int","AOD_MAM","Sur_Direct_MAM","TOA_Direct_MAM","uv850","Evap_rate","precp"))
#R.bd <- readMoments(file="/home/prashant/Desktop/nc_data/OBS-data/coefficient_matrix/2003/Corr_Matrix_Direct.txt",names=c("AOD_JJAS","Sur_Direct_JJAS","LTS","SH_int","W_int","AOD_MAM","Sur_Direct_MAM","TOA_Direct_MAM","uv850","Evap_rate","precp"))

#==========================================================================================================================================================================
#Modified Model data Analysis (Direct Effect)
#1. Without LTS
#R.bd <- readMoments(file="/home/prashant/Desktop/Echam-Ham_backup/csv_modified2/13-12-2013/without_LTS/2007/Corr_Matrix_Direct.txt",names=c("AOD_JJAS","Sur_Direct_JJAS","SH_int","W_int","AOD_MAM","Sur_Direct_MAM","TOA_Direct_MAM","uv850","Evap_rate","precp"))
#Model.bd <- specifyModel(file="/home/prashant/Desktop/Echam-Ham_backup/csv_modified2/13-12-2013/without_LTS/Aerosol_Radiation_Atmospheric_Dynamics.txt")
#sem.bd <- sem(Model.bd, R.bd, N=667, fixed.x=c("AOD_JJAS","AOD_MAM"),objective=objectiveML)

#2. Without LTS and W
#R.bd <- readMoments(file="/home/prashant/Desktop/Echam-Ham_backup/csv_modified2/13-12-2013/without_W_LTS/2007/Corr_Matrix_Direct.txt",names=c("AOD_JJAS","Sur_Direct_JJAS","SH_int","AOD_MAM","Sur_Direct_MAM","TOA_Direct_MAM","uv850","Evap_rate","precp"))
#Model.bd <- specifyModel(file="/home/prashant/Desktop/Echam-Ham_backup/csv_modified2/13-12-2013/without_W_LTS/Aerosol_Radiation_Atmospheric_Dynamics.txt")
#sem.bd <- sem(Model.bd, R.bd, N=667, fixed.x=c("AOD_JJAS","AOD_MAM"),objective=objectiveML)

#3.Without W
#R.bd <- readMoments(file="/home/prashant/Desktop/Echam-Ham_backup/csv_modified2/13-12-2013/without_W/2007/Corr_Matrix_Direct.txt",names=c("AOD_JJAS","Sur_Direct_JJAS","LTS","SH_int","AOD_MAM","Sur_Direct_MAM","TOA_Direct_MAM","uv850","Evap_rate","precp"))
#Model.bd <- specifyModel(file="/home/prashant/Desktop/Echam-Ham_backup/csv_modified2/13-12-2013/without_W/Aerosol_Radiation_Atmospheric_Dynamics.txt")
#sem.bd <- sem(Model.bd, R.bd, N=667, fixed.x=c("AOD_JJAS","AOD_MAM"),objective=objectiveML)

#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
#Modified Model data Analysis (Indirect Effect)#
# 1. All Data
#R.bd <- readMoments(file="/home/prashant/Desktop/Echam-Ham_backup/csv_modified2/13-12-2013/Indirect_Effects/All/2002/Corr_Matrix_Indirect.txt",names=c("AOD_JJAS","SH_int","W_int","ICNC_BURDEN","Latent_heat","CD_IC_NC","CDER_mean", "Sur_Indirect_JJAS","LTS","aprc","aprl"))
#Model.bd <- specifyModel(file="/home/prashant/Desktop/Echam-Ham_backup/csv_modified2/13-12-2013/Indirect_Effects/All/Aerosol_Clouds_Atmospheric_Dynamics.txt")
#sem.bd <- sem(Model.bd, R.bd, N=667, fixed.x=c("AOD_JJAS"),objective=objectiveML)

# 2. Without CDNC
#R.bd <- readMoments(file="/home/prashant/Desktop/Echam-Ham_backup/csv_modified2/13-12-2013/Indirect_Effects/without_CDNC/2007/Corr_Matrix_Indirect.txt",names=c("AOD_JJAS","SH_int","W_int","ICNC_BURDEN","Latent_heat","CDER_mean", "Sur_Indirect_JJAS","LTS","aprc","aprl"))
#Model.bd <- specifyModel(file="/home/prashant/Desktop/Echam-Ham_backup/csv_modified2/13-12-2013/Indirect_Effects/without_CDNC/Aerosol_Clouds_Atmospheric_Dynamics.txt")
#sem.bd <- sem(Model.bd, R.bd, N=667, fixed.x=c("AOD_JJAS"),objective=objectiveML)

#3. Without W
#R.bd <- readMoments(file="/home/prashant/Desktop/Echam-Ham_backup/csv_modified2/13-12-2013/Indirect_Effects/without_W/2007/Corr_Matrix_Indirect.txt",names=c("AOD_JJAS","SH_int","ICNC_BURDEN","Latent_heat","CD_IC_NC","CDER_mean", "Sur_Indirect_JJAS","LTS","aprc","aprl"))
#Model.bd <- specifyModel(file="/home/prashant/Desktop/Echam-Ham_backup/csv_modified2/13-12-2013/Indirect_Effects/without_W/Aerosol_Clouds_Atmospheric_Dynamics.txt")
#sem.bd <- sem(Model.bd, R.bd, N=667, fixed.x=c("AOD_JJAS"),objective=objectiveML)

#4.Without W and CDNC
#R.bd <- readMoments(file="/home/prashant/Desktop/Echam-Ham_backup/csv_modified2/13-12-2013/Indirect_Effects/without_W_CDNC/2007/Corr_Matrix_Indirect.txt",names=c("AOD_JJAS","SH_int","ICNC_BURDEN","Latent_heat","CDER_mean", "Sur_Indirect_JJAS","LTS","aprc","aprl"))
#Model.bd <- specifyModel(file="/home/prashant/Desktop/Echam-Ham_backup/csv_modified2/13-12-2013/Indirect_Effects/without_W_CDNC/Aerosol_Clouds_Atmospheric_Dynamics.txt")
#sem.bd <- sem(Model.bd, R.bd, N=667, fixed.x=c("AOD_JJAS"),objective=objectiveML)

#5.Without CDNC and CDER
#R.bd <- readMoments(file="/home/prashant/Desktop/Echam-Ham_backup/csv_modified2/13-12-2013/Indirect_Effects/without_CDNC_CDER/2007/Corr_Matrix_Indirect.txt",names=c("AOD_JJAS","SH_int","W_int","ICNC_BURDEN","Latent_heat", "Sur_Indirect_JJAS","LTS","aprc","aprl"))
#Model.bd <- specifyModel(file="/home/prashant/Desktop/Echam-Ham_backup/csv_modified2/13-12-2013/Indirect_Effects/without_CDNC_CDER/Aerosol_Clouds_Atmospheric_Dynamics.txt")
#sem.bd <- sem(Model.bd, R.bd, N=667, fixed.x=c("AOD_JJAS"),objective=objectiveML)


#=========================================================================================================================================================================

#=========================================================================================================================================================================
# Modified Model 06-01-2014
#1. All
#R.bd <- readMoments(file="/home/prashant/Desktop/Echam-Ham_backup/csv_modified2/06-01-2014/Direct_Effects/All/2007/Corr_Matrix_Direct.txt",names=c("AOD_JJAS","Sur_Indirect_JJAS","Sur_Direct_JJAS","LTS","SH_int","W_int","AOD_MAM","Sur_Direct_MAM","TOA_Direct_MAM","uv850","Evap_rate","precp"))
#Model.bd <- specifyModel(file="/home/prashant/Desktop/Echam-Ham_backup/csv_modified2/06-01-2014/Direct_Effects/All/Aerosol_Radiation_Atmospheric_Dynamics.txt")
#sem.bd <- sem(Model.bd, R.bd, N=667, fixed.x=c("AOD_JJAS","AOD_MAM"),objective=objectiveML)

#2. Without_W
#R.bd <- readMoments(file="/home/prashant/Desktop/Echam-Ham_backup/csv_modified2/06-01-2014/Direct_Effects/Without_W/2007/Corr_Matrix_Direct.txt",names=c("AOD_JJAS","Sur_Indirect_JJAS","Sur_Direct_JJAS","LTS","SH_int","AOD_MAM","Sur_Direct_MAM","TOA_Direct_MAM","uv850","Evap_rate","precp"))
#Model.bd <- specifyModel(file="/home/prashant/Desktop/Echam-Ham_backup/csv_modified2/06-01-2014/Direct_Effects/Without_W/Aerosol_Radiation_Atmospheric_Dynamics.txt")
#sem.bd <- sem(Model.bd, R.bd, N=667, fixed.x=c("AOD_JJAS","AOD_MAM"),objective=objectiveML)

#3. Without_LTS
R.bd <- readMoments(file="/home/prashant/Desktop/Echam-Ham_backup/csv_modified2/06-01-2014/Direct_Effects/Without_LTS/2007/Corr_Matrix_Direct.txt",names=c("AOD_JJAS","Sur_Indirect_JJAS","Sur_Direct_JJAS","SH_int","W_int","AOD_MAM","Sur_Direct_MAM","TOA_Direct_MAM","uv850","Evap_rate","precp"))
Model.bd <- specifyModel(file="/home/prashant/Desktop/Echam-Ham_backup/csv_modified2/06-01-2014/Direct_Effects/Without_LTS/Aerosol_Radiation_Atmospheric_Dynamics.txt")
sem.bd <- sem(Model.bd, R.bd, N=667, fixed.x=c("AOD_JJAS","AOD_MAM"),objective=objectiveML)


#=========================================================================================================================================================================
#R.bd <- readMoments(file="/home/prashant/Desktop/Echam-Ham_backup/csv_modified/2002/Corr_Matrix_Indirect.txt",names=c("AOD_JJAS","SH_int","W_int","ICNC_BURDEN","Latent_heat","CD_IC_NC","CDER_mean", "Sur_Indirect_JJAS","LTS","aprc","aprl"))
#Model.bd <- specifyModel(file="/home/prashant/Desktop/Echam-Ham_backup/csv_modified/Aerosol_Clouds_Atmospheric_Dynamics.txt")
#sem.bd <- sem(Model.bd, R.bd, N=667, fixed.x=c("AOD_JJAS"),objective=objectiveML)

#R.bd <- readMoments(file="/home/prashant/Desktop/Echam-Ham_backup/csv_modified/combined_model/2002/Corr_Matrix_Direct.txt",names=c("AOD_JJAS", "Sur_Direct_JJAS", "LTS", "SH_int", "W_int", "AOD_MAM", "Sur_Direct_MAM","TOA_Direct_MAM", "uv850", "Evap_rate", "ICNC_BURDEN", "Latent_heat", "CD_IC_NC", "CDER_mean", "Sur_Indirect_JJAS", "aprc", "aprl"))
#Model.bd <- specifyModel(file="/home/prashant/Desktop/Echam-Ham_backup/csv_modified/combined_model/Aerosol_Radiation_Clouds_combined.txt")
#sem.bd <- sem(Model.bd, R.bd, N=667, fixed.x=c("AOD_JJAS","AOD_MAM"),objective=objectiveML)



#Boot Strapping on the Data
#Data.boot <- bootSem(sem.bd, Cov=cor, R=1000, data=Data.bd, max.failures=10)
