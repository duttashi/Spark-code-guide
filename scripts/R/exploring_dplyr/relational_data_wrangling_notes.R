# Relational Data wrangling in R
# reference: https://r4ds.had.co.nz/relational-data.html

# required libraries
library(tidyverse)
library(nycflights13)

# nycflights has 4 tibbles or tables 
# There are three families of verbs designed to work with relational data:
# Mutating joins, which add new variables to one data frame from matching observations in another.
# Filtering joins, which filter observations from one data frame based on whether or not they match an observation in the other table.
# Set operations, which treat observations as if they were set elements.

# The nycflights13 has 5 tables, as follows:
flights # # A tibble: 336,776 x 19. all flights that departed from NYC in 2013
airlines # A tibble: 16 x 2. translation between two letter carrier codes and names
airports # A tibble: 1,458 x 8. airport names and locations
planes # A tibble: 3,322 x 9. construction information about each plane
weather # A tibble: 26,115 x 15. hourly meterological data for each airport


# relationship between the 4 tables
# airport data is connected to flights data based on cols origin, dest
# planes data is connected to flights data based on cols tailnum
# weather data is connected to flights data based on cols origin,year,month,day,hour
# airlines data is connected to flights data based on cols carrier

# Outer join: An outer join keeps observations that appear in at least one of the tables. 
## There are 3 types of outer join: 
# A left join keeps all observations in x. Its a mutating join
# A right join keeps all observations in y.
# A full join keeps all observations in x and y

# example: Join the flight2 tbl with the airport tbl. Note, both tables have no matching cols
# answer: use crossing()
flights2 %>%
  crossing(airports)

# To identify the primary key for each table and ensure that they uniquely identify each observation.
# To do this, use the count()
planes %>%
  count(tailnum) %>%
  filter(n>1)

weather %>%
  count(origin,year,month,day,hour) %>%
  filter(n>1) # as we can see from this output, there is no unique primary key in the weather table

flights %>% 
  count(year, month, day, flight) %>% 
  filter(n > 1) # as we can see from this output, there is no unique primary key in the weather table

# Note: If a table lacks a primary key, it’s sometimes useful to add one with mutate() and row_number(). That makes it easier to match observations if you’ve done some filtering and want to check back in with the original data. This is called a surrogate key.
# exercise add a surrogate key to the flights table
flights %>%
  arrange(year, month, day, flight) %>%
  mutate(flight_id = row_number()) %>%
  glimpse()

# Mutating join:  A mutating join allows you to combine variables from two tables. It first matches observations by their keys, then copies across variables from one table to the other.

# exercise add the airline name to the flights table
# create a small dataset
flights2 <- flights %>%
  select(year:day, hour, distance, tailnum, carrier, origin, dest)
head(flights2)
flights2 %>%
  left_join(airlines, by="carrier") # The result of joining airlines to flights2 is an additional variable: na

# Inner join: An inner join keeps observations that appear in both tables.
# Return all rows from x where there are matching values in y, and all columns from x and y. 
# If there are multiple matches between x and y, all combination of the matches are returned. 
# This is a mutating join.
flights2 %>%
  inner_join(airlines, by="carrier")

# full_join(x, y): Return all rows and all columns from both x and y. 
# Where there are not matching values, returns NA for the one missing. 
# This is a mutating join.
flights2 %>%
  full_join(airlines, by="carrier")

# semi join
# Return all rows from x where there are matching values in y, keeping just columns from x
# A semi join differs from an inner join because an inner join will return one row of x for each matching row of y, where a semi join will never duplicate rows of x. This is a filtering join.
# A semi join is a filtering join
flights2 %>%
  semi_join(weather)

# anti join
# Return all rows from x where there are not matching values in y, keeping just columns from x. 
# This is a filtering join.
flights2 %>%
  anti_join(weather)
