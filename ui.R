
options(show.error.messages=F)

library(shiny)


pageWithSidebar(

  headerPanel('NIFTY'),
  sidebarPanel(

     selectInput('Year', label = h4("Select Year"),
                 choices = list("2013" = 2013, "2014" = 2014,
                 "2015" = 2015, "2016" = 2016), selected= 2016),
                 
    
     numericInput("Month",label = h4("Select Month"),
                 value=5, min =1, max = 12),
                 
     numericInput("obs",label = h4("Select Date"),
                 value=5, min =1, max = 31),
                 
    actionButton("refresh", "Refresh",icon("refresh"), 
                         style="color: #fff; background-color: #39ac73"),
                         
    width = 2),
  
  mainPanel(     
   ui <- basicPage(
             uiOutput(outputId = "text")),
   plotOutput('plot1',width = "1600px", height = "900px")

  )
)

