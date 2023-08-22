USE sakila;
SELECT payment_id, customer_id, amount FROM payment WHERE amount > 10.99;
SELECT payment_id, payment_date, amount FROM payment WHERE amount != 0.99;
SELECT * FROM address WHERE address2 IS NOT NULL;
SELECT title,length FROM film WHERE length < 60 OR length>100;
SELECT DISTINCT rental_duration FROM film;
SELECT * FROM film WHERE length BETWEEN 60 AND 100;
SELECT * FROM city WHERE city LIKE 'G%' OR city LIKE '%Z%';
SELECT actor_id, first_name, last_name FROM actor WHERE last_name IN ('Williams', 'Davis');
SELECT * FROM film ORDER BY rental_rate DESC;


