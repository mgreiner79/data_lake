#!/bin/sh

airflow db init
airflow users create --role Admin --username $AIRFLOW_ADMIN_USERNAME --email admin --firstname admin --lastname admin --password $AIRFLOW_ADMIN_PASSWORD

airflow scheduler & 
airflow webserver -p 8080
