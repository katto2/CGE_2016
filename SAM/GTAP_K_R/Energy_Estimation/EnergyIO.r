#This file replace Energy_Estimation_KSW.gms
## (1)Load Data and conversion factor CF (Total Energy => Net Energy)
## (2)Convert EBS using CF
## (3)Assign Energy consumption to IO sector 

################(1)Load Data#########################################
t=2010
D_name1=paste(paste("D1",t,sep="_"),"Rdata",sep=".")
load(D_name1)
##conversion factor
CF=read.csv(file=file.path("Energy_Estimation","Heatconf.csv"), header=T,as.is=T)

###############(2)Convert EBS using CF###############################
EBS_LLH=EBS
EBS_LLH[,!is.na(match(colnames(EBS),CF$ED))]=as.matrix(EBS[,!is.na(match(colnames(EBS),CF$ED))])%*%diag(CF$CF)
#(2-1) Exclude international transportation from Water_t and Air_t
GTAPBASE=1
if (GTAPBASE==1){
EBS_LLH["Water_t",]=0 # all water transportation is international transportation
EBS_LLH["Air_t",]=EBS_LLH["Air_t",]*((8483279-2431664)/8483270)

#(2-2)adjusting subsums of energy demand
EBS_LLH["Transport",]=colSums(EBS_LLH[c("Rail_t","Land_t","Water_t","Air_t"),])
EBS_LLH["F_con",]=colSums(EBS_LLH[c("Ind","Transport","Residential","Commercial","Public"),])
EBS_LLH["P_con",]=EBS_LLH["F_con",]-EBS_LLH["Transform",]
}

#(2-3)adjusting subsums of energy carrier
EBS_LLH[,"AnthraT"]=rowSums(EBS_LLH[,c("AnthraD","AnthraIm")])
EBS_LLH[,"BituT"]=rowSums(EBS_LLH[,c("BituCoke","BituSteam")])
EBS_LLH[,"CoalT"]=rowSums(EBS_LLH[,c("AnthraT","BituT")])
PetE=c("Gasoline","Kerosene","Diesel","BA","BB","BC","JA1","JP4","AVIG")
PetNE=c("Naphta","Solvent","Asphalt","Lubricant","ParaWax","PetroCoke","OtherProd")
EBS_LLH[,"PetroENG"]=rowSums(EBS_LLH[,PetE])
EBS_LLH[,"PetroNENG"]=rowSums(EBS_LLH[,PetNE])
EBS_LLH[,"LPG"]=rowSums(EBS_LLH[,c("Propane","Butane")])
EBS_LLH[,"PetroT"]=rowSums(EBS_LLH[,c("PetroENG","LPG","PetroNENG")])
EBS_LLH[,"TotalE"]=rowSums(EBS_LLH[,c("CoalT","PetroT",colnames(EBS_LLH[,(30:36)]))])

#################(3)Matching energy balance with IO Energy industry##################################

##IO Energy industries (384 industry)
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

con_totB=data.frame(rowSums(A_T_B_384)+F_T_B_384[,"Final_Pc"])
con_ene=data.frame(rep(0,dim(ENGind_index)[1]))
rownames(con_ene)=ENGind_index$basecode_col
colnames(con_ene)="con_ene"

rownames(con_totB)=paste("X",(1:384),sep="")
colnames(con_totB)="con_totB"

