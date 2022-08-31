  setwd("/home/scyther/Documents/clustergi/Hierarchical")
  distm<-c("euclidean", "maximum", "manhattan")
  real<-rep(1:6,each=100)
  hclustm<-c("ward.D", "ward.D2", "single", "complete","average","mcquitty","median","centroid")
  #system(paste0("mkdir -p ","\"",str_to_title(paste("Hierarchical Clustering",hclustm[1],"Linkage using",distm[1],"distance")),"\""))
  library(doParallel)
  cl <- makeCluster(6,type="FORK")
  registerDoParallel(cl)#not to overload your computer
  foreach(i=distm,.combine='rbind') %dopar%
  { 
    foreach (j=hclustm,.combine = 'rbind')%do%
    {
      library(clevr)
      library(aricode)
      library(ggplot2)
      library(dplyr)
      system(paste0("mkdir -p ","\"",str_to_title(paste("Hierarchical Clustering",j,"Linkage using",i,"distance")),"\""))
      setwd(paste0("./",str_to_title(paste("Hierarchical Clustering",j,"Linkage using",i,"distance"))))
      clusters <- hclust(dist(synthetic_control,method = i), method = j)
      clusterCut <- cutree(clusters, 6)
      ari<-ARI(as.factor(clusterCut),as.factor(real))
      vi<-variation_info(as.factor(clusterCut),as.factor(real))
      m<-t(as.matrix(c(round(ari,3),round(vi,3))))
      colnames(m)<-c("ARI","VI")
      sink(str_to_title(paste("Hierarchical Clustering",j,"Linkage using",i,"distance",".txt")))
      prmatrix(m,rowlab = rep_len("", ncol(m)))
      sink()
      df1<-mutate(synthetic_control,clusterCut)
      ggplot(df1,aes(x=clusterCut))+geom_bar()+labs(x="Predicted Cluster",title=str_to_title(paste("Hierarchical Clustering",j,"Linkage using",i,"distance")))+theme(axis.text.x = element_text(color = "grey20", size = 14, angle = 90, hjust = .5, vjust = .5, face = "plain"),
                                                                                                                                                                     axis.text.y = element_text(color = "grey20", size = 14, angle = 0, hjust = 1, vjust = 0, face = "plain"),  
                                                                                                                                                                     axis.title.x = element_text(color = "grey20", size = 14, angle = 0, hjust = .5, vjust = 0, face = "plain"),
                                                                                                                                                                     axis.title.y = element_text(color = "grey20", size = 14, angle = 90, hjust = .5, vjust = .5, face = "plain"))
      
      
      ggsave( paste0 ( str_to_title(paste("Hierarchical Clustering",j,"Linkage using",i,"distance")),".png") , width =9,height=5.064,dpi=700 )
      setwd("..")
    }
  }