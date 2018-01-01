# Objective: Connect to local spark instance and print spark version

# print session info for result reproducibility
sessionInfo()

# Load sparklyr
library(sparklyr)

# Connect to your Spark cluster
spark_conn <- spark_connect(master="local")

# Print the version of Spark
spark_version(spark_conn)

# Disconnect from Spark
spark_disconnect(sc)
