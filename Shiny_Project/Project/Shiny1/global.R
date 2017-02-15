## global.R for Shiny1
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

data1 <- group_by(thestepmother,year,quarter) %>%
  summarise_each(funs(sum(.,na.rm = T)),immid_R,immid_P)

applic_choice <- colnames(thestepmother)[-c(1:5)]

states <- levels(thestepmother$state)
states <- states[-which(states == 'Service Center')]

colnames(thestepmother)
thestepmother %>% filter(state == 'Service Center', year == 2016)
class(thestepmother$city)


ServiceCenter <- c("California","")