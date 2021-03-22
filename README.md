# ETL - Apache Sqoop, Apache Airflow and Bigquery

Regarding to the business needs today, Companies need to process a bulk data for generating into an insight or even a decision making. In this case, we are trying to import the data from Cloud SQL as a source to the BigQuery as a data warehouse using apache sqoop.
We also using Apache Airflow as an orchestration tools of our ETL process. Sometimes after importing from RDBMS using Apache Sqoop, Data engineer do a transformation with Apache Spark then do load to the Data Warehouse. This case we are not transforming so we don't nee use Apache Spark.

Here, is the flow detail of our ETL process flow

![alt text](https://github.com/rauldatascience/apache-sqoop-dag-cluster/blob/main/figure-resource/sqoop-job.jpg?raw=true)

## SETUP Cloud SQL

1. Go to Cloud SQL by typing SQL in Google CLoud Platform
2. Create an instance and pick MySQL
3. Give name into your instance like "mysql-instance", give a password into your root user
4. pick the MySQL version (in this case i use the updated MySQL which is MySQL 8.0), Define the region about your intances, i pick asia-southeast2 (Jakarta)
5. Because this is a development so i choose 'Single Zone'
6. Yups, let's create an instance! It will take around 5-10 minutes

After finish, you will get like this

![alt text](https://github.com/rauldatascience/apache-sqoop-dag-cluster/blob/main/figure-resource/MySQL-instances.png?raw=true)

7. Make a folder into your buckets with the name 'sqoop_jars" and upload all jars file there. 
8. These 2 files jars for run sqoop commands which are 'sqoop_sqoop-1.4.7.jar' and 'sqoop_avro-tools-1.8.2.jar'

## Import sql file dataset into mysql-instance

1. Create database first, by clicl 'databases' and create database with name airports with default character set 'utf8'.  
2. Make a folder into your buckets in Google Cloud Storage (This case my folder is sql-files)
3. upload all files needed, you can use UI upload service or by your terminal (you should make configuration between local and GCP SDK)
4. Go to SQL in GCP and pick your instance and also pick "import"
5. browse your sql file that located in GCS, select all files needed and pick "SQL" with destination database 'airports' and import it.
6. Configure your local MySQL with Cloud SQL by communicating through terminal. So, this case i assume that we already make a configuration between local and GCP
7. Check first your account by typyng ```gcloud info```. This make sure that you are in the right account and right project.
8. I also assume that the MySQL already installed into your local.
9. Connecting by ```gcloud sql connect mysql-instance --user root``` and type your root password. try to query!

## SETUP and run Google Composer (Apache Airflow Env)

1. Go to Google Composer by typing Composer in Google CLoud Platform
2. Give name into your instance (this case i give airflow-flight-jobs), and pick the location instance (this case i pick asia-east2)
3. You can use random node as given 3 node count, pick **n1-stadrd-2** is enough with 50 as a disk size
4. Pick the latest image version composer-1.15.0-airflow-1.10.14 with python version 3
5. Yups, let's create a composer airflow instance! it will take around 10-15 minutes
6. upload 'sqoop-incremental-import.py' into the dags folder 
7. upload 'sqoop-incremental-imports.sh' into the plugins folder
8. run the Airflow UI and trigger your dag's

![alt text](https://github.com/rauldatascience/apache-sqoop-dag-cluster/blob/main/figure-resource/success-dags.png?raw=true)
