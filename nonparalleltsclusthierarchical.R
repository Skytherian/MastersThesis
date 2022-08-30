disthash<-hash("sbd"="Shape-based distance",
               "sdtw"="Soft-DTW",
               "dtw"="DTW",
               "dtw2"="DTW with L2 norm")
library(bigmemory)

setwd("/home/scyther/Documents/clustergi/ts/hierarchical/")
for (i in names(disthash) ) {
  str1<-paste("Time Series Hierarchical Clustering","using"
              ,disthash[[i]]) |> str_to_title()
  
  
  str1%>% paste0("mkdir -p ","\"",.,"\"")|> system()
  str1%>% paste0("./",.) |> setwd()
  
  

pc <- tsclust(synthetic_control, type = "hierarchical", k = 6,  
              distance = i, centroid = DBA,
              seed = 3247L, trace = TRUE, 
              control = hierarchical_control(method = "ward.D") ) 

plot(pc,type="sc")
ggsave("pc.png",width =9,height=7,dpi=350) 

cvi(pc,type = "external",b=real) %>%
  data.table(t(.)) |>
  head(1)|>
  select.(ARI,VI) %>% 
  mutate_if(is.numeric, ~round(., 3)) |>
  fwrite("cvindf.csv",append = FALSE)
setwd("..")
}

