## This is temporary agriculture model SAM. Since it has to be linked to 2015 Bottom Up model, the grain ind (42) should be shared in Rice and Barley. 
## The new ind compostion in 2016, on the other hand, separate graining industry as Food industry. 
## If one industry is not in the agriculture in TD but in BU, then the cost differenetial is inevitable. 
## So we change the TD ind composition, so that Rice and Barley has same total cost in BU and TD.


## load sam aggregation function
#source("../GTAP_K_R/GTAP_K_R.r")
source("../IO/agg_agri_20160621.r")
source("../GHG/agg_ghg_agri_20160621.r")
source("sam_2010.r")
secter_BR=read.csv(file="sector_agri_BR.csv",header=T,as.is=T)

### A. Model SAM
## input should be prepared as follows.
#STEP 1: Size.SAM Determine the size of SAM   

ind=length(unique(secter_BR$sector_ind))
green=1
fac=2
h=1
gov=1
Nres=1
tax=4
S_I=1
ROW=1

Size.Sam=c(ind,green,fac,h,gov,Nres,tax,S_I,ROW)

#STEP 2: data.out : NON I-O data
#YTAX =current tax+ social contribution in individual use(2011, National Income. 'Income Account by institutional sectors') 
YTAX=(49205.3+115821.5)*1000
#TRANSFER =Social transfer in general government use (2011,National Income. 'Income Account by institutional sectors' )
TRANSFER=43360.5*1000

data.out=c(YTAX,TRANSFER)

# STEP 3: I-O data
##load I-O data (model)
IO_model=read.csv("IO_agri_model.csv",header=T, as.is=T)
rownames(IO_model)=IO_model[,1]
IO_model=IO_model[,-1]
# clean up IO: getting rid of subsums
n_totalrow=c("idinput1", "idinput2", "VA", "Tinput")
n_totalcol=c("Dint", "Dfin", "Dtotal", "Qtotal","Stotal_b","Contotal","Stotal_p" )
IO_model1=IO_model[is.na(match(rownames(IO_model),n_totalrow)),]
IO_model2=IO_model1[,is.na(match(colnames(IO_model),n_totalcol))]


DIO=as.matrix(IO_model2)

SAM_model=data.frame(SAM_agg_basic(Size.Sam,data.out,DIO))

m_ind_name=rownames(IO_model2)[1:ind]
m_Activity_name=paste(m_ind_name,"-a",sep="")
m_commodity_name=paste(m_ind_name,"-c",sep="")
factor_name=c("Labor","Capital")
Inst_name1=c("Household","GoV","NRES")
tax_name=c("Ptaxin","Ptaxetc","Tarrif","YTAX")
Inst_name2=c("S-I","ROW")
model_SAM_name=c(m_Activity_name,"CO2-a",m_commodity_name,"CO2-c",factor_name,Inst_name1,tax_name,Inst_name2)
rownames(SAM_model)=model_SAM_name
colnames(SAM_model)=model_SAM_name


### C. Boehringer and Rutherford SAM

ind_br=length(unique(secter_BR$BR_ind))
Size_br.Sam=c(ind_br,green,fac,h,gov,Nres,tax,S_I,ROW)

# I-O data_group
##load I-O data (Group)
IO_BR=read.csv("IO_agri_BR.csv",header=T, as.is=T)
rownames(IO_BR)=IO_BR[,1]
IO_BR=IO_BR[,-1]
# clean up IO: getting rid of subsums
n_totalrow=c("idinput1", "idinput2", "VA", "Tinput")
n_totalcol=c("Dint", "Dfin", "Dtotal", "Qtotal","Stotal_b","Contotal","Stotal_p" )
IO_BR1=IO_BR[is.na(match(rownames(IO_BR),n_totalrow)),]
IO_BR2=IO_BR1[,is.na(match(colnames(IO_BR),n_totalcol))]

DIO_BR=as.matrix(IO_BR2)

SAM_BR=data.frame(SAM_agg_basic(Size_br.Sam,data.out,DIO_BR))

br_ind_name=rownames(IO_BR2)[1:ind_br]
br_Activity_name=paste(br_ind_name,"-a",sep="")
br_commodity_name=paste(br_ind_name,"-c",sep="")
BR_SAM_name=c(br_Activity_name,"CO2-a",br_commodity_name,"CO2-c",factor_name,Inst_name1,tax_name,Inst_name2)
rownames(SAM_BR)=BR_SAM_name
colnames(SAM_BR)=BR_SAM_name

### D. add GHG total

GHG_model=read.csv(file="GHG_agri_model_p_20160621.csv",header=T,as.is=T)
#GHG_model[,(2:dim(GHG_model)[2])]=GHG_model[,(2:dim(GHG_model)[2])]/100000 # in 100,000 ton
rownames(GHG_model)=GHG_model$X

