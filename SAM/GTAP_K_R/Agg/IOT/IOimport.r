## This file does what sector.gms and IOimport.gms did
# (1) classifying IO entities
# (2) Construct variables using IO data
# (3) Enter Energy Balance entities
# (4) Save D1_'t'.Rdata (Data with IO variables)

t=2010
D_name0=paste(paste("D0",t,sep="_"),"Rdata",sep=".")
load(file=file.path("Agg/IOT",D_name0))
##(1) Construct IO variables

### (i) 82 industry mapping
io=unique(indindex_82[1:82,2])# model industry
mapi_G=indindex_82[1:82,1:2]# industry mapping
mapi_G$basecode_col=paste("X",mapi_G[,1],sep="")
ind_Transp_82=c(55,56)# Air and Water (international transportation included)


### (ii) 384 industry mapping
mapi_sec0=indindex_384[1:384,1:2]
mapi_sec0$basecode_col=paste("X",mapi_sec0[,1],sep="")


##(3) Classifying IO entities 


VAindex=indindex_82[!is.na(indindex_82$Va_index),c("Va_index", "Va_name", "Va_dict")]
FDindex=indindex_82[!is.na(indindex_82$FD_index),c("FD_index", "FD_name","FD_dict")]

Fin_Demand=c("Final_Pc", "Final_Gc","Final_Pk", "Final_Gk","Final_St", "Gold", "Final_Ex", "Final_Tot")
VA=c("PTAXin","labor","surplus","dep","PTAXetc")
VA_0=VA[VA!="PTAXin"]# Va without tax
FACT=c("labor", "dep","surplus") # production factor
PTAXVA=c("PTAXin","PTAXout") # tax in va
Fin_DD=c("Final_Pc", "Final_Gc","Final_Pk", "Final_Gk","Final_St", "Gold")#Domestic Demand
Fin_DX=c("Final_Ex") #Foreign Demand
Fin_K=c("Final_Pk", "Final_Gk","Final_St", "Gold")#Investment demand
resout=c("Resout")
resin=c("Resin")

## Non io entities
R0=c("China","EUR","India","Japan","Korea","LAF","MEA","OEU","OTH","SEA","USA")
FP=c("Land","Capital","Lab","NatRes","RNDsvs")#Production Factor in model



# (5) Construct variablbes using IO data

##(0) assign VA names and FD names to IO tables

n1=82# number of industries
n2=384 # number of industies
### Total (82)
DimT_82=dim(IO_T_N_82)
rownames(IO_T_N_82)[((n1+1):DimT_82[1])]=VAindex[,"Va_name"]
colnames(IO_T_N_82)[((n1+2):DimT_82[2])]=FDindex[,"FD_name"]
rownames(IO_T_B_82)[((n1+1):DimT_82[1])]=VAindex[,"Va_name"]
colnames(IO_T_B_82)[((n1+2):DimT_82[2])]=FDindex[,"FD_name"]

DimMD_82=dim(IO_D_N_82)

### Domestic (82)
rownames(IO_D_N_82)[((n1+1):DimMD_82[1])]=VAindex[(1:(DimMD_82[1]-n1)),"Va_name"]
colnames(IO_D_N_82)[((n1+2):DimMD_82[2])]=FDindex[(1:(DimMD_82[2]-(n1+1))),"FD_name"]
rownames(IO_D_B_82)[((n1+1):DimMD_82[1])]=VAindex[(1:(DimMD_82[1]-n1)),"Va_name"]
colnames(IO_D_B_82)[((n1+2):DimMD_82[2])]=FDindex[(1:(DimMD_82[2]-(n1+1))),"FD_name"]

