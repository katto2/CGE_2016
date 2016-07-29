## This file replaces Emission_IP_KSW.gms
## Task list of Emission_IP_KSW
## (0) Preparation 
## (1) Process Emission (CRF sector 2) estimation
## (2) Agricalutral Emission (CRF sector 4) estimation
## (3) Waste Emission (CRF sector 6) estimation
## (4) Eliminates emission estimates with zero emiter

###(0)Preparation
##(0-i) setting up Emit_Prcs
N_GHGs=c("CO2", "CH4", "N2O", "HFCs", "PFCs", "SF6")# GHGs not from fossil fuel burning
Emit_Prcs=data.frame(matrix(rep(0,length(N_GHGs)*384),length(N_GHGs),384))
Emit_Prcs$GHG=N_GHGs
Emit_Prcs=Emit_Prcs[c(385,1:384)]

##(0-ii)load data
Emit_GIR=read.csv(file=file.path("Emissions_Estimation","Prcs_GIR.csv"),header=T,as.is=T)
Prcs_D=read.csv(file=file.path("Emissions_Estimation","Prcs_Data.csv"), header=T,as.is=T)
GWP=read.csv(file=file.path("Emissions_EStimation","GWP.csv"),header=T,as.is=T) # conversion factor to CO2 equivalent
Rcoef=read.csv(file=file.path("Emissions_Estimation","Rcoef.csv"),header=T,as.is=T)

##(0-iii) merge GWP
Prcs_D=merge(Prcs_D,GWP, by="GHG", all=T, sort=F)
Prcs_D$GWP[Prcs_D$Unit=="tCO2eq"]=1 # already converted to CO2 equivalent
##(0-iv) select time index, keep related values,load IO values 
t=2010
Emit_GIR=Emit_GIR[Emit_GIR$t==t,]
Prcs_D=Prcs_D[Prcs_D$t==t,]
G_name1=paste(paste("IO_E_G1",t,sep="_"),"Rdata",sep=".")
load(G_name1)

##(0-v) Obtain GHG emission =Q_Emitter*CCF*GWP (size of emitter x emission coefficient x conversion factor in CO2equiv)
Prcs_D$Q_gas[is.na(Prcs_D$Q_gas)]=Prcs_D$Q_Emitter[is.na(Prcs_D$Q_gas)]*Prcs_D$CCF[is.na(Prcs_D$Q_gas)]


## (1) Process Emission (CRF sector 2) estimation
### (1-i) 2. A. Mineral 
### (i-ii) 2. B. Chemistry
### (1-iii) 2. C. metal
### (1-iv) 2. E. Halo carbon Production
### (1-v)  2. F. Halo carbon consumption
### (1-vi) 2. F. 7. Halo carbon in semiconductor and LCD
### (1-vii) 2.F. 8. SF6 in electronic transformer 


### (1-i) 2. A. Mineral (x148 Cement , X157 pig iron, x277 self-elec, x278 renewable , x151 Lime generate CO2)
D_2A=Prcs_D[(Prcs_D$CRF=="2A"),]

#### (1-i-a) x148
Emit_Prcs[(Emit_Prcs$GHG=="CO2"),"X148"]=D_2A$Q_gas[(D_2A$Emiter=="CLK")]*D_2A$GWP[(D_2A$Emiter=="CLK")] #Clinker


#### (1-i-b) x157 using DLM
Emit_Prcs[(Emit_Prcs$GHG=="CO2"),"X157"]=D_2A$Q_gas[(D_2A$Emiter=="DIM")]*D_2A$GWP[(D_2A$Emiter=="DIM")] #Dolomite


