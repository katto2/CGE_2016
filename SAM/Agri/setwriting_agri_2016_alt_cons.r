#This file follows "setwriting_agri_2016.r". 

## This is temporary agriculture model set. Since it has to be linked to 2015 Bottom Up model, the grain ind (42) should be shared in Rice and Barley. 
## The new ind compostion in 2016, on the other hand, separate graining industry as Food industry. 
## If one industry is not in the agriculture in TD but in BU, then the cost differenetial is inevitable. 
## So we change the TD ind composition, so that Rice and Barley has same total cost in BU and TD.

#sam_model=read.csv(file="b_sam_model_ng_pos.csv",header=T,as.is=T)
#ghg=read.csv(file="GHG_model_p_20160621.csv",header=T,as.is=T)
sam_model=read.csv(file="b_sam_agri_model_ng_pos_cons.csv",header=T,as.is=T)
ghg=read.csv(file="GHG_agri_model_process_cons.csv",header=T,as.is=T)

sec_dict=read.csv(file="sector_agri_BR.csv",header=T,as.is=T)
nsector=length(unique(sec_dict$sector_ind))
samsize=c(nsector,1,2,1,1,1,4,1,1,1)
Tmax=25
Link="unLink"
#mode=2
if(Link=="Link"){if (Tmax==0) {filename="set_agri_static_link_2016_alt_cons.txt"} else  {filename="set_agri_recursive_link_2016_alt_cons.txt"}} else {if (Tmax==0) {filename="set_agri_static_nonlink_2016_alt_cons.txt"} else  {filename="set_agri_recursive_nonlink_2016_alt_cons.txt"}}
ENC=c("GAS-c","Gasoline-c","Jetoil-c",       "Diesel-c",       "Kerosene-c",     "Fueloil-c",      "LPG-c","Oilpro-c","CoalPro-c","Coal-c","Oil-c","LNG-c" )
ELECC=c("ELEC-c","HEAT-c")
Sfuel=c("CoalPro-c","Coal-c")

Transition=c("ELEC","HEAT")
Elecg=c("ELEC")
Gasg=c("GAS","LNG")
Heatg=c("HEAT")
Oilg=c("Gasoline","Jetoil",       "Diesel",       "Kerosene",     "Fueloil",      "LPG","Oilpro" )
Coalg=c("CoalPro","Coal")
AGRIC=c("Rice-c",	"Barley-c",	"Bean-c",	"Potato-c",	"Vegi-c",	"Fruit-c",	"Flower-c",	"MissCrop-c",	"Dairy-c",	"Meat-c",	"Pork-c",	"Poultry-c",	"MissLstock-c")
AGRIA=c("Rice-a",	"Barley-a",	"Bean-a",	"Potato-a",	"Vegi-a",	"Fruit-a",	"Flower-a",	"MissCrop-a",	"Dairy-a",	"Meat-a",	"Pork-a",	"Poultry-a",	"MissLstock-a")
LinkC=c("Rice-c",	"Barley-c",	"Bean-c",	"Potato-c",	"Vegi-c",	"Fruit-c",	"Flower-c",	"MissCrop-c",	"Dairy-c",	"Meat-c",	"Pork-c",	"Poultry-c",	"MissLstock-c")
LinkA=c("Rice-a",	"Barley-a",	"Bean-a",	"Potato-a",	"Vegi-a",	"Fruit-a",	"Flower-a",	"MissCrop-a",	"Dairy-a",	"Meat-a",	"Pork-a",	"Poultry-a",	"MissLstock-a")

if(Link!="Link"){LinkC=NULL}
if(Link!="Link"){LinkA=NULL}




source("HC.r")
sink(file=filename)
# (1) preperation


