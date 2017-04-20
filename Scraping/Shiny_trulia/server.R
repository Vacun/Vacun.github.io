# Shiny server
library(ggplot2)
library(tidyr)
library(dplyr)
library(ggthemes)
library(shiny)

thestepmother <- read.csv('./data/thestepmother.csv',
                          stringsAsFactors = F)

thestepmother[ ,"state"] <- as.factor(thestepmother$state)
thestepmother$year <- as.factor(thestepmother$year)
thestepmother$quarter <- as.factor(thestepmother$quarter)


shinyServer(function(input,output){
  
  # statusInput <- reactive({
  #   switch(input$status,
  #          "R" = immid_R,
  #          "A" = immid_A,
  #          "D" = immid_D,
  #          "P" = immid_P)
  # })
  # status <- statusInput
  data1 <- group_by(thestepmother,year,quarter) %>% 
    summarise_each(funs(sum(.,na.rm = T)),immid_R,immid_A,immid_D,immid_P,
                   other_R,other_A,other_D,other_P)

  
    output$quarter <- renderPlot({ 
    
    choice_bar <- paste(input$relative, input$status, sep = "_")
    
    g <- ggplot(data = data1)
   
    g + geom_bar(aes(x = quarter, 
                     y =eval(parse(text = paste(input$relative, input$status, sep = "_")))/1000,
                     fill = year),
                 stat = 'identity', color = 'grey', position = 'dodge')+
      theme_economist() + scale_fill_economist() +
      ylab("Number of Applications in 1000's")
    # + coord_cartesian(ylim=c(0,1000)),
    })  
    output$year <- renderPlot({ 
      
      choice_bar <- paste(input$relative1, input$status1, sep = "_")
      
      g <- ggplot(data = data1)
      
      g + geom_bar(aes(x = year, 
                       y =eval(parse(text = paste(input$relative1, input$status1, sep = "_")))/1000,
                       fill = quarter),
                   stat = 'identity', color = 'grey', position = 'dodge')+
        theme_economist() + scale_fill_economist() +
        ylab("Number of Applications in 1000's")
      # + coord_cartesian(ylim=c(0,1000))
  })

  
})
