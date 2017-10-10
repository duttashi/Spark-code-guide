# Objective: Copy data into local spark connection

# LOAD REQUIRED LIBRARIES
library(nycflights13)
library(dplyr)
library(magrittr)
library(sparklyr)

# connect to local spark instance
sc <- spark_connect(master="local")

# print the spark version
spark_version(sc) # 2.1.0

# check data tables in spark local cluster
src_tbls(sc) # character(0) indicates NO tables 

# Copy data to spark local instance. Note, copy_to() returns a list, i.e. why I'm coercing it into a data frame for subsequent manaipulation.
flights_tbl <- as.data.frame(copy_to(sc, nycflights13::flights, "flights", 
                                     overwrite = TRUE))
# check data tables in spark local cluster
src_tbls(sc) # [1] "flights" indicates flight data has been copied

# check data dimension
dim(flights_tbl)
str(flights_tbl)

# check amount of memory taken up by the flights_tbl tibble
object.size(flights_tbl) # 40615752 bytes
# check colnames data table
colnames(flights_tbl)

# Disconnect from Spark
spark_disconnect(sc)
