library(sem)

#R.bd <- readMoments(file="Matrix2.txt",names=c("x1","x2","y3","y4","y5"))
#model.bd <- specifyModel(file="Model2.txt")
#R.bd <- readMoments(file="Matrix_7_2000.txt",names=c("Aerosol","Stability","Dimming","CDNC","Precp"))
#model.bd <- specifyModel(file="Model1.txt")
#R.bd <- readMoments(file="Matrix_7_2000.txt",names=c("Aerosol","CDNC","Dimming","Stability","Evap","Cloud_water","precp"))

R.bd <- readMoments(file="/home/prashant/Desktop/nc_data/ECHAM-HAM/2005/0609/CorrelationMatrix.txt",names=c("Aerosol","CDNC","Dimming","Stability","Evap","Cloud_water","precp","Cloud_albedo"))
model.bd <- specifyModel(file="/home/prashant/Desktop/Model_7.txt")
sem.bd <- sem(model.bd, R.bd, N=20700, fixed.x=c("Aerosol"))
summary(sem.bd)
effects(sem.bd)
