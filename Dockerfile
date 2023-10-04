FROM adoptopenjdk/openjdk8:latest

WORKDIR /opt

ENV HADOOP_VERSION=3.3.6
ENV METASTORE_VERSION=3.1.3
ENV MYSQL_CONNECTORJ=mysql-connector-j-8.1.0

ENV HADOOP_HOME=/opt/hadoop-${HADOOP_VERSION}
ENV HIVE_HOME=/opt/apache-hive-metastore-3.1.3-bin
ENV HADOOP_OPTIONAL_TOOLS="hadoop-aws"

RUN curl -L https://repo1.maven.org/maven2/org/apache/hive/hive-standalone-metastore/${METASTORE_VERSION}/hive-standalone-metastore-${METASTORE_VERSION}-bin.tar.gz | tar zxf -
RUN curl -L https://dlcdn.apache.org/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz | tar zxf -
RUN curl -L https://dev.mysql.com/get/Downloads/Connector-J/${MYSQL_CONNECTORJ}.tar.gz | tar zxf - 
RUN cp ${MYSQL_CONNECTORJ}/${MYSQL_CONNECTORJ}.jar ${HIVE_HOME}/lib/ && rm -rf ${MYSQL_CONNECTORJ}

RUN apt-get update && apt-get install -y netcat

COPY scripts/entrypoint.sh /entrypoint.sh

RUN groupadd -r hive --gid=1000
RUN useradd -r -g hive --uid=1000 -d ${HIVE_HOME} hive
RUN chown hive:hive -R ${HIVE_HOME}
RUN chown hive:hive /entrypoint.sh && chmod +x /entrypoint.sh
RUN mkdir -p /user/hive && chown hive:hive -R /user/hive

USER hive
EXPOSE 9083
EXPOSE 10000

ENTRYPOINT ["sh", "-c", "/entrypoint.sh"]