## set column and low names with variable names
### take the first column containing variable names and remove empty spaces
samnames=sam_model[,1]
samnames=sub("[[:space:]]+$","",samnames)
ghgnames=ghg[,1]
ghgnames=sub("[[:space:]]+$","",ghgnames)
#ghgnames=c(paste(ghgnames[1:(length(ghgnames)-2)], "-c",sep=""),ghgnames[(length(ghgnames)-1):length(ghgnames)])
#ghgnames=c("GAS-c",  "ROIL-c", "CoalPro-c", "Coal-c",   "Process", "Total")
### remove the first column from the data seet
sam_model=sam_model[,(2:(dim(sam_model)[2]))]
ghg=ghg[,(2:(dim(ghg)[2]))]
### replace column names with variable names
colnames(sam_model)=samnames
### replace row names with variable names
rownames(sam_model)=samnames
rownames(ghg)=ghgnames
sam_model.raw=sam_model
### indicating size

ind=samsize[1]
green=samsize[2]
fac=samsize[3]
hh=samsize[4]
gov=samsize[5]
Nres=samsize[6]
tax=samsize[7]
S_I=samsize[8]
ROW=samsize[9]
Total=samsize[10]

#ACTP: all entry
ACTP=unique(c(samnames,ghgnames))
setwords=function(setname,domain,x){paste(setname,"(",domain,") /", HC.com(x)," /",sep='')}
ACTP.words=paste("ACTP"," /",HC.com(ACTP)," /",sep='')
cat(ACTP.words, sep='\n')


#ACT=ACT-"process"
#ACT=setdiff(ACTP,setdiff(ghgnames,samnames))
ACT=ACTP[ACTP!="Process"]
ACT.words=setwords("ACT", "ACTP",ACT)
#ACNT: null set
ACNT.words="ACNT(ACT)"
cat(ACT.words, sep='\n')
cat(ACNT.words, sep='\n')

#ghg dataset entry
#GOT=ghgnames
#GO=ghgnames[ghgnames!="Total"]
#GOT.words=setwords("GOT","ACTP",GOT)
#GO.words=setwords("GO","GOT",GO)
#cat(GOT.words, sep='\n')
#cat(GO.words, sep='\n')


#modification of whole entry
AC=ACT[ACT!="Total"]
ACNGT=ACT[(ACT!="CO2-a")&(ACT!="CO2-c")]
ACNGA=ACNGT[ACNGT!="Total"]
AC.words=setwords("AC","ACT",AC)
ACNGT.words=setwords("ACNGT","ACT",ACNGT)
ACNGA.words=setwords("ACNGA","AC",ACNGA)
cat(AC.words, sep='\n')
cat(ACNGT.words, sep='\n')
cat(ACNGA.words, sep='\n')


#Activity and Commodity
Activity=AC[1:ind]
Commodity=AC[(ind+green+1):(2*(ind)+green)]
Activity.words=setwords("A","AC",Activity)
Commodity.words=setwords("C","AC",Commodity)
cat(Activity.words,sep='\n')
cat(Commodity.words,sep='\n')

#IO AV section
AV=sam_model[,Activity]

#ENC : Energy commodities
ENCN=setdiff(Commodity,ENC)
ENC.words=setwords("ENC","C",ENC)
ENCN.words=setwords("ENCN","C",ENCN)
cat(ENC.words, sep='\n')
cat(ENCN.words, sep='\n')

#AgriC: Agriculture commodities AgirA:Agriculture Activities
AgriC.words=setwords("AgriC","C",AGRIC)
AgriA.words=setwords("AGriA","A",AGRIA)
cat(AgriC.words, sep='\n')
cat(AgriA.words, sep='\n')

#LinkC: Linked commodities AgirA:Linked Activities
LinkC.words=setwords("LinkC","C",LinkC)
LinkA.words=setwords("LinkA","A",LinkA)
if (Link!="Link"){cat("$onempty",sep='\n')}
cat(LinkC.words, sep='\n')
cat(LinkA.words, sep='\n')
if (Link!="Link"){cat("$offempty",sep='\n')}


#Sfuel : Solid Fuel commodities
Sfuel.words=setwords("Sfuel","C",Sfuel)
cat(Sfuel.words,sep="\n")

#Lfuel : Liqoud Fuel commodities
Lfuel=setdiff(ENC,Sfuel)
Lfuel.words=setwords("Lfuel","C",Lfuel)
cat(Lfuel.words,sep="\n")


