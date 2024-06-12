FROM ubuntu
ENV DEBIAN_FRONTEND=noninteractive
#python
RUN apt-get update \
 && apt-get install -y curl tar wget vim \
    python3 python3-pip \
 && ln -s /usr/bin/python3 /usr/bin/python \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
#java
RUN apt-get update 
RUN apt-get install -y openjdk-8-jdk 
RUN apt-get clean 
RUN rm -rf /var/lib/apt/lists/*
#JAVA_HOME
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

ENV SPARK_VERSION=3.5.1
ENV HADOOP_VERSION=3
RUN wget -qO- "https://downloads.apache.org/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz" | tar -xz -C /opt/
ENV SPARK_HOME=/opt/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}
ENV PATH=$PATH:$SPARK_HOME/bin

RUN apt-get update \
 && apt-get install -y sqlite3 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN pip install pyspark
RUN wget https://repo1.maven.org/maven2/org/xerial/sqlite-jdbc/3.34.0/sqlite-jdbc-3.34.0.jar
RUN apt-get update && apt-get unzip

WORKDIR $SPARK_HOME
COPY data.zip $SPARK_HOME
RUN unzip /opt/spark-3.5.1-bin-hadoop3/data.zip -d /opt/spark-3.5.1-bin-hadoop3/
RUN rm /opt/spark-3.5.1-bin-hadoop3/data.zip
CMD ["bash"]`