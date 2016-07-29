## From June.21.2016, we drop 'Group' integration. We have not used it for over a year. 

## Step 1. Data preperation
#(i) loading
#load IO data
IOT_b=read.csv(file="../IO/IOT_b.csv",header=T, as.is=T)
#load index mapping
#sector_ind=read.csv(file="../IND/indcode_20160621.csv",header=T, as.is=T)
sector_ind=read.csv(file="../IND/indcode_agri_20160621.csv",header=T, as.is=T)


#(ii)preparing index
row_ind=sector_ind[,c(1,3)]
col_ind=sector_ind[,c(4,6)]
sec_dict=sector_ind[,7:8]
va_ind=sector_ind[,c(9,10)]
fd_ind=sector_ind[,c(12,13)]
sec_BR=sector_ind[,c(7,8,15,16)]
#getting rid of NA 
row_ind=row_ind[!is.na(row_ind[,1]),]
sec_dict=sec_dict[!is.na(sec_dict[,1]),]
sec_BR=sec_BR[!is.na(sec_BR[,1]),]
va_ind=va_ind[!is.na(va_ind[,1]),]
fd_ind=fd_ind[!is.na(fd_ind[,1]),]

nsector=length(unique((sec_dict[,1])))
#nBR=length(unique(sec_BR[,3]))
nva=dim(va_ind)[1]
nfd=dim(fd_ind)[1]

#(iii)preparing IO for merging with mapping
#set NA observations in IO as 0 
IOT_b[is.na(IOT_b)]=0
#add row index to be used in merging with mapping data to IO
IOT_b$basecode_row=IOT_b$X
#get dimmension of IO
dim_IOT_b=dim(IOT_b)

## Step 2. Rowsum:  merge and obtain rowsum using aggregate function
IOT_b_sec=merge(IOT_b,row_ind, by="basecode_row", all=T)
IOT_b_model=aggregate(IOT_b_sec[,4:(dim_IOT_b[2])],list(IOT_b_sec$sector_row),FUN=sum)

## Step 3. Column sum
#(i) Traspose rowsum 
T_IOT_b_model=data.frame(t(IOT_b_model))
#(ii) add column names for transposed data
colnames(T_IOT_b_model)[1:nsector]=sec_dict[(1:nsector),2]
colnames(T_IOT_b_model)[(nsector+1):(nsector+nva)]=va_ind[,2]
#(iii) drop Group indicator used in rowsum
T_IOT_b_model=T_IOT_b_model[-1,]
#(iv) add index to be used in column sum 
T_IOT_b_model$basecode_col=col_ind[,2]
#(v) take column sum using aggregate function
T_IOT_model_col=aggregate(T_IOT_b_model[,1:(nsector+nva)],list(T_IOT_b_model$basecode_col),FUN=sum)

## Step 4. obtain IO table
#(i)obtain transpose of column sum
IOT_model=data.frame(t(T_IOT_model_col))
#(ii) add column names
colnames(IOT_model)[1:nsector]=sec_dict[(1:nsector),2]
colnames(IOT_model)[(nsector+1):(nsector+nfd)]=fd_ind[,2]
#(iii) drop aggregatio indicator
IOT_model=IOT_model[-1,]

#Step 5. checking balance
# total input + Resout = Total Demand
check1=as.numeric(IOT_model["Tinput",(1:nsector)])+IOT_model$Resout[(1:nsector)]+IOT_model$Imp[(1:nsector)]-IOT_model$Dtotal[(1:nsector)]
check2=IOT_model$Qtotal[(1:nsector)]+IOT_model$Qself[(1:nsector)]+IOT_model$Resout[(1:nsector)]+IOT_model$Imp[(1:nsector)]-IOT_model$Dtotal[(1:nsector)]
check1
check2

write.csv(IOT_model, file="IO_agri_model.csv")

#determine energy intensive sector

library(dplyr)
library(tidyr)
Energy_indicator_row=sector_ind$Energy.IND[1:(dim(IOT_model)[1])]
Energy_indicator_col=sector_ind$Energy.IND[1:(dim(IOT_model)[2])]

Energy=rownames(IOT_model)[Energy_indicator_row=="Energy"]
Ind=colnames(IOT_model)[Energy_indicator_col=="IND"]
Energy_Ind=IOT_model[match(Energy,rownames(IOT_model)),match(Ind,colnames(IOT_model))]
Tinput_Ind=IOT_model["Tinput",match(Ind,colnames(IOT_model))]
Einputshare=data.frame(t(colSums(Energy_Ind)/Tinput_Ind))
Eindshare=data.frame(colSums(Energy_Ind)/sum(Energy_Ind))
E_share=cbind(Einputshare,Eindshare)
colnames(E_share)=c("E/Input","E/TotalE")
E_share=E_share[order(E_share[,1],decreasing=TRUE),]
E_share$dist=cumsum(E_share[,2])
EINT=rownames(E_share)[E_share$dist<0.56] #Ind with highest Energy input/Total input, up to 55% total energy cost.
NEINT=setdiff(Ind,EINT)

## Boehringer and Rutherford Toy model secter index
# Originally, BR has 6 sectors Elec, OIL, COAL, GAS, X(energy intensive),Y(non energy intensive)
# We separage agriculture to link with agriculutre bottom up model. That makes our sectors seven sectors
# ELEC, OIL, COAL,GASHEAT,EINT,NEINT,AGRI
# GAS and Heat are bundled as GASHEAT, ROIL and OIL are interageted into OIL

#step 0. modify sec_BR to have EINT and NEINT
sec_BR$BR_name[intersect(match(EINT,sec_BR[,2]),which(sec_BR[,4]=="IND"))]="EINT"
sec_BR$BR_ind[sec_BR$BR_name=="IND"]=6
sec_BR$BR_name[sec_BR$BR_name=="IND"]="NEINT"



