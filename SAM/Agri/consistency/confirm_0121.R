Cropmap=read.csv("New_iocost_ratio_crop_0121.csv",header=T,as.is=T)
CropT=read.csv("Newcost_crop_0121.csv",header=T,as.is=T)
Cropmap=Cropmap[,-1]
CropT=CropT[,-1]
Crop_data=merge(Cropmap,CropT,by.x="TC",by.y="Group.1",all=T)

lsmap=read.csv("iocost_ratio_LS_0121.csv",header=T,as.is=T)
lsT=read.csv("cost_LS_0121.csv",header=T,as.is=T)
lsmap=lsmap[,-1]
lsT=lsT[,-1]
ls_data=merge(lsmap,lsT,by.x="TC",by.y="Group.1",all=T)
ncrop=8
NLiveStock=5

iomap=read.csv("iomap_0121.csv",header=T,as.is=T)
Crop_data=merge(Crop_data,iomap,by="io",all=T)
cropname=paste(colnames(Crop_data)[3:(2+ncrop)],"_piece",sep="")
ls_data=merge(ls_data,iomap,by="io",all=T)
lsname=paste(colnames(ls_data)[3:(2+NLiveStock)],"_piece",sep="")

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

TC_LC=aggregate(ls_data[,((3+2*NLiveStock+1):(3+3*NLiveStock))],by=list(ls_data$TC),FUN=sum)
C_LC=aggregate(ls_data[,((3+2*NLiveStock+1):(3+3*NLiveStock))],by=list(ls_data$c),FUN=sum)
TC_Crop=aggregate(Crop_data[,((3+2*ncrop+1):(3+3*ncrop))],by=list(Crop_data$TC),FUN=sum)
C_Crop=aggregate(Crop_data[,((3+2*ncrop+1):(3+3*ncrop))],by=list(Crop_data$c),FUN=sum)

iocost_ratio=merge(Cropmap, lsmap,by=c("TC","io"),all=T)
iocost_ratio[is.na(iocost_ratio)]=0
TC=merge(CropT,lsT,by="Group.1",all=T)
TC[is.na(TC)]=0
write.csv(iocost_ratio,file="iocost_r_Agri_0121.csv")
colnames(TC)[1]="tc"
write.csv(TC,file="cost_Agri_0121.csv")