#### (1-i-c) x157,x277,x278 using LST (x33:Limestone)
LST_ind=c("X157","X277","X278")
Emit_Prcs[(Emit_Prcs$GHG=="CO2"),LST_ind]=Emit_Prcs[(Emit_Prcs$GHG=="CO2"),LST_ind]+D_2A$Q_gas[(D_2A$Emiter=="LST")]*D_2A$GWP[(D_2A$Emiter=="LST")]*A_T_B_384[33,LST_ind]/sum(A_T_B_384[33,LST_ind])

                                                                                                                                                
#### (1-i-d) x151 Concrete products : All CO2 from Mineral -(CO2 using CLK, CO2 using DIM, CO2 using LST, CO2 using SA)                                                                                                                                                 
Emit_Prcs[(Emit_Prcs$GHG=="CO2"),"X151"]=Emit_GIR[,"p_min_CO2"]-sum(Emit_Prcs[(Emit_Prcs$GHG=="CO2"),c("X148","X157","X277","X278")])-D_2A$Q_gas[(D_2A$Emiter=="SA")]*D_2A$GWP[(D_2A$Emiter=="SA")]


### (1-ii) 2. B. Chemistry
D_2B=Prcs_D[(Prcs_D$CRF=="2B"),]
####(1-ii-a) CO2 in Ammonia production (x123) fertilzer and Nitro Acid compound
####(1-ii-b) N2O in Nitro Acid production (x123) fertilzer and Nitro Acid compound
####(1-ii-c) N2O in Adif Acid Production (x115) misc. basic organic chemistry product 
####(1-ii-d) CH4 in Etilen production (x111) +CH4 in Stilen production (x112)
####(1-ii-e) CH4 in Carbon black used in basic inorganic chemistry product (x117)
####(1-ii-f) CH4 in Nitrogen Etilen used in intermediate organic chemistry product (x113)

####(1-ii-a) CO2 in Ammonia production (x123) fertilzer and Nitro Acid compound
Emit_Prcs[(Emit_Prcs$GHG=="CO2"),"X123"]=Emit_GIR["p_che_CO2"]

####(1-ii-b,c) N2O in Nitro Acid production (x123) fertilzer and Nitro Acid compound and in Adif Acid Production (x115) misc. basic organic chemistry product
N2O_ind_2B=c("X115","X123")
rownames(XP_B0)=paste("X",c(1:dim(XP_B0)[1]),sep="")
Emit_Prcs[(Emit_Prcs$GHG=="N2O"),N2O_ind_2B]=Emit_GIR[,"p_che_n2o"]*XP_B0[N2O_ind_2B,]/sum(XP_B0[N2O_ind_2B,])

####(1-ii-d) CH4 in Etilen production (x111) +CH4 in Stilen production (x112)
CH4_ind1=c("X111","X112")
Emit_Prcs[(Emit_Prcs$GHG=="CH4"),CH4_ind1]=sum(D_2B$Q_gas[!is.na(match(D_2B$Emiter,c("ST","ET")))]*D_2B$GWP[!is.na(match(D_2B$Emiter,c("ST","ET")))])*XP_B0[CH4_ind1,]/sum(XP_B0[CH4_ind1,])

###(1-ii_e) CH4 in Carbon black used in basic inorganic chemistry product (x117)
Emit_Prcs[(Emit_Prcs$GHG=="CH4"),"X117"]=D_2B$Q_gas[D_2B$Emiter=="CB"]*D_2B$GWP[D_2B$Emiter=="CB"]

####(1-ii-f) CH4 in Nitrogen Etilen used in intermediate organic chemistry product (x113)
Emit_Prcs[(Emit_Prcs$GHG=="CH4"),"X113"]=D_2B$Q_gas[D_2B$Emiter=="CET"]*D_2B$GWP[D_2B$Emiter=="CET"]

### (1-iii) 2. C. metal: CO2 from carbon electrode use in x159, x169, x161 [crude steel, steel bar, shape steel]
## Carbon electrode is in x223 misc. electronic device. Since it is usually imported, we use import IO to construct share parameter
D_2C=Prcs_D[(Prcs_D$CRF=="2C"),]
Metal_ind=c("X159","X160","X161")
Emit_Prcs[(Emit_Prcs$GHG=="CO2"),Metal_ind]=D_2C$Q_gas[D_2C$Emiter=="CE"]*D_2C$GWP[D_2C$Emiter=="CE"]*A_M_B_384[223,Metal_ind]/sum(A_M_B_384[223,Metal_ind])