#### Import (82)
rownames(IO_M_N_82)[((n1+1):DimMD_82[1])]=VAindex[(1:(DimMD_82[1]-n1)),"Va_name"]
colnames(IO_M_N_82)[((n1+2):DimMD_82[2])]=FDindex[(1:(DimMD_82[2]-(n1+1))),"FD_name"]
rownames(IO_M_B_82)[((n1+1):DimMD_82[1])]=VAindex[(1:(DimMD_82[1]-n1)),"Va_name"]
colnames(IO_M_B_82)[((n1+2):DimMD_82[2])]=FDindex[(1:(DimMD_82[2]-(n1+1))),"FD_name"]

### Total(384)
DimT_384=dim(IO_T_N_384)
rownames(IO_T_N_384)[((n2+1):DimT_384[1])]=VAindex[,"Va_name"]
colnames(IO_T_N_384)[((n2+2):DimT_384[2])]=FDindex[,"FD_name"]
rownames(IO_T_B_384)[((n2+1):DimT_384[1])]=VAindex[,"Va_name"]
colnames(IO_T_B_384)[((n2+2):DimT_384[2])]=FDindex[,"FD_name"]

### Domestic(384)
DimMD_384=dim(IO_D_N_384)
rownames(IO_D_N_384)[((n2+1):DimMD_384[1])]=VAindex[(1:(DimMD_384[1]-n2)),"Va_name"]
colnames(IO_D_N_384)[((n2+2):DimMD_384[2])]=FDindex[(1:(DimMD_384[2]-(n2+1))),"FD_name"]
rownames(IO_D_B_384)[((n2+1):DimMD_384[1])]=VAindex[(1:(DimMD_384[1]-n2)),"Va_name"]
colnames(IO_D_B_384)[((n2+2):DimMD_384[2])]=FDindex[(1:(DimMD_384[2]-(n2+1))),"FD_name"]

#### Import(384)
rownames(IO_M_N_384)[((n2+1):DimMD_384[1])]=VAindex[(1:(DimMD_384[1]-n2)),"Va_name"]
colnames(IO_M_N_384)[((n2+2):DimMD_384[2])]=FDindex[(1:(DimMD_384[2]-(n2+1))),"FD_name"]
rownames(IO_M_B_384)[((n2+1):DimMD_384[1])]=VAindex[(1:(DimMD_384[1]-n2)),"Va_name"]
colnames(IO_M_B_384)[((n2+2):DimMD_384[2])]=FDindex[(1:(DimMD_384[2]-(n2+1))),"FD_name"]

##(i) 82 ind
###(i-1) A table 

A_T_N_82=IO_T_N_82[1:n1,(2:(n1+1))]
A_D_N_82=IO_D_N_82[1:n1,(2:(n1+1))]
A_M_N_82=IO_M_N_82[1:n1,(2:(n1+1))]

A_T_B_82=IO_T_B_82[1:n1,(2:(n1+1))]
A_D_B_82=IO_D_B_82[1:n1,(2:(n1+1))]
A_M_B_82=IO_M_B_82[1:n1,(2:(n1+1))]

###(i-2) Final demand

F_T_N_82=IO_T_N_82[1:n1,!is.na(match(colnames(IO_T_N_82),Fin_Demand))]
F_D_N_82=IO_D_N_82[1:n1,!is.na(match(colnames(IO_T_N_82),Fin_Demand))]
F_M_N_82=IO_M_N_82[1:n1,!is.na(match(colnames(IO_T_N_82),Fin_Demand))]

F_T_B_82=IO_T_B_82[1:n1,!is.na(match(colnames(IO_T_N_82),Fin_Demand))]
F_D_B_82=IO_D_B_82[1:n1,!is.na(match(colnames(IO_T_N_82),Fin_Demand))]
F_M_B_82=IO_M_B_82[1:n1,!is.na(match(colnames(IO_T_N_82),Fin_Demand))]

###(i-3) Import taxes (No tarrif)
Tar10=rep(0,n1)
TaxM10=data.frame(IO_T_N_82[1:n1,"PTAXim"])
colnames(TaxM10)="PTAXim"
Tar0=Tar10
Tar000=Tar0
TaxM0=TaxM10
TaxM000=TaxM10