#ELECC: Electricity, ENERGY=ENC and ELECC, Material (M)=commodity - ENergy

ENERGY=c(ELECC,ENC)
ELECC.words=setwords("ELECC","C",ELECC)
cat(ELECC.words,sep="\n")
M=setdiff(Commodity,ENERGY)
M.words=setwords("M","C",M)
cat(M.words, sep='\n')


#Commodity and Activity Sets for energy gropus: Transition. Electricity. Gas. Heat. Oil. Coal


Transition.c=paste(Transition,"-c",sep="")
Elecg.c=paste(Elecg,"-c",sep="")
Gasg.c=paste(Gasg,"-c",sep="")
Heatg.c=paste(Heatg,"-c",sep="")
Oilg.c=paste(Oilg,"-c",sep="")
Coalg.c=paste(Coalg,"-c",sep="")

Transition.a=paste(Transition,"-a",sep="")
Elecg.a=paste(Elecg,"-a",sep="")
Gasg.a=paste(Gasg,"-a",sep="")
Heatg.a=paste(Heatg,"-a",sep="")
Oilg.a=paste(Oilg,"-a",sep="")
Coalg.a=paste(Coalg,"-a",sep="")

Transition.c.words=setwords("TransitionC","C",Transition.c)
Elecg.c.words=setwords("ElecgC","C",Elecg.c)
Gasg.c.words=setwords("Gasgc","C",Gasg.c)
Heatg.c.words=setwords("HeatgC","C",Heatg.c)
Oilg.c.words=setwords("Oilgc","C",Oilg.c)
Coalg.c.words=setwords("Coalgc","C",Coalg.c)

cat(Transition.c.words,sep="\n")
cat(Elecg.c.words,sep="\n")
cat(Gasg.c.words,sep="\n")
cat(Heatg.c.words,sep="\n")
cat(Oilg.c.words,sep="\n")
cat(Coalg.c.words,sep="\n")

Transition.a.words=setwords("TransitionA","A",Transition.a)
Elecg.a.words=setwords("ElecgA","A",Elecg.a)
Gasg.a.words=setwords("GasgA","A",Gasg.a)
Heatg.a.words=setwords("HeatgA","A",Heatg.a)
Oilg.a.words=setwords("OilgA","A",Oilg.a)
Coalg.a.words=setwords("CoalgA","A",Coalg.a)

cat(Transition.a.words,sep="\n")
cat(Elecg.a.words,sep="\n")
cat(Gasg.a.words,sep="\n")
cat(Heatg.a.words,sep="\n")
cat(Oilg.a.words,sep="\n")
cat(Coalg.a.words,sep="\n")


#For each commodity, define uique set
#Comset_name_1=paste(substring(setdiff(Commodity,ENC),1,6),"C(C) /",sep="")
Comset_name_1=paste(substring(setdiff(Commodity,ENC),1,(nchar(setdiff(Commodity,ENC))-2)),"C_s(C) /",sep="")
Comset_name_2=paste(substring(ENC,1,(nchar(ENC)-2)),"ac_s(C) /",sep="")
Comset_name=c(Comset_name_1,Comset_name_2)
Comset_set=c(setdiff(Commodity,ENC),ENC)
Comset.words=paste(paste(Comset_name,Comset_set,sep=""),"/",sep="")
cat(Comset.words, sep='\n')



#Contingency set of ELECC mix for each Activity
QINT_ELECC=sam_model[ELECC,Activity]
ELECCpattern=lapply(QINT_ELECC,function(x){rownames(QINT_ELECC)[x>0]})
ELECCpattern=ELECCpattern[mapply(FUN=length,ELECCpattern)>0]
#ELECCpattern=mapply(function(x){rownames(QINT_ELECC)[x>0]},QINT_ELECC)