### (1-iv) 2. E. Halo carbon Production. x116 industrial gas produces Halo carbon
Emit_Prcs[(Emit_Prcs$GHG=="HFCs"),"X116"]=Emit_GIR[,"p_haloP_hfc"]


### (1-v)  2. F. Halo carbon consumption:X116 mainly used in X197="Airconditioning/Refrigerator", X200=misc mach equip with general purpose, "X249-X252"=Auto 
D_2F=Prcs_D[(Prcs_D$CRF=="2F"),]
HCC_ind=c("X197","X200",paste("X",(249:252),sep=""))
Emit_Prcs[(Emit_Prcs$GHG=="HFCs"),HCC_ind]=(D_2F$Q_gas[(D_2F$GHG=="HFC-152a")]*(140/1000)+D_2F$Q_gas[(D_2F$GHG=="HFC-134a")]*(1300/1000))*A_T_B_384[116,HCC_ind]/sum(A_T_B_384[116,HCC_ind])


### (1-vi) 2. F. 7. Halo carbon in semiconductor use and LCD use
D_2F7=Prcs_D[(Prcs_D$CRF=="2F7"),]
D_2F7_R=merge(D_2F7,Rcoef, by.x=c("GHG","Ind_2F7"),by.y=c("GHG","ind"),all=T,sort=F)

####(1-vi-a) Semiconductor: Halo carbon in semiconductor use. x224 (semiconductor device) x225 (Integrated circuit)
##### Preparation
D_2F7_semi=D_2F7_R[((D_2F7_R$Ind_2F7=="Semicon")),]
PFC=c("CF4", "C2F6", "C3F8", "C4F8")
HFC=c("CHF3", "CH2F2", "C2HF5")
PFC_ind=(match(PFC,D_2F7_semi$GHG))[!is.na(match(PFC,D_2F7_semi$GHG))]
HFC_ind=(match(HFC,D_2F7_semi$GHG))[!is.na(match(HFC,D_2F7_semi$GHG))]
C4F8_ind=(D_2F7_semi$GHG=="C4F8")
CF4_ind=(D_2F7_semi$GHG=="CF4")
SF6_ind=(D_2F7_semi$GHG=="SF6")
CO2_ind=(D_2F7_semi$GHG=="CO2")
CH4_ind=(D_2F7_semi$GHG=="CH4")
N2O_ind=(D_2F7_semi$GHG=="N2O")

##### (PFC)
Q_PFC1=sum(D_2F7_semi$Q_gas[PFC_ind]*(1-D_2F7_semi$R1[PFC_ind])*D_2F7_semi$R2[PFC_ind]*(1-D_2F7_semi$R3[PFC_ind])*D_2F7_semi$GWP[PFC_ind])
Q_PFC2=D_2F7_semi$Q_gas[C4F8_ind]*(1-D_2F7_semi$R1[C4F8_ind])*D_2F7_semi$R_C2F6[C4F8_ind]*(1-D_2F7_semi$R4[C4F8_ind])*GWP$GWP[GWP$GHG=="C2F6"]
Q_PFC3=sum(D_2F7_semi$Q_gas[PFC_ind]*(1-D_2F7_semi$R1[PFC_ind])*D_2F7_semi$R_CF4[PFC_ind]*(1-D_2F7_semi$R4[PFC_ind])*GWP$GWP[GWP$GHG=="CF4"])
Q_PFC4=sum(D_2F7_semi$Q_gas[HFC_ind]*(1-D_2F7_semi$R1[HFC_ind])*D_2F7_semi$R_CF4[HFC_ind]*(1-D_2F7_semi$R4[HFC_ind])*GWP$GWP[GWP$GHG=="CF4"])
Q_PFC5=D_2F7_semi$Q_gas[CF4_ind]*(1-D_2F7_semi$R1[CF4_ind])*D_2F7_semi$R_CF4[CF4_ind]*(1-D_2F7_semi$R4[CF4_ind])*GWP$GWP[GWP$GHG=="CF4"]
Q_PFC=sum(c(Q_PFC1,Q_PFC2,Q_PFC3,Q_PFC4,-1*Q_PFC5))

