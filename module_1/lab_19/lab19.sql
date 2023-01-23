USE olist;

# 1. From the order_items table, find the price of the highest priced order and lowest price order.
SELECT * FROM order_items
ORDER BY price DESC
LIMIT 1;

SELECT * FROM order_items
ORDER BY price ASC
LIMIT 1;

# 2. From the order_items table, what is range of the shipping_limit_date of the orders?
SELECT CONCAT(MIN(shipping_limit_date),"---",MAX(shipping_limit_date)) as range_of_shipping_limit_date FROM order_items;

# 3. From the customers table, find the states with the greatest number of customers.
SELECT COUNT(customer_unique_id) AS customer_count, customer_state FROM customers
GROUP BY customer_state;

# 4. From the customers table, within the state with the greatest number of customers, find the cities with the greatest number of customers.
SELECT customer_city, COUNT(customer_city) AS city_count FROM customers
WHERE customer_state='SP'
GROUP BY customer_city
ORDER BY city_count DESC;


# 5. From the closed_deals table, how many distinct business segments are there (not including null)?
# There are 33 business_type's not counting NULL.
SELECT DISTINCT(business_segment) FROM closed_deals
WHERE business_segment IS NOT NULL;


# 6. From the closed_deals table, sum the declared_monthly_revenue for duplicate row values in business_segment and find the 3 business segments with the highest declared monthly revenue (of those that declared revenue).
SELECT business_segment, SUM(declared_monthly_revenue) AS total_declared_monthly_revenue FROM closed_deals
GROUP BY business_segment
ORDER BY total_declared_monthly_revenue DESC;

# 7. From the order_reviews table, find the total number of distinct review score values.
# Question unclear.
# The answer is 5 ?
SELECT DISTINCT(review_score) FROM order_reviews;

# 8. In the order_reviews table, create a new column with a description that corresponds to each number category for each review score from 1 - 5, then find the review score and category occurring most frequently in the table.
# Question unclear.
SELECT * FROM order_reviews;

# 9. From the order_reviews table, find the review value occurring most frequently and how many times it occurs.
# Review_score 5 occurs the most. 57420 times.
SELECT COUNT(review_id) AS total_count_of_review_score, review_score FROM order_reviews
GROUP BY review_score
ORDER BY total_count_of_review_score DESC;