###(i-4) Total (Domestic) output = Intermediate input + VA + Resin-Resout
output=c("Qtotal","Qself","PTAXd","Psub","Cmargin","Tmargin")
xpnorm10=IO_T_N_82[1:n1,!is.na(match(colnames(IO_T_N_82),output))]
xpb10=IO_T_B_82[1:n1,!is.na(match(colnames(IO_T_B_82),output))]

xpnorm=data.frame(rowSums(xpnorm10))
colnames(xpnorm)="xpnorm"
XP_B=data.frame(rowSums(xpb10))
colnames(XP_B)="XP_B"

###(i-5) Scrap in (Scrap in row ), Scrap out (Scrap in column)
#### Scrap in
XPN_resin=data.frame(t(IO_T_N_82["Resin",2:(n1+1)]))
XPB_resin=data.frame(t(IO_T_B_82["Resin",2:(n1+1)]))
####Scrap out

XPN_resout=data.frame(IO_T_N_82[1:n1,"Resout"])
colnames(XPN_resout)="Resout"
XPB_resout=data.frame(IO_T_B_82[1:n1,"Resout"])
colnames(XPB_resout)="Resout"
###(i-6) VA : VA is in IO_T_N, IO_T_B only. We use V_N for producers' price and V_B for basic price.
V_N_82=IO_T_N_82[!is.na(match(rownames(IO_T_N_82),VA)),2:(n1+1)]
V_B_82=IO_T_B_82[!is.na(match(rownames(IO_T_B_82),VA)),2:(n1+1)]

### Since we don't have separate subsidies, we don't integrate tax and subsidy in V_N and V_B
### subsidies, however, can be recovered from IO_T_N . The Psub column is subsidy

##(ii) 384 ind
###(ii-1) A table 

A_T_N_384=IO_T_N_384[1:n2,(2:(n2+1))]
A_D_N_384=IO_D_N_384[1:n2,(2:(n2+1))]
A_M_N_384=IO_M_N_384[1:n2,(2:(n2+1))]

A_T_B_384=IO_T_B_384[1:n2,(2:(n2+1))]
A_D_B_384=IO_D_B_384[1:n2,(2:(n2+1))]
A_M_B_384=IO_M_B_384[1:n2,(2:(n2+1))]

###(ii-2) Final demand

F_T_N_384=IO_T_N_384[1:n2,!is.na(match(colnames(IO_T_N_384),Fin_Demand))]
F_D_N_384=IO_D_N_384[1:n2,!is.na(match(colnames(IO_T_N_384),Fin_Demand))]
F_M_N_384=IO_M_N_384[1:n2,!is.na(match(colnames(IO_T_N_384),Fin_Demand))]

F_T_B_384=IO_T_B_384[1:n2,!is.na(match(colnames(IO_T_N_384),Fin_Demand))]
F_D_B_384=IO_D_B_384[1:n2,!is.na(match(colnames(IO_T_N_384),Fin_Demand))]
F_M_B_384=IO_M_B_384[1:n2,!is.na(match(colnames(IO_T_N_384),Fin_Demand))]

###(ii-3) Import taxes (No tarrif)
Tar_0=rep(0,n2)
TaxM_0=data.frame(IO_T_N_384[1:n2,"PTAXim"])
colnames(TaxM_0)="PTAXim"


###(ii-4) Total (Domestic) output = Intermediate input + VA + Resin-Resout
#output=c("Qtotal","Qself","PTAXd","Psub","Cmargin","Tmargin")
XP_00=IO_T_N_384[1:n2,!is.na(match(colnames(IO_T_N_384),output))]
XP_B00=IO_T_B_384[1:n2,!is.na(match(colnames(IO_T_B_384),output))]