##### (HFC)
Q_HFC=sum(D_2F7_semi$Q_gas[HFC_ind]*(1-D_2F7_semi$R1[HFC_ind])*D_2F7_semi$R2[HFC_ind]*(1-D_2F7_semi$R3[HFC_ind])*D_2F7_semi$GWP[HFC_ind])

##### (SF6)
Q_SF6=D_2F7_semi$Q_gas[SF6_ind]*(1-D_2F7_semi$R1[SF6_ind])*D_2F7_semi$R2[SF6_ind]*(1-D_2F7_semi$R3[SF6_ind])*D_2F7_semi$GWP[SF6_ind]

##### (CO2)
Q_CO2=D_2F7_semi$Q_gas[CO2_ind]*(1-D_2F7_semi$R1[CO2_ind])*(1-D_2F7_semi$R2[CO2_ind])*(1-D_2F7_semi$R3[CO2_ind])*D_2F7_semi$GWP[CO2_ind]

##### (CH4)
Q_CH4=D_2F7_semi$Q_gas[CH4_ind]*(1-D_2F7_semi$R1[CH4_ind])*(1-D_2F7_semi$R2[CH4_ind])*(1-D_2F7_semi$R3[CH4_ind])*D_2F7_semi$GWP[CH4_ind]

##### (N2O)
Q_N2O=D_2F7_semi$Q_gas[N2O_ind]*(1-D_2F7_semi$R1[N2O_ind])*(1-D_2F7_semi$R2[N2O_ind])*(1-D_2F7_semi$R3[N2O_ind])*D_2F7_semi$GWP[N2O_ind]

Q_semi=c(Q_CO2,Q_CH4,Q_N2O,Q_HFC,Q_PFC,Q_SF6)
Emit_Prcs[,"X224"]=Q_semi*XP_B0["X224",]/sum(XP_B0[c("X224","X225"),])
Emit_Prcs[,"X225"]=Q_semi*XP_B0["X225",]/sum(XP_B0[c("X224","X225"),])

####(1-vi-b) LCD: Halo carbon in LCD use. x226 Digital Display
###### Preparation
D_2F7_LCD=D_2F7_R[((D_2F7_R$Ind_2F7=="LCD")),]
#PFC=c("CF4", "C2F6", "C3F8", "C4F8")
#HFC=c("CHF3", "CH2F2", "C2HF5")
#PFC_ind=!is.na(match(D_2F7_LCD$GHG,PFC))
PFC_ind=(match(PFC,D_2F7_LCD$GHG))[!is.na(match(PFC,D_2F7_LCD$GHG))]
HFC_ind=(match(HFC,D_2F7_LCD$GHG))[!is.na(match(HFC,D_2F7_LCD$GHG))]
C4F8_ind=(D_2F7_LCD$GHG=="C4F8")
CF4_ind=(D_2F7_LCD$GHG=="CF4")
SF6_ind=(D_2F7_LCD$GHG=="SF6")
CO2_ind=(D_2F7_LCD$GHG=="CO2")
CHF3_ind=(D_2F7_LCD$GHG=="CHF3")
N2O_ind=(D_2F7_LCD$GHG=="N2O")


