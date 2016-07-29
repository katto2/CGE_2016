library(dplyr)
library(tidyr)
library(ggplot2)
######### Part A. preparation
#(i)load GHG data
GHG_IO=read.csv(file="GHGIO.csv",header=T, as.is=T)
GHG_IO[is.na(GHG_IO)]=0
GHG_IO_ind=GHG_IO[,colnames(GHG_IO)!="HE"]
AGRI=paste("X",(1:25),sep="")
Mining=paste("X",(26:34),sep="")
Transform=paste("X",(274:280),sep="")
Transport=paste("X",(304:317),sep="")
Service=paste("X",c(281:286,302:303,318:384),sep="")
ROIL=paste("X",c(99:108),sep="")
Const=paste("X",c(287:301),sep="")
NONind=c(AGRI,Mining,Transform,Transport,Service,ROIL,Const)
GHG_bydemand=GHG_IO_ind %>% select(-match(NONind,colnames(GHG_IO_ind)))%>%  gather(key="demand",value,-sector) %>% group_by(demand) %>%summarize(sum(value))
GHG_demand.d=data.frame(GHG_bydemand)

TotalE=sum(GHG_demand.d[,2])
GHG_demand.d$share=GHG_demand.d$sum.value./TotalE
GHG_demand.d=GHG_demand.d[order(GHG_demand.d[,2],decreasing=TRUE),]
GHG_demand.d$dist=cumsum(GHG_demand.d$share)

sector_ind=read.csv(file="indcode_20161223.csv",header=T, as.is=T)
row_ind=sector_ind[,1:2]
col_ind=sector_ind[,3:4]
row_name_b=sector_ind[,17:18]
col_name_b=sector_ind[,c(17,19)]

row_name_b$basecode.x=paste("X",row_name_b$basecode,sep="")
GHG_demand.d.name=merge(GHG_demand.d,row_name_b,by.x="demand",by.y="basecode.x",all.x=T)
GHG_demand.d.name=GHG_demand.d.name[order(GHG_demand.d.name$share, decreasing=T),]
GHG_demand_Top=GHG_demand.d.name %>% filter(dist<0.9) %>% select(c(2:4,6))

sec_group=sector_ind[,5:8]
sec_name=sector_ind[,5:6]
sec_name=sec_name[!is.na(sec_name),]

GHG_demand.d$Nsector=as.numeric(substr(GHG_demand.d$demand,2,nchar(GHG_demand.d$demand)))
GHG_demand.sector=merge(GHG_demand.d,col_ind, by.y="basecode_column",by.x="Nsector",all=T)
GHG_demand.sector=GHG_demand.sector[c(1:384,407),]
GHG_demand.sector$sector_column[385]=100

GHG_demand.sector.d=data.frame(GHG_demand.sector %>% group_by(sector_column) %>% select(3:5) %>% summarize_each(funs(sum(.,na.rm=T))))
GHG_demand.sector.d=GHG_demand.sector.d[order(GHG_demand.sector.d[,2],decreasing=T),]
GHG_demand.sector.d$dist=cumsum(GHG_demand.sector.d$share)

GHG_demand.sector.name=merge(GHG_demand.sector.d,sec_name,by.x="sector_column",by.y="sector_ind",all.x=T)
GHG_demand.sector.name=GHG_demand.sector.name[order(GHG_demand.sector.name$share, decreasing=T),]
GHG_demand.sector_Top=GHG_demand.sector.name %>% filter(dist<0.95) %>% select(c(2:5))

GHG_demand_Top%>% mutate(xind=(1:36)) %>%ggplot(aes(x=xind,y=share))+geom_bar(stat="identity")
GHG_demand_Top%>% mutate(xind=(1:36)) %>%ggplot(aes(x=xind,y=dist))+geom_bar(stat="identity")
ggsave("ghgorder_base.png")


GHG_demand.sector_Top %>%mutate(xind=(1:9)) %>% ggplot(aes(x=xind,y=share))+geom_bar(stat="identity")+scale_x_continuous(breaks=(1:9),labels=GHG_demand.sector_Top$sector_name)
GHG_demand.sector_Top %>%mutate(xind=(1:9)) %>% ggplot(aes(x=xind,y=dist))+geom_bar(stat="identity")+scale_x_continuous(breaks=(1:9),labels=GHG_demand.sector_Top$sector_name)

ggsave("ghgorder_sector.png")


write.csv(GHG_demand.d.name, file="GHGind_basesector.csv")
write.csv(GHG_demand.sector.name, file="GHGind_49sector.csv")