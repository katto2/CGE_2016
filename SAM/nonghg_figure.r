library(dplyr)
library(tidyr)
library(ggplot2)
proc.ghg=read.csv(file="GHG_model_process_20160621.csv",header=T,as.is=T)
sum.prog.ghg=colSums(proc.ghg[,-1])

core.prog.ghg= proc.ghg %>%  gather(key="IND",value="Emission",-1) %>%   group_by(IND) %>%   mutate(IND.E=sum(Emission)) %>% filter(IND.E>0) %>%   arrange(X,desc(IND.E))
core.prog.ghg$index=rep(1:22,6) 
ind.name=core.prog.ghg$IND[1:22]
ind.name=substr(ind.name,1,nchar(ind.name)-2)



ggplot(core.prog.ghg,aes(x=index,y=Emission))+geom_bar(stat="identity")+scale_x_continuous(breaks=(1:22),labels=ind.name)+facet_grid(X~.)
ggsave("pghgind.png")

core.prog.ghg %>%
  filter(X=="CH4") %>%
  ggplot(aes(x=(1:22),y=IND.E))+geom_bar(stat="identity")+scale_x_continuous(breaks=(1:22),labels=ind.name) 
  ggsave("pghgtotal.png")
