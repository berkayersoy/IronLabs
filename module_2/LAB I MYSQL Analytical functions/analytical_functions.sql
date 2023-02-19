USE sakila;

# Question 1 - Running total
SELECT customer_id, amount, SUM(amount) OVER (PARTITION BY customer_id ORDER BY payment_date) AS running_total
FROM payment;

# Question 2 - Running total
SELECT DATE(payment_date), amount,
RANK() OVER (PARTITION BY DATE(payment_date) ORDER BY amount DESC) AS rankk,
DENSE_RANK() OVER (PARTITION BY DATE(payment_date) ORDER BY amount DESC) AS dense_rankk
FROM payment;

# Question 3. find the ranking of each film based on its rental rate, within its respective category. 
# Hint: you need to extract the information from the film, film_category and category tables after applying join on them.
SELECT category.name, film.title, film.rental_rate,
RANK() OVER (PARTITION BY category.name ORDER BY film.rental_rate DESC, film.title) AS rankk,
DENSE_RANK() OVER (PARTITION BY category.name ORDER BY film.rental_rate DESC, film.title) AS dense_rankk
FROM film
INNER JOIN film_category ON film.film_id=film_category.film_id
INNER JOIN category ON category.category_id=film_category.category_id;

# Question 4 - (OPTIONAL) update the previous query from above to retrieve only the top 5 films within each category
SELECT * FROM (
        SELECT category.name, film.title, film.rental_rate,
		RANK() OVER (PARTITION BY category.name ORDER BY film.rental_rate DESC, film.title) AS rankk,
		DENSE_RANK() OVER (PARTITION BY category.name ORDER BY film.rental_rate DESC, film.title) AS dense_rankk,
        ROW_NUMBER() OVER (PARTITION BY category.name ORDER BY film.rental_rate DESC, film.title) AS row_number1
		FROM film
		INNER JOIN film_category ON film.film_id=film_category.film_id
		INNER JOIN category ON category.category_id=film_category.category_id
       ) AS sub
WHERE row_number1<=5;

# Question 5 - Find the difference between the current and previous payment amount and the difference between the current and next payment amount, for each customer in the payment table
SELECT payment_id, customer_id, amount, payment_date, 
  amount - LAG(amount) OVER (PARTITION BY customer_id ORDER BY payment_date) AS lagg,
  LEAD(amount) OVER (PARTITION BY customer_id ORDER BY payment_date) - amount AS leadd
FROM payment;








