### This file replace Emission_Estimation.gms
##(1) Construct Energy_IO A table and Final Demand
##(2) Construct GHG_IO A table, GHG_IO Final Demand, GHG by industry
##(3) Rescaling
##(4) Produce GHG stats

##(0) Load related data
#(0-i) IO and Energy Balance
t=2010
E_name1=paste(paste("IO_E",t,sep="_"),"Rdata",sep=".")
load(E_name1)
#(0-ii) Emission Factor converting Energy to CO2
EF=read.csv(file=file.path("Emissions_Estimation","EF.csv"), header=T,as.is=T)
EF_ind=merge(ENGind_index,EF,by.x="basecode_row", by.y="ind",all=T)

##(1) Construct Energy_IO A table
##(1-i) prepare IO values
###(a) call IO value to distribute/designate
Dist=con_totB[ENGind_index$basecode_col,]# To distribute
Dist=data.frame(Dist)
rownames(Dist)=ENGind_index$basecode_col
Desig_ind=c("X26","X27","X101","X106","X279")#industries with designated value
Desig_M=con_totB[Desig_ind,]#To be substracte for designation
Desig_M=data.frame(Desig_M)
rownames(Desig_M)=Desig_ind
###(b) construct values to designate
Desig_M["X26",]=sum(A_T_B_384[26,c("X100","X275")]) #Anthrachite in Yuntan and Thermal_generation
Desig_M["X27",]=A_T_B_384[27,"X275"]#Bituminus in Thermal_generation
Desig_M["X101",]=sum(A_T_B_384[101,paste("X",(111:139),sep="")])#Naphta in Petrochemical products
Desig_M["X106",]=A_T_B_384[106,"X275"]#Heavy Oil in Thermal_generation
Desig_M["X279",]=sum(A_T_B_384[279,c("X275","X280")])#Towngas in Thermal generatio and Heat and Water
###(c) construct values to distribute
Dist[Desig_ind,]=Dist[Desig_ind,]-Desig_M[Desig_ind,]

##(1-ii) prepare E values
###(a) call E values to distribute
Dist_E=con_ene
###(b) construct Evvalues to designate
Desig_Anthrat=abs(EBS_LLH[c("Residential","E_Gene"),"AnthraT"]) #Antharchite in Yuntan (Residential) and Thermal Generation
Desig_Bitu=-EBS_LLH["E_Gene","BituT"]#Bituminous coal in thermal electricity generation
Desig_Naphta=EBS_LLH["PetChem","Naphta"]#Naphta in Petro chemical production
Desig_Heavyoil=-1*EBS_LLH["E_Gene",c("BA","BB","BC")]# Heavy oil in thermal electricity generation
Desig_Towngas=-1*EBS_LLH[c("E_Gene","Heating"),c("LNG","TownGas")]# LNG and Towngas in thermal elec and Heating
#(LNG used in E_Gene and Heating is not captured in IO. We subtract it from Towngas instead)
Desig_E_list=list(Desig_Anthrat,Desig_Bitu,Desig_Naphta,Desig_Heavyoil,Desig_Towngas)

Desig_E=data.frame(sapply(Desig_E_list,FUN=sum))
rownames(Desig_E)=Desig_ind
colnames(Desig_E)="Desig_E"

###(c) construct E values to distribute
Dist_E[Desig_ind,]=Dist_E[Desig_ind,]-Desig_E[Desig_ind,]


##(1-iii) Construct Energy IO A table
###(a) Distribute E (Non Designated)
# E_ij =[M_ij/(M-M_designated)]*(E-E_designated)
IOT_energy=diag(Dist_E[,1])%*%solve(diag(Dist[,1]))%*%as.matrix(A_T_B_384[ENGind_index$basecode_row,])
IOT_energy=data.frame(IOT_energy)
rownames(IOT_energy)=EF_ind$basecode_col
#x275(Thermal E),X277(self E) came from E_Fcon+E_Gene-Hyrdo-Nuclear-Renewable E. We distribute this E to x275 and x277
# E_ij=[M_ij/M275+M277-(M275+M277|Designated)]*[E275+E277-(E275+E277|Designated)]
IOT_energy["X275",]=(A_T_B_384[275,]/(sum(Dist[c("X275","X277"),])))*sum(Dist_E[c("X275","X277"),])
IOT_energy["X277",]=(A_T_B_384[277,]/(sum(Dist[c("X275","X277"),])))*sum(Dist_E[c("X275","X277"),])


###(c) Designated E_ij
IOT_energy["X26",c("X100","X275")]=Desig_E_list[[1]] #Anthrachite in Yuntan and Thermal_generation
IOT_energy["X27","X275"]=Desig_E_list[[2]]#Bituminus in Thermal_generation
IOT_energy["X101",paste("X",(111:139),sep="")]=Desig_E_list[[3]]*A_T_B_384[101,paste("X",(111:139),sep="")]/sum(A_T_B_384[101,paste("X",(111:139),sep="")])#Naphta in Petrochemical products
IOT_energy["X106","X275"]=sum(Desig_E_list[[4]])#Heavy Oil in Thermal_generation
IOT_energy["X279",c("X275","X280")]=as.numeric(rowSums(Desig_E_list[[5]]))#Towngas in Thermal generatio and Heat and Water

