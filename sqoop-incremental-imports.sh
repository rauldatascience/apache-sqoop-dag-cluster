#!/bin/bash

bucket="gs://bigdata-etl-2_flights"

instance_name = "bigdata-etl-2:asia-southeast2:mysql-instance"

table_name="flights"

target_dir="/incremental_buckets"

pwd_file=$bucket/sqoop-pwd/pwd.txt

cluster_name=$1


gcloud dataproc jobs submit hadoop \
--cluster=$cluster_name --region=asia-southeast2 \
--class=org.apache.sqoop.Sqoop \
--jars=$bucket/sqoop_jars/sqoop_sqoop-1.4.7.jar,$bucket/sqoop_jars/sqoop_avro-tools-1.8.2.jar,file:///usr/share/java/mysql-connector-java-5.1.49.jar \
-- import \
-Dmapreduce.job.user.classpath.first=true \
-Dmapreduce.output.basename="part.20190515_" \
--driver com.mysql.jdbc.Driver \
--connect="jdbc:mysql://localhost:3307/airports" \
--username=root --password-file=$pwd_file \
--split-by id \
--table $table_name \
--check-column flight_date \
--last-value 2019-05-14 \
--incremental append \
-m 4 \
--target-dir $target_dir \
--as-avrodatafile 