### This file replaces cal_IOT_KSW.gms, which creats Producers' price IO using basic price IO.
### From 2011, Bank of Korea only publishes basic price IO annually. But,the producers' price IO will be published for every five years (base year) only.
### Since we need producers' price IO, we will estimate one using basic price IO and the relationship between base price IO and producers' price IO in base year.
### For example, A_T_N_est=A_T_B/R_T_N(base). R_T_N(base)=1+(A_T_B(base)-A_T_N(base))/(A_T_N(base))
### All operations are done using 384 industry files
### Specifically, the estimation is done in following steps


#(1) Obtain ratio coefficeints
##(1-i) load base year data
tb=2010
D_name1=paste(paste("D1",tb,sep="_"),"Rdata",sep=".")
load(D_name1)
## 384 industries
#(1-ii) VA ratio: R_V_N=(V_B-V_N)/V_N,
## if V_B(ij)=0 and V_N(ij)!=0, then we cannot V_N b/c V_B is zero

R_V_N_384=(V_B_384[c("labor","surplus","dep","PTAXetc"),]-V_N_384[c("labor","surplus","dep","PTAXetc"),])/V_N_384[c("labor","surplus","dep","PTAXetc"),]
R_V_N_384[is.na(R_V_N_384)]=0

#(1-iii) A_M_N and F_M_N ratio. (A_M_B-A_M_N/A_M_N), (F_M_B-F_M_N)/F_M_N)

R_MFTAX_K_384=(A_M_B_384-A_M_N_384)/A_M_N_384
R_MFTAX_K_384[is.na(R_MFTAX_K_384)]=0 

R_MFCTAX_K_384=(F_M_B_384-F_M_N_384)/F_M_N_384
R_MFCTAX_K_384[is.na(R_MFCTAX_K_384)]=0

#(1-vi) A_D_N and F_D_N ratio. (A_D_B-A_D_N/A_D_N)),(F_D_B-F_D_N/F_D_N)

DFTAX_K_384=A_D_B_384-A_D_N_384
DFCTAX_K_384=F_D_B_384-F_D_N_384

R_DFTAX_K_384=DFTAX_K_384/A_D_N_384
R_DFTAX_K_384[is.na(R_DFTAX_K_384)]=0

R_DFCTAX_K_384=DFCTAX_K_384/F_D_N_384
R_DFCTAX_K_384[is.na(R_DFCTAX_K_384)]=0


#(2) save ratio coefficients
R_name=paste(paste("R_est",tb,sep="_"),"Rdata",sep=".")
R_384_names=c("R_V_N_384", "R_MFTAX_K_384", "R_MFCTAX_K_384", "R_DFTAX_K_384", "R_DFCTAX_K_384")
save(list=R_384_names,file=file.path("Agg/IOT",R_name))

#(3) clear memory and load relevent data
rm(list=ls())
t=2010
D_name_t=paste(paste("D1",t,sep="_"),"Rdata",sep=".")
load(D_name_t)

load(file.path("Agg/IOT","R_est_2010.Rdata"))


#(4) Obtain Estimated producers' price IO in 384 industries

##(4-i) VA
V_N_384_est=V_B_384[c("labor","surplus","dep","PTAXetc"),]/(1+R_V_N_384)
V_N_384_est[is.na(V_N_384_est)]=0 # if R_V_N is -1. then V_N_384_est has NaN. R_V_N=-1 => V_B=0, then we set V_N_384_est as zero.

PTAXin_384_est=t(data.frame(rep(0,dim(V_N_384_est)[2])))## PTAXin in V_N (producers' price) is always zero.
colnames(PTAXin_384_est)=colnames(V_N_384_est)
rownames(PTAXin_384_est)="PTAXin"
V_N_384_est=rbind(PTAXin_384_est,V_N_384_est)

##(4-ii) A_M_N, F_M_N
A_M_N_384_est=A_M_B_384/(1+R_MFTAX_K_384) 
# if R_MFTAX_K=-1 then A_M_N_384_est has NaN. this happens when A_M_B=0 , A_M_N!=0. We cannot recover this value b/c A_M_B=0. So we set this value as zero
A_M_N_384_est[is.na(A_M_N_384_est)]=0

F_M_N_384_est=F_M_B_384/(1+R_MFCTAX_K_384)

##(4-iii) A_D_N, F_D_N
F_D_N_384_est=F_D_B_384/(1+R_DFCTAX_K_384)
F_D_N_384_est[,"Final_Ex"]=F_D_B_384[,"Final_Ex"]
F_D_N_384_est[,"Final_Tot"]=rowSums(F_D_N_384_est[,c(Fin_DD,Fin_DX)])
A_D_N_384_est=A_D_B_384/(1+R_DFTAX_K_384)

