GHG_IO_ind=read.csv(file="GIO_2010.csv",header=T,as.is=T)
GHG_IO_ind[,1]=as.numeric(substr(GHG_IO_ind[,1],2,nchar(GHG_IO_ind[,1])))
colnames(GHG_IO_ind)[1]="sector"
G_fd=read.csv(file="GIO_FD_2010.csv",header=T,as.is=T)
GHG_IO_F=G_fd[,colnames(G_fd)=="Final_Pc"]
