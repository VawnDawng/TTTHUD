from pyspark.sql import SparkSession
from pyspark.sql.functions import *
spark = SparkSession.builder.appName("SparkSQLExample").getOrCreate()

weather_df = spark.read.csv("home/data.csv", header=True, inferSchema=True)
weather_df.createOrReplaceTempView("mydb")
#update
updated_weather_df = weather_df.withColumn("status", when(weather_df["HourlyWindSpeed"] > 5, "good").otherwise("bad"))

updated_weather_df.write.mode("overwrite").saveAsTable("weather_table")
updated_weather_df.createOrReplaceTempView("weather_table")
updated_weather_df.show()