#(4-iv) A_T_N and F_T_N. A_T_N=A_D_B+A_M_B, F_T_N=F_T_B+F_M_B

F_T_N_384_est=F_D_N_384_est+F_M_N_384_est
A_T_N_384_est=A_D_N_384_est+A_M_N_384_est

#(5) generate XP matching total input residual adjustment Total output = Total input + cost saved by scrap (resin)
## Notice that Domestic Demand = Total output + Scrap supply = Total input + Cost saved by scrap + Scrap supply
cal_FD=colSums(V_N_384_est)+colSums(A_T_N_384_est)+resin_b0-(rowSums(A_D_N_384_est)+F_D_N_384_est[,"Final_Tot"]-resout_b0)
F_D_N_384_est[,"Final_St"]=cal_FD+F_D_N_384_est[,"Final_St"]
F_D_N_384_est[,"Final_Tot"]=rowSums(F_D_N_384_est[,c(Fin_DD,Fin_DX)])
F_M_N_384_est[,"Final_Tot"]=rowSums(F_M_N_384_est[,Fin_DD])
F_T_N_384_est=F_D_N_384_est+F_M_N_384_est
XP_0_384_est=rowSums(A_D_N_384_est)+F_D_N_384_est[,"Final_Tot"]-resout_b0 #Total Domestic Demand-Scrap supply =Total Output

check_384=XP_0_384_est-colSums(A_T_N_384_est)-colSums(V_N_384_est)-resin_b0
print ("max (abs(Total output_est-Total input_est)) in 384 industries")
print (max(abs(check_384)))

#(4_A) Obtain Estimated producers' price IO in 82 industries by aggregating A, F, V in 384 industries.

#(4-A-1) load industry matching 
Indmatch=read.csv(file=file.path("Agg/IOT","IO_index.csv"), header=T,as.is=T)
Indmatch=Indmatch[,c("basecode","m_code")]
Indmatch$X=paste("X",Indmatch$basecode,sep="")

#(4-A-2) VA aggregation
T_V_N_384_est=data.frame(t(V_N_384_est))
T_V_N_384_est$X=rownames(T_V_N_384_est)
T_V_N_est_m=merge(T_V_N_384_est,Indmatch, by="X", all=T, sort=F)
T_V_N_est_82=aggregate(T_V_N_est_m[,c(2:6)],list(T_V_N_est_m$m_code),FUN=sum)
V_N_est_82_m=data.frame(t(T_V_N_est_82))
V_N_est_82_m=V_N_est_82_m[-1,]

#(4-A-3) F_D_N, F_M_N aggregation
F_D_N_384_est$X=paste("X",rownames(F_D_N_384_est),sep="")
F_D_N_est_m=merge(F_D_N_384_est,Indmatch,by="X",all=T,sort=F)
F_D_N_est_82_m=data.frame(aggregate(F_D_N_est_m[,(2:9)],list(F_D_N_est_m$m_code),FUN=sum))
F_D_N_est_82_m=F_D_N_est_82_m[,-1] # Industry index used for merging is dropped

F_M_N_384_est$X=paste("X",rownames(F_M_N_384_est),sep="")
F_M_N_est_m=merge(F_M_N_384_est,Indmatch,by="X",all=T,sort=F)
F_M_N_est_82_m=data.frame(aggregate(F_M_N_est_m[,(2:9)],list(F_M_N_est_m$m_code),FUN=sum))
F_M_N_est_82_m=F_M_N_est_82_m[,-1] # Industry index used for merging is dropped

#(4-A-4) A_D_N, A_M_N aggregation
A_D_N_384_est$X=paste("X",rownames(A_D_N_384_est),sep="")
A_D_N_est_m=merge(A_D_N_384_est,Indmatch,by="X",all=T,sort=F)
dim_ADN=dim(A_D_N_est_m)
A_D_N_est_m_r=data.frame(aggregate(A_D_N_est_m[,(2:(dim_ADN[2]-2))],list(A_D_N_est_m$m_code),FUN=sum)) #RowSums
T_A_D_N_est_m_r=data.frame(t(A_D_N_est_m_r))#transpose
T_A_D_N_est_m_r=T_A_D_N_est_m_r[-1,]

