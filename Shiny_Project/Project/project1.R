library(dplyr)

# after using the function makeNumeric 
# function to get things done, i need to think...
# lets try to do some quick cleaning in Excel for all the files


attributes(d2016.4)
str(d2016.4)
colnames(d2016.4)

##############################################################
# creating the names for the big dataframe

newnames <- c("state","city","code",'immid_R','immid_A','immid_D',
              'immid_P','other_R','other_A','other_D','other_P')
quarts <- paste(c(rep(15,4),rep(16,4)),c(1:4),sep = ".")
length(quarts)

v = c()
for (i in 1:length(quarts)){
  v = c(v,rep(quarts[i],11))
  print(v)
}
v
newnames_year <- paste0(newnames,v)
newnames_year

#####################################################################
dim(d2015.1)
length(newnames)
#!!! before loading the files, clean the d2015.11.csv with Excel...
# loading the files
d2014.1 <- read.csv("d2014.11.csv",stringsAsFactors = F,col.names = newnames)
d2014.2 <- read.csv("d2014.22.csv",stringsAsFactors = F,col.names = newnames)
d2014.3 <- read.csv("d2014.33.csv",stringsAsFactors = F,col.names = newnames)
d2014.4 <- read.csv("d2014.44.csv",stringsAsFactors = F,col.names = newnames)
d2015.1 <- read.csv("d2015.11.csv",stringsAsFactors = F,col.names = newnames)
d2015.2 <- read.csv("d2015.22.csv",stringsAsFactors = F,col.names = newnames)
d2015.3 <- read.csv("d2015.33.csv",stringsAsFactors = F,col.names = newnames)
d2015.4 <- read.csv("d2015.44.csv",stringsAsFactors = F,col.names = newnames)
d2016.1 <- read.csv("d2016.11.csv",stringsAsFactors = F,col.names = newnames)
d2016.2 <- read.csv("d2016.22.csv",stringsAsFactors = F,col.names = newnames)
d2016.3 <- read.csv("d2016.33.csv",stringsAsFactors = F,col.names = newnames)
d2016.4 <- read.csv("d2016.44.csv",stringsAsFactors = F,col.names = newnames)

#d2015.1 <- d2015.1[ ,-1]
#write.csv(d2015.1,"d2015.11.csv",row.names = F)
##########################################################
themother <- right_join(d2015.1,d2015.2, by = c('state','city','code'),
                       suffix = c(".2015.1", ".2015.2"))

themother <- right_join(themother,d2015.3, by = c('state','city','code'),
                        suffix = c(".2015.2", ".2015.3"))

themother <- right_join(themother,d2015.4, by = c('state','city','code'),
                        suffix = c(".2015.3", ".2015.4"))

themother <- right_join(themother,d2016.1, by = c('state','city','code'),
                        suffix = c(".2015.4", ".2016.1"))

themother <- right_join(themother,d2016.2, by = c('state','city','code'),
                        suffix = c(".2016.1", ".2016.2"))

themother <- right_join(themother,d2016.3, by = c('state','city','code'),
                        suffix = c(".2016.2", ".2016.3"))

themother <- right_join(themother,d2016.4, by = c('state','city','code'),
                        suffix = c(".2016.3", ".2016.4"))

write.csv(themother,'themother.csv',row.names = F)
###########################################################

# the following is done to each of 8 df's to add the year and quarter
# columns

year = rep("2014",nrow(d2014.1))
#year
quarter = rep("1",nrow(d2014.1))
#quarter

d2014.1 <- cbind(year,quarter,d2014.1)

###########################################################

# an attempt to automate this whole column adding process
# v = c()
# for (i in 1:4){
#   v[i] <- (paste0("d2016.",i))
# }
# v
# dim(d2016.1)[1]
# v[1]
# dim(eval(parse(text = "v[1]")))
#
#
# for (i in 1:14){
#   Year = rep("2016",dim(as.name(v[i])[1]))
#   Quarter = rep(as.character(i),dim(as.name(v[i]))[1])
#   as.name(v[i]) <- cbind(Year,Quarter,as.name(v[i]))
# }

# the answer could be in passing the data.frame name as
# eval(parse(text = "name"))

###########################################################
#adding the data from 2014 to the stepmother

thestepmother

thestepmother1 <- rbind(d2014.1,d2014.2,d2014.3,d2014.4,thestepmother)

# namesForData <- c("year","quarter","state","city","code","immid_R",
#                   "immid_A","immid_D","immid_P","other_R","other_A","other_D","other_P")
str(thestepmother)
str(thestepmother1)

write.csv(thestepmother1,'thestepmother.csv',row.names = F)
