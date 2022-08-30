library(doParallel)
partitionhash<-hash("mean"="Mean",
                    "median"="Median",
                    "shape"="Shape Averaging",
                    "dba"="DTW Barycenter Averaging",
                    "sdtw_cent"= "Soft-DTW centroids",
                    "pam"="Partition around medoids")
setwd("/home/scyther/Documents/clustergi/ts/hierarchical/")
cl <- makeCluster(6)
registerDoParallel(cl)
foreach ( i= names(partitionhash), .combine = 'c' ) %dopar%
{ 
  library(hash)
  library(dtwclust)
  library(tidytable)
  library(doParallel)
  library(stringr)
  library(data.table)
  library(ggplot2)
  
str1<-paste("Time Series Hierarchical Clustering","using"
            ,partitionhash[[i]]) |> str_to_title()

  
    str1%>% paste0("mkdir -p ","\"",.,"\"")|> system()
    str1%>% paste0("./",.) |> setwd()
  

  
  
pc <- tsclust(synthetic_control, type = "hierarchical", k = 6, 
              distance = "dtw2", centroid = i, 
              seed = 3247L, trace = TRUE,
              args = tsclust_args(dist = list(window.size = c(3,2)   )))
plot(pc)
ggsave("pc.png",width =9,height=7,dpi=700) 


cvi(pc,type = "external",b=real) %>%
  data.table(t(.)) |>
  head(1)|>
  select.(ARI,VI) %>% 
  mutate_if(is.numeric, ~round(., 3)) |>
  fwrite("cvindf.csv",append = FALSE)

setwd("..")

}
stopCluster(cl)
