library(readr)
synthetic_control <- read_table2("~/Downloads/Work/Thesis/synthetic_control.data", 
                                 col_names = FALSE)
x1<-synthetic_control[205,]
x1<-as.numeric(x1)
index=1:ncol(synthetic_control)
plot(x)

par("mar")
par(mar=c(2,2,2,2))
ggplot(data=NULL, aes(x=as.numeric(synthetic_control[206,]),y=index))+geom_point()+geom_line()
distm<-dist(synthetic_control)
heatmap(as.matrix(distm))
df<-as.data.frame( t(apply(synthetic_control, 1, scale)))


data("iris")
clusters <- hclust(dist(synthetic_control,method = "canberra"), method = 'complete')
plot(clusters)
clusters <- pam(k= 6, diss=TRUE,x=as.matrix(daisy(synthetic_control,metric= "gower")))
hist(clusters$clustering)
clusterCut <- cutree(clusters, 6)

index<-1:600
table(clusterCut,index)
df1<-mutate(synthetic_control,clusterCut)
ggplot(df1,aes(x=clusterCut))+geom_bar()+labs(x="Predicted Cluster",title = "Hierarchial Clustering Complete Linkage using Canberra Distance")
real<-rep(clustersnum, each=100)
sink("Hierarchial Clustering Complete Linkage using Manhattan Distance.txt")
confusionMatrix(as.factor(df1$clusterCut),as.factor(real))
sink()
hc2 <- agnes(synthetic_control, method = "complete")
hc2$ac
hc3 <- agnes(synthetic_control, method = "ward")
pltree(hc3, cex = 0.6, hang = -1, main = "Dendrogram of agnes") 
hc3c<-cutree(hc3,6)
table(hc3c)