Elecc.A={}
for (i in (1:length(ELECCpattern))){
  #Fuel.A_i=HC.com(names(fuelpattern.v)[fuelpattern.v==fuelpattern_u.v[i]])
  Elecc.A_i=paste(paste(names(ELECCpattern)[i],HC.com(ELECCpattern[[i]]),sep=".("),")")
  Elecc.A=rbind(Elecc.A,Elecc.A_i)
}
cat("EleccA(A,C)",sep="\n")
cat("/",sep="\n")
cat(Elecc.A,sep="\n")
cat("/",sep="\n")
                            
#Contingency set of fuel mix for each Activity

QINT_FUEL=sam_model[ENC,Activity]

fuelpattern=mapply(function(x){rownames(QINT_FUEL)[x>0]},QINT_FUEL)

Fuel.A={}
for (i in (1:ind)){
                            #Fuel.A_i=HC.com(names(fuelpattern.v)[fuelpattern.v==fuelpattern_u.v[i]])
                            Fuel.A_i=paste(paste(names(fuelpattern)[i],HC.com(fuelpattern[[i]]),sep=".("),")")
                            Fuel.A=rbind(Fuel.A,Fuel.A_i)
}
cat("FuelA(A,C)",sep="\n")
cat("/",sep="\n")
cat(Fuel.A,sep="\n")
cat("/",sep="\n")



#Greenhouse gas.Commodity
GC="CO2-c"
GC.words=setwords("GC","AC",GC)
cat(GC.words, sep='\n')

# contingency set of sfuel mix for Activity

QINT_SFUEL=sam_model[Sfuel,Activity]
sfuelpattern=lapply(QINT_SFUEL,function(x){rownames(QINT_SFUEL)[x>0]})
sfuelpattern=sfuelpattern[mapply(FUN=length,sfuelpattern)>0]
SFuel.A={}
for (i in (1:length(sfuelpattern))){
  #Fuel.A_i=HC.com(names(fuelpattern.v)[fuelpattern.v==fuelpattern_u.v[i]])
  SFuel.A_i=paste(paste(names(sfuelpattern)[i],HC.com(sfuelpattern[[i]]),sep=".("),")")
  SFuel.A=rbind(SFuel.A,SFuel.A_i)
}
cat("SFuelA(A,C)",sep="\n")
cat("/",sep="\n")
cat(SFuel.A,sep="\n")
cat("/",sep="\n")

# contingency set of Lfuel mix for Activity

QINT_LFUEL=sam_model[Lfuel,Activity]
Lfuelpattern=lapply(QINT_LFUEL,function(x){rownames(QINT_LFUEL)[x>0]})
Lfuelpattern=Lfuelpattern[mapply(FUN=length,Lfuelpattern)>0]
LFuel.A={}
for (i in (1:length(Lfuelpattern))){
  #Fuel.A_i=HC.com(names(fuelpattern.v)[fuelpattern.v==fuelpattern_u.v[i]])
  LFuel.A_i=paste(paste(names(Lfuelpattern)[i],HC.com(Lfuelpattern[[i]]),sep=".("),")")
  LFuel.A=rbind(LFuel.A,LFuel.A_i)
}
cat("LFuelA(A,C)",sep="\n")
cat("/",sep="\n")
cat(LFuel.A,sep="\n")
cat("/",sep="\n")

# contingency set of ghg generating fuel mix for Activity

colnames(ghg)[1:ind]=Activity
ghg_a=ghg[!is.na(match(rownames(ghg),ENC)),Activity]
Gfuelpattern=lapply(ghg_a,function(x){rownames(ghg_a)[x>0]})
Gfuelpattern=Gfuelpattern[mapply(FUN=length,Gfuelpattern)>0]
Gfuel.A={}
for (i in (1:length(Gfuelpattern))){
  Gfuel.A_i=paste(paste(names(Gfuelpattern)[i],HC.com(Gfuelpattern[[i]]),sep=".("),")")
  Gfuel.A=rbind(Gfuel.A,Gfuel.A_i)
}
cat("GfuelA(A,C)",sep="\n")
cat("/",sep="\n")
cat(Gfuel.A,sep="\n")
cat("/",sep="\n")

