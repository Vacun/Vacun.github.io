# there is a special case treated seporately on the bottom: d2015.1

cleaningData <- function(filename,newfile){
  library(dplyr)
  library(tidyr)
  
  
  immidata <- read.csv(filename,
                       stringsAsFactors = F, na.strings=c(""," ", "NA"))
  
  
  str(immidata)
  attributes(immidata)
  names(immidata)
  
  colNum <- dim(immidata)[2]
  
  
  #checking the columns for uselessnes.
  useless <-  c()
  for (i in 1:colNum){
    if(all(sapply(immidata[i],is.na)))
    {
      useless[i] = i
      cat("The column number",i, "is useless!\n")
    } else { cat(i,"is not empty\n")
      if (dim(immidata[i])[1] > 10){
        cat("more than 10 raws\n")
      } else {
        cat(i,"th raw has the following useful things")
      }
    }
  }
  
  # after the check, removing the column
  
  if (!is.null(useless)){
    useless <- useless[!is.na(useless)]
    immidata[useless] = NULL
  }
  
  # creating a new DF with only the raws interested in
  
  servCenter <-  which(immidata[1] == "Service Center")
  servCenterBottom <- servCenter + 5
  
  
  # FOState <- which(immidata[1] == "Field Office by State6") + 1
  FOStateBottom <- which(immidata[1] == "Field Office by Territory6")-1
  
  immidata.US <- rbind(immidata[1:FOStateBottom, ] ,
                       immidata[servCenter:servCenterBottom, ])
  
  # Filling the State column
  immidata.US <- fill(immidata.US,1)
  
  
  ### Look into Bookmarks for an excelant post on droping NA raws!
  # for now im just gonna use filter(v, is.na(w) & is.na(k))
  
  # here I take only the raws that have NA in 2nd and 3rd columns
  # by check if 2nd and 3rd column are NA, and then passin the resulting 
  # boolien vector to the main DF to select only those rows.
  
  row.names(immidata.US[is.na(immidata.US[2]) & is.na(immidata.US[3]),])
  
  # after chcking that this names actually give the empty raws, i just delete
  # them, by revercing the resulting Boolien vecotr of 
  # is.na(immidata.US[2]) & is.na(immidata.US[3])
  
  immidata.US <- immidata.US[!(is.na(immidata.US[2]) & is.na(immidata.US[3]) & 
                                 is.na(immidata.US[4])), ]
  
  # Chopping the last 4 columns
  
  immidata.US <- immidata.US[ ,-((dim(immidata.US)[2]-3):dim(immidata.US)[2])]
  
  # Now i exported this final "half-read" data to Excel and did some
  # retouching
  write.csv(immidata.US, newfile, row.names = FALSE)
  
}  


cleaningData("./USCIS/I130_performancedata_fy2014_qtr4.csv","d2014.4.csv")



# I manually deleted the raws in the 2014 data

# fixing the data in d2015.csv by adding the code column
df2 <- read.csv('d2015.44.csv')
df1 <- read.csv('d2014.4.csv')

# head(df2)
# tail(df2,10)
# head(df1)

df1$code = df2[ ,3]
# nrow(df2)
# nrow(df1)
# colnames(df1)
# colnames(df2)
# ncol(df1)
# ncol(df2)
df1 <- df1[ ,c(1,2,11,3:10)]
# colnames(df1)
# str(df1)

write.csv(df1,'d2014.4.csv', row.names = FALSE)
