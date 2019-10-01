library(dplyr)
library(ggplot2)
library(tidyr)

df_trulia <- read.csv('listings_trulia.csv',stringsAsFactors = F)
#df <- read.table('listings_zillow.csv',header = T, sep = ",")
df_zillow <- read.csv('zillow_clean_final.csv', stringsAsFactors = F)
df_myzips <- read.csv('my_zips.csv',stringsAsFactors = F)
names(df_zillow)
names(df_trulia)

sapply(df_trulia[c('price','bedrooms','bathrooms','sqft','price_per_sqft')],sd)
class(df_trulia$bedrooms)
sum(is.na(df_trulia[c('price','bedrooms','bathrooms','sqft','price_per_sqft')]))

sapply(df_trulia[c('price','bedrooms','bathrooms','sqft','price_per_sqft')],is.na) %>%tbl() %>%
  summarise_each(funs(mean),price)

summary(df_zillow)
summary(df_trulia)

#ZILLOW
#df_zillow['barough'] <- as.factor(df_zillow[['barough']])
#df_zillow['zip'] <- as.factor(df_zillow[['zip']])
#str(df_zillow)
# df_built = df_zillow %>% subset(grepl("Built",df_zillow$FACTS))
# # lets split each fact into its own column
# grepl("",df_zillow['FACTS'])
# colnames(df_zillow)
# grepl("a",df_zillow['CONSTRUCTION'])
# grepl("a",df_zillow[['ADDITIONAL.FEATURES']])
# 
# df_zillow[with(df_zillow, grepl("Built", FACTS)|grepl("Built", CONSTRUCTION)|grepl("Built", ADDITIONAL.FEATURES))]
#
# #unique zip codes in Zillow
# dim(unique(df_zillow['zip']))
# #unique zip codes in Zillow
# dim(unique(df_trulia['zip_code']))
# intersect(unique(df_trulia['zip_code']),unique(df_zillow['zip']))
# 
# z = unique(df_zillow['zip'])
# t = unique(df_trulia['zip_code'])



class(df_trulia[['zip_code']])
#df_trulia['zip_code'] <- as.factor(df_trulia[['zip_code']])
df_trulia <- df_trulia[!is.na(df_trulia$price),]
sum(is.na(df_trulia$neighborhood))
df_trulia['neighborhood'] <- as.factor(df_trulia$neighborhood)

# df_g <- df_trulia %>% group_by(zip_code) %>% summarise_each(funs(mean),price,price_per_sqft)
# 
# df_g['zip_code'] <- as.factor(df_g[['zip_code']])
# 
# g <- ggplot(df_g,aes(x = zip_code, y = price_per_sqft))
# 
# g + geom_bar(stat = 'identity')
# 
# g+geom_point()
# 
options(scipen=5)
ggplot(df_trulia,aes(x = price)) + 
  geom_histogram(binwidth = 100000,color='white') +
  theme(axis.text.x= element_text(angle=45)) +
  xlim(0, 5000000)

# ggplot(df_trulia,aes(x = price)) + 
#   geom_density() +
#   theme(axis.text.x= element_text(angle=45)) +
#   xlim(0, 5000000)

# g <- ggplot(df_trulia)
# lets see the distribution of the zip_code
# g+geom_bar(aes(x=zip_code))

# df_trulia %>% filter(zip_code %in% c(10001:10005)) %>%
#   ggplot(aes(x = zip_code,y = price)) +
#   geom_boxplot()
# 
# df_trulia %>% filter(zip_code %in% c(10001:10005)) %>%
#   ggplot(aes(x = zip_code,y = price)) +
#   geom_violin()

ggplot(df_trulia, aes(x = log(price)))+geom_density()
exp(12.5)
exp(17.5)
summary(df_trulia['price'])

df_bedroom <- df_trulia %>% group_by(bedrooms) %>% 
  summarise_each(funs(mean),price,price_per_sqft)
df_bedroom

# Grouping by neighbourhoods

# df_trulia %>% group_by(neighborhood) %>%
#   summarise_each(funs(count))

#changing the df_trulia to tbl_df for dplyr
#trulia_tbl <- tbl_df(df_trulia)

df_neigh <- count(df_trulia['neighborhood'])
df_neigh

class(df_trulia$neighborhood)

df_neigh_tally <- df_trulia %>% group_by(neighborhood) %>% tally(sort=TRUE)
df_neigh_tally[1:15,] %>% 
  ggplot() + 
  geom_bar(aes(x = reorder(neighborhood,n),y=n),stat = 'identity',fill="#0072B2") +
  theme(axis.text.x= element_text(angle=45)) +
  coord_flip() 
  #scale_fill_manual(values=c("red", "blue", "green"))

names(df_myzips)
as.numeric(df_myzips[['zip']])
df_myzips[['zip']]

left_join(df_trulia,df_myzips, by = c("zip_code" = "zip"))
separate(df_myzips, zip, into=c(1:10), sep=",")
df_myzips[['zip']]
