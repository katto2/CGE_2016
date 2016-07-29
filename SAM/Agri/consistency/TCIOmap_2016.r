## Loading bottom up io-cost files with separated grain (nnrice)

Cropmap=read.csv("cropmap_2016.csv",header=T,as.is=T)
CropT=read.csv("cropt_2016.csv",header=T,as.is=T)
Crop_data=merge(Cropmap,CropT,by="TC",all=T)

lsmap=read.csv("lsmap_2016.csv",header=T,as.is=T)
lsT=read.csv("lst_2016.csv",header=T,as.is=T)
ls_data=merge(lsmap,lsT,by="TC",all=T)
ncrop=9
NLiveStock=5

## merge io-sector mapping for TD model and merge it with io-cost model
iomap=read.csv("iomap_2016.csv",header=T,as.is=T)
Crop_data=merge(Crop_data,iomap,by="io",all=T)
cropname=paste(colnames(Crop_data)[3:(2+ncrop)],"_piece",sep="")
ls_data=merge(ls_data,iomap,by="io",all=T)
lsname=paste(colnames(ls_data)[3:(2+NLiveStock)],"_piece",sep="")

## obtain io-cost pieces for each cost item in each Agriculture production
for (i in (3:(2+ncrop))){
  piece_i=Crop_data[,i]*Crop_data[,(ncrop+i)]
  Crop_data=cbind(Crop_data,piece_i)
  colnames(Crop_data)[dim(Crop_data)[2]]=cropname[i-2]
}

for (i in (3:(2+NLiveStock))){
  piece_i=ls_data[,i]*ls_data[,(NLiveStock+i)]
  ls_data=cbind(ls_data,piece_i)
  colnames(ls_data)[dim(ls_data)[2]]=lsname[i-2]
}

## obtain cost describtion
#Livestock BU cost item
TC_LC=aggregate(ls_data[,((3+2*NLiveStock+1):(3+3*NLiveStock))],by=list(ls_data$TC),FUN=sum)
#Livestock TD input item
C_LC=aggregate(ls_data[,((3+2*NLiveStock+1):(3+3*NLiveStock))],by=list(ls_data$c),FUN=sum)
#Crop BU cost item (grain separated)
TC_Crop=aggregate(Crop_data[,((3+2*ncrop+1):(3+3*ncrop))],by=list(Crop_data$TC),FUN=sum)
#Crop TD input item (grain separated)
C_Crop=aggregate(Crop_data[,((3+2*ncrop+1):(3+3*ncrop))],by=list(Crop_data$c),FUN=sum)


write.csv(C_Crop,file="C_Crop_2016_temp.csv")
write.csv(C_LC,file="C_LC_2016_temp.csv")

## Adjust grain in Rice and Barley
# BU cost of Rice, Barley, Grain
RiceBarley_adj=TC_Crop[,c(1:3,dim(TC_Crop)[2])]
# Grain cost split in rice and barley and merge 
RiceBarleysplit=read.csv("riecbarleysplit_2016.csv",header=T,as.is=T)
# merge BU cost and Grain cost split
RiceBarley_adj=merge(RiceBarley_adj,RiceBarleysplit, by.x="Group.1", by.y="TC",all=T)
# Obtain Rice and Barley with Grain piece
RiceBarley_adj$ricebase=RiceBarley_adj$rice.x_piece/RiceBarley_adj$Rice_o_r
RiceBarley_adj$Barleybase=RiceBarley_adj$barley.x_piece/RiceBarley_adj$Barley_o_r
RiceBarley_adj[RiceBarley_adj$Barley_o_r==0,"Barleybase"]=0
# Obtain grain piece in Rice/Barley by Rice/Barley with grain - Rice/Barley without grain
RiceBarley_adj$nrice_rice=RiceBarley_adj$ricebase-RiceBarley_adj$rice.x_piece
RiceBarley_adj$nrice_Barley=RiceBarley_adj$Barleybase-RiceBarley_adj$barley.x_piece
# Obtain ratio of Grain in Rice/Grain, Grain in Barley/Barley
RiceBarley_adj$nrice_rice_ratio=RiceBarley_adj$nrice_rice/RiceBarley_adj$nrice.x_piece
RiceBarley_adj$nrice_rice_ratio[RiceBarley_adj$nrice.x_piece==0]=0
RiceBarley_adj$nrice_Barley_ratio=RiceBarley_adj$nrice_Barley/RiceBarley_adj$nrice.x_piece
RiceBarley_adj$nrice_Barley_ratio[RiceBarley_adj$nrice.x_piece==0]=0

## merge Crop BU cost data with adjusted Rice and Barley input data.
Crop_data_adj=Crop_data
Crop_data_adj=merge(Crop_data,RiceBarley_adj, by.x="TC",by.y="Group.1",as.is=T,all=T)

##split nrice BU cost in io items
Crop_data_adj$nrice_rice=Crop_data_adj$nrice.x_piece.x*Crop_data_adj$nrice_rice_ratio
Crop_data_adj$nrice_Barley=Crop_data_adj$nrice.x_piece.x*Crop_data_adj$nrice_Barley_ratio

