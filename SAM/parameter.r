#sigmaq.data=read.csv(file="sigmaq.csv",header=T,as.is=T)
#sigmaq.n=sigmaq.data[,2]
#sigmaq.c=paste(paste("sigmaq('",sigmaq.data[,1],"')=",sep=""),sigmaq.n,";",sep="")
#cat(sigmaq.c, file="sigmaq.txt",sep="\n")

library(XLConnect)
library(qdap)

param.text=function(df,index,Tmax){
  P.TEXT={}
  ind=df[,(1:index)]
  param.number=dim(df)[2]-index
  for (i in (1:param.number)){
    if (index==1) {param.i=paste(colnames(df)[index+i],"('",ind,"')=",df[,(index+i)],";",sep="")} 
    else {param.i=paste(colnames(df)[index+i],"('",paste2(ind,sep="','"),"')=",df[,(index+i)],";",sep="")}
    filename.i=paste(colnames(df)[index+i],"txt",sep=".")
    if (Tmax==0){filename.i=paste("parameter/static/",filename.i,sep="")} else {filename.i=paste("parameter/recursive/",filename.i,sep="")}
    cat(param.i,file=filename.i,sep="\n")
    P.TEXT=c(P.TEXT,param.i)}
  #  cat(P.TEXT, file=filename,sep="\n")
}
xlsname="parameter.xlsx"
Tmax=25
param.d=loadWorkbook(xlsname)
index=sapply((strsplit(getSheets(param.d),"\\.")),FUN=length)
Ndata=length(index)
for (j in 1:Ndata){ 
  param.j=readWorksheet(param.d,sheet=j)
  if (as.numeric(is.na((match("t",colnames(param.j)))))==0){param.j=param.j[param.j$t<=Tmax,]}
  index.j=index[j]
  #print(param.j)
  param.text(param.j,index.j,Tmax)
}



#param.t=readWorksheet(param.d,sheet="T")
#param.c=readWorksheet(param.d,sheet="C")
#param.gc.t=readWorksheet(param.d,sheet="gc.t")

#param.text(param.g,1)
#param.text(param.c,1)
#param.text(param.gc.t,2)

#param.g.text={}
#nind=1
#gind=param.g[,1]
#param.g.number=dim(param.g)[2]-1
#for (i in (1:param.g.number)){
#  if (nind==1) {param.g.i=paste(colnames(param.g)[1+i],"('",gind,"')=",param.g[,(1+i)],";",sep="")} 
#  else {param.g.i=paste(colnames(param.g)[1+i],"('",paste2(gind,sep="','"),"')=",param.g[,(1+i)],";",sep="")}
#  filename_i=paste(colnames(param.g)[nind+i],"txt",sep=".")
#  cat(param.g.i, file=filename_i,sep="\n")
#  param.g.text=c(param.g.text,param.g.i)}
#cat(param.g.text, file="param.growth.txt",sep="\n")


#param.c.text={}

#cind=param.c[,1]
#param.c.number=dim(param.c)[2]-1
#for (i in (1:param.c.number)){
#  param.c.i=paste(colnames(param.c)[1+i],"('",cind,"')=",param.c[,(1+i)],";",sep="")
#  filename.i=paste(colnames(param.c)[1+i],".txt",sep="")
#  param.c.text=c(param.c.text,param.c.i)
#}
#cat(param.c.text,file="param.c.txt", sep="\n")

#param.gc.t.text={}
#gc.t.ind=param.gc.t[,(1:2)]
#param.gc.t.number=dim(param.gc.t)[2]-2
#for (i in (1:param.gc.t.number)){
#  param.gc.t.i=paste(colnames(param.gc.t)[2+i],"('",paste2(gc.t.ind,sep="','"),"')=",param.gc.t[,(2+i)],";",sep="")
#  filename.i=paste(colnames(param.gc.t)[2+i],".txt",sep="")
#  cat(param.gc.t.i,file=filename.i,sep="\n")
#  param.gc.t.text=c(param.gc.t.text,param.gc.t.i)
#}

#cat(param.gc.t.text,file="param.gc.t.txt", sep="\n")