#Contingency set of Agriculture input mix for each Activity
QINT_AGRI=sam_model[AGRIC,Activity]
AGRICpattern=lapply(QINT_AGRI,function(x){rownames(QINT_AGRI)[x>0]})
AGRICpattern=AGRICpattern[mapply(FUN=length,AGRICpattern)>0]
#ELECCpattern=mapply(function(x){rownames(QINT_ELECC)[x>0]},QINT_ELECC)

AGRIC.A={}
for (i in (1:length(AGRICpattern))){
  #Fuel.A_i=HC.com(names(fuelpattern.v)[fuelpattern.v==fuelpattern_u.v[i]])
  AGRIC.A_i=paste(paste(names(AGRICpattern)[i],HC.com(AGRICpattern[[i]]),sep=".("),")")
  AGRIC.A=rbind(AGRIC.A,AGRIC.A_i)
}
cat("AgricA(A,C)",sep="\n")
cat("/",sep="\n")
cat(AGRIC.A,sep="\n")
cat("/",sep="\n")


# commodity-activity mapping
QINT_AC=sam_model[Activity,Commodity]
ACpattern=lapply(QINT_AC,function(x){rownames(QINT_AC)[x>0]})
ACpattern=ACpattern[mapply(FUN=length,ACpattern)>0]
AC.A={}
for (i in (1:length(ACpattern))){
  #Fuel.A_i=HC.com(names(fuelpattern.v)[fuelpattern.v==fuelpattern_u.v[i]])
  AC.A_i=paste(paste(names(ACpattern)[i],HC.com(ACpattern[[i]]),sep=".("),")")
  AC.A=rbind(AC.A,AC.A_i)
}
cat("XPXC(C,A)",sep="\n")
cat("/",sep="\n")
cat(AC.A,sep="\n")
cat("/",sep="\n")


# Activities holing each M and Electricity as intermediate input

QINT=sam_model[c(ELECC,M),Activity]
T_QINT=data.frame(t(QINT))
colnames(T_QINT)=rownames(QINT)
Positive.int.demand=lapply(T_QINT,function(x){rownames(T_QINT)[x>0]})
Positive.int.demand=Positive.int.demand[mapply(FUN=length,Positive.int.demand)>0]
CA.A={}
for (i in (1:length(Positive.int.demand))){
  #Fuel.A_i=HC.com(names(fuelpattern.v)[fuelpattern.v==fuelpattern_u.v[i]])
  CA.A_i=paste(paste(names(Positive.int.demand)[i],HC.com(Positive.int.demand[[i]]),sep=".("),")")
  CA.A=rbind(CA.A,CA.A_i)
}
cat("XAPA(C,A)",sep="\n")
cat("/",sep="\n")
cat(CA.A,sep="\n")
cat("/",sep="\n")

# Activities holing each fuel as intermediate input
QCE=sam_model[ENC,Activity]
T_QCE=data.frame(t(QCE))
colnames(T_QCE)=rownames(QCE)
Positive.enc.demand=lapply(T_QCE,function(x){rownames(T_QCE)[x>0]})
Positive.enc.demand=Positive.enc.demand[mapply(FUN=length,Positive.enc.demand)>0]
ENCA.A={}
for (i in (1:length(Positive.enc.demand))){
  #Fuel.A_i=HC.com(names(fuelpattern.v)[fuelpattern.v==fuelpattern_u.v[i]])
  ENCA.A_i=paste(paste(names(Positive.enc.demand)[i],HC.com(Positive.enc.demand[[i]]),sep=".("),")")
  ENCA.A=rbind(ENCA.A,ENCA.A_i)
}
cat("XEPA(C,A)",sep="\n")
cat("/",sep="\n")
cat(ENCA.A,sep="\n")
cat("/",sep="\n")

#Non household (Domestic) Final demand: FD

FD=c("GoV","S-I")
cat(paste(paste("FD(ACT) ",HC.com(FD),sep="/"),"/"),sep="\n")

#Final demand mix for non household institutions   