###### (PFC)
Q_PFC1=sum(D_2F7_LCD$Q_gas[PFC_ind]*(1-D_2F7_LCD$R1[PFC_ind])*D_2F7_LCD$R2[PFC_ind]*(1-D_2F7_LCD$R3[PFC_ind])*D_2F7_LCD$GWP[PFC_ind])
Q_PFC2=D_2F7_LCD$Q_gas[C4F8_ind]*(1-D_2F7_LCD$R1[C4F8_ind])*D_2F7_LCD$R_CF4[C4F8_ind]*(1-D_2F7_LCD$R_CHF3[C4F8_ind])*D_2F7_LCD$GWP[CF4_ind]
Q_PFC3=D_2F7_LCD$Q_gas[CHF3_ind]*(1-D_2F7_LCD$R1[CHF3_ind])*D_2F7_LCD$R_CF4[CHF3_ind]*(1-D_2F7_LCD$R_CHF3[CHF3_ind])*D_2F7_LCD$GWP[CF4_ind]
Q_PFC4=D_2F7_LCD$Q_gas[C4F8_ind]*(1-D_2F7_LCD$R1[C4F8_ind])*D_2F7_LCD$R_C2F6[C4F8_ind]*(1-D_2F7_LCD$R_CHF3[C4F8_ind])*D_2F7_LCD$GWP[C4F8_ind]
Q_PFC=sum(c(Q_PFC1,Q_PFC2,Q_PFC3,Q_PFC4))

##### (HFC)
if (t<1991) {
Q_HFC1=sum(D_2F7_LCD$Q_gas[HFC_ind]*(1-D_2F7_LCD$R1[HFC_ind])*D_2F7_LCD$R2[HFC_ind]*(1-D_2F7_LCD$R3[HFC_ind])*D_2F7_LCD$GWP[HFC_ind])
Q_HFC2=D_2F7_LCD$Q_gas[CHF3_ind]*(1-D_2F7_LCD$R1[CHF3_ind])*D_2F7_LCD$R4[CHF3_ind]*(1-D_2F7_LCD$R_CHF3[CHF3_ind])*D_2F7_LCD$GWP[CHF3_ind]
Q_HFC=sum(c(Q_HFC1,Q_HFC2))
} else {
Q_HFC1=sum(D_2F7_LCD$Q_gas[HFC_ind]*(1-D_2F7_LCD$R1[HFC_ind])*D_2F7_LCD$R2[HFC_ind]*(1-D_2F7_LCD$R3[HFC_ind])*D_2F7_LCD$GWP[HFC_ind])
Q_HFC2=D_2F7_LCD$Q_gas[C4F8_ind]*0.9*0.02
Q_HFC=sum(c(Q_HFC1,Q_HFC2))
}

#####(SF6)
Q_SF6=D_2F7_LCD$Q_gas[SF6_ind]*(1-D_2F7_LCD$R1[SF6_ind])*D_2F7_LCD$R2[SF6_ind]*(1-D_2F7_LCD$R3[SF6_ind])*D_2F7_LCD$GWP[SF6_ind]

#####(CO2)
Q_CO2=D_2F7_LCD$Q_gas[CO2_ind]*(1-D_2F7_LCD$R1[CO2_ind])*(1-D_2F7_LCD$R2[CO2_ind])*(1-D_2F7_LCD$R3[CO2_ind])*D_2F7_LCD$GWP[CO2_ind]

#####(N2O)
Q_N2O=D_2F7_LCD$Q_gas[N2O_ind]*(1-D_2F7_LCD$R1[N2O_ind])*(1-D_2F7_LCD$R2[N2O_ind])*(1-D_2F7_LCD$R3[N2O_ind])*D_2F7_LCD$GWP[N2O_ind]

LCD_GHG=c("PFCs","HFCs","SF6","CO2","N2O")
Emit_Prcs[match(LCD_GHG,Emit_Prcs$GHG),"X226"]=c(Q_PFC,Q_HFC,Q_SF6,Q_CO2,Q_N2O)

### (1-vii) 2.F. 8. SF6 in electronic transformer = SF6 emission Total - sum of SF6 from all the other industries

if (Emit_Prcs[(Emit_Prcs$GHG=="SF6"),"X226"]>0){
  Emit_Prcs[(Emit_Prcs$GHG=="SF6"),"X215"]=Emit_GIR[,"p_halo_sf6"]-sum(Emit_Prcs[(Emit_Prcs$GHG=="SF6"),(2:dim(Emit_Prcs)[2])])
}


