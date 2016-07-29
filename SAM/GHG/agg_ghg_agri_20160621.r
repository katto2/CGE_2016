
#setwd("C:/Users/sungw/OneDrive/work_2016/0000_Hybrid_2nd/CGE/SAM")
######### Part A. preparation
#(i)load GHG data
GHG_IO_ind=read.csv(file="../GTAP_K_R/GIO_2010.csv",header=T, as.is=T)
GHG_IO_F=read.csv(file="../GTAP_K_R/GIO_FD_2010.csv",header=T, as.is=T)
GHG_Process=read.csv(file="../GTAP_K_R/GHG_p_2010.csv",header=T,as.is=T)
#load index mapping
sector_ind=read.csv(file="../IND/indcode_agri_20160621.csv",header=T, as.is=T)
sec_BR=read.csv(file="sector_agri_BR.csv",header=T, as.is=T)
sec_BR=sec_BR[,-1]
#(ii)preparing index

row_ind=sector_ind[,c(1,3)]
col_ind=sector_ind[,c(4,6)]
sec_dict=sector_ind[,7:8]

IOind_model=row_ind[(1:384),]

sec_dict=sec_dict[!is.na(sec_dict[,1]),]
##(iii) preparing sector numbers
nsector=dim(sec_dict)[1]
nBR=length(unique(sec_BR[,3]))

## (iv) sector dictionary
BR_dict=unique(sec_BR[,3:4])

###### Part B. GHG_ind
### I. IO to model
## Step 1. get dimmension of IO
dim_GHG_IO_ind=dim(GHG_IO_ind)

## Step 2. Rowsum:  merge and obtain rowsum using aggregate function
GHG_IO_ind$sector=as.numeric(substr(GHG_IO_ind$X,2,nchar(GHG_IO_ind$X)))

GHG_sec=merge(GHG_IO_ind,IOind_model, by.x="sector", by.y="basecode_row", all.x=T)
GHG_row_model=aggregate(GHG_sec[,3:(dim_GHG_IO_ind[2]+1)],list(GHG_sec$sector_row),FUN=sum)

dim_GHG_row_model=dim(GHG_row_model)
## Step 3. Colsum: transpose rowsum, merge with IOind_model index matching, take rowsum using aggregate function
#3-1. keep row index
rowindex_model=GHG_row_model[,1]
#3-2. transpose
T_GHG_model=data.frame(t(GHG_row_model))
T_GHG_model=T_GHG_model[-1,]
T_GHG_model$xsec=rownames(T_GHG_model)#preparing merging index

#3-3. merge
IOind_model$xsec=paste("X",IOind_model[,1],sep="")
T_GHG_model_name=merge(T_GHG_model,IOind_model,by="xsec",all.x=T,sort=F)

#3-4. aggregate

GHG_model_0=aggregate(T_GHG_model_name[,2:(dim_GHG_row_model[1]+1)],list(T_GHG_model_name$sector_row),FUN=sum)
GHG_model_0=data.frame(t(GHG_model_0))

## Step 4. set index for model IO
colindex_GHG_model=as.numeric(GHG_model_0["Group.1",])
rowindex_GHG_model=rowindex_model

## Step 5.  keep only numeric values 
GHG_model_Ind=(GHG_model_0[-1,])
## Step 6. Add row and column names
colnames(GHG_model_Ind)=sec_dict[colindex_GHG_model,2]
rownames(GHG_model_Ind)=sec_dict[rowindex_GHG_model,2]

### II. model to BR

## Step 1. get dimmension of IO

dim_GHG_model_Ind=dim(GHG_model_Ind)

## Step 2. merge with BR index and aggregate by BR index
GHG_model_BR=GHG_model_Ind
GHG_model_BR$secname=rownames(GHG_model_BR)
GHG_model_BRname=merge(GHG_model_BR, sec_BR, by.x="secname", by.y="sector_name", all.x=T,sort=F)
GHG_row_BR=aggregate(GHG_model_BRname[,(2:(dim_GHG_model_Ind[2]+1))],list(GHG_model_BRname$BR_ind),FUN=sum)

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


###### Part D. GHG_F

##(i) model GHG_F
# step 1. merge with model ind
GHG_F_model=merge(GHG_IO_F,IOind_model, by.x="X", by.y="xsec",all.x=T,sort=F)

# step 2. aggregate by "sector_row(model variable)"

GHG_F_model=data.frame(aggregate(GHG_F_model[,"Final_Pc"],list(GHG_F_model[,"sector_row"]),FUN=sum))

# step 3. obtain model F 
rownames(GHG_F_model)=sec_dict[GHG_F_model[,"Group.1"],2]
colnames(GHG_F_model)=c("model_ind", "Household")


##(ii) BR GHG_F
#step 1. merge with BR ind

GHG_F_BR=merge(GHG_F_model, sec_BR, by.x="model_ind", by.y="sector_ind", all.x=T, sort=F)


# step 2. aggregate by "BR_ind(BR variable)"


GHG_F_BR=data.frame(aggregate((GHG_F_BR[,"Household"]),list(GHG_F_BR[,"BR_ind"]),FUN=sum))

