--CREATE DATABASE dwhdb;
--CREATE DATABASE apidb;
--CREATE DATABASE airflowdb;

--CREATE USER airflow WITH ENCRYPTED PASSWORD 'airflow';
--GRANT ALL PRIVILEGES ON DATABASE airflowdb TO airflow;

--CREATE USER django_app LOGIN PASSWORD 'secret';
--GRANT ALL PRIVILEGES ON DATABASE apidb TO django_app;
--ALTER USER django_app CREATEDB;

-- dwh without historization for research data with 
CREATE SCHEMA IF NOT EXISTS landing;
CREATE SCHEMA IF NOT EXISTS logic; -- no staging, no persistent, no historisation
CREATE SCHEMA IF NOT EXISTS mart; -- views

CREATE TABLE IF NOT EXISTS landing.dim_test (
	x float NULL,
	y float NULL
);

INSERT INTO landing.dim_test(x, y) VALUES(1, 1.5);
INSERT INTO landing.dim_test(x, y) VALUES(2, 2.5);
INSERT INTO landing.dim_test(x, y) VALUES(3, 3.5);

CREATE VIEW landing.v_dim_test_x AS
    SELECT x
    FROM landing.dim_test;

CREATE VIEW landing.v_dim_test_y AS
    SELECT y
    FROM landing.dim_test;


--CREATE USER django_app LOGIN PASSWORD 'secret';
--GRANT ALL PRIVILEGES ON DATABASE apidb TO django_app;

-- unclear if statements below are necessary
-- \connect apidb;
-- REVOKE CREATE ON SCHEMA public FROM PUBLIC;
-- REVOKE ALL ON DATABASE apidb FROM PUBLIC;
-- CREATE SCHEMA operational AUTHORIZATION django_app;
-- ALTER ROLE django_app SET SEARCH_PATH TO operational, public;
-- CREATE ROLE app_manager;
-- GRANT CONNECT ON DATABASE apidb TO app_manager;
-- GRANT USAGE ON SCHEMA operational TO app_manager;
-- GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA operational TO app_manager;
-- GRANT USAGE ON ALL SEQUENCES IN SCHEMA operational TO app_manager;
-- ALTER USER django_app CREATEDB;
-- GRANT app_manager TO django_app;

