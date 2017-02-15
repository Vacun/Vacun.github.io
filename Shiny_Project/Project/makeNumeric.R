#

makeNumeric <- function(filename){
  # sub the "," by ".", get rad of weard symbols
  # and then make the columns numeric
  data <- read.table(filename, stringsAsFactors = F, 
                         na.strings=c("NA", " -   "," D "), sep = ',', 
                         header = T)
  
  for (i in 4:ncol(data)) {
    data[ ,i] = as.numeric(
      gsub(',','',data[ ,i], fixed = TRUE))
  }
  
  write.csv(data,paste0(paste0(substr(filename,1,7),substr(filename,7,7)),
                            ".csv"),row.names = F)
}

makeNumeric("d2014.4.csv")

data1 <- read.csv('d2014.44.csv')
str(data1)
