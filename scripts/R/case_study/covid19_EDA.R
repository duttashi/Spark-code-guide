# objective: data cleaning

# required libraries
library(tidyverse)
library(lubridate)

# clean the workspace
rm(list = ls())

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
table(df$location)
df$location[which(df$location=="Hechi, Guangxi")]<-"Hechi"
df$location[which(df$location=="Shenzhen, Guangdong")]<-"Shenzhen"
df$location[which(df$location=="Shanxi (é™•è¥¿)")]<-"Shanxi"
df$location[which(df$location=="Wuhan, Hubei")]<-"Wuhan"
df$location[which(df$location=="NSW")]<-"New South Wales"

# split date into day, month, year format
str(df)
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

