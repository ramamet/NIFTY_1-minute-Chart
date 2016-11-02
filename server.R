
 suppressPackageStartupMessages(library("shiny"))
 suppressPackageStartupMessages(library("plotly"))
 suppressPackageStartupMessages(library("ggthemr"))

 library(stringr)
 library(RColorBrewer)
 #****************************
 #+ scrape NSE Gainers data
 source('load.R', local=TRUE)
 options(show.error.messages=F)
 
 
# Define server logic required to plot various variables against mpg
function(input, output) {

  
  output$plot1 <- renderPlot({
    
    rawdata <- reactive({
    input$refresh
    isolate(runTest(input$Year,input$Month,input$obs))

    })
    
  
    df=rawdata()
    
    if(nrow(df)<10){    
    output$text <- renderText({
      HTML(paste0("<font size='7'>","MARKET HOLIDAY","</font>",
      "<h1 style='color:blue;'>", " Happy trading","</h1>"))})
    
    }
    
    else{
     output$text <- renderText({})
    
    }
    
    
    
    tit= df$date[1]
    
    ggthemr('greyscale')
    pl <- ggplot(df, aes(x=Time))+
		  labs(title=tit)+
	           geom_linerange(data=df,aes(ymin=Low, ymax=High,color="black"),size=0.3,alpha=0.6) +
	           geom_linerange(data=df,aes(ymin=Open, ymax=Close,color=chg), size = 1.5,alpha=0.7)+
	            scale_x_continuous(breaks = c(540,570,600,630,660,690,720,750,780,810,840,870,900,930), 
		  labels = c("9:00","9:30","10:00","10:30","11:00","11:30","12:00","12:30","13:00","13:30","14:00","14:30","15:00","15:30"))+
		  theme(axis.text=element_text(size=16),axis.title=element_text(size=30,face="bold"))+
		  theme(plot.title = element_text(size=30))+
		  scale_color_manual(values = c("black","darkred","darkgreen"))+
		  #scale_color_manual(values = c("dn" = "darkred", "up" = "darkgreen"))+
	          guides(colour=FALSE)
	         
     pl	          
	          

	
      })

}