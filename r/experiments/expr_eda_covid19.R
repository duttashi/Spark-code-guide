# objective: data cleaning
# data source: https://www.kaggle.com/sudalairajkumar/novel-corona-virus-2019-dataset

# clean the workspace
rm(list = ls())

# required libraries
library(tidyverse)
library(tidytext)

# load data
covid_geog_data<- read.csv("data/covid19/covid19_line_list_data.csv", stringsAsFactors = FALSE, sep = ",")

# data cleaning
# remove multiple cols with no data
df<- covid_geog_data[,-c(4,20:27)]
# rename the column names
df <- df %>%
  rename(id=ï..id, case_reprt_date=reporting.date,
         onset_approx=If_onset_approximated,wuhan_visit=visiting.Wuhan,
         wuhan_resid=from.Wuhan)
# clean location col. Keep only the city name
df$location[which(df$location=="Hechi, Guangxi")]<-"Hechi"
df$location[which(df$location=="Shenzhen, Guangdong")]<-"Shenzhen"
df$location[which(df$location=="Shanxi (é™•è¥¿)")]<-"Shanxi"
df$location[which(df$location=="Wuhan, Hubei")]<-"Wuhan"
df$location[which(df$location=="NSW")]<-"New South Wales"

# split date into day, month, year format
## coerce character data type for date cols to Date format
df$case_reprt_date<- as.Date(df$case_reprt_date, format = "%m/%d/%y")
df$symptom_onset<- as.Date(df$symptom_onset, format = "%m/%d/%y")
df$hosp_visit_date<- as.Date(df$hosp_visit_date, format = "%m/%d/%y")
df$exposure_start<- as.Date(df$exposure_start, format = "%m/%d/%y")
df$exposure_end<- as.Date(df$exposure_end, format = "%m/%d/%y")

## split the Date cols into day, month, year cols
df <- df %>%
  separate(case_reprt_date, into = c("case_reprt_yr","case_reprt_mnth","case_reprt_day"))
df <- df %>%
  separate(symptom_onset, into = c("symptom_onset_yr","symptom_onset_mnth","symptom_onset_day"))
df <- df %>%
  separate(hosp_visit_date, into = c("hosp_visit_yr","hosp_visit_mnth","hosp_visit_day"))
df <- df %>%
  separate(exposure_start, into = c("exposure_start_yr","exposure_start_mnth","exposure_start_day"))
df <- df %>%
  separate(exposure_end, into = c("exposure_end_yr","exposure_end_mnth","exposure_end_day"))

# extract data from summary col and add to a new col
df$summ_symptm<- ifelse(grepl("vomiting", df$summary, ignore.case = T),"vomiting",
                        ifelse(grepl("diarrhea", df$summary, ignore.case = T),"diarrhea",
                               ifelse(grepl("fever", df$summary, ignore.case = T),"fever",
                                      ifelse(grepl("pneumonia", df$summary, ignore.case = T),"fever",
                                      ifelse(grepl("cough", df$summary, ignore.case = T),"cough",
                                             ifelse(grepl("joint pain", df$summary, ignore.case = T),"joint pain",
                                                    ifelse(grepl("shortness of breath", df$summary, ignore.case = T),"short breath",
                                                           ifelse(grepl("breathlessness", df$summary, ignore.case = T),"short breath",
                                                                  ifelse(grepl("malaise", df$summary, ignore.case = T),"malaise",
                                                                         ifelse(grepl("cold", df$summary, ignore.case = T),"cold",
                                                                                ifelse(grepl("headache", df$summary, ignore.case = T),"headache",
                                                                                       ifelse(grepl("nasal discharge", df$summary, ignore.case = T),"cold",
                                                                                              ifelse(grepl(c("sore throat"), df$summary, ignore.case = T),"cold",
                                                                                                     ifelse(grepl("throat discomfort", df$summary, ignore.case = T),"cold",
                                                                                                            ifelse(grepl("runny nose", df$summary, ignore.case = T),"cold",
                                                                                                                   ifelse(grepl("nausea", df$summary, ignore.case = T),"cold",
                                                                                                                                 ifelse(grepl("dyspnea", df$summary, ignore.case = T),"cold",
                                                                                                                                        ifelse(grepl("myalgias", df$summary, ignore.case = T),"cold",
                                                                                                                                               ifelse(grepl("reflux", df$summary, ignore.case = T),"cold",
                                                                                                                                                      ifelse(grepl("flu", df$summary, ignore.case = T),"cold",
                                                                                                                                                             ifelse(grepl("flu symptoms", df$summary, ignore.case = T),"cold",
                                                                                                                                                                    ifelse(grepl("tired", df$summary, ignore.case = T),"lethargic",
                                                                                                                                                                           ifelse(grepl("physical discomfort", df$summary, ignore.case = T),"lethargic",
                                                                                                                                                                                  ifelse(grepl("sore body", df$summary, ignore.case = T),"lethargic",
                                                                                                                                                                                         ifelse(grepl("fatigue", df$summary, ignore.case = T),"lethargic",
                                                                                                                                                                                                ifelse(grepl("loss of appetite", df$summary, ignore.case = T),"lethargic","NA"))))))))))))))))))))))))))

# Text cleanup 
# summary variable has free form text

df$summary_clean<- tibble(line = 1:nrow(df), text =  tolower(df$summary)) %>% # as tibble
  unnest_tokens(word, text) %>%   # remove punctuations, lowercase, put words in column
  anti_join(stop_words, by = c("word" = "word"))  %>% # remove stopwords
  group_by(line) %>% 
  summarise(cleantxt=paste(word,collapse =' ')) %>%  # now all in a row
  mutate(cleantxt = str_remove_all(cleantxt, '[[:punct:]]'))%>% 
  mutate(tokens = str_split(cleantxt, "\\s+")) %>%
  mutate(tokens = strsplit(cleantxt, split = " "))

