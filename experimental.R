k1<-kmeans(df,6)
k1$cluster
k1$centers

ari<-ARI(as.factor(k1$cluster),as.factor(real))

vi<-variation_info(as.factor(k1$cluster),as.factor(real))

m<-t(as.matrix(c(round(ari,3),round(vi,3))))
colnames(m)<-c("ARI","VI")
prmatrix(m,rowlab = rep_len("", ncol(m)))
ggplot(NULL,aes(x=k1$cluster))+geom_bar()+labs(x="Predicted Cluster",title = "K Means")
print(real)

mm<-cuml_kmeans(df,6,300)
print(mm)
