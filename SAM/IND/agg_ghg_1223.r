######### Part A. preparation
#(i)load GHG data
GHG_IO=read.csv(file="GHGIO.csv",header=T, as.is=T)
GHG_IO[is.na(GHG_IO)]=0
GHG_IO_ind=GHG_IO[,colnames(GHG_IO)!="HE"]
GHG_IO_F=GHG_IO[,colnames(GHG_IO)=="HE"]

#load index mapping
sector_ind=read.csv(file="indcode_20161223.csv",header=T, as.is=T)

#(ii)preparing index
row_ind=sector_ind[,1:2]
col_ind=sector_ind[,3:4]
sec_group=sector_ind[,5:8]
sec_BR=sector_ind[,c(5,6,15,16)]

IOind_model=row_ind[(1:384),]
sec_group=sec_group[!is.na(sec_group[,1]),]
sec_BR=sec_BR[!is.na(sec_BR[,1]),]

##(iii) preparing sector numbers
nsector=dim(sec_group)[1]
ngroup=length(unique(sec_group[,3]))
nBR=length(unique(sec_BR[,3]))

## (iv) sector dictionary
sec_dict=sec_group[,1:2]
group_dict=unique(sec_group[,3:4])
BR_dict=unique(sec_BR[,3:4])

###### Part B. GHG_ind
### I. IO to model
## Step 1. get dimmension of IO
dim_GHG_IO_ind=dim(GHG_IO_ind)

## Step 2. Rowsum:  merge and obtain rowsum using aggregate function
GHG_sec=merge(GHG_IO_ind,IOind_model, by.x="sector", by.y="basecode_row", all.x=T)
GHG_row_37=aggregate(GHG_sec[,2:(dim_GHG_IO_ind[2])],list(GHG_sec$sector_row),FUN=sum)

dim_GHG_row_37=dim(GHG_row_37)
## Step 3. Colsum: transpose rowsum, merge with IOind_model index matching, take rowsum using aggregate function
#3-1. keep row index
rowindex_37=GHG_row_37[,1]
#3-2. transpose
T_GHG_37=data.frame(t(GHG_row_37))
T_GHG_37=T_GHG_37[-1,]
T_GHG_37$xsec=rownames(T_GHG_37)#preparing merging index

#3-3. merge
IOind_model$xsec=paste("X",IOind_model[,1],sep="")
T_GHG_37_name=merge(T_GHG_37,IOind_model,by="xsec",all.x=T,sort=F)

#3-4. aggregate

GHG_37_0=aggregate(T_GHG_37_name[,2:(dim_GHG_row_37[1]+1)],list(T_GHG_37_name$sector_row),FUN=sum)
GHG_37_0=data.frame(t(GHG_37_0))

## Step 4. set index for model IO
colindex_GHG_37=as.numeric(GHG_37_0["Group.1",])
rowindex_GHG_37=rowindex_37

## Step 5.  keep only numeric values and transpose
GHG_37_Ind=(GHG_37_0[-1,])
## Step 6. Add row and column names
colnames(GHG_37_Ind)=sec_dict[colindex_GHG_37,2]
rownames(GHG_37_Ind)=sec_dict[rowindex_GHG_37,2]

### II. model to BR

## Step 1. get dimmension of IO

dim_GHG_37_Ind=dim(GHG_37_Ind)

## Step 2. merge with BR index and aggregate by BR index
GHG_37_BR=GHG_37_Ind
GHG_37_BR$secname=rownames(GHG_37_BR)
GHG_37_BRname=merge(GHG_37_BR, sec_BR, by.x="secname", by.y="sector_name", all.x=T,sort=F)
GHG_row_BR=aggregate(GHG_37_BRname[,(2:(dim_GHG_37_Ind[2]+1))],list(GHG_37_BRname$BR_ind),FUN=sum)

dim_GHG_row_BR=dim(GHG_row_BR)
## Step 3. Colsum: transpose rowsum, merge with model_BR index matching, take rowsum using aggregate function
#3-1. keep row index
rowindex_BR=GHG_row_BR$Group.1
#3-2. Transpose
T_GHG_BR=data.frame(t(GHG_row_BR))
T_GHG_BR=T_GHG_BR[-1,]
T_GHG_BR$sec=rownames(T_GHG_BR)

