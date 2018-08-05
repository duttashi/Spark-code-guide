# Databricks notebook source
# load library
library(SparkR)

# COMMAND ----------

df <- createDataFrame(faithful)

# Displays the content of the DataFrame to stdout
head(df)

# COMMAND ----------

# Creating SparkR dataframe
df <- createDataFrame(faithful)
# Display the dataframe
head(df)

# COMMAND ----------

# The general method for creating DataFrames from data sources is read.df. This method takes the path for the file to load and the type of data source. SparkR supports reading CSV, JSON, Text and Parquet files natively and through Spark Packages you can find data source connectors for popular file formats like CSV and Avro.
diamondsDF <- read.df("/databricks-datasets/Rdatasets/data-001/csv/ggplot2/diamonds.csv",
                    source = "csv", header="true", inferSchema = "true")
head(diamondsDF)

# COMMAND ----------

printSchema(diamondsDF)

# COMMAND ----------

display(diamondsDF)

# COMMAND ----------

str(diamondsDF)

# COMMAND ----------

# Split data into Training set and Test set
trainingData <- sample(diamondsDF, FALSE, 0.7)
testData <- except(diamondsDF, trainingData)

# Exclude rowIDs
trainingData <- trainingData[, -1]
testData <- testData[, -1]

print(count(diamondsDF))
print(count(trainingData))
print(count(testData))

# COMMAND ----------

head(trainingData)

# COMMAND ----------

# Indicate family = "gaussian" to train a linear regression model
lrModel <- glm(price ~ ., data = trainingData, family = "gaussian")

# Print a summary of trained linear regression model
summary(lrModel)

# COMMAND ----------

# Generate predictions using the trained Linear Regression model
predictions <- predict(lrModel, newData = testData)

# View predictions against mpg column
display(select(predictions, "price", "prediction"))

# COMMAND ----------

# Model evaluation
errors <- select(predictions, predictions$price, predictions$prediction, alias(predictions$price - predictions$prediction, "error"))
display(errors)

# COMMAND ----------

# Calculate the RMSE
head(select(errors, alias(sqrt(sum(errors$error^2 , na.rm = TRUE) / nrow(errors)), "RMSE")))

# COMMAND ----------

# We can create a Logistic Regression on the same dataset. Let’s see if we can predict a diamond’s cut based on some of its features.  As of Spark 1.6, Logistic Regression in MLlib only supports binary classification. To test out the algorithm with our dataset in this example, we will subset our data so as to work with only 2 labels

# Subset data to include rows where diamond cut = "Premium" or diamond cut = "Very Good"
trainingDataSub <- subset(trainingData, trainingData$cut %in% c("Premium", "Very Good"))
testDataSub <- subset(testData, testData$cut %in% c("Premium", "Very Good"))

# COMMAND ----------

# Indicate family = "binomial" to train a logistic regression model
logrModel <- glm(cut ~ price + color + clarity + depth, data = trainingDataSub, family = "binomial")

# Print summary of Logistic Regression model
# Note: This only works in Spark 1.6+
summary(logrModel)

# COMMAND ----------

# Generate predictions using the trained Linear Regression model
predictionsLogR <- predict(logrModel, newData = testDataSub)

# View predictions against label column
display(select(predictionsLogR, "label", "prediction"))

# COMMAND ----------

# Evaluate Logistic Regression model
errorsLogR <- select(predictionsLogR, predictionsLogR$label, predictionsLogR$prediction, alias(abs(predictionsLogR$label - predictionsLogR$prediction), "error"))
display(errorsLogR)

# COMMAND ----------


