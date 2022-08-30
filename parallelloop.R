library(doParallel)
library(data.table)
cores=detectCores()
cl <- makeCluster(13,type="FORK") #not to overload your computer
registerDoParallel(cl)
dft<-data.table(df)
d1<-foreach(i=1:nrow(dft),.combine = 'rbind') %dopar%{
 foreach(j=1:nrow(dft),.combine = 'c') %do%
  {
    
    c(i=i,j=j,x=TSclust::diss.SPEC.GLK(as.numeric(dft[i,]) , as.numeric(dft[j,])))
  }
}
stopCluster(cl)
m2<-sparseMatrix(d1[,1],d1[,2],x=d1[,3])
as.matrix(m2)