T_A_D_N_est_m_r$X=rownames(T_A_D_N_est_m_r)
T_A_D_N_est_m=merge(T_A_D_N_est_m_r,Indmatch,by="X",all=T,sort=F)#merge with 82 industry index
dim_TADN=dim(T_A_D_N_est_m)
T_A_D_N_est_m_c=data.frame(aggregate(T_A_D_N_est_m[,(2:(dim_TADN[2]-2))],list(T_A_D_N_est_m$m_code),FUN=sum)) #colSums
A_D_N_est_82_m=data.frame(t(T_A_D_N_est_m_c))
A_D_N_est_82_m=A_D_N_est_82_m[-1,]

A_M_N_384_est$X=paste("X",rownames(A_M_N_384_est),sep="")
A_M_N_est_m=merge(A_M_N_384_est,Indmatch,by="X",all=T,sort=F)
dim_AMN=dim(A_M_N_est_m)
A_M_N_est_m_r=data.frame(aggregate(A_M_N_est_m[,(2:(dim_AMN[2]-2))],list(A_M_N_est_m$m_code),FUN=sum)) #RowSums
T_A_M_N_est_m_r=data.frame(t(A_M_N_est_m_r))#transpose
T_A_M_N_est_m_r=T_A_M_N_est_m_r[-1,]

T_A_M_N_est_m_r$X=rownames(T_A_M_N_est_m_r)
T_A_M_N_est_m=merge(T_A_M_N_est_m_r,Indmatch,by="X",all=T,sort=F)#merge with 82 industry index
dim_TAMN=dim(T_A_M_N_est_m)
T_A_M_N_est_m_c=data.frame(aggregate(T_A_M_N_est_m[,(2:(dim_TAMN[2]-2))],list(T_A_M_N_est_m$m_code),FUN=sum)) #colSums
A_M_N_est_82_m=data.frame(t(T_A_M_N_est_m_c))
A_M_N_est_82_m=A_M_N_est_82_m[-1,]

#(4-A-5) A_T_N, F_T_N 
A_T_N_est_82_m=A_M_N_est_82_m+A_D_N_est_82_m
F_T_N_est_82_m=F_M_N_est_82_m+F_D_N_est_82_m


#(5) generate XP matching total input residual adjustment Total output = Total input + cost saved by scrap (resin)
## Notice that Domestic Demand = Total output + Scrap supply = Total input + Cost saved by scrap + Scrap supply

cal_FD_82_m=colSums(V_N_est_82_m)+colSums(A_T_N_est_82_m)+XPB_resin-(rowSums(A_D_N_est_82_m)+F_D_N_est_82_m[,"Final_Tot"]-XPB_resout)
F_D_N_est_82_m[,"Final_St"]=cal_FD_82_m+F_D_N_est_82_m[,"Final_St"]
F_D_N_est_82_m[,"Final_Tot"]=rowSums(F_D_N_est_82_m[,c(Fin_DD,Fin_DX)])
F_M_N_est_82_m[,"Final_Tot"]=rowSums(F_M_N_est_82_m[,Fin_DD])
F_T_N_est_82_m=F_D_N_est_82_m+F_M_N_est_82_m
XP_0_82_est_m=rowSums(A_D_N_est_82_m)+F_D_N_est_82_m[,"Final_Tot"]-XPB_resout #Total Domestic Demand-Scrap supply =Total Output

check_82=XP_0_82_est_m-colSums(A_T_N_est_82_m)-colSums(V_N_est_82_m)-XPB_resin
print ("max (abs(Total output_est-Total input_est)) in 82 industries")
print (max(abs(check_82)))

if (t!=2010){
  V_N_384=V_N_384_est
  A_D_N_384=A_D_N_384_est
  A_M_N_384=A_M_N_384_est
  A_T_N_384=A_T_N_384_est
  F_D_N_384=F_D_N_384_est
  F_M_N_384=F_M_N_384_est
  F_T_N_384=F_T_N_384_est
  V_N_82=V_N_est_82_m
  
  A_D_N_82=A_D_N_est_82_m
  A_M_N_82=A_M_N_est_82_m
  A_T_N_82=A_T_N_est_82_m
  F_D_N_82=F_D_N_est_82_m
  F_M_N_82=F_M_N_est_82_m
  F_T_N_82=F_T_N_est_82_m
  
  xpnorm=XP_0_82_est_m
  XPN_resin=XPB_resin
  XPN_resout=XPB_resout
  XP_0=XP_0_384_est
  resin_0=resin_b0
  resout_0=resout_b0
}

D_name_est=paste(paste("D1_est",t,sep="_"),"Rdata",sep=".")

save(list=ls(), file=D_name_est)




