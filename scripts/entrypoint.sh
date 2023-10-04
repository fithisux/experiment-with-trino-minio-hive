#!/bin/sh

export HADOOP_OPTS="$HADOOP_OPTS -Djava.io.tmpdir=/user/hive/tmp"

$HADOOP_HOME/bin/hadoop fs -mkdir /user/hive/tmp
$HADOOP_HOME/bin/hadoop fs -mkdir /user/hive/warehouse
$HADOOP_HOME/bin/hadoop fs -chmod g+w /user/hive/tmp
$HADOOP_HOME/bin/hadoop fs -chmod g+w /user/hive/warehouse

cd /user/hive

$HIVE_HOME/bin/schematool -initSchema -dbType mysql
$HIVE_HOME/bin/start-metastore