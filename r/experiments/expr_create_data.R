# create a dataframe for advertising dataset.


# Approach # 1: create vectors first and then bundle them into a dataframe
p_age=c(rep(20:21, each=2, times=4))
p_sex=c(rep(as.character(c('m','f')), each=2, times=4))
p_race=c(rep(as.character(c('indian','chinese','malay','other')), each=2, times=3))
scr_loc <- c(rep(as.character(c("KL Sentral","Universiti","Mid Valley","Cheras")), 
                 each=2, times=3))
scr_vew_date <- c( rep( as.Date("2020-07-31"), each=2, times=8))
scr_vew_date <- seq(as.Date('2020/01/01'), as.Date('2020/01/24'), by="day")
scr_vew_date
df<- data.frame(p_age,p_race,p_sex, scr_loc,scr_vew_date)
df

# Approach # 2
library(lubridate)
dates <- data.frame(
  days = seq(as.Date('2020/01/01'), as.Date('2020/09/01'), by="day")
)
dates
dates$month <- month(dates$day)
results <- lapply(1:9, function(x){
  sample_dates <- dates$days[dates$month == x]
  
  return(sample(sample_dates, size = 1))
})
df <- data.frame(
  dates = as.Date(unlist(results), origin = "1970-01-01")
  #dates = as.Date(unlist(results))
)
df

# Approach # 3
p_age <- seq(from=20, to=43)
p_sex <- c(seq(as.character(c('m','f')), each=2, times=4))
p_sex=c(rep(as.character(c('m','f')), each=2, times=6))
df <- data.frame(p_age=seq(from=20, to=43),
                 p_sex=c(rep(as.character(c('m','f')), each=2, times=6)),
                 p_race=c(rep(as.character(c('indian','chinese','malay','other')), each=2, times=3)),
                 screen_loc = c(rep(as.character(c("KL Sentral","Universiti","Mid Valley","Cheras")), 
                                    each=2, times=3)),
                 screen_view_date = seq(as.Date('2020/01/01'), as.Date('2020/01/24'), by="day")
                 )

# shuffle the data row-wise
# see this SO post: https://stackoverflow.com/questions/6422273/how-to-randomize-or-permute-a-dataframe-rowwise-and-columnwise
df1 <- df[sample(nrow(df)),]
df1
# shuffle the data column-wise
df2 <- df1[,sample(ncol(df1))]
df2