## (2) Agricalutral Emission (CRF sector 4) estimation
### (2-i) Livestock: CH4 from livestocks enteric fermentation (4.A) and CH4,N2O from Livestock manure (4.B)
### (2-ii) Cultivation: CH4 from rice cultivation. 
### (2-iii) cultivation: N2O from cultivation, CH4/N2O from residue burning (4.D)
### (2-iv) Residue Buring: CH4, N2O from residue buring (4.F)


### (2-i) Livestock: x14(Dairy farming), x15 (Beefcattle), X16 (Pigs), X17(Poultry and birds), X18 (other animlas)

####(2-i-a) CH4 from Livestock Enteric fermentation  (4.A) 
D_4A=Prcs_D[Prcs_D$CRF=="4A",]
D_4A$IO_ind=c("X17","X14","X15","X16","X18","X18","X18","X18","X17")
D_4A$Q_gas_GWP=D_4A$Q_gas*D_4A$GWP
Q_4A=aggregate(D_4A$Q_gas_GWP, by=list(D_4A$IO_ind),FUN=sum)
Emit_Prcs[Emit_Prcs$GHG=="CH4",Q_4A[,1]]=as.numeric(Q_4A[,2])

####(2-i-b)CH4 from Livestock manure management (4.B) 
D_4B=Prcs_D[Prcs_D$CRF=="4B",]
D_4B$IO_ind=c("X14","X15","X18","X18","X17","X16","X17","X18","X18")
D_4B$Q_gas_GWP=D_4B$Q_gas*D_4A$GWP
Q_4B=aggregate(D_4B$Q_gas_GWP, by=list(D_4B$IO_ind),FUN=sum)
Emit_Prcs[Emit_Prcs$GHG=="CH4",Q_4B[,1]]=Emit_Prcs[Emit_Prcs$GHG=="CH4",Q_4B[,1]]+as.numeric(Q_4B[,2])

####(2-i-c)N2O from Livestock manure management (4.B)

Livs=paste("X",(14:18),sep="")# (Livestock industry)
Emit_Prcs[Emit_Prcs$GHG=="N2O",Livs]=Emit_GIR[,"a_ferm_n2o"]*(XP_B0[(Livs),]/sum(XP_B0[(Livs),]))

check=sum(Emit_Prcs[Emit_Prcs$GHG=="N2O",Livs])-Emit_GIR[,"a_ferm_n2o"]

print ("Check_N2O_D4B=")
print(check)
if (check>0.0001){
  Print ("4.B N2o has data inconsistency")
}

### (2-ii) Cultivation: CH4 from rice cultivation. Rice (X1)
Emit_Prcs[Emit_Prcs$GHG=="CH4","X1"]=Emit_GIR[,"a_farm_ch4"]