con_ene["X26",]=EBS_LLH["P_con","AnthraT"]
con_ene["X27",]=EBS_LLH["P_con","BituT"]
con_ene["X29",]=EBS_LLH["P_con","LNG"]
con_ene["X100",]=EBS_LLH["Residential","AnthraT"]
con_ene["X101",]=EBS_LLH["P_con","Naphta"]
con_ene["X102",]=EBS_LLH["P_con","Gasoline"]
con_ene["X103",]=EBS_LLH["P_con","JA1"]#JP-4 is for military use AVI-G is used in small airplanes not using jet engine
con_ene["X104",]=EBS_LLH["P_con","Kerosene"]
con_ene["X105",]=EBS_LLH["P_con","Diesel"]
con_ene["X106",]=sum(EBS_LLH["P_con",c("BA","BB","BC")])
con_ene["X107",]=EBS_LLH["P_con","LPG"]
con_ene["X108",]=EBS_LLH["P_con","Lubricant"]*con_totB["X108",]/sum(con_totB[c("X108","X109"),])
con_ene["X109",]=EBS_LLH["P_con","Lubricant"]*con_totB["X109",]/sum(con_totB[c("X108","X109"),])
con_ene["X110",]=sum(EBS_LLH["P_con",c("PetroCoke","OtherProd")])
con_ene["X274",]=EBS_LLH["P_con","Hydro"]*(860/2150)
con_ene["X276",]=EBS_LLH["P_con","Nuclear"]*(860/2150)
con_ene["X279",]=EBS_LLH["P_con","LNG"]
#LNG energy double counting. In IO, LNG is used 100% in City gas production. But in E_balance LNG is used in electricity generation.
#con_ene["X29",]=EBS_LLH["P_con","LNG"] This energy is LNG used in City Gas
#con_ene["X279",]=EBS_LLH["P_con","LNG"] This energy is energy used in City Gas form. But this also includes LNG in electricity generation.

#Heat = Steam and Hot Warter
HeatE=data.frame(EBS_LLH[,"Heat"])
rownames(HeatE)=rownames(EBS_LLH)
colnames(HeatE)="Heat"
E_Exit=c("Export","IntBunk","Stock_d")
E_Transf=c("E_Gene","Heating","Gas_Manu","OwnUse")

con_ene["X280",]=HeatE["F_con",]-sum(HeatE[E_Exit,])-(sum(HeatE[E_Transf,]*as.numeric(HeatE[E_Transf,]<0)))
## We add non electricity renewables to Heat and Hot water (b/c we add all renewable P_con to Heat in 2005 version)
con_ene["X280",]=con_ene["X280",]+EBS_LLH["P_con","Renewable"]+EBS_LLH["E_Gene","Renewable"]*(as.numeric(EBS_LLH["E_Gene","Renewable"]<0))

# Coke and other coal product Energy
#= Bituminous coal E used in the form of other prodcuts 
#= Bituminous coal E not used in Generation 
#* Money used in Other product production for Bituminous coal/Money used for Bitumious coal except for generation

con_ene["X99",]=sum(EBS_LLH[c("P_con","E_Gene"),"BituT"])*A_T_B_384[27,99]/(con_totB["X27",]-A_T_B_384[27,275])

# Thermal power generation and self generation = E generation -Hydro - Nuclear - Renewable generation
## Thermal power generatin = E generation -Hydro - Nuclear - Renewable generation Energy *(Money Spent in thermal power)/Money Spent in thermal power and self-generation
## self generatin = E generation -Hydro - Nuclear - Renewable generation Energy *(Money Spent in self generation)/Money Spent in thermal power and self-generation

ElecE=data.frame(EBS_LLH[,"Elect"])
rownames(ElecE)=rownames(EBS_LLH)
colnames(ElecE)="ElecE"

Elec_Fossil=ElecE["F_con",]-sum(ElecE[E_Exit,])-(sum(ElecE[E_Transf,]*as.numeric(ElecE[E_Transf,]<0))) - con_ene["X274",]-con_ene["X276",]+EBS_LLH["E_Gene","Renewable"]*as.numeric(EBS_LLH["E_Gene","Renewable"]<0)

con_ene["X275",]=Elec_Fossil*con_totB["X275",]/sum(con_totB[c("X275","X277"),])
con_ene["X277",]=Elec_Fossil*con_totB["X277",]/sum(con_totB[c("X275","X277"),])


# Renewable energy : Previously assigned to heat. Now we assign renewable energy demand in Electricity to Renewable industry b/c renewable in 2010 IO only covers electricity generation.

#con_ene["X278",]=EBS_LLH["P_con","Renewable"]
con_ene["X278",]=-1*EBS_LLH["E_Gene","Renewable"]

E_name1=paste(paste("IO_E",t,sep="_"),"Rdata",sep=".")

save(list=ls(), file=E_name1)
