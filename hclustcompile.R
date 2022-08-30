sorted_complete$ARI<-as.numeric(sorted_complete$ARI)
sorted_complete[24,2:3]<-list(0,1.823)

a1<-str_match_all(sorted_complete$Method,".*?Using (.*?) Distance.*?")
regmatches(as.character(sorted_complete$Method),regexec(".*Using(.*)Distance.*"))
a<-strcapture(pattern = ".*?Using (.*?) Distance", perl = TRUE ,x=sorted_complete$Method,proto = list(key = character()) )
a1<-as.vector(a$key)
sorted_complete_1<-sorted_complete
sorted_complete_1$Distance<-a1

b<-strcapture(pattern = ".*?Clustering (.*?) Linkage.*?", perl = TRUE ,x=sorted_complete$Method,proto = list(key = character()) )
b1<-as.vector(b$key)

sorted_complete_1$Linkage<-b1
ggplot(data=sorted_complete_1,aes(x=Distance,y=ARI))+geom_boxplot()
ggsave('./DistanceARI.png',width =9,height=5.064,dpi=700 )
ggplot(data = sorted_complete_1,aes(x=Linkage,y=ARI))+geom_boxplot()
ggsave('./LinkageARI.png',width =9,height=5.064,dpi=700 )


ggplot(data=sorted_complete_1,aes(x=Distance,y=VI))+geom_boxplot()
ggsave('./DistanceVI.png',width =9,height=5.064,dpi=700 )

ggplot(data = sorted_complete_1,aes(x=Linkage,y=VI))+geom_boxplot()
ggsave('./LinkageVI.png',width =9,height=5.064,dpi=700 )

ggplot(data=sorted_complete_1,aes(x=ARI,y=VI))+geom_point()+theme_bw()+geom_smooth(method="lm")
ggsave('./ARIVI.png',width =9,height=5.064,dpi=700)
cor(sorted_complete_1$ARI,sorted_complete_1$VI)
