from pyspark.sql import SparkSession
spark = SparkSession.builder.appName("example-app").getOrCreate()

df = spark.read.format("jdbc").option("url", f"jdbc:sqlite:/home/test.db").option("dbtable", "mydb").load()

df.createOrReplaceTempView("mydb")
result = spark.sql("SELECT COUNT(*) FROM mydb")
result.show()

spark.stop()