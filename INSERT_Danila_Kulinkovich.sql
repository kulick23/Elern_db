-- first task
INSERT INTO film (title, description, release_year, language_id, original_language_id, rental_duration, rental_rate, length, replacement_cost, rating, last_update, special_features, fulltext)
VALUES ('The Green Mile', 'A story about miracles and human connection', 1999, 1, NULL, 14, 4.99, 188, 19.99, 'R', CURRENT_TIMESTAMP, '{"Special Features Here"}', 'Full Text Here');

-- second task
INSERT INTO actor (first_name, last_name, last_update)
VALUES
    ('Tom', 'Hanks', CURRENT_TIMESTAMP),
    ('David', 'Morse', CURRENT_TIMESTAMP),
    ('Michael', 'Clarke Duncan', CURRENT_TIMESTAMP);
  
INSERT INTO film_actor (actor_id, film_id, last_update)
VALUES
    ((SELECT actor_id FROM actor WHERE first_name = 'Tom' ), (SELECT film_id FROM film WHERE title = 'The Green Mile'), CURRENT_TIMESTAMP),
    ((SELECT actor_id FROM actor WHERE first_name = 'David' ), (SELECT film_id FROM film WHERE title = 'The Green Mile'), CURRENT_TIMESTAMP),
    ((SELECT actor_id FROM actor WHERE first_name = 'Michael' ), (SELECT film_id FROM film WHERE title = 'The Green Mile'), CURRENT_TIMESTAMP);

-- third task
INSERT INTO film (title, description, release_year, language_id, original_language_id, rental_duration, rental_rate, length, replacement_cost, rating, last_update, special_features, fulltext)
VALUES
    ('Star Wars: Episode III - Revenge of the Sith', 'The fall of Anakin Skywalker and the rise of Darth Vader', 2005, 1, NULL, 7, 2.99, 140, 19.99, 'PG-13', CURRENT_TIMESTAMP, '{"Special Features Here"}', 'Full Text Here');

INSERT INTO inventory (film_id, store_id, last_update)
VALUES
    ((SELECT film_id FROM film WHERE title = 'Star Wars: Episode III - Revenge of the Sith' LIMIT 1), (SELECT store_id FROM store WHERE store_id IN (1, 2) LIMIT 1), CURRENT_TIMESTAMP);

