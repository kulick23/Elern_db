-- 1 
DELETE FROM rental
WHERE inventory_id IN (SELECT inventory_id FROM inventory WHERE film_id = (SELECT film_id FROM film WHERE title = 'The Green Mile' LIMIT 1));

DELETE FROM inventory
WHERE film_id = (SELECT film_id FROM film WHERE title = 'The Green Mile' LIMIT 1);

-- 2 
DELETE FROM payment
WHERE customer_id = (SELECT customer_id
    FROM customer
    WHERE first_name = 'Danila'  AND last_name = 'Kulinkovich'
    );
  
DELETE FROM rental
WHERE customer_id = (SELECT customer_id
    FROM customer
    WHERE first_name = 'Danila'  AND  last_name = 'Kulinkovich'
    );