XFA=sam_model[Commodity,match(FD,colnames(sam_model))]
T_XFA=data.frame(t(XFA))
colnames(T_XFA)=rownames(XFA)
Positive.fin.demand=lapply(T_XFA,function(x){rownames(T_XFA)[x!=0]})
Positive.fin.demand=Positive.fin.demand[mapply(FUN=length,Positive.fin.demand)>0]
XFA.A={}
for (i in (1:length(Positive.fin.demand))){
  #Fuel.A_i=HC.com(names(fuelpattern.v)[fuelpattern.v==fuelpattern_u.v[i]])
  XFA.A_i=paste(paste(names(Positive.fin.demand)[i],HC.com(Positive.fin.demand[[i]]),sep=".("),")")
  XFA.A=rbind(XFA.A,XFA.A_i)
}
cat("FD_C(C,FD)",sep="\n")
cat("/",sep="\n")
cat(XFA.A,sep="\n")
cat("/",sep="\n")



#Factors as a subset of AC
FACTOR.endow=ACT[(2*(ind+green)+1):(2*(ind+green)+fac)]
Labor=FACTOR.endow[1]
Capital=FACTOR.endow[2]
FACTOR.words=paste("F(AC) /",HC.com(FACTOR.endow),"/",sep='')
Labor.words=paste("L(F) /",Labor,"/",sep='')
Capital.words=paste("K(F) /",Capital,"/",sep='')

FACTOR.words=setwords("F","AC",FACTOR.endow)
Labor.words=setwords("L","F",Labor)
Capital.words=setwords("K","F",Capital)

cat(FACTOR.words, sep='\n')
cat(Labor.words, sep='\n')
cat(Capital.words, sep='\n')




#Institution as a subset of AC

INS=ACT[(2*(ind+green)+fac+hh):(2*(ind+green)+fac+hh+gov+Nres+tax+S_I+ROW)]
INSD=setdiff(INS,INS[length(INS)])
INSDN=INS[length(INS)]
H=ACT[(2*(ind+green)+fac+1):(2*(ind+green)+fac+hh)]
INS.words=setwords("INS","AC",INS)
INSD.words=setwords("INSD","INS",INSD)
INSDN.words=setwords("INSDN","INS",INSDN)
H.words=setwords("H","INSD",H)

cat(INS.words,sep='\n')
cat(INSD.words,sep='\n')
cat(INSDN.words,sep='\n')
cat(H.words,sep='\n')

# Comodities with positive household demand XACH(H,C)

HCC=data.frame(sam_model[Commodity,match(H,colnames(sam_model))])
colnames(HCC)=H
rownames(HCC)=Commodity
cat("XACH(H,C)",sep="\n")
cat("/",sep="\n")
cat(paste("Household",rownames(HCC)[HCC>0],sep="."),sep="\n")
cat("/",sep="\n")

## Energy Plan target industries
#Agrimin(A) /Agri-a,Mining-a/
  #Manufact(A)/IS-a,Cement-a,Orgchem-a,WoodPaper-a,FiberLeather-a,Mineral-a,nonISmetal-a,Machine-a,Electro_e-a,Electro_ne-a,Electro_sig-a,semicon-a,Auto-a,Ship-a,Food-a,MissManu-a/
  #RoilChemM(A)/IS-a,Orgchem-a,nonISmetal-a/
  #FabMetal(A)/Machine-a,Electro_e-a,Electro_ne-a,Electro_sig-a,semicon-a,Auto-a,Ship-a/
  #SOC(A)/Const-a/
  #Service(A)/Housing-a,Commercial-a,Public-a,Waste-a/
  #Other(A)/Oil-a,LNG-a,Rail-a,Road-a,Air-a,Marine-a,MissTrans-a/
  #Energy(A)/ELEC-a,GAS-a,HEAT-a,ROIL-a,CoalPro-a,Coal-a/
  #ELECA(A)/Elec-a/
#HEATA(A)/Heat-a/
  
