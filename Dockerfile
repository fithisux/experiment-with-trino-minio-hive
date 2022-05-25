FROM adoptopenjdk/openjdk8:latest

WORKDIR /opt

ENV HADOOP_VERSION=3.3.3
ENV METASTORE_VERSION=3.1.3

ENV HADOOP_HOME=/opt/hadoop-${HADOOP_VERSION}
ENV HIVE_HOME=/opt/apache-hive-3.1.3-bin
ENV HADOOP_OPTIONAL_TOOLS="hadoop-aws"

RUN curl -L https://dlcdn.apache.org/hive/hive-3.1.3/apache-hive-3.1.3-bin.tar.gz | tar zxf -
RUN curl -L https://dlcdn.apache.org/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz | tar zxf -
RUN curl -L https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-8.0.29.tar.gz | tar zxf - 
RUN cp mysql-connector-java-8.0.29/mysql-connector-java-8.0.29.jar ${HIVE_HOME}/lib/ && rm -rf  mysql-connector-java-8.0.29

RUN apt-get update && apt-get install -y netcat

COPY scripts/entrypoint.sh /entrypoint.sh

RUN groupadd -r hive --gid=1000
RUN useradd -r -g hive --uid=1000 -d ${HIVE_HOME} hive
RUN chown hive:hive -R ${HIVE_HOME}
RUN chown hive:hive /entrypoint.sh && chmod +x /entrypoint.sh
RUN mkdir -p /user/hive && chown hive:hive -R /user/hive

USER hive
EXPOSE 9083

ENTRYPOINT ["sh", "-c", "/entrypoint.sh"]