#3-3,merge with sec_BR index

T_GHG_BR_name=merge(T_GHG_BR,sec_BR,by.x="sec", by.y="sector_name",all.x=T,sort=F)

#3-4. aggregate

GHG_BR_0=aggregate(T_GHG_BR_name[,2:(dim_GHG_row_BR[1]+1)],list(T_GHG_BR_name$BR_ind),FUN=sum)
GHG_BR_0=data.frame(t(GHG_BR_0))

## step 4. Obtain BR IO 
#4-1. row and column name index
colindex_BR=as.numeric(GHG_BR_0["Group.1",])
rowindex_BR=as.numeric(rowindex_BR)

#4-2. keep data
GHG_BR_ind=GHG_BR_0[-1,]

#4-3 add names

colnames(GHG_BR_ind)=BR_dict[colindex_BR,2]
rownames(GHG_BR_ind)=BR_dict[rowindex_BR,2]

### III. model to Group

## Step 1. get dimmension of IO

dim_GHG_37_Ind=dim(GHG_37_Ind)

## Step 2. merge with group index and aggregate by group index
GHG_37_GR=GHG_37_Ind
GHG_37_GR$secname=rownames(GHG_37_GR)
GHG_37_GRname=merge(GHG_37_GR, sec_group, by.x="secname", by.y="sector_name", all.x=T,sort=F)
GHG_row_GR=aggregate(GHG_37_GRname[,(2:(dim_GHG_37_Ind[2]+1))],list(GHG_37_GRname$Group_ind),FUN=sum)

dim_GHG_row_GR=dim(GHG_row_GR)
## Step 3. Colsum: transpose rowsum, merge with model_BR index matching, take rowsum using aggregate function
#3-1. keep row index
rowindex_GR=GHG_row_GR$Group.1
#3-2. Transpose
T_GHG_GR=data.frame(t(GHG_row_GR))
T_GHG_GR=T_GHG_GR[-1,]
T_GHG_GR$sec=rownames(T_GHG_GR)

#3-3,merge with sec_GR index

T_GHG_GR_name=merge(T_GHG_GR,sec_group,by.x="sec", by.y="sector_name",all.x=T,sort=F)

#3-4. aggregate

GHG_GR_0=aggregate(T_GHG_GR_name[,2:(dim_GHG_row_GR[1]+1)],list(T_GHG_GR_name$Group_ind),FUN=sum)
GHG_GR_0=data.frame(t(GHG_GR_0))

## step 4. Obtain GR IO 
#4-1. row and column name index
colindex_GR=as.numeric(GHG_GR_0["Group.1",])
rowindex_GR=as.numeric(rowindex_GR)

#4-2. keep data
GHG_GR_ind=GHG_GR_0[-1,]

#4-3 add names

colnames(GHG_GR_ind)=group_dict[colindex_GR,2]
rownames(GHG_GR_ind)=group_dict[rowindex_GR,2]


###### Part D. GHG_F

## (i) data preparation
GHG_IO_F=data.frame(cbind(GHG_IO$sector,GHG_IO_F))
colnames(GHG_IO_F)=c("sector","HE")

##(ii) model GHG_F
# step 1. merge with model ind
GHG_F_model=merge(GHG_IO_F,IOind_model, by.x="sector", by.y="basecode_row",all.x=T,sort=F)

# step 2. aggregate by "sector_row(model variable)"

GHG_F_model=data.frame(aggregate(GHG_F_model[,"HE"],list(GHG_F_model[,"sector_row"]),FUN=sum))

# step 3. obtain model F 
rownames(GHG_F_model)=sec_dict[GHG_F_model[,"Group.1"],2]
colnames(GHG_F_model)=c("model_ind", "HE")


##(iii) BR GHG_F
#step 1. merge with BR ind