Agrimin=c("Agri-a","Mining-a")
Manufact=c("IS-a","Cement-a","Orgchem-a","WoodPaper-a","FiberLeather-a","Mineral-a","nonISmetal-a","Machine-a","Electro_e-a","Electro_ne-a","Electro_sig-a","semicon-a","Auto-a","Ship-a","Food-a","MissManu-a")
RoilChemM=c("IS-a","Orgchem-a","nonISmetal-a")
FabMetal=c("Machine-a","Electro_e-a","Electro_ne-a","Electro_sig-a","semicon-a","Auto-a","Ship-a")
SOC=c("Const-a")
Service=c("Housing-a","Commercial-a","Public-a","Waste-a")
Other=c("Oil-a","LNG-a","Rail-a","Road-a","Air-a","Marine-a","MissTrans-a")
EnergyA=c("ELEC-a","GAS-a","HEAT-a","ROIL-a","CoalPro-a","Coal-a")
ELECA=c("Elec-a")
HEATA=c("Heat-a")

#Agrimin.words=setwords("Agrimin","A",Agrimin)
#Manufact.words=setwords("Manufact","A",Manufact)
#RoilChemM.words=setwords("RoilChemM","A",RoilChemM)
#FabMetal.words=setwords("FabMetal","A",FabMetal)
#SOC.words=setwords("SOC","A",SOC)
#Service.words=setwords("Service","A",Service)
#Other.words=setwords("Other","A",Other)
#EnergyA.words=setwords("Energy","A",EnergyA)
#ELECA.words=setwords("ELECA","A",ELECA)
#HEATA.words=setwords("HEATA","A",HEATA)

#cat(Agrimin.words, sep='\n')
#   cat(Manufact.words, sep='\n')
#       cat(RoilChemM.words, sep='\n')
#           cat(FabMetal.words, sep='\n')
#               cat(SOC.words, sep='\n')
#                   cat(Service.words, sep='\n')
#                       cat(Other.words, sep='\n')
#                           cat(EnergyA.words, sep='\n')
#                               cat(ELECA.words, sep='\n')
#                                   cat(HEATA.words, sep='\n')


#time horizon
cat("t",sep="\n")
cat("/",sep="\n")
if (Tmax==0){cat("0",sep="\n")} else{cat(paste("0",Tmax,sep="*"),sep="\n")}
cat("/",sep="\n")


#Alias
Alias1=c("ACT","INS","AC","A","C","F","L","K","H","GC")
Alias2=c("ACTPP","INSP","ACP","AP","CP","FP","LP","KP","HP","GCP")
Alias=cbind(Alias1,Alias2)
#Alias
Alias.words=paste("Alias(", Alias1, ",", Alias2, ");",sep="")
cat(Alias.words,sep='\n')

#set modification
Modification.words=c("ACNT(ACT)=yes;","ACNT('Total')=no;")
cat(Modification.words,sep='\n')
#}


#Agriculture singleton parameter: 0 for singleton, 1 for nonsingleton

Agri_d=sam_model[AGRIC,Activity]

Agrimix=data.frame(mapply(function(x){sum(as.numeric(x>0))},Agri_d))

Agrimix_zero=(Agrimix==0)
ind_nonzero_Agrimix=rownames(Agrimix)[!Agrimix_zero]

Agrimix_nonzero=data.frame(Agrimix[!Agrimix_zero])
rownames(Agrimix_nonzero)=ind_nonzero_Agrimix

Agrimix_one=(Agrimix_nonzero==1)

Agrimix_nonzero[Agrimix_one]=0
Agrimix_nonzero[!Agrimix_one]=1
colnames(Agrimix_nonzero)=" "

cat("Parameters","\n")
cat("Agri_single(A)","\n")
cat("/","\n")
print(Agrimix_nonzero)
cat("/","\n")

# Lfuel singleton parameter : 0 for singleton, 1 for nonsingleton

Lfuel_d=sam_model[Lfuel,Activity]

Lfuelmix=data.frame(mapply(function(x){sum(as.numeric(x>0))},Lfuel_d))

Lfuelmix_zero=(Lfuelmix==0)
ind_nonzero_Lfuelmix=rownames(Lfuelmix)[!Lfuelmix_zero]

