######### Part A. preparation
library(dplyr)
library(ggplot2)
library(tidyr)
#(i)load GHG data
GHG_IO=read.csv(file="GHGIO.csv",header=T, as.is=T)
GHG_IO[is.na(GHG_IO)]=0
GHG_IO_ind=GHG_IO[,colnames(GHG_IO)!="HE"]
GHG_IO_F=GHG_IO[,colnames(GHG_IO)=="HE"]

#load index mapping
sector_ind=read.csv(file="indcode_20161223.csv",header=T, as.is=T)
indname=read.csv(file="indname.csv",header=T, as.is=T)

# obtain share and cumulative share (distribution function) of ghg from manufacture (35:98,109:271)
GHG_ind_dist=GHG_IO_ind %>% gather(key="ind",value,c(35:98,109:271)) %>% group_by(ind) %>% summarise(ind_ghg=sum(value)) %>% mutate(share=ind_ghg/sum(ind_ghg)) %>% arrange(desc(share)) %>% mutate(dist=cumsum(share))

#add names
indname$xcode=paste("X",indname$basecode,sep="")
GHG_ind_dist.N=merge(GHG_ind_dist,indname,by.x="ind",by.y="xcode",all.x=T)

GHG_ind_dist.N=GHG_ind_dist.N[order(GHG_ind_dist.N$share,decreasing=T),]

Top_ind=GHG_ind_dist.N %>% filter(dist<0.9) %>% arrange(desc(share))
print(Top_ind)

Top_ind %>%ggplot(aes(x=(1:34),y=dist))+geom_bar(stat="identity")
Top_ind %>%ggplot(aes(x=(1:34),y=share))+geom_bar(stat="identity")+scale_x_continuous(breaks=c(1:34),labels(Top_ind$basename))


#(ii)preparing index
row_ind=sector_ind[,1:2]
col_ind=sector_ind[,3:4]
sec_group=sector_ind[,5:8]
sec_BR=sector_ind[,c(5,6,15,16)]

IOind_model=row_ind[(1:384),]
sec_group=sec_group[!is.na(sec_group[,1]),]
sec_BR=sec_BR[!is.na(sec_BR[,1]),]
sectorname=sec_group[,1:2]

GHG_ind_core=GHG_IO_ind %>% gather(key="ind",value,c(35:98,109:271)) %>% group_by(ind) %>% summarise(ind_ghg=sum(value))

col_ind$xcode=paste("X",col_ind$basecode_column,sep="")

GHG_sector=merge(GHG_ind_core,col_ind,by.x="ind",by.y="xcode",all.x=T)
GHG_sector_dist=GHG_sector %>% group_by(sector_column) %>% summarize(sector_ghg=sum(ind_ghg))%>% mutate(share=sector_ghg/sum(sector_ghg)) %>% arrange(desc(sector_ghg)) %>% mutate(dist=cumsum(share))
sectorname=sec_group[,1:2]

GHG_sector_dist.N=merge(GHG_sector_dist,sectorname, by.x="sector_column",by.y="sector_ind",all.x=T,sort=F)

Top_sector=GHG_sector_dist.N %>% filter(dist<0.95) %>% arrange(desc(share)) 
print(Top_sector)

Top_sector%>%ggplot(aes(x=(1:8),y=share))+geom_bar(stat="identity")+scale_x_continuous(breaks=(1:8),labels=(Top_sector$sector_name))
Top_sector%>%ggplot(aes(x=(1:8),y=dist))+geom_bar(stat="identity")+scale_x_continuous(breaks=(1:8),labels=(Top_sector$sector_name))


