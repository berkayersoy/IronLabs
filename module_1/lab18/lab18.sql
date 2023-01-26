SHOW tables;
USE ironhack_examples;

SELECT * from applestore;

# 1. What are the different genres?
SELECT distinct prime_genre FROM applestore;

# 2. Which is the genre with the most apps rated?
SELECT prime_genre, COUNT(user_rating) AS num_of_rating FROM applestore
GROUP by prime_genre
ORDER BY num_of_rating DESC;

# 3. Which is the genre with most apps?
SELECT COUNT(prime_genre) AS app_count, prime_genre FROM applestore
GROUP BY prime_genre
ORDER BY app_count DESC
LIMIT 1;
# the genre with most apps is 'Games'

# 4. Which is the one with least?
SELECT COUNT(prime_genre) AS app_count, prime_genre FROM applestore
GROUP BY prime_genre
ORDER BY app_count ASC
LIMIT 1;
# the genre with least apps is 'medical' apps

USE ironhack_examples;
# 5. Find the top 10 apps most rated.
SELECT * FROM applestore
ORDER BY rating_count_tot DESC
LIMIT 10;

SELECT * FROM applestore;

# 6. Find the top 10 apps best rated by users.
SELECT * FROM applestore
ORDER BY user_rating DESC
LIMIT 10;


# 7. Take a look at the data you retrieved in question 5. Give some insights.
# We can say that in the top 10 most rated apps, there is only one paid application.
# In the top 3 there are 2 Social Networking apps.
SELECT * FROM applestore
ORDER BY rating_count_tot DESC
LIMIT 10;


# 8. Take a look at the data you retrieved in question 6. Give some insights.
# There are 8 paid apps out of 10 in the top 10 best rated apps.
SELECT * FROM applestore
ORDER BY user_rating DESC
LIMIT 10;


# 9. Now compare the data from questions 5 and 6. What do you see?
# Best rated and the apps that has most ratings are different.
# Paid apps are better rated.
# Free apps has more ratings


# 10. How could you take the top 3 regarding both user ratings and number of votes?
# We can order by two columns first by user ratings then by number of votes.
SELECT * FROM applestore
ORDER BY rating_count_tot DESC, user_rating DESC
LIMIT 10;

# 11. Do people care about the price of an app? Do some queries, comment why are you doing them and the results you retrieve. What is your conclusion?
SELECT * FROM applestore
ORDER BY rating_count_tot DESC
LIMIT 30;
# The apps that have the 30 most numbers of rating are almost all free apps. There are only 2 paid apps. Conclusion: people tend to go for free apps.