##(1-iv) Construct Energy IO Final Demand
IOT_energy_FinD=data.frame(matrix(rep(0,dim(IOT_energy)[1]*dim(F_T_B_384)[2]),dim(IOT_energy)[1],dim(F_T_B_384)[2]))
colnames(IOT_energy_FinD)=Fin_Demand
rownames(IOT_energy_FinD)=EF_ind$basecode_col
IOT_energy_FinD_Pc=(F_T_B_384[ENGind_index$basecode_row,"Final_Pc"]/Dist)*Dist_E
IOT_energy_FinD_Pc["X275",]=(F_T_B_384[275,"Final_Pc"]/sum(Dist[c("X275","X277"),]))*sum(Dist_E[c("X275","X277"),])
IOT_energy_FinD_Pc["X277",]=(F_T_B_384[277,"Final_Pc"]/sum(Dist[c("X275","X277"),]))*sum(Dist_E[c("X275","X277"),])

IOT_energy_FinD$Final_Pc=IOT_energy_FinD_Pc
IOT_energy_FinD$Final_Tot=IOT_energy_FinD_Pc
colnames(IOT_energy_FinD)=Fin_Demand
##(1-v) check if the sum of energy distributed matches with con_ene
check_E=max(abs(rowSums(IOT_energy)+IOT_energy_FinD$Final_Tot-con_ene))
print("check_E=")
print(check_E)
if (check_E>0.000001) {
  print ("The rowsum of IOT_energy doesn't match with con_ene")
}

##(2) Construct GHG_IO A table, GHG_IO Final Demand, GHG by industry
###(2-i) preparing related data
#IOT_E_GHG=IOT_energy # preparing IOT_energy used for GHG estimation
#IOT_E_GHG_FinD=IOT_energy_FinD
EF_ind$EF_adj=EF_ind$EF*(44/12)*(1-EF_ind$Sink) # adjusting emission factor . 44/12 converts CO to CO2, 1-sink takes out sinking Carbons in Naphta and Lubricant
###(2-ii) Excluding double counted Energy from IOT_E_GHG(Not Necessary)
#IOT_E_GHG[c("X26","X27"),c("X99","X100")]=0 # Coals used in coal products. Emission is captured when coal products are used.
#IOT_E_GHG["X280",]=0 
#IOT_E_GHG_FinD["X280",]=0 # zero emission in heat using. Carbon is captured when Heat is produced.
###(2-ii)Preparing non counting dummy matrix for GHG_IO A table
Del_Dummy=matrix(rep(1, dim(IOT_energy)[1]*dim(IOT_energy)[2]),dim(IOT_energy)[1],dim(IOT_energy)[2])
rownames(Del_Dummy)=rownames(IOT_energy)
colnames(Del_Dummy)=colnames(IOT_energy)
####(a) Transformed energy doesn't emit GHG (X274-X278 Elec, X280 Heat)
Del_Dummy[c(paste("X",(274:278),sep=""),"X280"),]=0
####(b) coal used in Coal product(X99) and coal briquettes(X100) doesn't emit GHG. Carbons remain in Coal Products and Coal briquet
Del_Dummy[c("X26","X27"),c("X99","X100")]=0
####(c) Crud oil used in refinary oil production(X101~X110) doesn't emit GHG. Carbons remain in refinary products
Del_Dummy["X28",paste("X",(101:110),sep="")]=0
####(e) LNG used in Towngas production doesn't emit GHG. Carbons remain in Towngas
#### Notice that we assigned primary consumption of LNG in Towngas, so that we can capture LNG not used in Towngas production
Del_Dummy["X29","X279"]=0

##(2-iv) Obtain GHG IO A table Emit_Dir0, Emit_Dir1

IOT_E_GHG=IOT_energy*Del_Dummy

Emit_Dir0=data.frame(diag(EF_ind$EF_adj)%*%as.matrix(IOT_E_GHG))
rownames(Emit_Dir0)=rownames(IOT_energy)


##(2-v) obtain GHG IO Final Demand Emit_Dir0_FinD, Emit_Dir1_FinD

Del_Dummy_FinD=matrix(rep(1,dim(IOT_energy_FinD)[1]*dim(IOT_energy_FinD)[2]),dim(IOT_energy_FinD)[1],dim(IOT_energy_FinD)[2])
rownames(Del_Dummy_FinD)=rownames(IOT_energy_FinD)
colnames(Del_Dummy_FinD)=colnames(IOT_energy_FinD)
#### Transformed energy doesn't emit GHG in Final Consumption (X274-X278 Elec, X280 Heat)
Del_Dummy_FinD[c(paste("X",(274:278),sep=""),"X280"),]=0

IOT_E_GHG_FinD=IOT_energy_FinD*Del_Dummy_FinD

Emit_Dir0_FinD=data.frame(diag(EF_ind$EF_adj)%*%as.matrix(IOT_E_GHG_FinD))
colnames(Emit_Dir0_FinD)=Fin_Demand
rownames(Emit_Dir0_FinD)=rownames(IOT_energy_FinD)


##(3) Rescaling (from kton to ton)
Emit_Dir0=1000*Emit_Dir0
Emit_Dir0_FinD=1000*Emit_Dir0_FinD

##(4) Produce GHG stats
Emit_Dir1=colSums(Emit_Dir0)
Emit_Dir1_FinD=sum(Emit_Dir0_FinD[,"Final_Pc"])

Emit_Dir=Emit_Dir1
Emit_Dir_FinD=Emit_Dir1_FinD
Emit_Dir_ene=rowSums(Emit_Dir0)+Emit_Dir0_FinD$Final_Pc
Emit_Dir_G=sum(Emit_Dir)+sum(Emit_Dir0_FinD$Final_Pc)

G_name1=paste(paste("IO_E_G1",t,sep="_"),"Rdata",sep=".")

save(list=ls(), file=G_name1)

