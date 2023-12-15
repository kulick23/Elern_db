-- Staff task 1 solution
SELECT 
   s.staff_id,
   s.first_name,
   s.last_name,
   COALESCE(SUM(p.amount), 0) AS total_amount
FROM staff s
LEFT JOIN payment p ON s.staff_id = p.staff_id AND EXTRACT(YEAR FROM p.payment_date) = 2017
GROUP BY s.staff_id, s.first_name, s.last_name
ORDER BY total_amount DESC;

-- Staff task 2 solution
SELECT 
   staff.staff_id,
   staff.first_name,
   staff.last_name,
   a.total_amount
FROM staff
LEFT JOIN (
   SELECT
     staff_id,
     SUM(amount) AS total_amount
   FROM payment
   WHERE EXTRACT(YEAR FROM payment_date) = 2017
   GROUP BY staff_id
) AS a ON staff.staff_id = a.staff_id
ORDER BY total_amount DESC;


-- Film task 1 solution
SELECT 
   f.film_id,
   b.total_rentals,
   f.rating
FROM film f
INNER JOIN (
   SELECT
     i.film_id,
     SUM(a.cnt) as total_rentals
   FROM inventory i
   INNER JOIN (
     SELECT
       inventory_id,
       COUNT(inventory_id) as cnt
     FROM rental
     GROUP BY inventory_id
   ) as a ON i.inventory_id = a.inventory_id
   GROUP BY i.film_id
) as b ON f.film_id = b.film_id
ORDER BY b.total_rentals DESC;

-- Film task 2 solution
SELECT 
   film.film_id,
   COALESCE(rental_counts.total_rentals, 0) AS total_rentals,
   film.rating
FROM film
LEFT JOIN (
   SELECT
     i.film_id,
     COUNT(r.inventory_id) AS total_rentals
   FROM inventory i
   LEFT JOIN rental r ON i.inventory_id = r.inventory_id
   GROUP BY i.film_id
) AS rental_counts ON film.film_id = rental_counts.film_id
ORDER BY total_rentals DESC;

-- Actor task 1 solution
SELECT 
  film_actor.actor_id,
  MAX(film.release_year) AS max_release_year
FROM film_actor
INNER JOIN film ON film_actor.film_id = film.film_id
GROUP BY film_actor.actor_id
ORDER BY max_release_year DESC;

-- Actor task 2 solution
SELECT 
   actor.actor_id,
   MAX(film.release_year) AS max_release_year
FROM film
INNER JOIN (
   SELECT 
       actor_id, 
       film_id 
   FROM film_actor
) AS actor ON film.film_id = actor.film_id
GROUP BY actor.actor_id
ORDER BY max_release_year DESC;