# step 3. obtain BR F 
rownames(GHG_F_BR)=BR_dict[GHG_F_BR[,"Group.1"],2]
colnames(GHG_F_BR)=c("BR_ind", "Household")


############### Part D. merge IND and F
GHG_model_Ind$rowindex=rownames(GHG_model_Ind)
GHG_F_model$rowindex=rownames(GHG_F_model)
GHG_F_model=GHG_F_model[-1]
GHG_model=merge(GHG_model_Ind,GHG_F_model, by="rowindex",all=T,sort=F)
rownames(GHG_model)=GHG_model$rowindex
GHG_model=GHG_model[,-1]

GHG_BR_ind$rowindex=rownames(GHG_BR_ind)
GHG_F_BR$rowindex=rownames(GHG_F_BR)
GHG_F_BR=GHG_F_BR[,-1]
GHG_BR=merge(GHG_BR_ind,GHG_F_BR,by="rowindex",all=T,sort=F)
rownames(GHG_BR)=GHG_BR$rowindex
GHG_BR=GHG_BR[,-1]

############### Part E. Add process

T_GHG_process_core=data.frame(t(GHG_Process[,-(1:2)]))
colnames(T_GHG_process_core)=GHG_Process[,2]
T_GHG_process_core$xsec=rownames(T_GHG_process_core)
T_GHG_process_model=merge(T_GHG_process_core,IOind_model,by="xsec",all=T,sort=F)
GHG_process_model=aggregate(T_GHG_process_model[,(2:7)],list(T_GHG_process_model[,"sector_row"]),FUN=sum)

GHG_process_model_BR=merge(GHG_process_model,sec_BR,by.x="Group.1",by.y="sector_ind",all=T,sort=F)
GHG_process_model=GHG_process_model_BR
rownames(GHG_process_model)=GHG_process_model$sector_name
GHG_process_model=data.frame(t(GHG_process_model[,(2:7)]))

GHG_process_BR=aggregate(GHG_process_model_BR[,(2:7)],list(GHG_process_model_BR[,"BR_ind"]),FUN=sum)
GHG_process_BR_name=merge(GHG_process_BR,BR_dict,by.x="Group.1",by.y="BR_ind",all=T,sort=F)
rownames(GHG_process_BR_name)=GHG_process_BR_name$BR_name
GHG_process_BR=data.frame(t(GHG_process_BR_name[,(2:7)]))
############### Part F. reduce size and add process
GHG_model_p=GHG_model/100000 # in 100,000 ton
GHG_BR_p=GHG_BR/100000
GHG_process_model=GHG_process_model/100000
GHG_process_BR=GHG_process_BR/100000

Total_ghg_process_model=t(data.frame(colSums(GHG_process_model)))
rownames(Total_ghg_process_model)="process"
Total_ghg_process_model=data.frame(Total_ghg_process_model)
Total_ghg_process_model$Household=0

Total_ghg_process_BR=t(data.frame(colSums(GHG_process_BR)))
rownames(Total_ghg_process_BR)="process"
Total_ghg_process_BR=data.frame(Total_ghg_process_BR)
Total_ghg_process_BR$Household=0

GHG_model=data.frame(t(cbind(t(GHG_model_p),t(Total_ghg_process_model))))

GHG_BR=data.frame(t(cbind(t(GHG_BR_p),t(Total_ghg_process_BR))))

GHG_model$Total=rowSums(GHG_model)
model_total=colSums(GHG_model)
GHG_model=rbind(GHG_model,t(data.frame(model_total)))
rownames(GHG_model)[dim(GHG_model)[1]]="Total"

GHG_BR$Total=rowSums(GHG_BR)
BR_total=colSums(GHG_BR)
GHG_BR=rbind(GHG_BR,t(data.frame(BR_total)))
rownames(GHG_BR)[dim(GHG_BR)[1]]="Total"


## change names used in GAMS coding: adding -a for activity, -c for commodity##
colnames(GHG_model)[1:nsector]=paste(colnames(GHG_model)[1:nsector],"-a",sep="")
Non_ind_r_model=is.na(match(rownames(GHG_model),c("process","Total")))
rownames(GHG_model)[Non_ind_r_model]=paste(rownames(GHG_model)[Non_ind_r_model],"-c",sep="")

colnames(GHG_BR)[1:nBR]=paste(colnames(GHG_BR)[1:nBR],"-a",sep="")
Non_ind_r_BR=is.na(match(rownames(GHG_BR),c("process","Total")))
rownames(GHG_BR)[Non_ind_r_BR]=paste(rownames(GHG_BR)[Non_ind_r_BR],"-c",sep="")

colnames(GHG_process_model)[1:nsector]=paste(colnames(GHG_process_model)[1:nsector],"-a",sep="")
colnames(GHG_process_BR)[1:nBR]=paste(colnames(GHG_process_BR)[1:nBR],"-a",sep="")

## change column name HE to houseold

write.csv(GHG_model, file="GHG_agri_model_p_20160621.csv")
write.csv(GHG_process_model, file="GHG_agri_model_process_20160621.csv")
write.csv(GHG_BR,file="GHG_agri_BR_p_20160621.csv")
write.csv(GHG_process_BR, file="GHG_agri_BR_process_20160621.csv")