XP_0=data.frame(rowSums(XP_00))
colnames(XP_0)="XP_0"
XP_B0=data.frame(rowSums(XP_B00))
colnames(XP_B0)="XP_B0"
###(ii-5) Scrap in (Scrap in row ), Scrap out (Scrap in column)
#### Scrap in
resin_0=data.frame(t(IO_T_N_384["Resin",2:(n2+1)]))
resin_b0=data.frame(t(IO_T_B_384["Resin",2:(n2+1)]))
####Scrap out

resout_0=data.frame(IO_T_N_384[1:n2,"Resout"])
colnames(resout_0)="Resout"
resout_b0=data.frame(IO_T_B_384[1:n2,"Resout"])
colnames(resout_b0)="Resout"

###(ii-6) VA : VA is in IO_T_N, IO_T_B only. We use V_N for producers' price and V_B for basic price.
V_N_384=IO_T_N_384[!is.na(match(rownames(IO_T_N_384),VA)),2:(n2+1)]
V_B_384=IO_T_B_384[!is.na(match(rownames(IO_T_B_384),VA)),2:(n2+1)]



# (5) Energy Balance entities

##(5-1)IO Energy industries (384 industry)
#0026           "Anthracite"
#0027           "Bituminous coal"
#0028           "Crude petroleum"
#0029           "Natural gas"
#0100           "Coal briquettes"
#0099           "Coke and other coal products"
#0101           "Naphtha"
#0102           "Gasoline"
#0103           "Jet oil"
#0104           "Kerosene"
#0105           "Light oil"
#0106           "Heavy oil"
#0107           "Liquefied petroleum gas"
#0108           "Refined mixture for fuel oil"
#0109           "Lubricants and Grease"
#0110           "Misc. petroleum refinery products"
#0274           "Hydro power generation"
#0275           "thermal power generation"
#0276           "nuclear power generation"
#0277           "self generation electricity"
#0278           "New Renewable Energy"
#0279           "Manufactured gas supply"
#0280           "Steam and hot water supply"

ENG_N=c(26:29,99,100:110,274:280)

ENGind_index=indindex_384[ENG_N,1:2]
ENGind_index$basecode_col=paste("X",ENGind_index$basecode_row,sep="")





#save
names_IO=c("IO_T_N_82","IO_D_N_82","IO_M_N_82","IO_T_N_384","IO_D_N_384","IO_M_N_384","IO_T_B_82","IO_D_B_82","IO_M_B_82","IO_T_B_384","IO_D_B_384","IO_M_B_384")
names_index=c("indindex_82","io","mapi_G","ind_Transp_82","indindex_384","mapi_sec0","VAindex","FDindex","Fin_Demand","VA","VA_0","FACT","PTAXVA","Fin_DD","Fin_DX","Fin_K","resout","resin","R0","FP","output")
names_82=c("A_T_N_82","A_D_N_82","A_M_N_82","A_T_B_82","A_D_B_82","A_M_B_82","F_T_N_82","F_D_N_82","F_M_N_82","F_T_B_82","F_D_B_82","F_M_B_82","Tar10","TaxM10","Tar0","Tar000","TaxM0","TaxM000","xpnorm10","xpb10","xpnorm","XP_B","XPN_resin","XPB_resin","XPN_resout","XPB_resout","V_N_82","V_B_82")
names_384=c("A_T_N_384","A_D_N_384","A_M_N_384","A_T_B_384","A_D_B_384","A_M_B_384","F_T_N_384","F_D_N_384","F_M_N_384","F_T_B_384","F_D_B_384","F_M_B_384","Tar_0","TaxM_0","XP_00","XP_B00","XP_0","XP_B0","resin_0","resin_b0","resout_0","resout_b0","V_N_384","V_B_384")
names_ENG=c("ENGind_index","EBS")


D_name1=paste(paste("D1",t,sep="_"),"Rdata",sep=".")
save(list=c(names_IO,names_index,names_82,names_384,names_ENG),file=D_name1)
# load(file=D_name1)