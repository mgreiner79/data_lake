# ms_postgres
FROM postgres:14.1-alpine3.14

# SQL Import Scripts
COPY create_databases.sql /docker-entrypoint-initdb.d/
# copy support for multiple databases
COPY create-multiple-postgresql-databases.sh /docker-entrypoint-initdb.d/
