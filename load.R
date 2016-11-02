#+++++++++++++++++++++++++++++++++++++++++++++++++++++++

# scrap 1-min chart from NIFTY50 index to understand the maximum
# deviation time on the plot

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++
suppressPackageStartupMessages(library("ggplot2"))
suppressPackageStartupMessages(library("dplyr"))
suppressPackageStartupMessages(library("reshape2"))
suppressPackageStartupMessages(library("lubridate"))
#suppressPackageStartupMessages(library("ggthemr"))
suppressPackageStartupMessages(library("stringr"))

 options(show.error.messages=F)


runTest <- function(yr,mn,dt){

	YEAR= yr   #2016
	MONTH= mn  #9
	DATE= dt   #6

	if(MONTH<10){
		MONTH=str_pad(MONTH, 2, pad = "0")
		}

	if(DATE<10){
		DATE=str_pad(DATE, 2, pad = "0")
		}
		
		  
	  dat =as.POSIXct(paste(YEAR, MONTH, DATE),format="%Y%m%d", tz="UTC")	

	  m=month(dat,label=T)

	  mm=toupper(m)

	  df=read.table((paste0("NIFTY_HistoricalData/",YEAR,"/",YEAR," ",mm," NIFTY",".txt",sep="")),sep=",")

	  colnames(df)[4]="Open"
	  colnames(df)[5]="High"
	  colnames(df)[6]="Low"
	  colnames(df)[7]="Close"
	  df$chg <- ifelse(df$Close > df$Open, "up", "dn")

	  dff= mutate(df,id=as.POSIXct(paste(df[,2], df[,3]),format="%Y%m%d %H:%M", tz="UTC")) 

	  dff$time=format(dff$id, "%H:%M")
	  dff$time=as.factor(as.character(dff$time))

	  dff$date=format(dff$id, "%Y-%m-%d")
	  dff=mutate(dff,Time=60*hour(id)+minute(id))

	  ram=filter(dff,V2==paste0(YEAR,MONTH,DATE,sep=""))
              
          return(ram)

  }
 
  
  
