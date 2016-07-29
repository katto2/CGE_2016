library(dplyr)
library(tidyr)

#load data
KSIC.KAIST=read.csv(file="KCIS_KAIST.csv",header=T,as.is=T)
IO.KSIC=read.csv(file="2010_IO_KCIS.csv",header=T,as.is=T)
IO.KSIC.m=read.csv(file="2010_IO_KCIS_m.csv",header=T,as.is=T)
IO.model=read.csv("indcode_20160616.csv",header=T,as.is=T)
KSIC.name=KSIC.KAIST[,(9:10)]
KSIC_ind=unique(KSIC.name[,1])
KSIC.name.dict={}
for (ki in 1:length(KSIC_ind)){
KSIC_ind_i=KSIC_ind[ki]
KSIC_n_i=paste(unique(KSIC.name[KSIC.name[,1]==KSIC_ind_i,2]),collapse=" & ")
nind_i=cbind(KSIC_ind_i,KSIC_n_i)
KSIC.name.dict=rbind(KSIC.name.dict,nind_i)
}
KSIC.name.dict=data.frame(KSIC.name.dict)
colnames(KSIC.name.dict)=c("Tiny","Tiny_name")

IO.name_row=IO.model[,(1:2)]
IO.name_col=IO.model[,(4:5)]
model.name=IO.model[,(7:8)]
IO.name_row=IO.name_row[!is.na(IO.name_row[,1]),]
model.name=model.name[!is.na(model.name[,1]),]

## Step 1. IO_model_KCIS
#trim IO_model
IO.model=IO.model[,c(1,3)]
IO.model=IO.model[(1:384),]
#integrate IO_KSIC
IO.KSIC=IO.KSIC[,(2:3)]

IO.KSIC.m_data={}

for (i in 1:length(IO.KSIC.m)){
basei=IO.KSIC.m[i,1]
begin_i=IO.KSIC.m[i,"KCIS_begin"]
end_i=IO.KSIC.m[i,"KCIS_end"]
ci=(begin_i:end_i)
data_i=cbind(rep(basei,length(ci)),ci)
IO.KSIC.m_data=rbind(IO.KSIC.m_data,data_i)
}

IO.KSIC.m_data=data.frame(IO.KSIC.m_data)
colnames(IO.KSIC.m_data)=colnames(IO.KSIC)
IO.KSIC=rbind(IO.KSIC,IO.KSIC.m_data)

# merge IO_model with IO_KSIC
IO_model_KSIC=merge(IO.model,IO.KSIC,by.x="basecode_row",by.y="basecode_fill",all=T)

# merge with sector name

IO_model_KSIC.N=merge(IO_model_KSIC,model.name, by.x="sector_row",by.y="sector_ind",all=T,sort=FALSE)


# Step 2. obtain KSIC_model
NKSIC=length(unique(IO_model_KSIC$KCIS))
UKSIC=unique(IO_model_KSIC$KCIS)

KSIC_model={}

for (i in 1:NKSIC){
  UKSIC_i=UKSIC[i]
IO_i=IO_model_KSIC.N[IO_model_KSIC.N$KCIS==UKSIC_i,"basecode_row"]
IO_i=unique(IO_i)
IO_i=paste(IO_i,collapse=" & ")
N_i=IO_model_KSIC.N[IO_model_KSIC.N$KCIS==UKSIC_i,"sector_name"]
N_i=unique(N_i)
N_i=paste(N_i,collapse=" & ")
S_i=IO_model_KSIC.N[IO_model_KSIC.N$KCIS==UKSIC_i,"sector_row"]
S_i=unique(S_i)
S_i=paste(S_i,collapse=" & ")
D_i=data.frame(cbind(UKSIC_i,N_i,S_i,IO_i))
KSIC_model=rbind(KSIC_model,D_i)
}

#step 3. Obtain KAIST KSIC_model

KSIC_KAIST.s=KSIC.KAIST[,c(9,10,15)]

KSIC.m=merge(KSIC_model,KSIC_KAIST.s, by.x="UKSIC_i",by.y="Tiny",all=T)
colnames(KSIC.m)=c("KSICcode","CGE_name_mapp","CGE_code_mapp","IO_code","KSIC_name","CGE_code_actual")


KSIC.m.diffmodel=KSIC.m[(KSIC.m[,2]!=KSIC.m[,6]),]
KSIC.m.diffmodel.s=KSIC.m.diffmodel[!is.na(KSIC.m.diffmodel[,1]),]
KSIC.m.diffmodel.NA=KSIC.m.diffmodel[is.na(KSIC.m.diffmodel[,1]),]
write.csv(KSIC.m.diffmodel.s, file="diff_small.csv")
write.csv(KSIC.m.diffmodel.NA,file="diff_large.csv")

KSIC.m.core=KSIC.m[!is.na(KSIC.m[,1]) & !is.na(KSIC.m[,6]),]
KSIC.m.core=KSIC.m.core[order(KSIC.m.core[,1]),]
KSIC.m.core=KSIC.m.core %>% select(KSICcode, KSIC_name,CGE_code_actual,CGE_code_mapp,CGE_name_mapp)
KSIC.m.core=KSIC.m.core[!duplicated(KSIC.m.core),]
save(KSIC.m.core, file="KSIC-IO-model.mapping.rdata")