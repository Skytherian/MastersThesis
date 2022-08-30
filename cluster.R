data("iris")
iris1<-iris[,1:4]
C<-chol(var(iris1))
y<-as.matrix(iris1) %*% solve(C)
iris2<-as.matrix(iris1)
k1<-kmeans(y,3)
#rownames(iris1)<-iris$Species
library(factoextra)
fviz_cluster(k1,data=iris1,geom = c("point")) + scale_fill_discrete(label=unique(iris$Species))
