## This file only import IO and save 
# (1) load IO data
# (2) load industry mapping
# (3) classifying IO entities
# (4) Construct variablbes using IO data
# (5) Enter Energy Balance entities
# (6) Load energy balance

##(1) load IO data. 
### IO data name protocol : IO_"Type"_"price"_"year" 
#### Type= T(Total), D(Domestic),M(Import)
#### Price =B (basic), N (Producer)
#### year= 4 digit (2010, 2011,.....)
t=2010
IOnames=c("IO_T_N_82","IO_D_N_82","IO_M_N_82","IO_T_N_384","IO_D_N_384","IO_M_N_384","IO_T_B_82","IO_D_B_82","IO_M_B_82","IO_T_B_384","IO_D_B_384","IO_M_B_384")
indexnames=c("indindex_82","indindex_384")
IOnames_t=paste(paste(IOnames,t,sep="_"),"csv",sep=".")
indexnames_t=paste(indexnames,"csv",sep=".")
EBSname=c("EBS")
EBSname_t=paste(paste(EBSname,t,sep=""),"csv",sep=".")
IO_T_N_82=read.csv(file=file.path("Agg/IOT",IOnames_t[1]), header=T,as.is=T)
IO_D_N_82=read.csv(file=file.path("Agg/IOT",IOnames_t[2]), header=T,as.is=T)
IO_M_N_82=read.csv(file=file.path("Agg/IOT",IOnames_t[3]), header=T,as.is=T)
IO_T_N_384=read.csv(file=file.path("Agg/IOT",IOnames_t[4]), header=T,as.is=T)
IO_D_N_384=read.csv(file=file.path("Agg/IOT",IOnames_t[5]), header=T,as.is=T)
IO_M_N_384=read.csv(file=file.path("Agg/IOT",IOnames_t[6]), header=T,as.is=T)

IO_T_B_82=read.csv(file=file.path("Agg/IOT",IOnames_t[7]), header=T,as.is=T)
IO_D_B_82=read.csv(file=file.path("Agg/IOT",IOnames_t[8]), header=T,as.is=T)
IO_M_B_82=read.csv(file=file.path("Agg/IOT",IOnames_t[9]), header=T,as.is=T)
IO_T_B_384=read.csv(file=file.path("Agg/IOT",IOnames_t[10]), header=T,as.is=T)
IO_D_B_384=read.csv(file=file.path("Agg/IOT",IOnames_t[11]), header=T,as.is=T)
IO_M_B_384=read.csv(file=file.path("Agg/IOT",IOnames_t[12]), header=T,as.is=T)


##(2) Load industry mapping
indindex_82=read.csv(file=file.path("Agg/IOT",indexnames_t[1]),header=T,as.is=T)
indindex_384=read.csv(file=file.path("Agg/IOT",indexnames_t[2]),header=T,as.is=T)

##(3) Load Energy balance data

EBS=read.csv(file=file.path("Energy_Estimation",EBSname_t), header=T,as.is=T)


### fill up the NA with 0
EBS[is.na(EBS)]=0

### change row names
rownames(EBS)=EBS[,1]
EBS=EBS[,-1]

##(4) Create Data file 

D_name0=paste(paste("D0",t,sep="_"),"Rdata",sep=".")
#save(list=c(IOnames,indexnames,"EBS"),file=file.path("Agg/IOT",D_name0))
save(list=c(IOnames,indexnames,"EBS"),file=D_name0)
