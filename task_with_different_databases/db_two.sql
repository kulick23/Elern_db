CREATE TABLE remote_table (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    age INTEGER
);

INSERT INTO remote_table (name, age) VALUES
    ('Danila Kulinkovich', 21),
    ('Rick Sanchez', 60),
    ('Morty Smith', 14);


