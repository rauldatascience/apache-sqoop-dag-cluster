# ETL - Apache Sqoop, Apache Airflow and Bigquery

Regarding to the business needs today, Companies need to process a bulk data for generating into an insight or even a decision making. In this case, we are trying to import the data from Cloud SQL as a source to the BigQuery as a data warehouse using apache sqoop.
We also using Apache Airflow as an orchestration tools of our ETL process.

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

