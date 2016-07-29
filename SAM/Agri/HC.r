HC=function(x,s){
                XN={}
                if (length(x)==1){XN=x}
                if (length(x)>1) {for (i in (1:length(x))){
                                                         XN=paste(XN,x[i],sep=s)
                                                        }
                                  XN=substring(XN,2,nchar(XN))
                                  }
                                  return(XN)
                 }
HC.com=function(X){HC(X,",")}                 