GHG_F_BR=merge(GHG_F_model, sec_BR, by.x="model_ind", by.y="sector_ind", all.x=T, sort=F)


# step 2. aggregate by "BR_ind(BR variable)"


GHG_F_BR=data.frame(aggregate((GHG_F_BR[,"HE"]),list(GHG_F_BR[,"BR_ind"]),FUN=sum))

# step 3. obtain BR F 
rownames(GHG_F_BR)=BR_dict[GHG_F_BR[,"Group.1"],2]
colnames(GHG_F_BR)=c("BR_ind", "HE")


##(iv) group GHG_F
#step 1. merge with GR ind

GHG_F_GR=merge(GHG_F_model, sec_group, by.x="model_ind", by.y="sector_ind", all.x=T, sort=F)


# step 2. aggregate by "Group_ind(Group variable)"


GHG_F_GR=data.frame(aggregate((GHG_F_GR[,"HE"]),list(GHG_F_GR[,"Group_ind"]),FUN=sum))

# step 3. obtain BR F 
rownames(GHG_F_GR)=group_dict[GHG_F_GR[,"Group.1"],2]
colnames(GHG_F_GR)=c("Group_ind", "HE")


############### Part D. merge IND and F
GHG_37_Ind$rowindex=rownames(GHG_37_Ind)
GHG_F_model$rowindex=rownames(GHG_F_model)
GHG_F_model=GHG_F_model[-1]
GHG_model=merge(GHG_37_Ind,GHG_F_model, by="rowindex",all=T,sort=F)
rownames(GHG_model)=GHG_model$rowindex
GHG_model=GHG_model[,-1]

GHG_BR_ind$rowindex=rownames(GHG_BR_ind)
GHG_F_BR$rowindex=rownames(GHG_F_BR)
GHG_F_BR=GHG_F_BR[,-1]
GHG_BR=merge(GHG_BR_ind,GHG_F_BR,by="rowindex",all=T,sort=F)
rownames(GHG_BR)=GHG_BR$rowindex
GHG_BR=GHG_BR[,-1]

GHG_GR_ind$rowindex=rownames(GHG_GR_ind)
GHG_F_GR$rowindex=rownames(GHG_F_GR)
GHG_F_GR=GHG_F_GR[,-1]
GHG_GR=merge(GHG_GR_ind,GHG_F_GR,by="rowindex",all=T,sort=F)
rownames(GHG_GR)=GHG_GR$rowindex
GHG_GR=GHG_GR[,-1]

############### Part E. add total

GHG_model=rbind(GHG_model,colSums(GHG_model))
GHG_BR=rbind(GHG_BR,colSums(GHG_BR))
GHG_GR=rbind(GHG_GR,colSums(GHG_GR))

GHG_model=cbind(GHG_model,rowSums(GHG_model))
GHG_BR=cbind(GHG_BR,rowSums(GHG_BR))
GHG_GR=cbind(GHG_GR,rowSums(GHG_GR))

rownames(GHG_model)[dim(GHG_model)[1]]="Total"
rownames(GHG_BR)[dim(GHG_BR)[1]]="Total"
rownames(GHG_GR)[dim(GHG_GR)[1]]="Total"

#write.csv(GHG_model, file="GHG_model.csv")
#write.csv(GHG_BR,file="GHG_BR.csv")
#write.csv(GHG_GR,file="GHG_GR.csv")

############### Part F. reduce size and add process
GHG_model_p=GHG_model/100000 # in 100,000 ton
GHG_BR_p=GHG_BR/100000
GHG_GR_p=GHG_GR/100000

ghg_process=c(287.6894,1.4893,1.6919)
ghg_process_ind=c("Cement","Orgchem","IS")
ghg_process_model=data.frame(GHG_model_p["Total",])
colnames(ghg_process_model)=colnames(GHG_model_p)
rownames(ghg_process_model)="process"
ghg_process_model[1,]=0
ghg_process_model[,match(ghg_process_ind,colnames(ghg_process_model))]=t(ghg_process)

