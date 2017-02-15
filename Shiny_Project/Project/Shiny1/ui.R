#project ui
library(ggplot2)
library(tidyr)
library(dplyr)
library(ggthemes)
library(shiny)
library(shinydashboard)


shinyUI(dashboardPage(
  dashboardHeader(title = "USCIS I-130 Data"
                  ),
  dashboardSidebar(
    sidebarUserPanel(
      name = 'Vahe Voskerchyan',
      image = img(src = './Shiny1/image/Vahe.jpg')),
    sidebarMenu(
      menuItem("Quarters", tabName = "quarter", icon = icon("bar-chart")),
      menuItem("Years", tabName = "year", icon = icon("bar-chart")))
    # selectizeInput("relativeSide",
    #                h4("The Relative Category"),
    #                choice = list('Immidiat Relatives' = 1,
    #                              'All Other Relatives' = 2)),
    # selectizeInput('year',
    #                h4('Year'),
    #                choice = list('2015' = 2015,
    #                              '2016' = 2016)),
    # selectizeInput('quarter',
    #                h4('Quarter'),
    #                choice = list('1st Quarter' = 1,
    #                              '2nd Quarter' = 2,
    #                              '3rd Quarter' = 3,
    #                              '4th Quarter' = 4)),
    # checkboxGroupInput('stats',
    #                    h4('Statistics'),
    #                    choices = list('Total' = 1,
    #                                   'Mean'= 2,
    #                                   'Spead' = 3))
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "quarter",
              fluidRow(plotOutput("quarter"),
                       selectizeInput("relative",
                                      h4("The Relative Category"),
                                      choice = list('Immidiate Relatives' = "immid",
                                                    'All Other Relatives' = "other")),
                       selectInput('status',
                                   h4('Application Status'),
                                   choice = list('Received' = "R",
                                                  'Approved' = "A",
                                                  'Denied' = "D",
                                                  'Pending'= "P"),
                                      selected = 'immid_R'))),
      tabItem(tabName = "year",
              fluidRow(plotOutput('year'),
                       selectizeInput("relative1",
                                      h4("The Relative Category"),
                                      choice = list('Immidiate Relatives' = "immid",
                                                    'All Other Relatives' = "other")),
                       selectInput('status1',
                                   h4('Application Status'),
                                   choice = list('Received' = "R",
                                                 'Approved' = "A",
                                                 'Denied' = "D",
                                                 'Pending'= "P"),
                                   selected = 'immid_R'))
              )
  )
)))
