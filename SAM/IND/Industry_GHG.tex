---
title: "Industry GHG"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```
This memo records the result from industry_GHG.r.

* Manufacutre emission distribution (384 ind)


```{r}
######### Part A. preparation
library(dplyr)
library(ggplot2)
library(tidyr)
#(i)load GHG data
GHG_IO=read.csv(file="GHGIO.csv",header=T, as.is=T)
GHG_IO[is.na(GHG_IO)]=0
GHG_IO_ind=GHG_IO[,colnames(GHG_IO)!="HE"]
GHG_IO_F=GHG_IO[,colnames(GHG_IO)=="HE"]

#load index mapping
sector_ind=read.csv(file="indcode_20161223.csv",header=T, as.is=T)
indname=read.csv(file="indname.csv",header=T, as.is=T)

```
To select energy intensive industry, we obtain share of emission by each manufacture among total emission from manufactutre. So we excludes AFF (1-25), Mining(26-34), Refined Oil (99-108), Service (281-286,302-384), Construction (287-301) on IO table. Then we aggregate emissions by industries, and optain emission share for each industry. Then we select industries with largest emission that covers 90% of total manufacture emissions.


```{r}
# obtain share and cumulative share (distribution function) of ghg from manufacture (35:98,109:271)
GHG_ind_dist=GHG_IO_ind %>% gather(key="ind",value,c(35:98,109:271)) %>% group_by(ind) %>% summarise(ind_ghg=sum(value)) %>% mutate(share=ind_ghg/sum(ind_ghg)) %>% arrange(desc(share)) %>% mutate(dist=cumsum(share))

#add names
indname$xcode=paste("X",indname$basecode,sep="")
GHG_ind_dist.N=merge(GHG_ind_dist,indname,by.x="ind",by.y="xcode",all.x=T)

GHG_ind_dist.N=GHG_ind_dist.N[order(GHG_ind_dist.N$share,decreasing=T),]

# keep top emitters covering 90% of emission
Top_ind=GHG_ind_dist.N %>% filter(dist<0.9) %>% arrange(desc(share))
print(Top_ind)
```