#Step.1 Preparing data
#(i)set aside industry data IOT_model
IOT_model_BR=IOT_model
#(ii)preparing index to sort after merging
IOT_model_BR$index=(1:(dim(IOT_model)[1]))
#(iii)preparing index to merge with sector-group mapping
IOT_model_BR$sector=rownames(IOT_model_BR)
#(iv) merge with sector-BR index mapping and sort to original order
IOT_model_BR=merge(IOT_model_BR,sec_BR, by.x="sector", by.y="sector_name", all=T)
IOT_model_BR=IOT_model_BR[order(IOT_model_BR$index),]
#(v) give row names
rownames(IOT_model_BR)=IOT_model_BR$sector
#(vi)preparing Group name and Group index to be used in aggregation. The VA part
IOT_model_BR$BR_name[is.na(IOT_model_BR$BR_name)]=IOT_model_BR$sector[is.na(IOT_model_BR$BR_name)]

BRimax=max(IOT_model_BR$BR_ind,na.rm=T)
BRiblank=length(IOT_model_BR$BR_ind[is.na(IOT_model_BR$BR_ind)])

IOT_model_BR$BR_ind[is.na(IOT_model_BR$BR_ind)]=((BRimax+1):(BRimax+BRiblank))

#step 2. rowsum by aggregate function: take row sum
IOT_BR_row=aggregate(IOT_model_BR[,2:(nsector+nfd+1)],list(IOT_model_BR$BR_ind),FUN=sum)

#step 3. prepare for column sum
#(i)add group name and index to rowsum data 
## (i-1) prepare BR_name and index to add to rowsum data b/c character vector with group name was excluded in aggregation
BR_ind=data.frame(unique(cbind(IOT_model_BR$BR_ind,IOT_model_BR$BR_name)))
colnames(BR_ind)=c("BR_ind","BR_name")
##(i-2) add BR_name and change rowname
IOT_BR_row=merge(IOT_BR_row, BR_ind, by.x="Group.1", by.y="BR_ind", all=T)
rownames(IOT_BR_row)=IOT_BR_row$BR_name
##(i-3) getting rid of aggregate group indicator (1st variable) and Group_name variable, so thea we can apply aggregate function 
IOT_BR_row=IOT_BR_row[,-1*c(1, dim(IOT_BR_row)[2])]
##(i-4)Transpose
T_IOT_BR_row=data.frame(t(IOT_BR_row))

#step 4. colsum by aggregate function
#(i) prepare to merge with mapping index
##(i-1) prepare merging varible to merge with sector_group mapping
T_IOT_BR_row$sector=rownames(T_IOT_BR_row)
##(i-2) prepare index varible to sort after merging
T_IOT_BR_row$index=(1:dim(T_IOT_BR_row)[1])
##(i-3) merge with sector_BR mapping
T_IOT_BR_row=merge(T_IOT_BR_row,sec_BR, by.x="sector", by.y="sector_name", all=T,sort=F)
##(i-4) sort merged data to 'before-merge' order
T_IOT_BR_row=T_IOT_BR_row[order(T_IOT_BR_row$index),]
##(i-5) give rownames
rownames(T_IOT_BR_row)=T_IOT_BR_row$sector


#(ii) prepare variable for colum sum aggregation: prepare BR name and BR index to use in aggregate funciton
## Group name =Group name + Final demand elements
T_IOT_BR_row$BR_name[is.na(T_IOT_BR_row$BR_name)]=T_IOT_BR_row$sector[is.na(T_IOT_BR_row$BR_name)]
BRimax2=max(T_IOT_BR_row$BR_ind,na.rm=T)
BRiblank2=length(T_IOT_BR_row$BR_ind[is.na(T_IOT_BR_row$BR_ind)])
T_IOT_BR_row$BR_ind[is.na(T_IOT_BR_row$BR_ind)]=((BRimax2+1):(BRimax2+BRiblank2))
#ngroup=8
nBR=7
#(iii) column sum by aggregate function
T_IOT_BR=aggregate(T_IOT_BR_row[,2:(nBR+nva+1)],list(T_IOT_BR_row$BR_ind),FUN=sum)


#step 5. management after aggregation
#(i) add row names to aggregated data
##(i-1) prepare row names =BR name + final demand elements
BR_ind_name=data.frame(unique(cbind(T_IOT_BR_row$BR_ind,T_IOT_BR_row$BR_name)))
colnames(BR_ind_name)=c("BR_ind","BR_name")
##(i-2) merge row name data
T_IOT_BR=merge(T_IOT_BR, BR_ind_name, by.x="Group.1", by.y="BR_ind", all=T)
##(i-3) change row name
rownames(T_IOT_BR)=T_IOT_BR$BR_name
#(ii) Take transpose again to obtain BR IO data
IOT_BR=data.frame(t(T_IOT_BR[,-1*c(1,dim(T_IOT_BR)[2])]))

#checking balance
# total input + Resout = Total Demand
check5=as.numeric(IOT_BR["Tinput",(1:nBR)])+IOT_BR$Resout[(1:nBR)]+IOT_BR$Imp[(1:nBR)]-IOT_BR$Dtotal[(1:nBR)]
check6=IOT_BR$Qtotal[(1:nBR)]+IOT_BR$Qself[(1:nBR)]+IOT_BR$Resout[(1:nBR)]+IOT_BR$Imp[(1:nBR)]-IOT_BR$Dtotal[(1:nBR)]
check5
check6
write.csv(sec_BR,file="sector_agri_BR.csv")
write.csv(IOT_BR, file="IO_agri_BR.csv")