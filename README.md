# Spark-code-guide

This repository contains my experiments in data wrangling and analysis with `sparklyr`- R interface for Apache Spark. By leveraging Spark’s APIs for Python and R to present practical applications, I present to the interested reader the technology that is used to solve big data paradigms.

## Setup
  * [Local Installation](https://edumine.wordpress.com/2015/06/11/how-to-install-apache-spark-on-a-windows-7-environment/)
  * [RStudio](https://edumine.wordpress.com/2015/06/18/working-with-apache-sparkr-1-4-0-in-rstudio/)
  * [Cluster Deployment](http://www.slideshare.net/jonathandinu/the-data-scientists-guide-to-apache-spark/69)
  
## SparkR with a Notebook
  1. Install [IRKernel](https://github.com/IRkernel/IRkernel)
  
  ```
    install.packages(c('rzmq','repr','IRkernel','IRdisplay')
    repos = c('http://irkernel.github.io/', getOption('repos')))
    IRkernel::installspec()
  ```
 
  2. Set [environment variables](https://github.com/apache/spark/tree/master/R#using-sparkr-from-rstudio)
 
 ```
    # Example: Set this to where Spark is installed
    Sys.setenv(SPARK_HOME="/Users/[username]/spark")
    # This line loads SparkR from the installed directory
    .libPaths(c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib"), .libPaths()))
    # if these two lines work, you are all set
    library(SparkR)
    sc <- sparkR.init(master="local")
   ```

## Spark Documentation
Q: How can I find out more about Spark's Python API, MLlib, GraphX, Spark Streaming, deploying Spark to EC2?

  * Go to https://spark.apache.org/docs/latest
  * Navigate using tabs to the following areas in particular.
  * Programming Guide > Quick Start, Spark Programming Guide, Spark Streaming, DataFrames and SQL, MLlib, GraphX, SparkR.
  * Deploying > Overview, Submitting Applications, Spark Standalone, YARN, Amazon EC2.
  * More > Configuration, Monitoring, Tuning Guide.

## Original Papers
  * [Matei's Thesis](https://people.eecs.berkeley.edu/~matei/papers/2012/nsdi_spark.pdf)
  * [Original RDD paper](http://www-bcf.usc.edu/~minlanyu/teach/csci599-fall12/papers/nsdi_spark.pdf)
  
## Spark Internals
  * [Pyspark Internals]( https://spark-summit.org/2014/wp-content/uploads/2014/07/A-Deeper-Understanding-of-Spark-Internals-Aaron-Davidson.pdf)
  * [Spark Internals](https://cwiki.apache.org/confluence/display/SPARK/Spark+Internals)

## Community
  * Community
  
  https://spark.apache.org/community.html
  Spark's community page lists meetups, mailing-lists, and upcoming Spark conferences.
  * Meetup's
  
  http://spark.meetup.com/
  Spark has meetups in the Bay Area, NYC, Seattle, and most major cities around the world.
  * Mailing List
  
  https://spark.apache.org/community.html
  The user mailing list covers issues and best practices around using Spark. The dev mailing list is for people who want to contribute to Spark.
  

  