GHG_model_p=rbind(GHG_model_p[-5,],ghg_process_model)
GHG_model_p[,dim(GHG_model_p)[2]]=rowSums(GHG_model_p[,(1:(dim(GHG_model_p)[2]-1))])
model_total_p=colSums(GHG_model_p)
GHG_model_p=rbind(GHG_model_p,t(data.frame(model_total_p)))
rownames(GHG_model_p)[dim(GHG_model_p)[1]]="Total"

ghg_process_BR=data.frame(GHG_BR_p["Total",])
colnames(ghg_process_BR)=colnames(GHG_BR_p)
rownames(ghg_process_BR)="process"
ghg_process_BR[1,]=0
ghg_process_BR[,"ENIT"]=sum(ghg_process)

GHG_BR_p=rbind(GHG_BR_p[-(dim(GHG_BR_p)[1]),],ghg_process_BR)
GHG_BR_p[,dim(GHG_BR_p)[2]]=rowSums(GHG_BR_p[,(1:(dim(GHG_BR_p)[2]-1))])
BR_total_p=colSums(GHG_BR_p)
GHG_BR_p=rbind(GHG_BR_p,t(data.frame(BR_total_p)))
rownames(GHG_BR_p)[dim(GHG_BR_p)[1]]="Total"

ghg_process_GR=data.frame(GHG_GR_p["Total",])
colnames(ghg_process_GR)=colnames(GHG_GR_p)
rownames(ghg_process_GR)="process"
ghg_process_GR[1,]=0
ghg_process_GR[,"Ind"]=sum(ghg_process)

GHG_GR_p=rbind(GHG_GR_p[-(dim(GHG_GR_p)[1]),],ghg_process_GR)
GHG_GR_p[,dim(GHG_GR_p)[2]]=rowSums(GHG_GR_p[,(1:(dim(GHG_GR_p)[2]-1))])
GR_total_p=colSums(GHG_GR_p)
GHG_GR_p=rbind(GHG_GR_p,t(data.frame(GR_total_p)))
rownames(GHG_GR_p)[dim(GHG_GR_p)[1]]="Total"

colnames(GHG_model_p)[dim(GHG_model_p)[2]]="Total"
colnames(GHG_BR_p)[dim(GHG_BR_p)[2]]="Total"
colnames(GHG_GR_p)[dim(GHG_GR_p)[2]]="Total"

## change names used in GAMS coding: adding -a for activity, -c for commodity##
colnames(GHG_model_p)[1:nsector]=paste(colnames(GHG_model_p)[1:nsector],"-a",sep="")
Non_ind_r_model=is.na(match(rownames(GHG_model_p),c("process","Total")))
rownames(GHG_model_p)[Non_ind_r_model]=paste(rownames(GHG_model_p)[Non_ind_r_model],"-c",sep="")

colnames(GHG_BR_p)[1:nBR]=paste(colnames(GHG_BR_p)[1:nBR],"-a",sep="")
Non_ind_r_BR=is.na(match(rownames(GHG_BR_p),c("process","Total")))
rownames(GHG_BR_p)[Non_ind_r_BR]=paste(rownames(GHG_BR_p)[Non_ind_r_BR],"-c",sep="")

colnames(GHG_GR_p)[1:ngroup]=paste(colnames(GHG_GR_p)[1:ngroup],"-a",sep="")
Non_ind_r_GR=is.na(match(rownames(GHG_GR_p),c("process","Total")))
rownames(GHG_GR_p)[Non_ind_r_GR]=paste(rownames(GHG_GR_p)[Non_ind_r_GR],"-c",sep="")

colnames(GHG_model_p)[which(colnames(GHG_model_p)=="HE")]="Household"
colnames(GHG_BR_p)[which(colnames(GHG_BR_p)=="HE")]="Household"
colnames(GHG_GR_p)[which(colnames(GHG_GR_p)=="HE")]="Household"

## change column name HE to houseold



write.csv(GHG_model_p, file="GHG_model_p_1223.csv")
write.csv(GHG_BR_p,file="GHG_BR_p_1223.csv")
write.csv(GHG_GR_p,file="GHG_GR_p_1223.csv")