Lfuelmix_nonzero=data.frame(Lfuelmix[!Lfuelmix_zero])
rownames(Lfuelmix_nonzero)=ind_nonzero_Lfuelmix

Lfuelmix_one=(Lfuelmix_nonzero==1)

Lfuelmix_nonzero[Lfuelmix_one]=0
Lfuelmix_nonzero[!Lfuelmix_one]=1
colnames(Lfuelmix_nonzero)=" "

cat("Parameter","\n")
cat("Lfuel_single(A)","\n")
cat("/","\n")
print(Lfuelmix_nonzero)
cat("/","\n")


# Sfuel singleton parameter : 0 for singleton, 1 for nonsingleton

Sfuel_d=sam_model[Sfuel,Activity]

Sfuelmix=data.frame(mapply(function(x){sum(as.numeric(x>0))},Sfuel_d))

Sfuelmix_zero=(Sfuelmix==0)
ind_nonzero_Sfuelmix=rownames(Sfuelmix)[!Sfuelmix_zero]

Sfuelmix_nonzero=data.frame(Sfuelmix[!Sfuelmix_zero])
rownames(Sfuelmix_nonzero)=ind_nonzero_Sfuelmix

Sfuelmix_one=(Sfuelmix_nonzero==1)

Sfuelmix_nonzero[Sfuelmix_one]=0
Sfuelmix_nonzero[!Sfuelmix_one]=1
colnames(Sfuelmix_nonzero)=" "

#cat("Parameter","\n")
cat("Sfuel_single(A)","\n")
cat("/","\n")
print(Sfuelmix_nonzero)
cat("/","\n")

# ELECC singleton parameter : 0 for singleton, 1 for nonsingleton

ELECC_d=sam_model[ELECC,Activity]

elecmix=data.frame(mapply(function(x){sum(as.numeric(x>0))},ELECC_d))

elecmix_zero=(elecmix==0)
ind_nonzero_elecmix=rownames(elecmix)[!elecmix_zero]

elecmix_nonzero=data.frame(elecmix[!elecmix_zero])
rownames(elecmix_nonzero)=ind_nonzero_elecmix

elecmix_one=(elecmix_nonzero==1)

elecmix_nonzero[elecmix_one]=0
elecmix_nonzero[!elecmix_one]=1
colnames(elecmix_nonzero)=" "

#cat("Parameter","\n")
cat("ELECC_single(A)","\n")
cat("/","\n")
print(elecmix_nonzero)
cat("/","\n")

#Labor=c("Labor")
#Capital=c("Capital")


# capital singleton parameter: 0 for singleton 1 for nonsingleton 

cap_d=sam_model[Capital,Activity]

capmix=data.frame(mapply(function(x){sum(as.numeric(x>0))},cap_d))

capmix_zero=(capmix==0)
ind_nonzero_capmix=rownames(capmix)[!capmix_zero]

capmix_nonzero=data.frame(capmix[!capmix_zero])
rownames(capmix_nonzero)=ind_nonzero_capmix

capmix_one=(capmix_nonzero==1)

capmix_nonzero[capmix_one]=0
capmix_nonzero[!capmix_one]=1
colnames(capmix_nonzero)=" "

#cat("Parameter","\n")
cat("K_single(A)","\n")
cat("/","\n")
print(capmix_nonzero)
cat("/","\n")

# labor singleton parameter: 0 for singleton 1 for nonsingleton 

lab_d=sam_model[Labor,Activity]

labmix=data.frame(mapply(function(x){sum(as.numeric(x>0))},lab_d))

labmix_zero=(labmix==0)
ind_nonzero_labmix=rownames(labmix)[!labmix_zero]

labmix_nonzero=data.frame(labmix[!labmix_zero])
rownames(labmix_nonzero)=ind_nonzero_labmix

labmix_one=(labmix_nonzero==1)

labmix_nonzero[labmix_one]=0
labmix_nonzero[!labmix_one]=1
colnames(labmix_nonzero)=" "

#cat("Parameter","\n")
cat("L_single(A)","\n")
cat("/","\n")
print(labmix_nonzero)
cat("/","\n")



sink()
