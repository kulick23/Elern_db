
CREATE EXTENSION postgres_fdw;

CREATE SERVER same_server_postgres
    FOREIGN DATA WRAPPER postgres_fdw
    OPTIONS (dbname 'db_two');

CREATE USER MAPPING FOR CURRENT_USER
    SERVER same_server_postgres
    OPTIONS (user 'postgres', password '');
	
CREATE FOREIGN TABLE local_remote_table (
   id INTEGER,
   name VARCHAR(255),
   age INTEGER
)
SERVER same_server_postgres
OPTIONS (schema_name 'public', table_name 'remote_table');

SELECT * FROM local_remote_table;

INSERT INTO local_remote_table (id, name, age) VALUES (4, 'Michael Johnson', 30);


UPDATE local_remote_table SET age = 65 WHERE name = 'Rick Sanchez';


DELETE FROM local_remote_table WHERE name = 'Morty Smith';


CREATE TABLE local_table (
    id serial PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255) UNIQUE NOT NULL
);


INSERT INTO local_table (name, email) VALUES
    ('Danila Kulinkovich', 'danila.kulinkovich@example.com'),
    ('Rick Sanchez', 'rick.sanchez@example.com'),
    ('Morty Smith', 'morty.smith@example.com');
	
SELECT r.*, l.email
FROM local_remote_table  r 
LEFT JOIN  local_table l ON (r.name = l.name );
	
    
      
		

