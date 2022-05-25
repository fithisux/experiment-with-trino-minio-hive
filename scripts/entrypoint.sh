#!/bin/sh

export HADOOP_HOME=/opt/hadoop-3.3.3
export METASTORE_DB_HOSTNAME=${METASTORE_DB_HOSTNAME:-localhost}
export HADOOP_OPTS="$HADOOP_OPTS -Djava.io.tmpdir=/user/hive/tmp"

echo "Waiting for database on ${METASTORE_DB_HOSTNAME} to launch on 3306 ..."

while ! nc -z ${METASTORE_DB_HOSTNAME} 3306; do
  sleep 1
done

echo "Database on ${METASTORE_DB_HOSTNAME}:3306 started"
echo "Init apache hive metastore on ${METASTORE_DB_HOSTNAME}:3306"

$HADOOP_HOME/bin/hadoop fs -mkdir /user/hive/tmp
$HADOOP_HOME/bin/hadoop fs -mkdir /user/hive/warehouse
$HADOOP_HOME/bin/hadoop fs -chmod g+w /user/hive/tmp
$HADOOP_HOME/bin/hadoop fs -chmod g+w /user/hive/warehouse

$HIVE_HOME/bin/schematool -initSchema -dbType mysql
$HIVE_HOME/bin/hiveserver2