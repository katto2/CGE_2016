## input should be prepared as follows.
#STEP 1: Size.SAM Determine the size of SAM   

#ind=36
#green=1
#fac=2
#h=1
#gov=1
#Nres=1
#tax=4
#S_I=1
#ROW=1

#Size.Sam=c(ind,green,fac,h,gov,Nres,tax,S_I,ROW)

#STEP 2: data.out : NON I-O data

#YTAX=83753*1000
#TRANSFER=39046*1000

#data.out=c(YTAX,TRANSFER)

# STEP 3: I-O data
##load I-O data (model)
#IO_model=read.csv("IO_model.csv",header=T, as.is=T)
#rownames(IO_model)=IO_model[,1]
#IO_model=IO_model[,-1]
# clean up IO: getting rid of subsums
#n_totalrow=c("idinput1", "idinput2", "VA", "Tinput")
#n_totalcol=c("Dint", "Dfin", "Dtotal", "Qtotal","Stotal_b","Contotal","Stotal_p" )
#IO_model1=IO_model[is.na(match(rownames(IO_model),n_totalrow)),]
#IO_model2=IO_model1[,is.na(match(colnames(IO_model),n_totalcol))]


#DIO=as.matrix(IO_model2)




SAM_agg_basic=function(Size.Sam,data.out,DIO){
#load library Matrix
library(Matrix)
#Determine the size of SAM

ind=Size.Sam[1]
green=Size.Sam[2]
fac=Size.Sam[3]
h=Size.Sam[4]
gov=Size.Sam[5]
Nres=Size.Sam[6]
tax=Size.Sam[7]
S_I=Size.Sam[8]
ROW=Size.Sam[9]

#Prepare SAM as Zero Matrix
SAM_s=2*(ind+green)+fac+h+gov+Nres+tax+S_I+ROW
SAM=matrix(nrow=SAM_s,ncol=SAM_s)
SAM[,]=0

# STEP1: Activity Colum [,1:ind]
## STEP1-1: Intermediate demand
SAM[(ind+green+1):(2*ind+green),1:ind]=as.matrix(DIO[1:ind,1:ind])

## STEP1-2:Factor cost for each Activity
SAM[(2*(ind+green)+1),1:ind]=DIO["Payroll",1:ind] #employee payment
SAM[(2*(ind+green)+2),1:ind]=colSums(DIO[c("Surplus","Deprec"),1:ind]) # surplus-depreciation

## STEP1-3: Net Scrap supply for each Activity
#cost saved by scrap(-) + supply in scrap (+) . Pretend that each industry buy scrap supply and sell them in the market.
SAM[(2*(ind+green)+fac+h+gov+Nres),1:ind]=DIO["Resin",1:ind]+DIO[1:ind, "Resout"] 

## STEP1-4: Production Tax[interemediate] for each Activity
SAM[(2*(ind+green)+fac+h+gov+Nres+1),1:ind]=DIO["PTAXin",1:ind] # production tax on intermediate demand

## STEP1-5: Production Tax etc for each Activity
SAM[(2*(ind+green)+fac+h+gov+Nres+2),1:ind]=DIO["PTAXetc",1:ind] # production tax on intermediate demand


#STEP2: Commodity Column [,ind+green+1:2*ind+green]
## STEP2-1: Activity Commodity equality
totalout=colSums(DIO[(1:(dim(DIO)[1])),(1:ind)])+DIO[1:ind, "Resout"] 
totalout.m=as.matrix(Diagonal(ind,totalout))
SAM[1:ind,(ind+green+1):(2*ind+green)]=totalout.m


## STEP2-2: Import Tax
SAM[(2*(ind+green)+fac+h+gov+Nres+3),(ind+green+1):(2*ind+green)]=DIO[1:ind,"PTAXim"]

## STEP2-3: Import
SAM[SAM_s,(ind+green+1):(2*ind+green)]=DIO[1:ind,"Imp"]

# STEP 3: Factor Column [,(2*(ind+green)+1):(2*(ind+green)+2)]
L_inc=DIO["Payroll",1:ind] # employee payment
K_inc=colSums(DIO[c("Surplus","Deprec"),1:ind]) # running surplus-depreciation
SL_inc=sum(L_inc)#Labor Income
SK_inc=sum(K_inc)#Capital Income
SAM[(2*(ind+green)+fac+h),(2*(ind+green)+1)]=SL_inc
SAM[(2*(ind+green)+fac+h),(2*(ind+green)+2)]=SK_inc

# STEP 4: Household Column [,(2*(ind+green)+fac+h)]
## STEP 4-1: Household Consumption
SAM[(ind+green+1):(2*ind+green),(2*ind+2*green+fac+h)]=DIO[1:ind,"HE"]

## STEP 4-2: Household tax payment:Ptaxin
SAM[2*(ind+green)+fac+h+gov+Nres+1,(2*ind+2*green+fac+h)]=DIO["PTAXin","HE"]

## STEP 4-3: Household tax payment:YTAX
SAM[2*(ind+green)+fac+h+gov+Nres+tax,(2*ind+2*green+fac+h)]=data.out[1]


## STEP 4-3 Household Savings
#SAM[(2*(ind+green)+fac+h+gov+Nres+tax+S_I),(2*ind+2*green+fac+h)]=data.out[2]

# STEP 5 : Government Column [, (2*(ind+green)+fac+h+gov)]: Consumption, Transferpayment, Savings
## STEP 5-1: Government Consumption
SAM[(ind+green+1):(2*ind+green),(2*(ind+green)+fac+h+gov)]=DIO[1:ind,"GE"]

## STEP 5-2: Tranfer Payment
SAM[(2*(ind+green)+fac+h),(2*(ind+green)+fac+h+gov)]=data.out[2]

## STEP 5-3: Government tax payment:Ptaxin
SAM[2*(ind+green)+fac+h+gov+Nres+1,(2*ind+2*green+fac+h+gov)]=DIO["PTAXin","GE"]


## STEP 5-4: Government Savings
#Gsaving=dsavings[2]
#SAM[(2*(ind+green)+fac+h+gov+tax+S_I),(2*(ind+green)+fac+h+gov)]=Gsaving



# STEP 6 : Nres Column [, (2*(ind+green)+fac+h+gov+Nres)]: -1*cost save in final consumption due to scrap = net scrap supply
## STEP 6-1: Household consumption
SAM[2*(ind+green)+fac+h,(2*(ind+green)+fac+h+gov+Nres)]=-1*DIO["Resin","HE"]

## STEP 6-2: Government consumption
SAM[2*(ind+green)+fac+h+gov,(2*(ind+green)+fac+h+gov+Nres)]=-1*DIO["Resin","GE"]

## STEP 6-3: Investment consumption
Invindex=c("HI","GI","ST","Gold")
SAM[2*(ind+green)+fac+h+gov+Nres+tax+S_I,(2*ind+2*green+fac+h+gov+Nres)]=-1*sum(DIO["Resin",Invindex])

## STEP 6-4: Import
SAM[2*(ind+green)+fac+h+gov+Nres+tax+S_I+ROW,(2*ind+2*green+fac+h+gov+Nres)]=-1*DIO["Resin","Imp"]


#STEP 7: Tax Column [,(2*(ind+green)+fac+h+gov+Nres+1):(2*(ind+green)+fac+h+Nres+tax)]
## STEP 6-1: Production Tax on consumption (Ptaxin)
S_PTAXin=sum(DIO["PTAXin",])#(Production tax -Production Subsidy)
S_PTAXetc=sum(DIO["PTAXetc",])
S_Tarrif=sum(DIO[,"PTAXim"])
SAM[(2*(ind+green)+fac+h+gov),(2*(ind+green)+fac+h+gov+Nres+1):(2*(ind+green)+fac+h+gov+Nres+tax)]=c(S_PTAXin,S_PTAXetc,S_Tarrif,data.out[1])

# STEP 7: Savings-Investment Column [,(2*(ind+green)+fac+h+gov+Nres+tax+S_I)]
#Private Investment+Government Investment+Stock change + jewerly
SAM[(ind+green+1):(2*ind+green),(2*(ind+green)+fac+h+gov+Nres+tax+S_I)]=rowSums(DIO[1:ind,Invindex])
#Ptaxin in investment (Ptax paid in investment good consumption)
SAM[2*(ind+green)+fac+h+gov+Nres+1,(2*(ind+green)+fac+h+gov+Nres+tax+S_I)]=sum(DIO["PTAXin",Invindex])

# STEP 8: ROW Rest Of World Column [,(2*(ind+green)+fac+h+gov+Nres+tax+S_I+ROW)]
## STEP 8-1: Export as the consumption of ROW
SAM[(ind+green+1):(2*ind+green),(2*(ind+green)+fac+h+gov+Nres+tax+S_I+ROW)]=DIO[1:ind,"EX"]
## STEP 8-2: PTAXin paid to imports. (Cost paid by ROW)
SAM[2*(ind+green)+fac+h+gov+Nres+1,(2*(ind+green)+fac+h+gov+Nres+tax+S_I+ROW)]=DIO["PTAXin","Imp"]




#STEP 9: Household, government,Foreign savings
## STEP 9-1 Household Savings
SAM[(2*(ind+green)+fac+h+gov+Nres+tax+S_I),(2*ind+2*green+fac+h)]=sum(SAM[(2*ind+2*green+fac+h),])-sum(SAM[,(2*ind+2*green+fac+h)])
## STEP 9-2 Government Savings
SAM[(2*(ind+green)+fac+h+gov+Nres+tax+S_I),(2*(ind+green)+fac+h+gov)]=sum(SAM[(2*ind+2*green+fac+h+gov),])-sum(SAM[,(2*ind+2*green+fac+h+gov)])
## STEP 9-3: Foreing saving = Import -Export-Ptaxin in import
FSAV=sum(DIO[1:ind,"Imp"])-sum(DIO[1:ind,"EX"])-DIO["PTAXin","Imp"]
SAM[(2*(ind+green)+fac+h+gov+Nres+tax+S_I),(2*(ind+green)+fac+h+gov+Nres+tax+S_I+ROW)]=FSAV


return(SAM)
}

#SAM_model=data.frame(SAM_agg(Size.Sam,data.out,DIO))

#write.csv(SAM_model, file="SAM_model.csv")