SAM_model=SAM_model/1000 #1,000,000,000 won

#replace negative capital cost to mimimum positive capital cost ratio to Total cost*total cost
KTC_ratio=SAM_model["Capital",1:ind]/colSums(SAM_model[,1:ind])
minK_ind=which(SAM_model["Capital",]<0)
altK=colSums(SAM_model[,1:ind])*min(KTC_ratio[KTC_ratio>0])
dK=altK-SAM_model["Capital",1:ind]

##step 1. change capital cost
SAM_model_k1=SAM_model
SAM_model_k1["Capital",minK_ind]=altK[minK_ind]
##Step 2. change ptaxin to make up for increased cost (government subsidy is given to guarantee mimimum surplus)
SAM_model_k2=SAM_model_k1
SAM_model_k2["Ptaxin",minK_ind]=SAM_model_k2["Ptaxin",minK_ind]-dK[minK_ind]
##Step 3. change household capital income (matching inreased capital cost)
SAM_model_k3=SAM_model_k2
SAM_model_k3["Household","Capital"]=sum(SAM_model_k3["Capital",])
##Step 4. change government ptaxin revenue (subtracting subsidy to guarantee miminum surplus)
SAM_model_k4=SAM_model_k3
SAM_model_k4["GoV","Ptaxin"]=sum(SAM_model_k4["Ptaxin",])
##Step 5. adjust household saving and government saving 
SAM_model_k5=SAM_model_k4
SAM_model_k5["S-I","Household"]=sum(SAM_model_k5["Household",])-(sum(SAM_model_k5[,"Household"])-SAM_model_k5["S-I","Household"])
SAM_model_k5["S-I","GoV"]=sum(SAM_model_k5["GoV",])-(sum(SAM_model_k5[,"GoV"])-SAM_model_k5["S-I","GoV"])

SAM_model_ng=SAM_model
SAM_model["CO2-c",(1:ind)]=as.numeric(GHG_model["Total",(2:(ind+1))])
SAM_model["GoV","CO2-a"]=sum(GHG_model["Total",(2:(ind+1))])
SAM_model["CO2-a","CO2-c"]=sum(GHG_model["Total",(2:(ind+1))])
SAM_model[(1:ind),"GoV"]=as.numeric(GHG_model["Total",(2:(ind+1))])

check_model=max(abs(colSums(SAM_model)-rowSums(SAM_model)))
check_model


SAM_model_ng_pos=SAM_model_k5
SAM_model_k5["CO2-c",(1:ind)]=as.numeric(GHG_model["Total",(2:(ind+1))])
SAM_model_k5["GoV","CO2-a"]=sum(GHG_model["Total",(2:(ind+1))])
SAM_model_k5["CO2-a","CO2-c"]=sum(GHG_model["Total",(2:(ind+1))])
SAM_model_k5[(1:ind),"GoV"]=as.numeric(GHG_model["Total",(2:(ind+1))])

check_model_5=max(abs(colSums(SAM_model_k5)-rowSums(SAM_model_k5)))
check_model_5


GHG_BR=read.csv(file="GHG_agri_BR_p_20160621.csv",header=T, as.is=T)
#GHG_BR[,(2:dim(GHG_BR)[2])]=GHG_BR[,(2:dim(GHG_BR)[2])]/100000 # in 100,000 ton
rownames(GHG_BR)=GHG_BR$X

SAM_br=SAM_BR/1000
SAM_br_ng=SAM_br
SAM_br["CO2-c",(1:ind_br)]=as.numeric(GHG_BR["Total",(2:(ind_br+1))])
SAM_br["GoV","CO2-a"]=sum(GHG_BR["Total",(2:(ind_br+1))])
SAM_br["CO2-a","CO2-c"]=sum(GHG_BR["Total",(2:(ind_br+1))])
SAM_br[(1:ind_br),"GoV"]=as.numeric(GHG_BR["Total",(2:(ind_br+1))])
check_br=max(abs(colSums(SAM_br)-rowSums(SAM_br)))
check_br

#write.csv(SAM_model_ng,file="b_sam_36_ng.csv")


#write.csv(SAM_model,file="b_sam_36_g.csv")
#write.csv(SAM_gr,file="b_sam_group_g.csv")
write.csv(SAM_br_ng,file="b_sam_agri_br_ng.csv")
write.csv(SAM_br,file="b_sam_agri_br_g.csv")

write.csv(SAM_model_ng_pos,file="b_sam_agri_model_ng_pos.csv")
write.csv(SAM_model_k5,file="b_sam_agri_model_g_pos.csv")

source("setwriting_agri_2016_alt.r")
#source("parameter.r")