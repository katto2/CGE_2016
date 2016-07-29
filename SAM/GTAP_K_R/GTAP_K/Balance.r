# This file replaces GTAP_K_KWS.gms 
# GTAP_K_KSW has following tasks. 
# (1)Balancing Input and output using basic price IO/producers' price IO (82 sector)
# (2)Adjust Basic price IO Final demand to make Total input in Producers' price match with total domestic demand in basic price 
# [Adjust: Should Adjust Producers' price IO Final demand to make total input in basic price match with total domestic demand in producers' price]
# (3)Generate variables in 2007 price [Adjust to 2011]
# [Adjust: GTAP 9 base year is 2011. Should convert in 2011 price]
# (4)International transportation. Shipping / Passenger division. On IO, we only have passenger related transaction record.
# (5)Generate GTAP variable 
# (6)GTAP variable balance check
# (7)Negative Final Demand adjustment

# (0) 2011 GDP deflator and 2011 Dollor/Won exchange rate (Bank of Korea. http://ecos.bok.or.kr/) 
## All values in Global model is in 2011 dollar terms. 
t=2010
GDPDF=data.frame(c(100, 101.6, 102.6))
rownames(GDPDF)=c(2010:2012)
colnames(GDPDF)="Deflator"

CR_2011=(1101.84+1114.14)/2 #mean over Fist half average and Secon half average
CR=data.frame(rep(CR_2011,3))
rownames(CR)=(2010:2012)
colnames(CR)="one-dollar EX"

G_name2=paste(paste("IO_E_G2",t,sep="_"),"Rdata",sep=".")
load(G_name2)


# (1)Balancing Input and output using basic price IO/producers' price IO (82 sector)
## Previously, we needed this step for two reasons.
### (a) basic price IO is estimated. balance was not guranteed. 
### (b) producers' price VA is used both in basic price IO and producers' price IO. The basic price IO input cannot be balanced with domestic demand
## We did this because basic price VA was not available. Especially PTAXin in basic price could not be recoverd from producers' price VA. 
## But, from 2011, we estimate producers' price IO using basic price IO. So, we do have raw data on basic price VA. 
## And producers' price VA can be recovered from basic price VA. 
###(i) Except for PTAXin and PTAXetc, VA in basic price is identical with VA in producers' price
###(ii) In producer's price IO, ptaxin is set to 0
###(iii) We assume that the ratio of basic price PTAXetc to producer's price PTAXetc doesn't change. Then we can obtain estimates of producers' price PTAXetc   
### So, we stop (b) practice and use producers' price VA estimates for producers' IO estimates
### Regarding (a) We adjusted F_T_N_est_82_m and F_T_N_384_est, 
### so that total output XP_0_384_est + resout_0 = Total demand +resin_0/XP_0_82_est_m+XPB_resout=Total demand+XPB_resin
### is guaranteed in NIO_Est_agg.r. So no need for further balance check.
### In conclusion, we don't need this balancing stuff. I put it here for checking.