### (2-iii)cultivation: N2O. N2o from fertilzer use (X123), Manure management (Livs), Beans(Non vegi crops) (Crop2), Straws (Crop3), indirect emission (All agri)
#### (2-iii-0) preparation
D_4D=Prcs_D[Prcs_D$CRF=="4D",]
Agri=paste("X",(1:18),sep="")
crop=c(paste("X",(1:10),sep=""),"X12","X13")
#Livs=paste("X",(14:18),sep="")
Crop2=c("X1","X2","X4") #Rice(X1),Barley(X2),Potatoes(X4)
Crop3=Crop2
#### (2-iii-a) Fertilzer use
Emit_Prcs[(Emit_Prcs$GHG=="N2O"),crop]=Emit_Prcs[(Emit_Prcs$GHG=="N2O"),crop]+D_4D$Q_gas[D_4D$Emiter=="fertilizer"]*D_4D$GWP[D_4D$Emiter=="fertilizer"]*A_T_B_384[123,crop]/sum(A_T_B_384[123,crop])
#### (2-iii-b) Manure management
Emit_Prcs[(Emit_Prcs$GHG=="N2O"),Livs]=Emit_Prcs[(Emit_Prcs$GHG=="N2O"),Livs]+D_4D$Q_gas[D_4D$Emiter=="Livestock"]*D_4D$GWP[D_4D$Emiter=="Livestock"]*XP_B0[Livs,]/sum(XP_B0[Livs,])
#### (2-iii-c) Non Vegi crops
Emit_Prcs[(Emit_Prcs$GHG=="N2O"),Crop2]=Emit_Prcs[(Emit_Prcs$GHG=="N2O"),Crop2]+D_4D$Q_gas[D_4D$Emiter=="Crops"]*D_4D$GWP[D_4D$Emiter=="Crops"]*XP_B0[Crop2,]/sum(XP_B0[Crop2,])
#### (2-iii-d) Straws
Emit_Prcs[(Emit_Prcs$GHG=="N2O"),Crop3]=Emit_Prcs[(Emit_Prcs$GHG=="N2O"),Crop3]+D_4D$Q_gas[D_4D$Emiter=="Residue"]*D_4D$GWP[D_4D$Emiter=="Residue"]*XP_B0[Crop3,]/sum(XP_B0[Crop3,])
#### (2-iii-e) indirect emission
Emit_Prcs[(Emit_Prcs$GHG=="N2O"),Agri]=Emit_Prcs[(Emit_Prcs$GHG=="N2O"),Agri]+D_4D$Q_gas[D_4D$Emiter=="indirect"]*D_4D$GWP[D_4D$Emiter=="indirect"]*XP_B0[Agri,]/sum(XP_B0[Agri,])

### (2-iv) Residue Buring: CH4, N2O from residue buring (4.F) Rice (X1), Barley (X2), Wheat(X3), Vegi (X5)
Residue_ind=c("X1","X2","X3","X5")
Emit_Prcs[Emit_Prcs$GHG=="CH4",Residue_ind]=Emit_Prcs[Emit_Prcs$GHG=="CH4",Residue_ind]+Emit_GIR[,"a_res_ch4"]*XP_B0[Residue_ind,]/sum(XP_B0[Residue_ind,])
Emit_Prcs[Emit_Prcs$GHG=="N2O",Residue_ind]=Emit_Prcs[Emit_Prcs$GHG=="N2O",Residue_ind]+Emit_GIR[,"a_res_n2o"]*XP_B0[Residue_ind,]/sum(XP_B0[Residue_ind,])


## (3) Waste Emission (CRF sector 6) estimation x284 (Waste management. Public), x285 (Waste management. Private)
### CH4 from waste water is excluded.
Waste_GHG_indic=c("w_total_co2","w_total_ch4","w_total_n2o")
Waste_GHG=c("CO2","CH4","N2O")
Emit_Prcs[match(Waste_GHG,Emit_Prcs$GHG),c("X284","X285")]=t(as.matrix((XP_B0[c("X284","X285"),]/sum(XP_B0[c("X284","X285"),])))%*%as.matrix(Emit_GIR[,Waste_GHG_indic]))
D6=Prcs_D[Prcs_D$CRF=="6",]
WasteW_GHG=D6$Q_gas*XP_B0[c("X284","X285"),]/sum(XP_B0[c("X284","X285"),])
Emit_Prcs[Emit_Prcs$GHG=="CH4",c("X284","X285")]=Emit_Prcs[Emit_Prcs$GHG=="CH4",c("X284","X285")]-WasteW_GHG

## (4) Eliminates emission estimates with zero emiter (Omitting)

## (5) Obtain aggregate
Prcs_GHG=colSums(Emit_Prcs[,(2:dim(Emit_Prcs)[2])])

G_name2=paste(paste("IO_E_G2",t,sep="_"),"Rdata",sep=".")

save(list=ls(), file=G_name2)

#write.csv(Emit_Prcs, file="Emit_Prcs_2010.csv")
#write.csv(Prcs_GHG, file="Prcos_GHG_2010.csv")


