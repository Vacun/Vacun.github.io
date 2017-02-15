# please not that due to some missing data, d2015.1 is missing a column
# which was fixed manually, however, i dont have time to write the code

library(ggplot2)
library(tidyr)
library(dplyr)
library(ggthemes)

thestepmother <- read.csv('thestepmother.csv',stringsAsFactors = F)

str(thestepmother)

thestepmother[ ,"state"] <- as.factor(thestepmother$state)
thestepmother$year <- as.factor(thestepmother$year)
thestepmother$quarter <- as.factor(thestepmother$quarter)
# 
# just in case. d2015.1 might give a problem
# # Patch 1
# #fixing d2015.1 column immid_1 "," problem
# thestepmother[ ,6]
# thestepmother$immid_R = as.integer(
#     gsub(',','',thestepmother[ ,6], fixed = TRUE))
# write.csv(thestepmother,"thestepmother.csv", row.names = F)

colnames(thestepmother)
str(thestepmother)

data1 <- group_by(thestepmother,year,quarter) %>% 
  summarise_each(funs(sum(.,na.rm = T)),immid_R,immid_A,immid_D,immid_P,
                 other_R,other_A,other_D,other_P)

g <- ggplot(data = data1)

g + geom_bar(aes(x = quarter, y = immid_R, fill = year),
             stat = 'identity', color = 'grey', position = 'dodge')+
  # geom_bar(aes(x = quarter, y = immid_P,fill = year),
  #            stat = 'identity', color = 'grey', position = 'dodge')+
  theme_economist() + scale_fill_economist() + 
  ylab("Recieved Applications") + coord_cartesian(ylim=c(0,180000))

g + geom_point(aes(x = immid_R, y = immid_A,color = year))







# # lets see if i can bucket the approved column
# 
# data("stateMapEnv")
# map('state')
# 
# 
# #load us map data
# all_states <- map_data("state")
# #plot all states with ggplot
# p <- ggplot(data = uscis.2016.4.state)
# p <- p + geom_polygon( data=all_states, 
#                        aes(x=long, y=lat, group = group),
#                        colour="white", fill=uscis.2016.4.state['Immediate.Relative.Petitions.Received'] )
# p
# ggplot()+
#   geom_polygon( data=all_states, 
#                 aes(x=long, y=lat, group = group),
#                 colour="white", fill='blue') +
#   geom_point(data = copy,
#              aes(x = long, 
#                  y = lat))
# 
