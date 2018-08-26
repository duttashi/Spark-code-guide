# Basic sparkR script
# Resource: http://spark.rstudio.com/
# Resource: https://beta.rstudioconnect.com/content/1705/taxiDemo.nb.html

# set the java path
#java_path<- normalizePath('C:/Program Files (x86)/Java/jre1.8.0_91')
#Sys.setenv(JAVA_HOME=java_path)
# Load the libraries
library(sparklyr)
library(dplyr)
spark_install(version = "1.6.2")

# connecting to spark
sc <- spark_connect(master = "local")
# if you get the followinb error 
# In create_hive_context_v1(sc) : Failed to create Hive context, falling back to SQL. Some operations, like window-functions, will not work
# Solution: Install winutils.exe. Follow this post https://blogs.msdn.microsoft.com/arsen/2016/02/09/resolving-spark-1-6-0-java-lang-nullpointerexception-not-found-value-sqlcontext-error-when-running-spark-shell-on-windows-10-64-bit/
# 
iris_tbl <- copy_to(sc, iris)
flights_tbl <- copy_to(sc, nycflights13::flights, "flights")
batting_tbl <- copy_to(sc, Lahman::Batting, "batting")
src_tbls(sc)

# filter by departure delay and print the first few records
flights_tbl %>% filter(dep_delay == 2)

delay <- flights_tbl %>% 
  group_by(tailnum) %>%
  summarise(count = n(), dist = mean(distance), delay = mean(arr_delay)) %>%
  filter(count > 20, dist < 2000, !is.na(delay)) %>%
  collect

# plot delays
library(ggplot2)
ggplot(delay, aes(dist, delay)) +
  geom_point(aes(size = count), alpha = 1/2) +
  geom_smooth() +
  scale_size_area(max_size = 2)

# Windows functions
batting_tbl %>%
  select(playerID, yearID, teamID, G, AB:H) %>%
  arrange(playerID, yearID, teamID) %>%
  group_by(playerID) %>%
  filter(min_rank(desc(H)) <= 2 & H > 0)

# Using SQL
library(DBI)
iris_preview <- dbGetQuery(sc, "SELECT * FROM iris LIMIT 10")
iris_preview

# Machine learning within sparklyr
# copy mtcars into spark
mtcars_tbl <- copy_to(sc, mtcars)

# transform our data set, and then partition into 'training', 'test'
partitions <- mtcars_tbl %>%
  filter(hp >= 100) %>%
  mutate(cyl8 = cyl == 8) %>%
  sdf_partition(training = 0.5, test = 0.5, seed = 1099)

# fit a linear model to the training dataset
fit <- partitions$training %>%
  ml_linear_regression(response = "mpg", features = c("wt", "cyl"))
fit
summary(fit)



# disconnect the spark connection
spark_disconnect(sc)

# show spark config
#spark_config()