colSums(Crop_data[,22:dim(Crop_data)[2]])
##Obtain io cost of Rice/Barley with grain = Rice/Barley without grain + Rice/Barley with grain
Crop_data_adj$rice_piece_new=Crop_data_adj$rice.x_piece.x+Crop_data_adj$nrice_rice
Crop_data_adj$Barley_piece_new=Crop_data_adj$barley.x_piece.x+Crop_data_adj$nrice_Barley

#New Sam entry of Rice and Barley
NewRiceandBarley=aggregate(Crop_data_adj[,(44:45)],by=list(Crop_data_adj$c),FUN=sum)

#Recalculate TC io mapping coefficient

NewTC=aggregate(Crop_data_adj[,c("rice_piece_new","Barley_piece_new")],by=list(Crop_data_adj$TC),FUN=sum)
colnames(NewTC)=c("TC","NewRice_TC","NewBarley_TC")

Crop_data_new=merge(Crop_data_adj,NewTC, by="TC",all=T,as.is=T)

## reconstruct Crop cost data with io-cost ratio. This time, ratio is adjusted for grain split in Rice/Barley
Crop_data_new$rice.x_new=Crop_data_new$rice_piece_new/Crop_data_new$NewRice_TC
Crop_data_new$rice.x_new[Crop_data_new$NewRice_TC==0]=0
Crop_data_new$barley.x_new=Crop_data_new$Barley_piece_new/Crop_data_new$NewBarley_TC
Crop_data_new$barley.x_new[Crop_data_new$NewBarley_TC==0]=0
# check if new io cost ratio and new cost in Rice and Barley can reproduce SAM
Crop_data_new$rice.x_trialpiece=Crop_data_new$rice.x_new*Crop_data_new$NewRice_TC
Crop_data_new$barley.x_trialpiece=Crop_data_new$barley.x_new*Crop_data_new$NewBarley_TC
aggregate(Crop_data_new[,c("rice.x_trialpiece","barley.x_trialpiece")],by=list(Crop_data_new$TC),FUN=sum)
aggregate(Crop_data_new[,c("rice.x_trialpiece","barley.x_trialpiece")],by=list(Crop_data_new$c),FUN=sum)

croppieceindex=c("rice.x_trialpiece","barley.x_trialpiece","bean.x_piece","potato.x_piece","vegi.x_piece","fruit.x_piece","flower.x_piece","misscrop.x_piece")

Costsum_crop=aggregate(Crop_data_new[,match(croppieceindex,colnames(Crop_data_new))],by=list(Crop_data_new$TC),FUN=sum)
Costsum_LS=TC_LC
Inputsum_crop=aggregate(Crop_data_new[,match(croppieceindex,colnames(Crop_data_new))],by=list(Crop_data_new$c),FUN=sum)
Inputsum_LS=C_LC
Costsum_crop
Inputsum_crop
Costsum_LS
Inputsum_LS

iocostratio_index_Crop=c("io","TC","rice.x_new", "barley.x_new" ,"bean.x" ,"potato.x" ,"vegi.x" ,"fruit.x" ,"flower.x" ,"misscrop.x" )
iocostratio_index_LS=c("io","TC","dairy.x", "meat.x" ,"pork.x" ,"poultry.x" ,"misslstock.x" )
ICratio_crop=Crop_data_new[,match(iocostratio_index_Crop,colnames(Crop_data_new))]
ICratio_crop=ICratio_crop[do.call(order,ICratio_crop[,c("io","TC")]),]
ICratio_LS=ls_data[,match(iocostratio_index_LS,colnames(ls_data))]
ICratio_LS=ICratio_LS[do.call(order,ICratio_LS[,c("io","TC")]),]

Namej_crop=c("rice",   "barley", "bean","potato",     "vegi",       "fruit",      "flower",    "misscrop")      
Namea_crop=paste(Namej_crop,"-a",sep="")

colnames(Costsum_crop)[2:(ncrop)]=Namej_crop
colnames(Inputsum_crop)[2:(ncrop)]=Namea_crop
colnames(ICratio_crop)[3:(ncrop+1)]=Namej_crop
#Crop cost(BU item) data (Rice and Barley adjusted)
write.csv(Costsum_crop,file="Newcost_crop_2016.csv")
#io cost ratio in Crop cost(Rice and Barley adjusted)
write.csv(ICratio_crop,file="New_iocost_ratio_crop_2016.csv")
#Crop input(TD item) data (Rice and Barley adjusted)
write.csv(Inputsum_crop,file="Newinput_crop_2016.csv")
#Rice Barley cost data (including grain)
write.csv(NewRiceandBarley,file="ricebarley_new_2016.csv")

Namej_LS=c("dairy",      "meat",       "pork",       "poultry",    "misslstock")
Namea_LS=paste(Namej_LS,"-a",sep="")
colnames(Costsum_LS)[2:(NLiveStock+1)]=Namej_LS
colnames(Inputsum_LS)[2:(NLiveStock+1)]=Namea_LS
colnames(ICratio_LS)[3:(NLiveStock+2)]=Namej_LS

#Livstock cost(BU item) data 
write.csv(Costsum_LS,file="cost_LS_2016.csv")
#io cost ratio in Livestock cost(Rice and Barley adjusted)
write.csv(ICratio_LS,file="iocost_ratio_LS_2016.csv")
#io cost ratio in Input cost(Rice and Barley adjusted)
write.csv(Inputsum_LS,file="input_LS_2016.csv")
