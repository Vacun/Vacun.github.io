# state <- c('ny','ca','tx','kt','nv','ut','ms','ne')
# immid_A.2015.1 <- c(1:8)
# immid_P.2015.1 <- c('a','b','c','d','e','f','g','h')
# immid_A.2015.2 <- c(2:9)
# immid_P.2015.2 <- c('i','j','k','l','m','n','o','p')
# immid_A.2015.3 <- c(3:10)
# immid_P.2015.3 <- c('q','r','s','t','u','v','w','x')
# v = data.frame(state,immid_A.2015.1,immid_P.2015.1,
#                immid_A.2015.2,immid_P.2015.2,immid_A.2015.3,immid_P.2015.3)
# v
# 
# gather(v,key = "year", value = 2,4,6)

head(mpg)

g <- ggplot(data = mpg, aes(x = displ, y = hwy))

g + geom_point()
g + geom_point(aes(color = cyl)) + theme_fivethirtyeight()
# so if i change the cyl column to facter, ill get a different coloring
mpg$cyl <- factor(mpg$cyl)
g + geom_point(aes(color = cyl)) + theme_fivethirtyeight()
