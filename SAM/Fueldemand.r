SAM_model=read.csv(file="../SAM/b_sam_model_ng_pos.csv",header=T,as.is=T)
A=SAM_model[which(grepl("-c",SAM_model$X)),c(1,which(grepl("\\.a",colnames(SAM_model))))]
rownames(A)=SAM_model$X[grepl("-c",SAM_model$X)]

Fuel_name=c("Gasoline-c",     "Jetoil-c",       "Diesel-c",       "Kerosene-c",    "Fueloil-c",      "LPG-c")
library(dplyr)
library(tidyr)
library(ggplot2)
FuelA=A[match(Fuel_name,A$X),]
FuelA %>% 
  gather(key="demand",value,-1) %>%
  group_by(X) %>%
  arrange(X,desc(value)) %>%
  mutate(dist=100*(value/sum(value))) %>%
  top_n(5)%>%
  mutate(index=(1:5)) %>%
  ggplot(aes(x=index,y=dist))+geom_bar(stat="identity")+facet_wrap(~X)
  ggsave("Fueldmand.png")

    FuelA %>% 
    gather(key="demand",value,-1) %>%
    group_by(X) %>%
    arrange(X,desc(value)) %>%
    mutate(dist=100*(value/sum(value))) %>%
    top_n(5)%>%
    mutate(index=(1:5)) %>%
#    ggplot(aes(x=index,y=dist))+geom_bar(stat="identity")+facet_wrap(~X)
    gather(key="data",value,(2:4)) %>%
    spread(key=data,value) %>%
    write.csv(file="Top5.dist.csv")

for (i in 1:6){
  FuelA.i=FuelA[i,]
  Top5.i=FuelA.i %>% 
    gather(key="demand",value,-1) %>%
    arrange(desc(value)) %>%
    mutate(dist=100*(value/sum(value)))%>%
    mutate(index=(1:54)) %>%
    filter(index<=5)
print("")    
Top5.i %>%
  select(X,demand,dist) %>%
  print()

    ggplot(Top5.i,aes(x=index,y=dist))+geom_bar(stat="identity")+scale_x_continuous(breaks=Top5.i$index,labels=Top5.i$demand)
    figname=paste(FuelA.i$X,".png",sep="")
    ggsave(figname,width=4,height=4) 
  }